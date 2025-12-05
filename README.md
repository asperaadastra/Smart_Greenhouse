# 🌱 Smart Greenhouse Signal Processing (2025–2030)
*A MATLAB Project for Smart Environments & Signal Processing*

![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![MATLAB](https://img.shields.io/badge/MATLAB-R2022a+-blue)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

---

## 📌 Description  
This project implements a complete **smart greenhouse signal-processing pipeline** in MATLAB. It simulates multi-sensor environmental data, applies LTI (linear time-invariant) systems, performs Fourier analysis, custom filtering, anomaly detection, and a Laplace-style control demonstration.

It is designed according to the **Smart Environments (2025–2030)** course requirements.  
The greenhouse simulation includes signals for:
- Temperature  
- Humidity  
- Soil Moisture  
- CO₂ Concentration  
- Light Intensity  

All signals undergo realistic modeling, LTI filtering, FFT analysis, denoising, and visualization.

---

## ✨ Features  

### 🌡 Sensor Simulation  
- Generates realistic 48-hour greenhouse data  
- Includes noise, irrigation, ventilation, day/night cycles  

### 🔁 LTI System Modeling  
- First-order LTI model  
- Manual convolution (toolbox-free)  
- Simulates slow-response sensor behavior  

### 📊 Fourier Analysis  
- FFT before/after LTI  
- Frequency-domain comparison  
- High-frequency anomaly detection  
- Automated console reports  

### 🧹 Filtering & Denoising  
- Low-pass smoothing filter without toolboxes  
- Designed for temperature & moisture signals  

### 🧮 Laplace-like Control System  
- Heating response simulation  
- First-order approximation of Laplace systems  

### 🖥️ Interactive Dashboard  
- Adjustable cutoff slider  
- Multi-sensor visualization  
- UI-based controls  

---

## 📁 Project Structure

📦 Smart-Greenhouse-MATLAB

│

├── greenhouse_main.m # Main pipeline runner

├── simulate_signals.m # 48h greenhouse sensor generator

├── sensor_LTI.m # LTI convolution-based sensor modeling

├── do_fft_and_plots.m # FFT comparisons + anomaly detection

├── filter_and_denoise.m # Toolbox-free low-pass filter
├── laplace_control_demo.m # Heating control model (Laplace-like)

├── greenhouse_dashboard.m # UI dashboard for visualization

│

├── README.md

├── LICENSE

---

## ⚙️ Installation

### Prerequisites
- MATLAB **R2022a or newer**
- **No additional toolboxes required**

### Setup
1. Clone the repository or download all `.m` files.  
2. Open the folder in MATLAB.  
3. Add all files to the MATLAB path:
   ```matlab
   addpath(genpath(pwd));
   ```
## 🚀 Usage

To run the full simulation pipeline:
```matlab
greenhouse_main
```

This will automatically generate:

- Time-domain sensor plots
- LTI-processed signal comparisons
- FFT magnitude analysis + anomaly detection
- Filtered and denoised signals
- Heating control Laplace-style model
- Full interactive dashboard


Example console output:
```console
=== CO2 FFT Anomaly Report ===
HF Energy (raw): 0.6206
HF Energy (LTI): 1.3489
⚠️ Raw signal anomaly: possible noise burst
⚠️ LTI output anomaly: poor sensor dynamic filtering
=======================================
```

## 🔧 Configuration
| Parameter      | Default | File                   | Description                     |
| -------------- | ------- | ---------------------- | ------------------------------- |
| fs             | 1/60 Hz | greenhouse_main.m      | Sampling rate (1 sample/minute) |
| duration_hours | 48      | greenhouse_main.m      | Total simulation duration       |
| tau            | 2 hrs   | laplace_control_demo.m | Heating system time constant    |
| filter_alpha   | 0.1     | filter_and_denoise.m   | Exponential smoothing factor    |

All configuration values can be edited directly in their respective MATLAB files.
## 🛠 Technologies Used
| Component         | Technology                                 |
| ----------------- | ------------------------------------------ |
| Language          | MATLAB                                     |
| Signal Simulation | Sinusoids, exponential decay, random noise |
| LTI Modeling      | Manual convolution (`conv`)                |
| FFT               | `fft()`                                    |
| Filtering         | Custom exponential smoothing filter        |
| Dashboard         | MATLAB `uifigure`, sliders, UI components  |
| Control Demo      | Discrete-time first-order heating model    |


## 🗺 Roadmap / Future Work
- Kalman filtering for noise suppression
- PCA-based anomaly detection
- Expanded dashboard with multi-sensor comparison
- PID greenhouse control simulation
- ML-based irrigation forecasting
- MQTT/IoT integration for real sensors
## 🤝 Contributing
1. 1)Fork the repository
2. 2)Create a new feature branch
3. 3)Commit your changes
4. 4)Open a pull request
   
All contributions are welcome!

## 📜 License
Licensed under the MIT License.
You are free to use, modify, and distribute this project.
Made with ❤️ for the Smart Environments 2025–2030 course.


