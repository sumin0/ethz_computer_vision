% Generate initial values for mu
% K is the number of segments
function mu = generate_mu(O, L, a, b, K)

mu = zeros(K,3);
for i = 1:K
    mu(i,:) = [L a b] * i/(K+1) + O;
end

end