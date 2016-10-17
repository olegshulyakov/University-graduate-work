function Theta = regulirizedLinearRegression(X,Y,lambda)

Corr = eye(size(X,2),size(X,2));
Corr(1,1) = 0;

Theta = pinv( X' * X + lambda * Corr ) * X' * Y; % calculate thetas