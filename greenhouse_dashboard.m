function greenhouse_dashboard(t, L, denoised, fs)
% Minimal UI showing temp and a slider for cutoff frequency to re-filter temperature live
fig = uifigure('Name','Greenhouse Dashboard','Position',[100 100 900 600]);
ax = uiaxes(fig,'Position',[25 125 850 450]);
plot(ax, L.hours, L.temperature, 'DisplayName','after LTI'); hold(ax,'on');
hPlotD = plot(ax, L.hours, denoised.temperature, 'DisplayName','denoised'); hold(ax,'off');
xlabel(ax,'Hours'); ylabel(ax,'Temperature (C)');
legend(ax);

lbl = uilabel(fig,'Position',[25 80 300 20],'Text','Lowpass cutoff (cycles/hour):');
sld = uislider(fig,'Position',[25 60 300 3],'Limits',[0.001 0.1],'Value',1/24);
sld.ValueChangedFcn = @(s,event) update_cutoff(s, event, L, t, fs, hPlotD);

end

function update_cutoff(src, event, L, t, fs, hPlotD)
    % Get new cutoff from slider
    cutoff = src.Value;

    % Toolbox-free simple first-order RC filter
    % a*y[n] = y[n-1] + b*(x[n] - y[n-1])
    dt = 1/fs;
    RC = 1/(2*pi*cutoff);
    alpha = dt / (RC + dt);

    filtered = zeros(size(L));
    filtered(1) = L(1);

    for i = 2:length(L)
        filtered(i) = filtered(i-1) + alpha * (L(i) - filtered(i-1));
    end

    % Update plot
    set(hPlotD, 'YData', filtered);
    drawnow;
end
