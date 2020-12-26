function [wa_x, wa_y, E] = tps_model(X,Y,lambda)
% input X N*2
% input Y N*2

N = size(X,1);

P = [ones(N,1) X]; % N*3
K = zeros(N);
for i=1:N
    for j=1:N
        t = dist2(X(i,:),X(j,:));
        if t == 0
            K(i,j) = 0;
        else
            K(i,j) = t*log(t);
        end
    end
end

A = [[K+lambda*eye(N) P]; [P' zeros(3)]];
b = [Y; zeros(3,2)];

% Ax = b
x = A \ b;

wa_x = x(:, 1);
wa_y = x(:, 2);

w_x = wa_x(1:N);
w_y = wa_y(1:N);

E = w_x'*K*w_x + w_y'*K*w_y;

end