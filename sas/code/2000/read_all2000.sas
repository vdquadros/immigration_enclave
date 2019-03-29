options ls = 100 nocenter;
libname c00 '/home/groups/sorkin/quadros/data/2000/' ;

proc import out= c00.all2000
                        datafile = "/home/groups/sorkin/quadros/data/raw/all2000.dta"
                        replace;
run;
proc contents data= c00.all2000;
run;

proc datasets lib= c00  memtype=data;
   modify all2000;
     attrib _all_ label=' ';
     attrib _all_ format=;
run;

proc contents data= c00.all2000;
run;
