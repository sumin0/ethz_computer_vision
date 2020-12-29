% Match descriptors.
%
% Input:
%   descr1        - k x q descriptor of first image
%   descr2        - k x q' descriptor of second image
%   matching      - matching type ('one-way', 'mutual', 'ratio')
%   
% Output:
%   matches       - 2 x m matrix storing the indices of the matching
%                   descriptors
function matches = matchDescriptors(descr1, descr2, matching)
    distances = ssd(descr1, descr2);
    
    if strcmp(matching, 'one-way')
        matches = zeros(2, length(descr1));
        matches(1, :) = 1:length(descr1);
        [~, matches(2, :)] = min(distances,[],2);
        
    elseif strcmp(matching, 'mutual')       
        [~, match1] = min(distances,[],2);
        [~, match2] = min(distances,[],1);
        matches = [];
        for idx=1:length(match1)
            if match2(match1(idx)) == idx
                matches = [matches; idx match1(idx)];
            end
        end
        matches = matches';
        
    elseif strcmp(matching, 'ratio')
        matches = [];
        [~, I] = mink(distances,2,2);
        for idx=1:length(descr1)
            if distances(idx, I(idx,1)) < distances(idx, I(idx,2))*0.5
                matches = [matches; idx I(idx,1)];
            end
        end
        matches = matches';
        
    else
        error('Unknown matching type.');
    end
end

function distances = ssd(descr1, descr2)

distances = pdist2(double(descr1)', ...
    double(descr2)', 'squaredeuclidean');

end