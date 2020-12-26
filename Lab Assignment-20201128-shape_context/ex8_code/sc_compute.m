function shape_desc = sc_compute(X,nbBins_theta,nbBins_r,smallest_r,biggest_r)
% computing shape contexts for (deformed) model
% input X : 2*N
N = size(X,2);
% output :  (nbBins_theta * nbBins_r) * N
shape_desc = zeros(nbBins_theta*nbBins_r, N);

% normalization scale
scale = mean2(sqrt(dist2(X',X')));
% define grid
grid_r = logspace(log10(smallest_r), log10(biggest_r), nbBins_r+1);
grid_theta = linspace(0, 2*pi, nbBins_theta+1);

% for each point,
for i=1:N
    pt = X(:,i); % 2x1
    
    % define a log polar coordinate system with the point as origin
    dist_vec = X - repmat(pt, 1, N);
    
    [theta, r] = cart2pol(dist_vec(1,:),dist_vec(2,:));
    r_normalized = r / scale;
    
    % count number of points inside each bin
    shape_desc_tmp = hist3([theta' r_normalized'],'Edges', ...
        {grid_theta(1:end-1), grid_r(1:end-1)});
    shape_desc(:,i) = reshape(shape_desc_tmp, [nbBins_theta*nbBins_r, 1]);
end

end