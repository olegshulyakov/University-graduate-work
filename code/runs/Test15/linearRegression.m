function Theta = linearRegression(X,Y)

Theta = pinv(X'*X)*X'*Y; % calculate thetas