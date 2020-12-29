%% !!! DO NOT CHANGE THE FUNCTION INTERFACE, OTHERWISE, YOU MAY GET 0 POINT !!! %%

function [K, R, t] = decompose(P)
%Decompose P into K, R and t using QR decomposition

% TODO Compute R, K with QR decomposition such M=K*R 
M = P(:,1:3);
[iR,iK] = qr(inv(M));
R = inv(iR);
K = inv(iK);

% TODO Compute camera center C=(cx,cy,cz) such P*C=0 
[~, ~, V] = svd(P);
C = V(:,end);
C = C(1:3) / C(4);

% TODO normalize K such K(3,3)=1
K = K / K(3,3);

% TODO Adjust matrices R and Q so that the diagonal elements of K (= intrinsic matrix) are non-negative values and R (= rotation matrix = orthogonal) has det(R)=1
T = eye(3);
if K(1,1) < 0
    T(1,1) = -1;
end
if K(2,2) < 0
    T(2,2) = -1;
end
K = K*T; % K'= K*T
R = T\R; % R'= inv(T)*R

if det(R) < 0
    R = -R;
end

% TODO Compute translation t=-R*C
t = -R*C;

end