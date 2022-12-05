proc import out=players
	datafile = ".\dataset.csv"
	dbms = csv replace;
run;

data players;
	set players;
	AAV_k = AAV / 100000;
run;

proc univariate;
	var AAV_k;
	histogram/normal;
run;

proc genmod;
	model AAV_k = age OPS_ oWAR dWAR SO/dist=gamma link=log;
run;

proc genmod;
	model AAV_k =/dist=gamma link=log;
run;

data deviance_test;
	deviance=-2*(-755.5562-(-672.5850));
	pvalue=1-probchi(deviance,5);
run;

proc print noobs;
run;

data prediction;
	input age OPS_ oWAR dWAR SO;
cards;
29 129 12.7 1.5 272
27 128 11.3 5.0 286
;

data players;
	set players prediction;
run;

proc genmod;
	model AAV_k = age OPS_ oWAR dWAR SO/dist=gamma link=log;
	output out=outdata p=predicted;
run;

proc print data=outdata (firstobs = 140);
	var predicted;
run;
