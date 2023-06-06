%%% SIO112 
%%% Chapter ω
%%% Exercise 6.3: Direct estimation, empirical data
% William Davis, June 2023
clearvars,close all

%% Plotting variables
big_font = 20;

%% Load example data

% Settings
filename = 'example_data.mat';
load(filename,"X","t")
dt = t(2) - t(1);

figure
plot(t,X,'k-','LineWidth',1)
xlabel('Time, t')
ylabel('Observation, X(t)')
title('Empirical data')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

%% Repeat for many x-evaluation points

% Single bin
npts = 20;
x_eval_range = linspace(-1,1,npts);
bin_width = 0.1;

M1 = zeros(1,npts);
M2 = zeros(1,npts);
for i = 1:npts
    x_eval_point = x_eval_range(i);
    [M1(i),M2(i)] = HBR_moments(X,x_eval_point,bin_width);
end

f_est = M1(1,:)/dt;
g_est = sqrt(M2(1,:)/dt);

%% Plot results

figure
subplot(1,2,1)
scatter(x_eval_range,f_est,50,'filled')
xlabel('x')
ylabel('f(x)')
title('Drift function')
legend('Estimate')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)
subplot(1,2,2)
scatter(x_eval_range,g_est,50,'filled')
ylim([0,1.2])
xlabel('x')
ylabel('g(x)')
title('Diffusion function')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

%% Compare with true model

% Change this to true when you're ready to see the true model
reveal_true_model = true;

if reveal_true_model
    [x_domain,f_sample,g_sample] = get_secret_model();

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
    ylim([0,1.2])
    xlabel('x')
    ylabel('g(x)')
    title('Diffusion function')
    set(findall(gcf,'-property','FontSize'),'FontSize',big_font)
end