function activations = forwardprop(inputs, activations, weights)
inputs = inputs(:) ;
L = length(activations) ;
activations{1}(2:length(activations{1})) = inputs ;
for ii = 2:(L - 1)
  activations{ii}(2:length(activations{ii})) = activate(weights{ii - 1} * activations{ii - 1}) ;
endfor
activations{L} = activate(weights{L - 1} * activations{L - 1}) ;
endfunction