%%% SIO112 
%%% Chapter ω
%%% Example 3.1: Other SDEs
% William Davis, June 2023
clearvars,close all

%% Plotting variables
big_font = 20;

%% SDE model, functions

x_domain = linspace(-2,2,100);

% Example functions here, feel free to change
f = @(x) 0.1*x;
g = @(x) 0.5*x;

f_sample = arrayfun(f,x_domain);
g_sample = arrayfun(g,x_domain);

figure
subplot(1,2,1)
plot(x_domain,f_sample)
xlabel('x')
ylabel('f(x)')
title('Drift function')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)
subplot(1,2,2)
plot(x_domain,g_sample)
xlabel('x')
ylabel('g(x)')
title('Diffusion function')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

%% SDE model, integrate numerically

% Settings
dt = 0.01;
tend = 100;
x0 = 0.1;

[t,X] = euler_maruyama(f,g,dt,tend,x0);

figure
plot(t,X,'k-','LineWidth',1)
xlabel('Time, t')
ylabel('Observation, X(t)')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

%% Ornstein-Uhlenbeck process, repeat

% Integration 1
[t1,X1] = euler_maruyama(f,g,dt,tend,x0);

% Integration 2
[t2,X2] = euler_maruyama(f,g,dt,tend,x0);

figure
hold on,box on
plot(t1,X1,'-','LineWidth',1)
plot(t2,X2,'-','LineWidth',1)
xlabel('Time, t')
ylabel('Observation, X(t)')
legend('Int. 1','Int. 2')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)
