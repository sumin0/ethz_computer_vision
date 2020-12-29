% show feature matches between two images
%
% Input:
%   img1        - n x m color image 
%   corner1     - 2 x k matrix, holding keypoint coordinates of first image
%   img2        - n x m color image 
%   corner1     - 2 x k matrix, holding keypoint coordinates of second image
%   fig         - figure id
function showFeatureMatches(img1, corner1, img2, corner2, fig, inliers, outliers)
    [sx, sy, sz] = size(img1);
    img = [img1, img2];
    
    corner2 = corner2 + repmat([sy, 0]', [1, size(corner2, 2)]);
    
    figure(fig), imshow(img, []);    
    hold on, plot(corner1(1,:), corner1(2,:), '+r');
    hold on, plot(corner2(1,:), corner2(2,:), '+r');
    hold on, plot([corner1(1,inliers); corner2(1,inliers)], [corner1(2,inliers); corner2(2,inliers)], 'b');
    hold on, plot([corner1(1,outliers); corner2(1,outliers)], [corner1(2,outliers); corner2(2,outliers)], 'k');
end