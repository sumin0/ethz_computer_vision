function particles_w = observe(particles,frame,H,W,hist_bin,hist_target,sigma_observe)

N =size(particles,1);
particles_w = zeros(N,1) ; 
hist_target = reshape(hist_target,1,3*hist_bin);

for i = 1:N
    % bounding box
    min_x = particles(i,1) - W/2;
    max_x = particles(i,1) + W/2;
    min_y = particles(i,2) - H/2;
    max_y = particles(i,2) + H/2;
    
    % calculate color histogram
    hist_current = color_histogram(min_x,min_y,max_x,max_y,frame,hist_bin); 
    hist_current = reshape(hist_current,1,3*hist_bin);
    
    % difference between the two color histogram vectors
    dist = chi2_cost(hist_target,hist_current);
    
    % update weight
    particles_w(i) = 1/(sqrt(2*pi)*sigma_observe) * ...
        exp(-(dist^2)/(2*sigma_observe^2));
end

% normalize
particles_w = particles_w / sum(particles_w);

end