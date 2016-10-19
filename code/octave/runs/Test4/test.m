function test(input,minPower,maxPower)

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
	Results = zeros(n,13);    
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
			Results(i,5 + j) = J;
			Y = Ytst(:,j);
			J = costFunction(Xtst,Y,Theta);
			Results(i,9 + j) = J;					
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
