function particles = propagate(particles,sizeFrame,params)

% system noise
n_pos = normrnd(0,params.sigma_position,params.num_particles,2);
n_vel = normrnd(0,params.sigma_velocity,params.num_particles,2);

if (params.model == 0) % 0 velocity
    A = eye(2);
    particles = particles*A + n_pos;
else                   % constant velocity 
    A = [1 0 0 0;
         0 1 0 0;
         1 0 1 0;
         0 1 0 1];
    particles = particles*A + [n_pos n_vel] ; %(N*4)
end

% ensure that the center of the particle lies inside the frame
particles(:,1) = min(particles(:,1),sizeFrame(2));
particles(:,1) = max(particles(:,1),1);
particles(:,2) = min(particles(:,2),sizeFrame(1));
particles(:,2) = max(particles(:,2),1);

end