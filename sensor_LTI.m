function L = sensor_LTI(S, t, fs)
% sensor_LTI  Model sensor LTI dynamics (simple first-order lowpass sensors)
%   L = sensor_LTI(S, t, fs) returns struct of filtered signals via convolution
%
% We simulate sensors as first-order low-pass: h(t) = (1/tau) * exp(-t/tau) u(t)

tau_temp = 60*60*1.5;   % temperature sensor time constant ~1.5 hour (in seconds)
tau_hum  = 60*60*0.8;   % humidity sensor faster
tau_co2  = 60*30;       % CO2 sensor faster
tau_soil = 60*60*3;     % soil moisture very slow (~3 hours)
tau_light= 5*60;        % light sensor very fast (5 minutes)

% create continuous impulse responses sampled at fs
t_imp = 0:1/fs:6*3600; % impulse support (6 hours)
h_temp = (1/tau_temp) * exp(-t_imp/tau_temp);
h_hum  = (1/tau_hum)  * exp(-t_imp/tau_hum);
h_co2  = (1/tau_co2)  * exp(-t_imp/tau_co2);
h_soil = (1/tau_soil) * exp(-t_imp/tau_soil);
h_light= (1/tau_light)* exp(-t_imp/tau_light);

% normalize to unit area (optional, keeps DC comparable)
h_temp = h_temp / sum(h_temp);
h_hum  = h_hum  / sum(h_hum);
h_co2  = h_co2  / sum(h_co2);
h_soil = h_soil / sum(h_soil);
h_light= h_light / sum(h_light);

% Convolve (use 'same' to keep same length)
L.temperature = conv(S.temperature, h_temp, 'same');
L.humidity    = conv(S.humidity, h_hum, 'same');
L.co2         = conv(S.co2, h_co2, 'same');
L.soil_moisture = conv(S.soil_moisture, h_soil, 'same');
L.light       = conv(S.light, h_light, 'same');

L.t = S.t;
L.hours = S.hours;
end
