function [map cluster] = EM(img)
% Get density function X (L*3)
N = size(img,1) * size(img,2);
X = [reshape(img(:,:,1)',[N,1]), ...
     reshape(img(:,:,2)',[N,1]), ...
     reshape(img(:,:,3)',[N,1])];
% X = double(X);

% number of clusters
K = 5;

% use function generate_mu to initialize mus
% use function generate_cov to initialize covariances
dL = max(X(:,1)) - min(X(:,1));
da = max(X(:,2)) - min(X(:,2));
db = max(X(:,3)) - min(X(:,3));
origin = [min(X(:,1)) min(X(:,2)) min(X(:,3))];
mu = generate_mu(origin, dL, da, db, K);
cov = generate_cov(dL, da, db, K);
alpha = ones(1,K) / K;

% iterate between maximization and expectation
% use function maximization
% use function expectation
max_iteration = 100;
it = 0;
thre = 0.5;

while it < max_iteration
    % E step
    P = expectation(mu, cov, alpha, X);
    % M step
    [new_mu, new_cov, new_alpha] = maximization(P, X);
       
    % termination condition
    diff_vec = new_mu - mu; % (K,3)
    delta_mu = sum(diff_vec .* diff_vec, 2);
    
    % update variable
    mu = new_mu;
    cov = new_cov;
    alpha = new_alpha;
    
    if max(delta_mu) < thre
        mu
        cov
        alpha
        break;
    end
    
    it = it+1
end

[~,idx] = max(P,[],2);
map = reshape(idx,[size(img,2) size(img,1)])';
cluster = mu;

end