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
	Results = zeros(n,13);
    
	for i = 1:n
		Theta = regulirizedLinearRegression(Xtr,Ytr,l);
		
		Results(i,1) = l;
		
		J = costFunction(Xtr,Ytr,Theta);
		Results(i,2) = J(1);
		Results(i,3) = J(2);
		Results(i,4) = J(3);
		Results(i,5) = J(4);
		J = costFunction(Xcv,Ycv,Theta);
		Results(i,6) = J(1);
		Results(i,7) = J(2);
		Results(i,8) = J(3);
		Results(i,9) = J(4);
		J = costFunction(Xtst,Ytst,Theta);
		Results(i,10) = J(1);
		Results(i,11) = J(2);
		Results(i,12) = J(3);
		Results(i,13) = J(4);
		
		if l == 0,
			l = 0.001;
		else l = l * 2;
		end;
	end;
	disp(power);
	lambda = Results(:,1);
	save lambda.res lambda;
	if power > minPower,
		OpenTr = [OpenTr Results(:,2)];
		HighTr = [HighTr Results(:,3)];
		LowTr = [LowTr Results(:,4)];
		CloseTr = [CloseTr Results(:,5)];
		
		OpenCv = [OpenCv Results(:,6)];
		HighCv = [HighCv Results(:,7)];
		LowCv = [LowCv Results(:,8)];
		CloseCv = [CloseCv Results(:,9)];
		
		OpenTst = [OpenTst Results(:,10)];
		HighTst = [HighTst Results(:,11)];
		LowTst = [LowTst Results(:,12)];
		CloseTst = [CloseTst Results(:,13)];
	else
		OpenTr = Results(:,2);
		HighTr = Results(:,3);
		LowTr = Results(:,4);
		CloseTr = Results(:,5);
		
		OpenCv = Results(:,6);
		HighCv = Results(:,7);
		LowCv = Results(:,8);
		CloseCv = Results(:,9);
		
		OpenTst = Results(:,10);
		HighTst = Results(:,11);
		LowTst = Results(:,12);
		CloseTst = Results(:,13);
	end;

	% save to file
	save OpenTr.res OpenTr; 
	save HighTr.res HighTr;
	save LowTr.res LowTr;
	save CloseTr.res CloseTr;
	
	save OpenCv.res OpenCv; 
	save HighCv.res HighCv;
	save LowCv.res LowCv;
	save CloseCv.res CloseCv;
  
	save OpenTst.res OpenTst; 
	save HighTst.res HighTst;
	save LowTst.res LowTst;
	save CloseTst.res CloseTst;
end;
