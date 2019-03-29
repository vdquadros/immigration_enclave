options ls=120 nocenter;
libname c2000 '/home/groups/sorkin/quadros/data/2000';
libname out '/home/groups/sorkin/quadros/data/out';

*This is to use convert directly to stata and use in table6;
data bigcells_new1;
set c2000.bigcells;
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
set c2000.bigcells;
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
data nw;
set c2000.bigcells;
if native=1 and male=1 and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

* Immigrant wages;
data iw;
set c2000.bigcells;
if native=0 and male=1 and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred; 

* Nativa wages by eclass;
data nw1;
set c2000.bigcells;
if native=1 and male=1 and eclass=1 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data nw2;
set c2000.bigcells;
if native=1 and male=1 and eclass=2 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data nw3;
set c2000.bigcells;
if native=1 and male=1 and eclass=3 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data nw4;
set c2000.bigcells;
if native=1 and male=1 and eclass=4 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

* Immigrant wages by eclass;
data iw1;
set c2000.bigcells;
if native=0  and male=1 and eclass=1 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data iw2;
set c2000.bigcells;
if native=0  and male=1 and eclass=2 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data iw3;
set c2000.bigcells;
if native=0  and male=1 and eclass=3 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;

data iw4;
set c2000.bigcells;
if native=0  and male=1 and eclass=4 and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;
if rmsa=. then delete;

proc print;
var rmsa native male eclass xclass2 count imm logwage2 v res vres pred vpred;


* Export to Stata;
PROC EXPORT DATA=bigcells_new1
            FILE="/home/groups/sorkin/quadros/data/out/2000_bigcells_new1.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=bigcells_new2
            FILE="/home/groups/sorkin/quadros/data/out/2000_bigcells_new2.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=nw
            FILE="/home/groups/sorkin/quadros/data/out/nw.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=iw
            FILE="/home/groups/sorkin/quadros/data/out/iw.dta"
            DBMS=STATA REPLACE;

PROC EXPORT DATA=nw1
            FILE="/home/groups/sorkin/quadros/data/out/nw1.dta"
            DBMS=STATA REPLACE;
RUN;
PROC EXPORT DATA=nw2
            FILE="/home/groups/sorkin/quadros/data/out/nw2.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=nw3
            FILE="/home/groups/sorkin/quadros/data/out/nw3.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=nw4
            FILE="/home/groups/sorkin/quadros/data/out/nw4.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=iw1
            FILE="/home/groups/sorkin/quadros/data/out/iw1.dta"
            DBMS=STATA REPLACE;
RUN;
PROC EXPORT DATA=iw2
            FILE="/home/groups/sorkin/quadros/data/out/iw2.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=iw3
            FILE="/home/groups/sorkin/quadros/data/out/iw3.dta"
            DBMS=STATA REPLACE;
RUN;

PROC EXPORT DATA=iw4
            FILE="/home/groups/sorkin/quadros/data/out/iw4.dta"
            DBMS=STATA REPLACE;
RUN;
