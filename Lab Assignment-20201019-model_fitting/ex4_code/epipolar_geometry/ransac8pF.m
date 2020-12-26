% Compute the fundamental matrix using the eight point algorithm and RANSAC
% Input
%   x1, x2 	  Point correspondences 3xN
%   threshold     RANSAC threshold
%
% Output
%   best_inliers  Boolean inlier mask for the best model
%   best_F        Best fundamental matrix
%
function [best_inliers, best_F] = ransac8pF(x1, x2, threshold)

iter = 1000;

num_pts = size(x1, 2); % Total number of correspondences
best_num_inliers = 0; best_inliers = [];
best_F = 0;

M = iter;
i = 1;
while M > i
    % Randomly select 8 points and estimate the fundamental matrix using these.
    indices = datasample(1:num_pts, 8, 'Replace', false);
    x1_sampled = x1(:,indices);
    x2_sampled = x2(:,indices);
    
    [Fh, ~] = fundamentalMatrix(x1_sampled, x2_sampled);
    
    % Compute the error.
    errors = (distPointsLines(x2, Fh*x1) + ...
             distPointsLines(x1, Fh'*x2)) / 2;
    
    % Compute the inliers with errors smaller than the threshold.
    inliers = (errors < threshold);
    num_inliers = nnz(inliers);
    
    % Update the number of inliers and fitting model if the current model
    % is better.
    if num_inliers > best_num_inliers
        best_inliers = inliers;
        best_num_inliers = num_inliers
        best_F = Fh;
        mean_error = mean(errors(best_inliers))
       
        p = 0.99; N = 8;
        r = best_num_inliers / num_pts;
        M = log(1-p) / log(1-r^N)
    end  
    
    i = i+1;
end

end


