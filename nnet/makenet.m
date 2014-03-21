function weights = makenet(sl)
% ================================
% In weights variable 
% each row - for each layer output
% columns:
%     first column for bias
%     each other for layer input
% ================================
% Getting number of layers
numberOfLayers = length(sl) ;
% Initializing Weights
weights = cell(numberOfLayers, 1) ;
% Input layer
weights{1} = [ ones(sl(2), 1) initweights(sl(2), sl(1)) ] ;
% Hidden layers
for ii = 2:(numberOfLayers - 1),
  weights{ii} = [ ones(sl(ii + 1), 1) initweights(sl(ii + 1), sl(ii)) ] ;
end;
% Output layer
% no weights for the output layer
endfunction