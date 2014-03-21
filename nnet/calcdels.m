function deltas = calcdels(target, activations, weights)
% =================================================
% Calculate deltas for update 
% feedforward neural network layer`s weights
% For specified inputs and with specified weights
% =================================================

% Gets number of layers
numberOfLayers = length(weights);
% Initialize deltas
deltas = cell(numberOfLayers, 1);
% Calculate delta for last layer
deltas{numberOfLayers} = activations{numberOfLayers} .* (1 - activations{numberOfLayers}) .* (target - activations{numberOfLayers});
for layer = (numberOfLayers - 1):-1:2
  s = length(activations{layer});
  deltas{layer} = activations{layer}(2:s) .* (1 - activations{layer}(2:s)) .* (deltas{layer + 1}' * weights{layer}(:, 2:s))';
endfor
endfunction