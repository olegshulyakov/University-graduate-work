function weights = backprop(target, activations, weights)
learning_rate = 0.25 ;
L = length(activations) ;
deltas = calcdels(target, activations, weights) ;
for ii = 1:(L - 1),
  s = length(activations{ii}) ;
  weights{ii}(:, 2:s) = weights{ii}(:, 2:s) + learning_rate .* (deltas{ii + 1} * activations{ii}(2:s)') ;
endfor
endfunction