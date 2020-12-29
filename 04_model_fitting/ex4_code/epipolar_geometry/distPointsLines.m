% Compute the distance for pairs of points and lines
% Input
%   points    Homogeneous 2D points 3xN
%   lines     2D homogeneous line equation 3xN
% 
% Output
%   d         Distances from each point to the corresponding line N
function d = distPointsLines(points, lines)

d_numerator = abs(dot(points, lines, 1)); % 1xN
d_denominator = (lines(1,:).^2 + lines(2,:).^2).^0.5; % 1xN

d = d_numerator ./ d_denominator;

end

