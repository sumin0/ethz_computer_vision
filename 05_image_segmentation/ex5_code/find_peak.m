function peak = find_peak(X, xl, r, kdt)

curr_x = xl;
thre = 1;

% go into the while loop
shift = thre + 1;

while(shift>thre)
   neighbor_idx = rangesearch(kdt,curr_x,r);
   sperical_window = X(neighbor_idx{1},:);
   new_x = mean(sperical_window,1);
   curr_x = new_x;
   
   shift = norm(new_x-curr_x);   
end

peak = curr_x;

end