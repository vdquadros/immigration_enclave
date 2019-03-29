options ls = 100 nocenter;
libname c80 '/home/groups/sorkin/quadros/data/1980/' ;

proc import out= c80.all80
                        datafile = "/home/groups/sorkin/quadros/data/raw/all80.dta"
                        replace;
run;
proc contents data= c80.all80;
run;

proc datasets lib= c80  memtype=data;
   modify all80; 
     attrib _all_ label=' ';
     attrib _all_ format=;
run;
	
proc contents data= c80.all80;
run;
