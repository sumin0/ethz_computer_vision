% Generate initial values for the K
% covariance matrices

function cov = generate_cov(L, a, b, K)

cov = zeros(3, 3, K);
for i = 1:K
    cov(:,:,i) = diag([L a b]);
end

end