function test()
input = 5;
minPower = 1;
maxPower = 20;
n = 50;
  
power = minPower:maxPower;  
save power.res power;  
for power = minPower:maxPower,

	filename = strcat("CostFunction-", num2str(input), "-", num2str(power), ".res");

	load('train.dat');
	% [trainN, meanTrain, stdTrain] = prestd(train');
	% [Xtr,Ytr] = genTrain(trainN',input,power);
	[Xtr,Ytr] = genTrain(train,input,power);

	load('cv.dat');
	% [cvN, meanCV, stdCV] = prestd(cv');
	% [Xcv,Ycv] = genTrain(cvN',input,power);
	[Xcv,Ycv] = genTrain(cv,input,power);

	load('test.dat');
	% [testN, meanTst, stdTst] = prestd(test');
	% [Xtst,Ytst] = genTrain(testN',input,power);
	[Xtst,Ytst] = genTrain(test,input,power);
	
	l = 0;
	Results = zeros(n,7);
    
	for i = 1:n
		Theta = regulirizedLinearRegression(Xtr,Ytr,l);
		
		Results(i,1) = l;
		
		J = costFunction(Xtr,Ytr,Theta);
		Results(i,2) = J(1);
		Results(i,3) = J(2);
		J = costFunction(Xcv,Ycv,Theta);
		Results(i,4) = J(1);
		Results(i,5) = J(2);
		J = costFunction(Xtst,Ytst,Theta);
		Results(i,6) = J(1);
		Results(i,7) = J(2);
		
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
