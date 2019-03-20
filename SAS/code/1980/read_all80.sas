options ls = 100 nocenter;
libname c80 '/folders/myfolders/data/1980' ;

proc import out= c80.all80 
			datafile = "/folders/myfolders/dta/all80.dta"
			replace;
run;
proc contents data= c80.all80;
run;