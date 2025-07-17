# ECG Info Lock Interface

A secure authentication system that uses your unique ECG biometric signature to protect and unlock sensitive information.

---

## 🔐 Project Overview

ECG Info Lock is a biometric-based security application that leverages the uniqueness of each user's ECG signal as a key for unlocking protected information. The system combines a Flutter-based frontend with a machine learning model trained to recognize and verify ECG signatures.

---

## 📁 Repository Structure

├── ECG Info Lock/              # Main Flutter source code  
├── UI/                         # App screenshots and UI assets  
├── archive/                    # Pre-recorded ECG biometric data for various users  
├── info lock python code.ipynb # Jupyter notebook with model training and inference code  
├── Report.docx / .pdf          # Full technical report documentation  
└── README.md                   # This file

---

## ⚙️ Key Features

- Secure biometric login using ECG signals  
- Real-time signal acquisition and verification  
- Machine learning-based user identification  
- Clean UI with intuitive flow  
- Offline ECG archive for multi-user testing  

---

## 🚀 Getting Started

### Run the Flutter App

cd 'ECG Info Lock'  
flutter pub get  
flutter run

### Run the Machine Learning Model

1. Open `info lock python code.ipynb`  
2. Run cells sequentially  
   *(Requires Python, NumPy, TensorFlow/Keras, Jupyter Notebook)*

---

## 🧠 Tech Stack

- **Flutter** — Cross-platform mobile development  
- **Dart** — Programming language  
- **Python** — Model development and signal analysis  
- **TensorFlow/Keras** — Deep learning  
- **Jupyter Notebook** — Model prototyping and experimentation  

---

## 🖼️ Screenshots

Screenshots of the app interface can be found in the `/UI` folder.

---

## 📝 License

This project is for educational and research purposes. All contributors are welcome.
