function laplace_control_demo(fs)
    % Demonstration of Laplace transform connection without Control Toolbox
    % Simple heating control model: first-order system
    % dh/dt = -(1/tau)*h + K*u

    K = 1;          % system gain
    tau = 5;        % time constant (hours)
    t = 0:1/fs:48;  % simulation for 48 hours

    % Input: simple on/off heater command
    u = double(mod(floor(t/6),2)==0);  % heater ON for 6h, OFF for 6h

    % Solve differential equation manually
    h = zeros(size(t));
    for k = 2:length(t)
        h(k) = h(k-1) + (-(1/tau)*h(k-1) + K*u(k-1)) * (1/fs);
    end

    % Plot results
    figure('Name','Laplace-Like Heating Control Model (Toolbox-Free)');
    subplot(2,1,1);
    plot(t,u);
    xlabel('Time (h)');
    ylabel('Heater Input');
    title('Heater Control Input (u(t))');
    grid on;

    subplot(2,1,2);
    plot(t,h,'LineWidth',1.4);
    xlabel('Time (h)');
    ylabel('Temp Response');
    title('First-Order Heating System Response');
    grid on;
end
