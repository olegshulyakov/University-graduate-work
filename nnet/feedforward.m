function output = feedforward(inputs, weights)
%inputs = inputs(:) ;
L = length(weights); 
activations = cell(L, 1); 
activations{1} = [1 ; inputs];
for ii = 2:(L - 1)
  activations{ii} = [1 ; activate(weights{ii - 1} * activations{ii - 1})] ;
endfor
output = activate(weights{L - 1} * activations{L - 1}) ;
endfunction