options ls=120 nocenter;
libname c80 '/home/groups/sorkin/quadros/data/1980';
libname out '/home/groups/sorkin/quadros/data/out';

*This file converts cell1 output to stata to be used in table6;
data bigcells_new1;
set c80.bigcells;
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
set c80.bigcells;
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
data nw80;
set c80.bigcells;
if native=1 and male=1 and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

* Immigrant wages;
data iw80;
set c80.bigcells;
if native=0 and male=1 and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred; 

* Native wages by eclass;
data nw801;
set c80.bigcells;
if native=1 and male=1 and eclass=1 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data nw802;
set c80.bigcells;
if native=1 and male=1 and eclass=2 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data nw803;
set c80.bigcells;
if native=1 and male=1 and eclass=3 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data nw804;
set c80.bigcells;
if native=1 and male=1 and eclass=4 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

* Immigrant wages by eclass; 
data iw801;
set c80.bigcells;
if native=0  and male=1 and eclass=1 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data iw802;
set c80.bigcells;
if native=0  and male=1 and eclass=2 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data iw803;
set c80.bigcells;
if native=0  and male=1 and eclass=3 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data iw804;
set c80.bigcells;
if native=0  and male=1 and eclass=4 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

* Export to Stata;
PROC EXPORT DATA=bigcells_new1
            FILE="/home/groups/sorkin/quadros/data/out/1980_bigcells_new1.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=bigcells_new2
            FILE="/home/groups/sorkin/quadros/data/out/1980_bigcells_new2.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=nw80
            FILE="/home/groups/sorkin/quadros/data/out/nw80.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=iw80
            FILE="/home/groups/sorkin/quadros/data/out/iw80.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=nw801
            FILE="/home/groups/sorkin/quadros/data/out/nw801.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=nw802
            FILE="/home/groups/sorkin/quadros/data/out/nw802.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=nw803
            FILE="/home/groups/sorkin/quadros/data/out/nw803.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=nw804
            FILE="/home/groups/sorkin/quadros/data/out/nw804.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=iw801
            FILE="/home/groups/sorkin/quadros/data/out/iw801.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=iw802
            FILE="/home/groups/sorkin/quadros/data/out/iw802.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=iw803
            FILE="/home/groups/sorkin/quadros/data/out/iw803.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=iw804
            FILE="/home/groups/sorkin/quadros/data/out/iw804.dta"
            DBMS=STATA REPLACE;
RUN;
