function hist = color_histogram(xMin,yMin,xMax,yMax,frame,num_hist_bin)

% bounding box sanity check
x_min = ceil(max(1,xMin));
y_min = ceil(max(1,yMin));
x_max = floor(min(xMax,size(frame,2)));
y_max = floor(min(yMax,size(frame,1)));

r = frame(y_min:y_max, x_min:x_max, 1);
g = frame(y_min:y_max, x_min:x_max, 2);
b = frame(y_min:y_max, x_min:x_max, 3);

hist_r = imhist(r, num_hist_bin);
hist_g = imhist(g, num_hist_bin);
hist_b = imhist(b, num_hist_bin);

hist = [hist_r; hist_g; hist_b];

% normalization
hist = hist/sum(hist);

end