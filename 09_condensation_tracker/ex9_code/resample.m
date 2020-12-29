function [particles, particles_w] = resample(particles,particles_w)

N = size(particles,1);
[new_particles, idx] = datasample(particles, N, 'Replace', true, 'Weights', particles_w);

new_particles_w = particles_w(idx);

particles_w = new_particles_w / sum(new_particles_w);
particles = new_particles;

end