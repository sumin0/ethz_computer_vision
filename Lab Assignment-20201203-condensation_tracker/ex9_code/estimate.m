function meanState = estimate(particles,particles_w)
% mean state given the particles and their weights
% weights sum up to 1
% meanState 1x2
meanState = particles_w' * particles;

end