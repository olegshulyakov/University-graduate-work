function test()
input = 5;
minPower = 1;
maxPower = 20;
n = 50;
  
power = minPower:maxPower;  
save power.res power;  
for power = minPower:maxPower,

	load('train.dat');
	[Xtr,Ytr] = genTrain(train,input,power);

	load('cv.dat');
	[Xcv,Ycv] = genTrain(cv,input,power);

	load('test.dat');
	[Xtst,Ytst] = genTrain(test,input,power);
	
	l = 0;
	Results = zeros(n,7);    
	m = size(Ytr,2);
	
	for i = 1:n,		
		Results(i,1) = l;		
		for j = 1:m,	
			Y = Ytr(:,j);
			Theta = regulirizedLinearRegression(Xtr,Y,l);						
			J = costFunction(Xtr,Y,Theta);
			Results(i,1 + j) = J;
			Y = Ycv(:,j);
			J = costFunction(Xcv,Y,Theta);
			Results(i,3 + j) = J;
			Y = Ytst(:,j);
			J = costFunction(Xtst,Y,Theta);
			Results(i,5 + j) = J;					
		end;		
		if l == 0,
				l = 0.001;
		else l = l * 2;
		end;
	end;
	disp(power);
	lambda = Results(:,1);
	save lambda.res lambda;
	if power > minPower,
		HighTr = [HighTr Results(:,2)];
		LowTr = [LowTr Results(:,3)];
		
		HighCv = [HighCv Results(:,4)];
		LowCv = [LowCv Results(:,5)];
		
		HighTst = [HighTst Results(:,6)];
		LowTst = [LowTst Results(:,7)];
	else
		HighTr = Results(:,2);
		LowTr = Results(:,3);
		
		HighCv = Results(:,4);
		LowCv = Results(:,5);
		
		HighTst = Results(:,6);
		LowTst = Results(:,7);
	end;

	% save to file
	save HighTr.res HighTr;
	save LowTr.res LowTr;
	
	save HighCv.res HighCv;
	save LowCv.res LowCv;
  
	save HighTst.res HighTst;
	save LowTst.res LowTst;
end;
