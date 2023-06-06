function [t,x] = euler_maruyama(f,g,dt,tend,x0)
% Euler-Maruyama method
t = 0:dt:tend;
n = length(t);
x = zeros(size(t)); 
x(1) = x0;
for i = 2:n
    x(i) = x(i-1) + f(x(i-1))*dt + g(x(i-1))*sqrt(dt)*randn;
end
end