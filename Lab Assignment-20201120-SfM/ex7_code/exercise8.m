% =========================================================================
% Exercise 8
% =========================================================================

% Initialize VLFeat (http://www.vlfeat.org/)

%K Matrix for house images (approx.)
K = [  670.0000     0     393.000
         0       670.0000 275.000
         0          0        1];

%Load images
imgName1 = './data/house.000.pgm';
imgName2 = './data/house.004.pgm';

img1 = single(imread(imgName1));
img2 = single(imread(imgName2));

%extract SIFT features and match
[fa, da] = vl_sift(img1);
[fb, db] = vl_sift(img2);

%don't take features at the top of the image - only background
filter = fa(2,:) > 100;
fa = fa(:,find(filter));
da = da(:,find(filter));

[matches, scores] = vl_ubcmatch(da, db);

showFeatureMatches(img1, fa(1:2, matches(1,:)), img2, fb(1:2, matches(2,:)), 20);

%% Compute essential matrix and projection matrices and triangulate matched points

%use 8-point ransac or 5-point ransac - compute (you can also optimize it to get best possible results)
%and decompose the essential matrix and create the projection matrices
x1_h = makehomogeneous(fa(1:2, matches(1,:)));
x2_h = makehomogeneous(fb(1:2, matches(2,:)));

[F, inliers] = ransacfitfundmatrix(x1_h, x2_h, 0.005);

% plot
x1_h_in = x1_h(:, inliers);
x2_h_in = x2_h(:, inliers);

% to plot outliers as well
outliers = setdiff(1:size(matches,2), inliers);
showFeatureMatches(img1, x1_h(1:2, :), img2, x2_h(1:2, :), 21, inliers, outliers);

% draw epipolar lines in img 1
figure(1)
imshow(img1, []); hold on, plot(x1_h_in(1,:), x1_h_in(2,:), '*r');
for k = 1:size(x1_h_in,2)
    drawEpipolarLines(F'*x2_h_in(:,k), img1, '-y');
end
% draw epipolar lines in img 2
figure(2)
imshow(img2, []); hold on, plot(x2_h_in(1,:), x2_h_in(2,:), '*r');
for k = 1:size(x2_h_in,2)
    drawEpipolarLines(F*x1_h_in(:,k), img2, '-y');
end

E = K'*F*K;
x1_calibrated = K \ x1_h_in;
x2_calibrated = K \ x2_h_in;

Ps{1} = eye(4);
Ps{2} = decomposeE(E, x1_calibrated, x2_calibrated);

%triangulate the inlier matches with the computed projection matrix
[XS, err] = linearTriangulation(Ps{1}, x1_calibrated, Ps{2}, x2_calibrated);

%% Add an addtional view of the scene 

imgName3 = './data/house.001.pgm';
img3 = single(imread(imgName3));
[fc, dc] = vl_sift(img3);

%match against the features from image 1 that where triangulated
% features, descriptors from image 1 that were triangulated
fa_tri = fa(:, matches(1,inliers));
da_tri = da(:, matches(1,inliers));

[matches_13, ~] = vl_ubcmatch(da_tri, dc);

x1_h_13 = makehomogeneous(fa_tri(1:2, matches_13(1,:)));
x3_h = makehomogeneous(fc(1:2, matches_13(2,:)));
x3_calibrated = K \ x3_h;

%run 6-point ransac
[Ps{3}, inliers_13] = ransacfitprojmatrix(x3_calibrated, XS(:,matches_13(1,:)), 0.05);

x1_h_in_13 = x1_h_13(:,inliers_13);
x3_h_in = x3_h(:,inliers_13);

% plot
% showFeatureMatches(img1, x1_h_in_13(1:2, :), img3, x3_h_in(1:2, :), 22);
% to plot outliers as well
outliers_13 = setdiff(1:size(matches_13,2), inliers_13);
showFeatureMatches(img1, x1_h_13(1:2, :), img3, x3_h(1:2, :), 22, inliers_13, outliers_13);

%triangulate the inlier matches with the computed projection matrix
x1_calibrated_13 = K \ x1_h_in_13;
x3_calibrated_in = K \ x3_h_in;

[XS_13, err_13] = linearTriangulation(Ps{1}, x1_calibrated_13, Ps{3}, x3_calibrated_in);

%% Add more view...

imgName4 = './data/house.002.pgm';
img4 = single(imread(imgName4));
[fd, dd] = vl_sift(img4);

%match against the features from image 1 that where triangulated
% features, descriptors from image 1 that were triangulated
[matches_14, ~] = vl_ubcmatch(da_tri, dd);

x1_h_14 = makehomogeneous(fa_tri(1:2, matches_14(1,:)));
x4_h = makehomogeneous(fd(1:2, matches_14(2,:)));
x4_calibrated = K \ x4_h;

%run 6-point ransac
[Ps{4}, inliers_14] = ransacfitprojmatrix(x4_calibrated, XS(:,matches_14(1,:)), 0.05);

x1_h_in_14 = x1_h_14(:,inliers_14);
x4_h_in = x4_h(:,inliers_14);

% plot
% showFeatureMatches(img1, x1_h_in_14(1:2, :), img4, x4_h_in(1:2, :), 23);
outliers_14 = setdiff(1:size(matches_14,2), inliers_14);
showFeatureMatches(img1, x1_h_14(1:2, :), img4, x4_h(1:2, :), 23, inliers_14, outliers_14);

%triangulate the inlier matches with the computed projection matrix
x1_calibrated_14 = K \ x1_h_in_14;
x4_calibrated_in = K \ x4_h_in;

[XS_14, err_14] = linearTriangulation(Ps{1}, x1_calibrated_14, Ps{4}, x4_calibrated_in);

%% Add more view...

imgName5 = './data/house.003.pgm';
img5 = single(imread(imgName5));
[fe, de] = vl_sift(img5);

%match against the features from image 1 that where triangulated
% features, descriptors from image 1 that were triangulated
[matches_15, ~] = vl_ubcmatch(da_tri, de);

x1_h_15 = makehomogeneous(fa_tri(1:2, matches_15(1,:)));
x5_h = makehomogeneous(fe(1:2, matches_15(2,:)));
x5_calibrated = K \ x5_h;

%run 6-point ransac
[Ps{5}, inliers_15] = ransacfitprojmatrix(x5_calibrated, XS(:,matches_15(1,:)), 0.05);

x1_h_in_15 = x1_h_15(:,inliers_15);
x5_h_in = x5_h(:,inliers_15);

% plot
% showFeatureMatches(img1, x1_h_in_15(1:2, :), img5, x5_h_in(1:2, :), 24);
outliers_15 = setdiff(1:size(matches_15,2), inliers_15);
showFeatureMatches(img1, x1_h_15(1:2, :), img5, x5_h(1:2, :), 24, inliers_15, outliers_15);

%triangulate the inlier matches with the computed projection matrix
x1_calibrated_15 = K \ x1_h_in_15;
x5_calibrated_in = K \ x5_h_in;

[XS_15, err_15] = linearTriangulation(Ps{1}, x1_calibrated_15, Ps{5}, x5_calibrated_in);

%% Plot stuff

fig = 10;
figure(fig);

%use plot3 to plot the triangulated 3D points
plot3(XS(1,:),XS(2,:),XS(3,:),'r.'); hold on;
plot3(XS_13(1,:),XS_13(2,:),XS_13(3,:),'g.'); hold on;
plot3(XS_14(1,:),XS_14(2,:),XS_14(3,:),'b.'); hold on;
plot3(XS_15(1,:),XS_15(2,:),XS_15(3,:),'y.'); hold on;

%draw cameras
drawCameras(Ps, fig);

%% Dense Reconstruction
% rectify image
imgNameL = './data/house.000.pgm';
imgNameR = './data/house.001.pgm';

scale = 1;
imgL = imresize(imread(imgNameL), scale);
imgR = imresize(imread(imgNameR), scale);

PL = K * Ps{1}(1:3,:);
PR = K * Ps{3}(1:3,:);

[imgRectL, imgRectR, Hleft, Hright, maskL, maskR] = ...
    getRectifiedImages(imgL, imgR);

figure(25);
subplot(121); imshow(imgRectL);
subplot(122); imshow(imgRectR);

%%
% get disparity map using graphcut
% [x1s, x2s] = getClickedPoints(imgRectL, imgRectR);
dispRange = -20:20;
% dispRange = -50:50;

%%
Labels = ...
    gcDisparity(imgRectL, imgRectR, dispRange);
dispsGCL = double(Labels + dispRange(1));
Labels = ...
    gcDisparity(imgRectR, imgRectL, dispRange);
dispsGCR = double(Labels + dispRange(1));

figure(1);
subplot(121); imshow(dispsGCL, [dispRange(1) dispRange(end)]);
subplot(122); imshow(dispsGCR, [dispRange(1) dispRange(end)]);

%%
se = strel('square', 15);
maskL = imerode(maskL, se);
maskR = imerode(maskR, se);

thresh = 2;
maskLRcheck = leftRightCheck(dispsGCL, dispsGCR, thresh);
maskRLcheck = leftRightCheck(dispsGCR, dispsGCL, thresh);

maskGCL = double(maskL).*maskLRcheck;
maskGCR = double(maskR).*maskRLcheck;

%%
b = norm(Ps{1}(:,4)-Ps{3}(:,4));
f = K(1,1);
depthGCL = b * f ./ dispsGCL;
imgRectR_fakergb=cat(3, imgRectR, imgRectR, imgRectR);
% Get 3D model
create3DModel(depthGCL .* (maskGCL.*maskGCR), imgRectR_fakergb, 30);

%%
dispsGCL = double(dispsGCL);
dispsGCR = double(dispsGCR);

S = [scale 0 0; 0 scale 0; 0 0 1];

% For each pixel (x,y), compute the corresponding 3D point 
% use S for computing the rescaled points with the projection 
% matrices PL PR
[coords ~] = ...
    generatePointCloudFromDisps(dispsGCL, Hleft, Hright, S*PL, S*PR);

% imwrite(imgRectL, 'imgRectL.png');
% imwrite(imgRectR, 'imgRectR.png');

% Use meshlab to open generated textured model, i.e. modelGC.obj
generateObjFile('modelGC', 'imgRectL.png', ...
    coords, maskGCL.*maskGCR);
