%% !!! DO NOT CHANGE THE FUNCTION INTERFACE, OTHERWISE, YOU MAY GET 0 POINT !!! %%
% xy: size 2xn
% XYZ: size 3xn
% xy_normalized: 3xn
% XYZ_normalized: 4xn
% T: 3x3
% U: 4x4

function [xy_normalized, XYZ_normalized, T, U] = normalization(xy, XYZ)
%data normalization

% TODO 1. compute centroids
[~, n] = size(xy);
xy_centroid = [sum(xy(1,:)), sum(xy(2,:))] / n;

xyz_centroid = [sum(XYZ(1,:)), sum(XYZ(2,:)), sum(XYZ(3,:))] / n;

% TODO 2. shift the points to have the centroid at the origin
xy_shift = xy - repmat(xy_centroid', 1, n);
xyz_shift = XYZ - repmat(xyz_centroid', 1, n);

% TODO 3. compute scale
scale2d = 0;
for i=1:n
    scale2d = scale2d + sqrt(xy_shift(1,i)^2 + xy_shift(2,i)^2)/n;
end

scale3d = 0;
for i=1:n
    scale3d = scale3d ...
    + sqrt(xyz_shift(1,i)^2 + xyz_shift(2,i)^2 + xyz_shift(3,i)^2)/n;
end

% TODO 4. create T and U transformation matrices (similarity transformation)
T_inv = [scale2d 0 xy_centroid(1);
         0 scale2d xy_centroid(2);
         0 0 1];

U_inv = [scale3d 0 0 xyz_centroid(1);
         0 scale3d 0 xyz_centroid(2);
         0 0 scale3d xyz_centroid(3);
         0 0 0 1];
     
T = inv(T_inv);
U = inv(U_inv);

% TODO 5. normalize the points according to the transformations
xy_normalized = T_inv \ [xy; ones(1, n)];
XYZ_normalized = U_inv \ [XYZ; ones(1, n)];

end