function do_fft_and_plots(raw, lti, t, fs)
% do_fft_and_plots
%   FFT before/after LTI + normalized spectra + annotations + anomaly detection

fields = {'temperature','soil_moisture','co2'};
N = length(t);
f = (0:N-1)*(fs/N);
f_hours = f*3600;
t_hours = t / 3600;

for k = 1:length(fields)

    name = fields{k};
    x_raw = raw.(name);
    x_lti = lti.(name);

    % ===== FFT & Normalize =====
    X = abs(fft(x_raw));
    Y = abs(fft(x_lti));

    Xn = X / max(X);
    Yn = Y / max(Y);

    % ===== SIMPLE Anomaly detection (High-frequency noise) =====
    hf_raw = sum(Xn(round(end*0.5):end));
    hf_lti = sum(Yn(round(end*0.5):end));

    fprintf("\n=== %s FFT Anomaly Report ===\n", upper(name));
    fprintf("HF Energy (raw): %.4f\n", hf_raw);
    fprintf("HF Energy (LTI): %.4f\n", hf_lti);

    if hf_raw > 0.12, fprintf("⚠️ Raw signal anomaly: possible noise burst\n"); end
    if hf_lti > 0.12, fprintf("⚠️ LTI output anomaly: poor sensor dynamic filtering\n"); end
    fprintf("=======================================\n");

    % ===== PLOTS =====
    figure('Name', ['Time & Freq: ' name], 'NumberTitle','off');

    subplot(2,2,1)
    plot(t_hours, x_raw, 'LineWidth',1.1)
    xlabel("Hours"); ylabel(name); title([name ' (raw)']); grid on;

    subplot(2,2,2)
    plot(t_hours, x_lti, 'LineWidth',1.1)
    xlabel("Hours"); ylabel(name); title([name ' (after LTI)']); grid on;

    % Choose useful frequency region
    maxidx = find(f_hours <= 8, 1, 'last'); 

    subplot(2,1,2)
    plot(f_hours(1:maxidx), Xn(1:maxidx), 'LineWidth',1.2, 'DisplayName','raw'); hold on;
    plot(f_hours(1:maxidx), Yn(1:maxidx), 'LineWidth',1.2, 'DisplayName','after LTI'); 
    xlabel("Frequency (cycles/hour)"); ylabel("Normalized Magnitude");
    title(['FFT (normalized) – ' name]); grid on; legend;

    % ===== Anomaly annotation (CO₂ drop event) =====
    if strcmp(name,'co2')
        low_threshold = 350;
        idx = find(x_raw < low_threshold, 1);
        if ~isempty(idx)
            hold on;
            plot(f_hours(1), Xn(1),'ro'); % marking presence only
            xline(t_hours(idx),'r--','Ventilation Event',...
                'LabelVerticalAlignment','bottom',...
                'LabelHorizontalAlignment','left');
        end
    end

end

end
