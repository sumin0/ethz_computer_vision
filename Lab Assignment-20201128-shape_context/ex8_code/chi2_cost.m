function C = chi2_cost(shape_desc1, shape_desc2)
% input shape desc: (nbBins_theta * nbBins_r) * N
n = size(shape_desc1, 2);
m = size(shape_desc2, 2);

C = zeros(n, m);

for i=1:n
    for j=1:m
        cost = (shape_desc1(:,i) - shape_desc2(:,j)).^2 ...
            ./ (shape_desc1(:,i) + shape_desc2(:,j));
        
        % if NaN, disregard it
        cost(isnan(cost)) = 0;
        
        C(i, j) = sum(cost)*0.5;
    end
end

end