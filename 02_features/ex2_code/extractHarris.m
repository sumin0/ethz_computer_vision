% Extract Harris corners.
%
% Input:
%   img           - n x m gray scale image
%   sigma         - smoothing Gaussian sigma
%                   suggested values: .5, 1, 2
%   k             - Harris response function constant
%                   suggested interval: [4e-2, 6e-2]
%   thresh        - scalar value to threshold corner strength
%                   suggested interval: [1e-6, 1e-4]
%   
% Output:
%   corners       - 2 x q matrix storing the keypoint positions
%   C             - n x m gray scale image storing the corner strength
function [corners, C] = extractHarris(img, sigma, k, thresh)
% Image gradient
sobel_1 = [-1 0 1];
sobel_2 = [1 2 1];

Ix = conv2(sobel_2', sobel_1, img, 'valid');
Iy = conv2(sobel_1', sobel_2, img, 'valid');

% auto-correlation matrix
Ixx = double(Ix .^ 2);
Iyy = double(Iy .^ 2);
Ixy = double(Ix .* Iy);

wIxx = imgaussfilt(Ixx, sigma);
wIyy = imgaussfilt(Iyy, sigma);
wIxy = imgaussfilt(Ixy, sigma);

% Harris response
score = (wIxx.*wIyy - wIxy.^2) - k*(wIxx + wIyy).^2;
C = score;

% Detection
score(score<thresh) = 0;

BW = imregionalmax(score);
[i, j] = find(BW);
corners = [i, j]';

end