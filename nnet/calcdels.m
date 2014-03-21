function deltas = calcdels(target, activations, weights)
target = target(:) ;
L = length(activations) ;
deltas = cell(L, 1) ;
deltas{L} = activations{L} .* (1 - activations{L}) .* (target - activations{L}) ;
for ii = (L - 1):-1:2
  s = length(activations{ii}) ;
  deltas{ii} = activations{ii}(2:s) .* (1 - activations{ii}(2:s)) .* (deltas{ii + 1}' * weights{ii}(:, 2:s))' ;
endfor
endfunction