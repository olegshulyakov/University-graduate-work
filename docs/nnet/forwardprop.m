function activations = forwardprop(inputs, weights)
% =================================================
% Calculate feedforward neural network output value 
% For specified inputs and with specified weights
% =================================================

% Gets number of layers
numberOfLayers = length(weights);
% Initialize activations values
activations = cell(numberOfLayers, 1);
% Calculate value in first layer
activations{1} = [1; inputs'];
% Calculate value in each hidden layer
for layer = 2:(numberOfLayers - 1),
	layerValue = activate(weights{layer - 1} * activations{layer - 1});
	activations{layer} = [1; layerValue];
end;
% Calculate value in last layer (no bias)
layerValue = activate(weights{numberOfLayers - 1} * activations{numberOfLayers - 1});
activations{numberOfLayers} = layerValue;
endfunction