%% !!! DO NOT CHANGE THE FUNCTION INTERFACE, OTHERWISE, YOU MAY GET 0 POINT !!! %%
% xyn: 3xn
% XYZn: 4xn

function [P_normalized] = dlt(xyn, XYZn)
%computes DLT, xy and XYZ should be normalized before calling this function

% TODO 1. For each correspondence xi <-> Xi, computes matrix Ai
N = length(xyn);
A = zeros(2*N, 12);

for i=1:N
    u = xyn(1,i);
    v = xyn(2,i);
    
    A(2*i-1,1:4) = XYZn(:,i);
    A(2*i-1,9:12) = -u * XYZn(:,i);
    
    A(2*i,5:8) = XYZn(:,i);
    A(2*i,9:12) = -v * XYZn(:,i);
end

% TODO 2. Compute the Singular Value Decomposition of Usvd*S*V' = A
[~,~,V] = svd(A);

% TODO 3. Compute P_normalized (=last column of V if D = matrix with positive
% diagonal entries arranged in descending order)
P_normalized = V(:,end);
P_normalized = reshape(P_normalized, 4, 3)';

end
