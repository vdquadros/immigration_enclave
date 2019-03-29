*indist follows np2.sas ;

options ls=120 nocenter;
libname c80 '/home/groups/sorkin/quadros/data/1980/'; 

data one;
set c80.np80 (keep=rmsa ind wt imm female);

mfg=(100<=ind<=392);

proc freq;
tables mfg*imm mfg*female female*mfg*imm;
weight wt;


proc summary;
class rmsa;
var mfg;
output out=c80.mfg
mean=;
weight wt;


proc print data=c80.mfg;
var rmsa mfg;
