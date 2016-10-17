function weights = backprop(target, activations, weights)
% Setting learning rate
learning_rate = 0.0001;
% Gets number of layers
numberOfLayers = length(weights);
% Calculates deltas
deltas = calcdels(target, activations, weights);
% Applies deltas to each layer, except last one
for ii = 1:(numberOfLayers - 1),
  s = length(activations{ii});
  weights{ii}(:, 2:s) = weights{ii}(:, 2:s) + learning_rate .* (deltas{ii + 1} * activations{ii}(2:s)') ;
endfor
endfunction