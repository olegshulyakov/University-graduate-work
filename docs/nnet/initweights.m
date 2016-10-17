function weights = initweights(r, c)
init = 0.05 ;
weights = init - (2 * init) .* rand(r, c) ;
endfunction