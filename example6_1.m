%%% SIO112 
%%% Chapter ω
%%% Exercise 6.1: Direct estimation, OU
% William Davis, June 2023
clearvars,close all

%% Plotting variables
big_font = 20;

%% SDE model, functions

x_domain = linspace(-1.1,1.1,100);

% Example functions here, feel free to change
f = @(x) -x;
g = @(x) 0.7;

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
tend = 1000;
x0 = 0.1;

[t,X] = euler_maruyama(f,g,dt,tend,x0);

figure
plot(t,X,'k-','LineWidth',1)
xlabel('Time, t')
ylabel('Observation, X(t)')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

%% Using direct estimation, single point

% Single bin
x_eval_point = -0.5;
bin_width = 0.1;
[M1_single,M2_single] = HBR_moments(X,x_eval_point,bin_width);

f_est_single = M1_single/dt;
g_est_single = sqrt(M2_single/dt);

figure
subplot(1,2,1)
hold on,box on
plot(x_domain,f_sample,'LineWidth',2)
scatter(x_eval_point,f_est_single,50,'filled')
xlabel('x')
ylabel('f(x)')
title('Drift function')
legend('True','Estimate')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)
subplot(1,2,2)
hold on,box on
plot(x_domain,g_sample,'LineWidth',2)
scatter(x_eval_point,g_est_single,50,'filled')
ylim([0,1.2])
xlabel('x')
ylabel('g(x)')
title('Diffusion function')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)


%% Repeat for many x-evaluation points

% Single bin
npts = 20;
x_eval_range = linspace(-1,1,npts);

M1 = zeros(1,npts);
M2 = zeros(1,npts);
for i = 1:npts
    x_eval_point = x_eval_range(i);
    [M1(i),M2(i)] = HBR_moments(X,x_eval_point,bin_width);
end

f_est = M1(1,:)/dt;
g_est = sqrt(M2(1,:)/dt);

%% 

figure
subplot(1,2,1)
hold on,box on
plot(x_domain,f_sample,'LineWidth',2)
scatter(x_eval_range,f_est,50,'filled')
xlabel('x')
ylabel('f(x)')
title('Drift function')
legend('True','Estimate')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)
subplot(1,2,2)
hold on,box on
plot(x_domain,g_sample,'LineWidth',2)
scatter(x_eval_range,g_est,50,'filled')
ylim([0,1.2*g(0)])
xlabel('x')
ylabel('g(x)')
title('Diffusion function')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)
