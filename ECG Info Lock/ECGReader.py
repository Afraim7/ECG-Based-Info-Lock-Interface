
import wfdb
import numpy as np
import json
import os

def read_ecg_data(file_path, output_dir='./ECG'):
    
    os.makedirs(output_dir, exist_ok=True)

    try:
        record = wfdb.rdrecord(file_path)

        try:
            ann = wfdb.rdann(file_path, 'atr')
            annotations_found = True
        except:
            annotations_found = False

        fs = record.fs
        sig_len = record.sig_len
        time = np.round(np.arange(sig_len) / fs, 6).tolist()
        signals = record.p_signal

        signal_data = {name: signals[:, idx].tolist() for idx, name in enumerate(record.sig_name)}

        ecg_json = {
            "record_name": record.record_name,
            "sampling_rate": fs,
            "num_channels": record.n_sig,
            "signal_length": sig_len,
            "duration_sec": round(sig_len / fs, 2),
            "annotations_available": annotations_found,
            "signal_names": record.sig_name,    
            "signals": signal_data,
            "time_vector": time,
        }

        output_path = os.path.join(output_dir, "ecg_data.json")
        with open(output_path, 'w') as f:
            json.dump(ecg_json, f, indent=2)
        return ecg_json

    except Exception as e:
        return None

if __name__ == "__main__":
    file_path = "C:/Users/afrai/Desktop/Info Lock ECG Based/archive/patient071/s0236lre"
    print("Starting ECG data extraction...")
    result = read_ecg_data(file_path)
    if result:
        print("✅ Extraction completed successfully.")


