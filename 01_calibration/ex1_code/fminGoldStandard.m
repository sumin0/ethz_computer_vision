%% !!! DO NOT CHANGE THE FUNCTION INTERFACE, OTHERWISE, YOU MAY GET 0 POINT !!! %%
% xy_normalized: 3xn
% XYZ_normalized: 4xn

function f = fminGoldStandard(pn, xy_normalized, XYZ_normalized)

%reassemble P
P = [pn(1:4);pn(5:8);pn(9:12)];

% TODO compute reprojection errors
xy_computed = P*XYZ_normalized;
xy_new = xy_computed ./ xy_computed(3,:);

diff = xy_new(1:2,:) - xy_normalized(1:2,:);
error = diag(diff'*diff);

% TODO compute cost function value
f = sum(error);

end