function [activations, weights] = makenet(sl)
L = length(sl) ;
weights = cell(L, 1) ;
activations = cell(L, 1) ;
# Input layer
activations{1} = [ 1 ; zeros(sl(1), 1) ] ;
weights{1} = [ ones(sl(2), 1) initweights(sl(2), sl(1)) ] ;
# Hidden layers
for ii = 2:(L - 1),
  activations{ii} = [ 1 ; zeros(sl(ii), 1) ] ;
  weights{ii} = [ ones(sl(ii + 1), 1) initweights(sl(ii + 1), sl(ii)) ] ;
endfor
# Output layer
activations(L) = zeros(sl(L), 1) ;
# no weights for the output layer
endfunction