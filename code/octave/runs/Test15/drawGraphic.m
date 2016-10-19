function drawGraphic()
load('HighCv.res');
load('power.res');
load('lambda.res');
[xx,yy] = meshgrid(power,lambda);
mesh(xx,yy,HighCv);
xlabel('Power');
ylabel('Lambda');
zlabel('Cost function');