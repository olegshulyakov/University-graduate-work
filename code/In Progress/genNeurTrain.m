function [X,Y] = genNeurTrain(matrix,inputNumber)

trainSize = size(matrix,1) - inputNumber;    % size of training examples
outputSize = size(matrix,2);  % size output
vector = vec(matrix(2:size(matrix,1),:)');        % values as a vector

if trainSize > 0
	X = zeros(trainSize, inputNumber * outputSize); % initialization X
	Y = zeros(trainSize, outputSize); % initialization Y
	for i=1 : trainSize,		
		rangeMin = outputSize * (i - 1) + 1;
		rangeMax = outputSize * (i - 1) + outputSize * inputNumber;
		row = vector([rangeMin:rangeMax],:);
		X(i,:) = row';
		Y(i,:) = matrix(i,:);
	end;
else
	disp('Parameters error');
end;