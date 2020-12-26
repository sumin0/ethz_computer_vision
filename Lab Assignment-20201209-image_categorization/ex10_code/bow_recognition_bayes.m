function label = bow_recognition_bayes(histogram, vBoWPos, vBoWNeg)


[muPos, sigmaPos] = computeMeanStd(vBoWPos);
[muNeg, sigmaNeg] = computeMeanStd(vBoWNeg);

% Calculating the probability of appearance each word in observed histogram
% according to normal distribution in each of the positive and negative bag of words
p_pos = 0;
p_neg = 0;
for i=1:size(histogram,2)
    if (muPos(i) > 0) && (sigmaPos(i) > 0)
        p_pos = p_pos + log(normpdf(histogram(i),muPos(i),sigmaPos(i)));
    end
    
    if (muNeg(i) > 0) && (sigmaNeg(i) > 0)
        p_neg = p_neg + log(normpdf(histogram(i),muNeg(i),sigmaNeg(i)));
    end
    
end

if (p_pos >= p_neg)
    label = 1;
else
    label = 0;
end

end