function [X,Y] = genTrain(matrix,inputNumber,power)

trainSize = size(matrix,1) - inputNumber;    % size of training examples

if trainSize > 0 && power > 0
	X = ones(size(matrix,1),1); % initialization X
	Y = matrix; % initialization Y
	for p = 1 : power,
		for i = 1: inputNumber,
			X = [X matrix .^ p];
		end;
	end;
else
	disp('Parameters error');
end;