function [descriptors,patches] = descriptors_hog(img,vPoints,cellWidth,cellHeight)

    nBins = 8;
    nCellsW = 4; % number of cells, hard coded so that descriptor dimension is 128
    nCellsH = 4; 

    w = cellWidth; % set cell dimensions
    h = cellHeight;   

    pw = w*nCellsW; % patch dimensions
    ph = h*nCellsH; % patch dimensions

    descriptors = zeros(0,nBins*nCellsW*nCellsH); % one histogram for each of the 16 cells
    patches = zeros(0,pw*ph); % image patches stored in rows    
    
    [grad_x,grad_y] = gradient(img);    
    Gdir = (atan2(grad_y, grad_x)); 
    
    for i = 1:size(vPoints,1) % for all local feature points
        patch = img((vPoints(i,2)-ph/2):(vPoints(i,2)+ ph/2-1), ...
                    (vPoints(i,1)-pw/2):(vPoints(i,1)+ pw/2-1));
        patches(i,:) = reshape(patch, 1, []);
        
        ind = 1;
        for j = -2:1
            for k = -2:1
                grads = Gdir((vPoints(i,2)+ k*h):(vPoints(i,2)+ (k+1)*h-1), ...
                             (vPoints(i,1)+ j*w):(vPoints(i,1)+ (j+1)*w-1));
                descriptors(i, ind:ind+7) = histcounts(grads, nBins);
                ind = ind + 8;
            end
        end
    end % for all local feature points
    
end
