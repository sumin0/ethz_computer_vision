function vPoints = grid_points(img,nPointsX,nPointsY,border)

[ny, nx] = size(img);

X = linspace(1+border, nx-border, nPointsX);
Y = linspace(1+border, ny-border, nPointsY);

[xx, yy] = meshgrid(X, Y);
vX = reshape(xx, nPointsX*nPointsY,1);
vY = reshape(yy, nPointsX*nPointsY,1);

vPoints = [vX, vY];
vPoints = int32(vPoints);

end
