%% greenhouse_main.m
% Smart Greenhouse pipeline: simulation -> LTI -> FFT -> filtering -> Laplace demo -> dashboard
% Run this file. Requires Control System Toolbox (for tf, pole) and Signal Processing Toolbox.

clear; close all; clc;

% Simulation parameters
fs = 1;                 % sampling rate [Hz] (1 sample per second)
T = 24*3600;            % simulate 24 hours (in seconds) -> long vector; but to make plots quicker we will simulate 48 hours with lower rate
fs = 1/60;              % 1 sample per minute
duration_hours = 48;    % simulate 48 hours to see diurnal cycles
t = (0:1/fs:duration_hours*3600)'; % time vector in seconds

% 1) Simulate signals
signals = simulate_signals(t, fs); % returns struct with fields: temperature, humidity, co2, soil, light

% 2) Model LTI sensor dynamics and apply convolution
lti_signals = sensor_LTI(signals, t, fs);

% 3) FFT analysis: before and after LTI
do_fft_and_plots(signals, lti_signals, t, fs);

% 4) Filtering and denoising (example on temperature and soil moisture)
[denoised, filters] = filter_and_denoise(lti_signals, t, fs);

% 5) Laplace-domain demo for irrigation control loop
laplace_control_demo(fs);

% 6) Launch simple dashboard (optional interactive)
greenhouse_dashboard(t, lti_signals, denoised, fs);

disp('Pipeline finished. Check figures for time-domain and frequency-domain results.');
