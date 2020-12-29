function [map, peak] = meanshiftSeg(img)

% Get density function X (total_num_pixels*3)
img = double(img);
N = size(img,1) * size(img,2);
X = [reshape(img(:,:,1)',[N,1]), ...
     reshape(img(:,:,2)',[N,1]), ...
     reshape(img(:,:,3)',[N,1])];

r = 10;
[map, peak] = mean_shift(X, r);
map = reshape(map,[size(img,2) size(img,1)])';

end