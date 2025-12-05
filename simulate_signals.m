function S = simulate_signals(t, fs)
% simulate_signals  Create synthetic greenhouse sensor data
%   S = simulate_signals(t, fs) returns struct S containing signals (vectors same length as t)
%
% Inputs:
%   t  - time vector in seconds
%   fs - sample rate in Hz
%
% Outputs:
%   S.temperature, S.humidity, S.co2, S.soil_moisture, S.light

N = length(t);
hours = t/3600;

% 1) Temperature: diurnal cycle + slow trend + random noise
temp_mean = 22; % degrees C
temp_diurnal_amp = 5; % amplitude
temp = temp_mean + temp_diurnal_amp * sin(2*pi*(1/24)*hours - pi/3); % daily sine
temp = temp + 0.2*(hours/24) + 0.5*randn(N,1); % slight trend + noise

% 2) Humidity: inversely related to temperature + daily component + spikes from irrigation
hum_base = 60; % percent
hum = hum_base - 0.4*(temp - temp_mean) + 5*sin(2*pi*(2/24)*hours); % some higher freq
hum = hum + 2*randn(N,1);

% inject irrigation humidity spikes every 8 hours
irrig_times = 8:8:max(hours);
for k=1:length(irrig_times)
    idx = find(hours >= irrig_times(k) & hours < irrig_times(k)+0.5);
    hum(idx) = hum(idx) + 10*exp(-((hours(idx)-irrig_times(k))/0.1).^2);
end

% 3) CO2: baseline with daytime plant uptake (drop during day), small periodic variations
co2_base = 420; % ppm
co2 = co2_base - 30*(sin(2*pi*(1/24)*hours - pi/6) > 0).*sin(2*pi*(1/24)*hours - pi/6);
co2 = co2 + 10*randn(N,1);

% simulated abnormal event: sudden CO2 drop at hour 30 (ventilation fault)
vent_event_time = 30; % hours
idx_evt = find(hours >= vent_event_time & hours < vent_event_time+0.5);
co2(idx_evt) = co2(idx_evt) - 80.*exp(-((hours(idx_evt)-vent_event_time)/0.05).^2);

% 4) Soil moisture: slow changes with irrigation pulses
soil = 0.30 + 0.01*sin(2*pi*(1/48)*hours) + 0.005*randn(N,1); % volumetric fraction
% irrigation pulses at 8, 16, 24, 32, 40 hours
pulse_times = 8:8:max(hours);
for p=pulse_times
    idx = find(hours >= p & hours < p+0.5);
    soil(idx) = soil(idx) + 0.08*exp(-((hours(idx)-p)/0.05).^2);
end

% 5) Light: clear diurnal on/off with small flicker noise
light = max(0, 1000 * sin(2*pi*(1/24)*hours + pi/2)); % lux-like
light = light + 50*randn(N,1);
light(light<0)=0;

% Pack into struct
S.temperature = temp;
S.humidity = hum;
S.co2 = co2;
S.soil_moisture = soil;
S.light = light;
S.t = t;
S.hours = hours;
end
