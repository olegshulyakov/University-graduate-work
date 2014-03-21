function test()

inputs = [0 0; 0 1; 1 0; 1 1];
targets = [0; 1; 1; 0];
layers = [2; 3; 1];

trainingSize = size(targets);
w = makenet(layers);
for k=1:10000,
for i=1:trainingSize,
	a = forwardprop(inputs(i,:),w);
	w = backprop(targets(i,:),a,w);
end;
end;
a
w
for i=1:trainingSize,
	feedforward(inputs(i,:),w)
end