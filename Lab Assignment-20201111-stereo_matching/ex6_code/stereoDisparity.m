function disp = stereoDisparity(img1, img2, dispRange)

% dispRange: range of possible disparity values
% --> not all values need to be checked

% predefined 2D filter
h_size = [7 7];
H = fspecial('average', h_size);

first = 1;
for d=dispRange
    % shift the image
    img2_shifted = shiftImage(img2, d);
    % SAD
    SAD = imabsdiff(img1, img2_shifted);
    % apply filter
    ldiff = conv2(SAD, H, 'same');
    
    if first
        first = 0;
        bestDiff = ldiff;
        disp = d*ones(size(bestDiff));
        continue;
    end
    
    mask = ldiff < bestDiff;
    bestDiff = bestDiff .* (~mask) + ldiff .* mask;
    disp = disp .* (~mask) + d * mask;
end

end