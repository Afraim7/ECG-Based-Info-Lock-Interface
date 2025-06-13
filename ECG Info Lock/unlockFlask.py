from flask import Flask, request, jsonify
import numpy as np
from scipy.signal import butter, filtfilt, find_peaks
from scipy.fftpack import dct
from scipy.stats import skew, kurtosis
import pywt
import joblib
import wfdb
import os
from werkzeug.utils import secure_filename
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
app.config['UPLOAD_FOLDER'] = './uploads'
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)

# Load model
model = joblib.load('dct_svm_model.pkl')

# Filter setup
fs = 1000
nyq = 0.5 * fs
b, a = butter(3, [1 / nyq, 40.0 / nyq], btype='band')
segment_window = 0.6

def extract_dct_features_from_file(file_path):
    record = wfdb.rdrecord(os.path.splitext(file_path)[0])
    ecg = record.p_signal[:, 0]
    filtered = filtfilt(b, a, ecg)

    r_peaks, _ = find_peaks(filtered, distance=fs * 0.6, height=np.mean(filtered))
    win = int(segment_window * fs / 2)

    dct_features = []
    for r in r_peaks:
        if r - win < 0 or r + win > len(ecg):
            continue
        segment = ecg[r - win:r + win]
        dct_feat = dct(segment, norm='ortho')[:28]
        dct_features.append(dct_feat)

    return np.array(dct_features)



@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'}), 400

    uploaded_files = request.files.getlist('file')
    for f in uploaded_files:
        filename = secure_filename(f.filename)
        save_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        f.save(save_path)

    dat_file = next((f for f in uploaded_files if f.filename.endswith('.dat')), None)
    if not dat_file:
        return jsonify({'error': 'No .dat file uploaded'}), 400

    file_path = os.path.join(app.config['UPLOAD_FOLDER'], os.path.splitext(dat_file.filename)[0])

    try:
        record = wfdb.rdrecord(file_path)
        record_name = record.record_name
        ecg = record.p_signal[:, 0]
        time = np.round(np.arange(record.sig_len) / record.fs, 6).tolist()
        samples = ecg.tolist()

        # Feature extraction
        features = extract_dct_features_from_file(file_path)
        if len(features) == 0:
            return jsonify({'result': 'Not Identified', 'reason': 'No valid ECG segments found'})

        predictions = model.predict(features)
        classes, counts = np.unique(predictions, return_counts=True)
        top_class = classes[np.argmax(counts)]
        correct_ratio = counts.max() / len(predictions)

        result = "Identified" if correct_ratio >= 0.7 else "Not Identified"

        return jsonify({
            'result': result,
            'predicted_class': int(top_class),
            'confidence': round(correct_ratio, 2),
            'patient_id': record_name,
            'signal_samples': samples[:6000], 
            'time_vector': time[:6000]
        })

    except Exception as e:
        return jsonify({'error': str(e)}), 500




if __name__ == '__main__':
    app.run(debug=True)