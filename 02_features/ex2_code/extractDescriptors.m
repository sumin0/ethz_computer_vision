% Extract descriptors.
%
% Input:
%   img           - the gray scale image
%   keypoints     - detected keypoints in a 2 x q matrix
%   
% Output:
%   keypoints     - 2 x q' matrix
%   descriptors   - w x q' matrix, stores for each keypoint a
%                   descriptor. w is the size of the image patch,
%                   represented as vector
function [keypoints, descriptors] = extractDescriptors(img, keypoints)
% patch size = 9
r = 4;
% filter out keypoints that are too close to the edge
[width, height] = size(img);
mask1 = (keypoints(1,:)>=1+r) & (keypoints(1,:)<=width-r);
mask2 = (keypoints(2,:)>=1+r) & (keypoints(2,:)<=height-r);
mask = mask1 & mask2;
keypoints = keypoints(:, mask);

% extract descriptors
descriptors = extractPatches(img, keypoints, r*2+1);

end