function P = expectation(mu,var,alpha,X)

K = length(alpha);
P = zeros(size(X,1), K);

for i = 1:size(X,1)
    for k = 1:K
        exp_arg = -0.5*(X(i,:)-mu(k,:)) * ...
            pinv(var(:,:,k)) * (X(i,:)-mu(k,:))';
        P(i,k) = alpha(k) / ((2*pi)^(K/2)*(det(var(:,:,k)))^(1/2)) ...
            * exp(exp_arg);
    end
    P(i,:) = P(i,:)/sum(P(i,:));
end

end