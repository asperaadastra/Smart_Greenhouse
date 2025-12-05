function do_fft_and_plots(raw, lti, t, fs)
% do_fft_and_plots Compare spectra before and after LTI processing
%   Shows time-domain and frequency-domain comparisons for temperature and soil moisture.

fs = fs; % Hz
N = length(t);
f = (0:N-1)*(fs/N);  % frequency axis (Hz)
f_hours = f*3600;    % convert to cycles per hour

% We'll plot using magnitude FFT (single-sided)
vars = {'temperature','soil_moisture','co2'};
for v = 1:length(vars)
    name = vars{v};
    x_raw = raw.(name);
    x_lti = lti.(name);

    % Compute FFT
    X_raw = fft(x_raw);
    X_lti = fft(x_lti);

    mag_raw = abs(X_raw)/N;
    mag_lti = abs(X_lti)/N;

    figure('Name', ['Time & Freq: ' name], 'NumberTitle','off','Position',[100 100 900 600]);
    subplot(2,2,1);
    plot(raw.hours, x_raw);
    xlabel('Hours'); ylabel(name); title([name ' (raw)']);
    xlim([min(raw.hours) max(raw.hours)]);

    subplot(2,2,2);
    plot(lti.hours, x_lti);
    xlabel('Hours'); ylabel(name); title([name ' (after LTI)']);
    xlim([min(lti.hours) max(lti.hours)]);

    subplot(2,1,2);
    % plot up to e.g. 4 cycles per day (i.e., up to ~0.2 cycles/hour)
    maxf_idx = find(f_hours <= 8, 1, 'last'); % up to 8 cycles/hour for detail (adjust)
    plot(f_hours(1:maxf_idx), mag_raw(1:maxf_idx), 'DisplayName','raw'); hold on;
    plot(f_hours(1:maxf_idx), mag_lti(1:maxf_idx), 'DisplayName','after LTI'); hold off;
    xlabel('Frequency (cycles/hour)'); ylabel('Magnitude'); title(['Spectrum of ' name]);
    legend();
end
end
