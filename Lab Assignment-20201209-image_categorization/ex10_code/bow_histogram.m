function histo = bow_histogram(vFeatures, vCenters)
  % input:
  %   vFeatures: MxD matrix containing M feature vectors of dim. D
  %   vCenters : NxD matrix containing N cluster centers of dim. D
  % output:
  %   histo    : N-dim. vector containing the resulting BoW
  %              activation histogram.
  
  
  % Match all features to the codebook and record the activated
  % codebook entries in the activation histogram "histo".
  
  histo = zeros(size(vCenters,1),1);
  
  idx = knnsearch(vCenters, vFeatures); % vector of size M
  for i=1:size(idx,1)
      histo(idx(i)) = histo(idx(i)) + 1;
  end
 
end
