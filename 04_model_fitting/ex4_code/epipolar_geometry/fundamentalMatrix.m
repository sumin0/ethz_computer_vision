% Compute the fundamental matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences 3xN
%
% Output
% 	Fh 		Fundamental matrix with the det F = 0 constraint
% 	F 		Initial fundamental matrix obtained from the eight point algorithm
%
function [Fh, F] = fundamentalMatrix(x1s, x2s)

% normalize points
[nxs1,T1] = normalizePoints2d(x1s);
[nxs2,T2] = normalizePoints2d(x2s);

[~,num_points] = size(nxs1);

% Compute the matrix A (Af = 0)
A = zeros(num_points,9);
for i=1:num_points
    A(i,:) = kron(nxs1(:,i),nxs2(:,i)).';
end

% solve Af = 0
[~,~,V] = svd(A,0);
F = reshape(V(:,9),3,3);

% with det(F)=0 constraint
[u,s,v]=svd(F);
s(3,3)=0;
Fh=u*s*v';

% de-normalize
F = T2.' * F * T1;
Fh = T2.' * Fh * T1;

end
