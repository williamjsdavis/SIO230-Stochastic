function [x_domain,f_sample,g_sample] = get_secret_model()
% Secret model

x_domain = linspace(-1.1,1.1,100);

% Example functions here, feel free to change
f = @(x) x - 2*x^3;
g = @(x) 0.2 + (abs(x)<0.5).*(0.5^2 - x.^2);

f_sample = arrayfun(f,x_domain);
g_sample = arrayfun(g,x_domain);
end