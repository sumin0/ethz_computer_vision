% Normalization of 2d-pts
% Inputs: 
%           xs = 2d points
% Outputs:
%           nxs = normalized points
%           T = 3x3 normalization matrix
%               (s.t. nx=T*x when x is in homogenous coords)
function [nxs, T] = normalizePoints2d(xs)
% xs : 3 x num_points
num_points = size(xs,2);

% convert
xs_2 = xs ./ repmat( xs(3,:),3,1);

% calculate centroid
mu = mean(xs_2(1:2,:),2);

% scale it to the mean squared distance
xs_shifted = xs_2(1:2,:)-repmat(mu,1,num_points);
scale = sqrt( mean(sum(xs_shifted.^2)) );
s = sqrt(2) / scale;

T = [s 0 -s*mu(1);
     0 s -s*mu(2);
     0 0 1];

nxs = T*xs;

end
