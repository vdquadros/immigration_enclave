options ls = 100 nocenter;
libname c90 '/folders/myfolders/data/1990' ;

proc import out= c90.all90 
			datafile = "/folders/myfolders/dta/all90.dta"
			replace;
run;
proc contents data= c90.all90;
run;