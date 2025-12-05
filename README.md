🌱 Greenhouse Signal Processing & LTI Filtering Project
This project demonstrates a full signal-processing pipeline for a simulated greenhouse environment, including:
Environmental signal simulation (temperature, soil moisture, CO₂)
Linear Time-Invariant (LTI) sensor modeling
Filtering and denoising
FFT-based frequency analysis
Automatic anomaly detection
A small Laplace-domain control demo
Visualization dashboards
The code is structured for clarity so each component is contained in its own .m file.
📁 Project Structure
.
├── do_fft_and_plots.m        % FFT, visualization, anomaly detection
├── filter_and_denoise.m      % Custom filtering pipeline (LTI + denoising)
├── greenhouse_dashboard.m    % Visualization panels (optional helper)
├── greenhouse_main.m         % The main pipeline script (RUN THIS)
├── laplace_control_demo.m    % Laplace-domain control demo
├── sensor_LTI.m              % LTI sensor model (1st order)
├── simulate_signals.m        % Greenhouse environmental signal generator
├── LICENSE
└── README.md                 % THIS FILE
🚀 How to Run the Project
1. Open MATLAB
Ensure all files are in the same folder and set that folder as your MATLAB workspace.
2. Run the main script
greenhouse_main
This will:
Generate temperature, moisture, and CO₂ signals
Pass them through your LTI sensor model
Apply filtering/denoising
Perform FFT analysis
Perform anomaly detection
Display time-domain and frequency-domain plots
Print anomaly results to the console
Run the Laplace control demo
You should see console output similar to:
=== TEMPERATURE FFT Anomaly Report ===
HF Energy (raw): 0.6592
HF Energy (LTI): 0.9662
⚠️ Raw signal anomaly: possible noise burst
⚠️ LTI output anomaly: poor sensor dynamic filtering
=======================================
...
📊 Features
1. Signal Simulation (simulate_signals.m)
Creates realistic greenhouse behavior with day/night cycles, evaporation changes, and CO₂ dips caused by ventilation.
2. LTI Sensor Model (sensor_LTI.m)
Implements a 1st-order dynamic sensor:
τ
d
y
d
t
+
y
=
x
(
t
)
τ 
dt
dy
​    
 +y=x(t)
Used to simulate sensor delay and smoothing.
3. Filtering & Denoising (filter_and_denoise.m)
Applies:
LTI model
High-pass / low-pass filtering (if enabled)
Noise reduction
4. FFT + Anomaly Detection (do_fft_and_plots.m)
Performs:
FFT computation
Harmonics visualization
High-frequency energy ratio
Detection of:
Noise bursts
Bad LTI filtering
CO₂ ventilation events
Plots generated include:
Raw vs. LTI time-domain signals
Raw vs. LTI frequency spectra
Highlighted anomaly points
5. Control Demo (laplace_control_demo.m)
Demonstrates:
Laplace transforms
Step response of a 1st-order system
Effect of time constant τ
🕵️‍♂️ Anomaly Detection Logic
High-frequency FFT anomaly detection
Each signal’s FFT is normalized before comparison:
HF_energy = sum(mag_fft(hf_band_indices).^2);
If the energy exceeds a threshold → noise anomaly is reported.
CO₂ ventilation detection
CO₂ ventilations cause sudden drops below 350 ppm:
event_indices = find(co2 < low_threshold);
When detected, the first event is highlighted on the graph.
📈 Visualization
Running the project generates:
Temperature, moisture, CO₂ over time
Their filtered/LTI versions
FFT magnitude plots
CO₂ anomaly markers
A separate figure for the Laplace control demo
All visuals are automatically generated. No extra configuration needed.
📌 Recommended Workflow for Students
Study simulate_signals.m — understand environmental modeling
Modify sensor_LTI.m — experiment with different sensor time constants
Add filters inside filter_and_denoise.m (Butterworth, moving average, etc.)
Extend anomaly detection in do_fft_and_plots.m
Document your findings for lab or project submission
📄 License
This project is licensed under the MIT license (see LICENSE file).
