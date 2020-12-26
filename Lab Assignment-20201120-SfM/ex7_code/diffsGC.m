function diffs = diffsGC(img1, img2, dispRange)

% get data costs for graph cut
diffs = zeros(size(img1, 1), size(img1, 2), length(dispRange));

h_size = [7 7];
H = fspecial('average', h_size);

idx = 1;
for d=dispRange
    SSD = (img1 - shiftImage(img2, d)).^2;
    diffs(:, :, idx) = conv2(SSD, H, 'same');
    idx = idx+1;
end

end