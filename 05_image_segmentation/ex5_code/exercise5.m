function run_ex5()

% load image
img = imread('cow.jpg');
% img = imread('zebra_b.jpg');
% for faster debugging you might want to decrease the size of your image
% (use imresize)
% (especially for the mean-shift part!)

figure, imshow(img), title('original image')

% smooth image (5.1a)
% (replace the following line with your code for the smoothing of the image)
imgSmoothed = imgaussfilt(img, 5.0, 'FilterSize', 5);
figure, imshow(imgSmoothed), title('smoothed image')

% convert to L*a*b* image (5.1b)
% (replace the folliwing line with your code to convert the image to lab
% space
imglab = applycform(imgSmoothed, makecform('srgb2lab'));
figure, imshow(imglab), title('l*a*b* image')

%%
% (5.2)
% imglab = rgb2lab(imgSmoothed);
[mapMS, peak] = meanshiftSeg(imglab);
visualizeSegmentationResults (mapMS,peak);

%%
% (5.3)
imglab = rgb2lab(imgSmoothed);
[mapEM, cluster] = EM(imglab);
visualizeSegmentationResults (mapEM,cluster);

end