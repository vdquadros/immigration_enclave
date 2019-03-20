options ls = 100 nocenter;
libname c2000 '/folders/myfolders/data/2000' ;

proc import out= c2000.all2000 
			datafile = "/folders/myfolders/dta/all2000.dta"
			replace;
run;
proc contents data= c2000.all2000;
run;