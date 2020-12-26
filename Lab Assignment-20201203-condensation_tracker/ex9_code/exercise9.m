%%
% videoName  - videoName 
% params - parameters structure
%        . draw_plots {0,1} draw output plots throughout
%        . hist_bin   1-255 number of histogram bins for each color: proper values 4,8,16
%        . alpha      number in [0,1]; color histogram update parameter (0 = no update)
%        . sigma_position   std. dev. of system model position noise
%        . sigma_observe    std. dev. of observation model noise
%        . num_particles    number of particles
%        . model      {0,1} system model (0 = no motion, 1 = constant velocity)
%
% if using model = 1 then the following parameters are used:
%        . sigma_velocity   std. dev. of system model velocity noise
%        . initial_velocity initial velocity to set particles to
%%
% videoName
videoName='video3';

% load ./data/params.mat
% params
params.draw_plots=1;
params.hist_bin=16;
params.alpha=0.5;
params.sigma_position=10;
params.sigma_observe=0.1;
params.num_particles=300;
params.model=1;
params.sigma_velocity=3;
params.initial_velocity=[10 0];

condensationTracker(videoName,params);
