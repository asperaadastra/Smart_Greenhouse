function laplace_control_demo(fs)
% LAPPLACE_CONTROL_DEMO  Toolbox-free demo of first-order heating control
%   fs : sample rate in Hz (samples per second) — same fs used in main pipeline.

% Simulation length (hours)
duration_hours = 48;
dt = 1/fs;                      % seconds per sample
t_sec = 0:dt:duration_hours*3600; % time vector in seconds
t_h = t_sec / 3600;             % time in hours for plotting

% Example plant parameters (keep units consistent: time constants in seconds)
K = 1;                          % unit gain
tau_hours = 2;                  % time constant in hours
tau = tau_hours * 3600;         % convert to seconds

% Input: simple on/off heater switching every 6 hours (in hours)
heater_period_hours = 6;
u = double(mod(floor(t_h/heater_period_hours),2) == 0); % 1 or 0

% Simulate first-order ODE: dh/dt = -(1/tau)*h + K*u  (Euler forward)
h = zeros(size(t_sec));
for k = 2:length(t_sec)
    h(k) = h(k-1) + (-(1/tau)*h(k-1) + K*u(k-1)) * dt;
end

% Plot
figure('Name','Laplace-Like Heating Control Model (Toolbox-Free)','Color',[0.12 0.12 0.12]);
subplot(2,1,1);
plot(t_h, u, 'LineWidth', 1.2);
xlabel('Time (h)'); ylabel('Heater Input');
title('Heater Control Input (u(t))','Color','w');
ylim([-0.1 1.1]); grid on;

subplot(2,1,2);
plot(t_h, h, 'LineWidth', 1.4);
xlabel('Time (h)'); ylabel('Temp Response (arb. units)');
title('First-Order Heating System Response','Color','w');
grid on;

% Print short summary to console (helpful for demo narration)
fprintf('Laplace-like demo: tau = %.2f hours, duration = %d hours, samples = %d\n', ...
    tau_hours, duration_hours, length(t_sec));
end
