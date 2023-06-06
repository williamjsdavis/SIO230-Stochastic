function [M1,M2] = HBR_moments(X,x_eval_point,bin_width)
% Histogram based moment, single bin
M1_sum = 0;
M2_sum = 0;
count = 0;
for k = 1:numel(X)-1
    if abs(X(k)-x_eval_point) < bin_width
        M1_sum = M1_sum + (X(k+1) - X(k));
        M2_sum = M2_sum + (X(k+1) - X(k))^2;
        count = count + 1;
    end
end
M1 = M1_sum / count;
M2 = M2_sum / count;
end