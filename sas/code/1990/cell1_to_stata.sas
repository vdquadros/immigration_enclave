options ls=120 nocenter;
libname c90 '/home/groups/sorkin/quadros/data/1990';
libname out '/home/groups/sorkin/quadros/data/out';

*This is to use convert directly to stata and use in table6;
data bigcells_new1;
set c90.bigcells;
if  xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;
if native=. then delete;
if eclass=. then delete;
if male=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data bigcells_new2;
set c90.bigcells;
if  xclass2=. and eclass=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;
if native=. then delete;
if male=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

* Native wages;
data nw90;
set c90.bigcells;
if native=1 and male=1 and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

* Immigrant wages;
data iw90;
set c90.bigcells;
if native=0 and male=1 and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

* Native wages by eclass;
data nw901;
set c90.bigcells;
if native=1 and male=1 and eclass=1 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data nw902;
set c90.bigcells;
if native=1 and male=1 and eclass=2 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data nw903;
set c90.bigcells;
if native=1 and male=1 and eclass=3 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data nw904;
set c90.bigcells;
if native=1 and male=1 and eclass=4 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

* Immigrant wages by eclass;
data iw901;
set c90.bigcells;
if native=0  and male=1 and eclass=1 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data iw902;
set c90.bigcells;
if native=0  and male=1 and eclass=2 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data iw903;
set c90.bigcells;
if native=0  and male=1 and eclass=3 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data iw904;
set c90.bigcells;
if native=0  and male=1 and eclass=4 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

* Export to Stata;
PROC EXPORT DATA=bigcells_new1
            FILE="/home/groups/sorkin/quadros/data/out/1990_bigcells_new1.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=bigcells_new2
            FILE="/home/groups/sorkin/quadros/data/out/1990_bigcells_new2.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=nw90
            FILE="/home/groups/sorkin/quadros/data/out/nw90.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=iw90
            FILE="/home/groups/sorkin/quadros/data/out/iw90.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=nw901
            FILE="/home/groups/sorkin/quadros/data/out/nw901.dta"
            DBMS=STATA REPLACE;
RUN; 
PROC EXPORT DATA=nw902
            FILE="/home/groups/sorkin/quadros/data/out/nw902.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=nw903
            FILE="/home/groups/sorkin/quadros/data/out/nw903.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=nw904
            FILE="/home/groups/sorkin/quadros/data/out/nw904.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=iw901
            FILE="/home/groups/sorkin/quadros/data/out/iw901.dta"
            DBMS=STATA REPLACE;
RUN;
PROC EXPORT DATA=iw902
            FILE="/home/groups/sorkin/quadros/data/out/iw902.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=iw903
            FILE="/home/groups/sorkin/quadros/data/out/iw903.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=iw904
            FILE="/home/groups/sorkin/quadros/data/out/iw904.dta"
            DBMS=STATA REPLACE;
RUN;
