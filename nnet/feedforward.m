function output = feedforward(inputs, weights)
% =================================================
% Calculate feedforward neural network output value 
% For specified inputs and with specified weights
% =================================================

% Gets number of layers
numberOfLayers = length(weights);
% Calculate value in first layer
layerValue = [1; inputs'];
% Calculate value in each hidden layer
for layer = 2:(numberOfLayers - 1),
	layerValue = activate(weights{layer - 1} * layerValue);
	layerValue = [1; layerValue];
end;
% Calculate value in last layer (no bias)
layerValue = activate(weights{numberOfLayers - 1} * layerValue);
output = layerValue;
endfunction