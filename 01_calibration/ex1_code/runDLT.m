%% !!! DO NOT CHANGE THE FUNCTION INTERFACE, OTHERWISE, YOU MAY GET 0 POINT !!! %%
% xy: size 2xn
% XYZ: size 3xn 

function [P, K, R, t, error] = runDLT(xy, XYZ)

% normalize 
[xy_normalized, XYZ_normalized, T, U] = normalization(xy, XYZ);

%compute DLT with normalized coordinates
[Pn] = dlt(xy_normalized, XYZ_normalized);

% TODO denormalize projection matrix
P = T \ Pn * U;

%factorize projection matrix into K, R and t
[K, R, t] = decompose(P);   

% TODO compute average reprojection error
N = length(xy);
error = 0;
for i=1:N
    xy_computed = P*[XYZ(:,i); 1];
    xy_computed = xy_computed(1:2) / xy_computed(3);
    error = error + norm(xy_computed - xy(:,i), 2)^2;
end
error = error / N;