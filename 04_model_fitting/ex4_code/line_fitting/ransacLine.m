function [best_k, best_b] = ransacLine(data, iter, threshold)
% data: a 2xn dataset with n data points
% iter: the number of iterations
% threshold: the threshold of the distances between points and the fitting line

num_pts = size(data, 2); % Total number of points
best_num_inliers = 0;   % Best fitting line with largest number of inliers
best_k = 0; best_b = 0;     % parameters for best fitting line

for i=1:iter
    % Randomly select 2 points and fit line to these
    % Tip: Matlab command randperm / randsample is useful here
    samples = datasample(data, 2, 2, 'Replace', false);
    
    % Model is y = k*x + b. You can ignore vertical lines for the purpose
    % of simplicity.
    model = polyfit(samples(1, :), samples(2, :), 1);
    k = model(1);
    b = model(2);
    % Compute the distances between all points with the fitting line
    dist = abs((-data(2,:)+k*data(1,:)+b) / (sqrt(1+k*k)));
%     dist = abs(polyval(model, data(1, :)) - data(2, :));
    
    % Compute the inliers with distances smaller than the threshold
    inliers = data(:,dist <= threshold);
    
    % Update the number of inliers and fitting model if the current model
    % is better.
    if best_num_inliers < length(inliers)
       best_num_inliers = length(inliers);
       model = polyfit(inliers(1, :), inliers(2, :), 1);
       best_k = model(1);
       best_b = model(2);
    end
end


end
