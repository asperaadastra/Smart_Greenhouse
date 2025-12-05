function [denoised, filters] = filter_and_denoise(lti_signals, t, fs)
    fields = fieldnames(lti_signals);
    denoised = struct();
    filters = struct();

    for i = 1:length(fields)
        name = fields{i};
        signal = lti_signals.(name);

        % Create a simple FIR low-pass filter using moving average
        window_size = round(fs * 0.2);   % smooth over 0.2 hour
        if window_size < 5
            window_size = 5;
        end
        kernel = ones(window_size,1) / window_size;

        filtered = conv(signal, kernel, 'same');

        denoised.(name) = filtered;
        filters.(name) = kernel;
    end
end
