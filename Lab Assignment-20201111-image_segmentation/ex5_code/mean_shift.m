function [map, peak] = mean_shift(X, r)

% create kdtree for rangesearch
kdt = KDTreeSearcher(X);

N = size(X, 1);
% map holds id of the associated peak for each pixel
map = zeros(N,1);

for i=1:N
    % show progress
    if mod(i,1000)==0
        i
    end
    
    % find peak
    curr_peak = find_peak(X, X(i,:), r, kdt);
    
    % initial
    if i == 1
        peak = curr_peak;
        map(i) = 1;
        continue;
    end
    
    % check distance
    num_peak = size(peak, 1);
    dist = vecnorm(repmat(curr_peak, [num_peak, 1]) - peak, 2, 2);
    [M, I] = min(dist,[],1);
    if M < r/2
        map(i) = I;
    else
        map(i) = num_peak + 1;
        peak = [peak; curr_peak];
    end
end

end