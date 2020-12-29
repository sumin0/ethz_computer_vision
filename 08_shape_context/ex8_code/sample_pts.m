function sampled_pts = sample_pts(X, num_samples)

num_original = size(X, 1);
rand_idx = randperm(num_original);
rand_idx = rand_idx(1:num_samples);

sampled_pts = X(rand_idx, :);

end