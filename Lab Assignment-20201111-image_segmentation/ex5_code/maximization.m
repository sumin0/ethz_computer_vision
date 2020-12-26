function [mu, var, alpha] = maximization(P, X)

K = size(P,2);
N = size(X,1);

alpha = zeros(K, 1);
mu = zeros(K, 3);
var = zeros(3, 3, K);

mean_P = mean(P,1);

for k = 1:K
    alpha(k) = mean_P(k);
    mu(k,:) = P(:,k)'*X/(alpha(k)*N);
    var_tmp = zeros(3, 3, N);
    for i = 1:N
        var_tmp(:,:,i) = P(i,k)*((X(i,:)-mu(k,:))'*(X(i,:)-mu(k,:)));
    end
    var(:,:,k) = sum(var_tmp,3)/(alpha(k)*N);
end


end