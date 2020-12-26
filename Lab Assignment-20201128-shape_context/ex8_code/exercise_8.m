%% main file for exercise 8

data = load('dataset.mat');
objects = data.objects;

% X, class, img
% 1-5 Heart
% 6-10 fork
% 11-15 watch

%%
idx_template=12;
idx_target=11;

X_template=objects(idx_template).X;
X_target=objects(idx_target).X;
img_template=objects(idx_template).img;
img_target=objects(idx_target).img;

figure()
subplot(1,2,1)
imshow(img_template);
title('Template Image')
subplot(1,2,2)
imshow(img_target);
title('Target Image')

%% resize
nbSamples = 1000;
sX_template = sample_pts(X_template, nbSamples);
sX_target = sample_pts(X_target, nbSamples);

%%
display=1;
% matchingCost=shape_matching(sX_template,sX_target,display);
matchingCost=shape_matching(X_template,X_target,display);
