proc import out=salary
	datafile = ".\salary.csv"
	dbms = csv replace;
run;

proc import out=stats
	datafile = ".\stats.csv"
	dbms = csv replace;
run;

proc sql;
	create table table1 as
		select *
			from salary, stats
				where salary.player = stats.Player AND salary.STAT_YEAR = stats.To;
	create table dataset as
		select player, position, age, Guarantee, AAV, agent, oWAR, G, PA, AB, HR, SO, OPS_, dWAR
			from table1;
quit;

proc export data=dataset
    outfile=".\dataset.csv"
    dbms=csv
    replace;
run;
