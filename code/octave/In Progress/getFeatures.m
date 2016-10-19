function [Result] = getFeatures(X,featuresNumber)

n = size(X,1);
[Counts, Points] = hist(X,n)
% Define ranges for features
AverageCount = size(X,1) * size(X,2) / featuresNumber
Ranges = zeros(featuresNumber,1);
k = 1;
i = 1;
while k < n	
	count = sum(Counts(k,:));
	while count < AverageCount && k < n
		k++;
		count += sum(Counts(k,:));
	end;
	Ranges(i) = Points(k);
	i++;
	k++;
end;

for i = 1: size(X,1);	
	for j = 1: size(X,2);
		el = zeros(1,featuresNumber);
		k = min( find (Ranges >= X(i,j)));
		el(k) = 1;
		if j == 1,
			row = el;
		else
			row = [row el];
		end;
	end;
	if i == 1
		Result = row;
	else
		Result = [Result; row];
	end;
end;