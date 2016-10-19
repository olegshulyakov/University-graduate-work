function Error = calculateError(Theta,X,Y,MeanV,StdV)

D = Y - X * Theta;       % calculate difference between ideal and output
% Calculate statistics
if MeanV != 0 && StdV != 0,
	D = poststd(D',MeanV,StdV);
	D = D';
end;
Error = mean(std(D));  
