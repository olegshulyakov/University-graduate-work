function test()

inputs = [0 0; 0 1; 1 0; 1 1];
targets = [0; 1; 1; 0];
layers = [2; 3; 1];

[a,w] = makenet(layers);

for i=1:4,
	inputs
	a = forwardprop(inputs(i),a,w);
	w = backprop(targets(i),a,w);
end
a
w
for i=1:4,
	inputs
	feedforward(inputs(i),w)
end