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

proc transreg;
	model BoxCox(AAV_k) = identity(age OPS_ oWAR dWAR SO);
run;

data players;
	set players;
	AAV_tr = 2*(AAV_k**.5 -1);
run;

proc univariate;
	var AAV_tr;
	histogram/normal;
run;

proc genmod;
	model AAV_tr=age OPS_ oWAR dWAR SO/dist=normal link=identity;
run;

proc genmod;
	model AAV_tr=/dist=normal link=identity;
run;

data deviance_test;
	deviance = -2*(-479.3305 - (-392.2484));
	pvalue = 1-probchi(deviance,5);
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
	model AAV_tr = age OPS_ oWAR dWAR SO/dist=normal link=identity;
	output out=outdata p=predicted;
run;

data outdata;
	set outdata;
	pred_aav = (.5*predicted + 1)**2;
run;

proc print data=outdata (firstobs=140);
	var pred_aav;
run;
