*table 6;
*immnat1 based on istructure3, based on structure3, follows t1, cell1, supply1 , inflow3;

*looks at wage gap between natives and imms within eclass;


options ls=120 nocenter;
libname here '.'; 

libname c80 '~/ely/data/c80/cells';
libname c90 '~/ely/data/c90/cells';


*this macro gets imm share and count by eclass;
%macro all(ed);
%let edg=&ed;
data all&edg;
set here.allcells;
if native=. and male=. and eclass=&edg and xclass2=. ;
imm&edg=imm;
count&edg=count/1000;
keep rmsa imm&edg count&edg;
proc sort; by rmsa;
%mend;


*this macro gets native wages by eclass;
%macro nwage(ed);
%let edg=&ed;
data nw&edg;
set here.bigcells;
if native=1 and male=1 and eclass=&edg and xclass2=. ;
nwage&edg=logwage2;
nres&edg=res;
npred&edg=pred;
ncountw&edg=count / 1000;
keep rmsa nwage&edg npred&edg nres&edg ncountw&edg;
proc sort; by rmsa;
%mend;



*this macro gets imm wages by eclass;
%macro iwage(ed);
%let edg=&ed;
data iw&edg;
set here.bigcells;
if native=0 and male=1 and eclass=&edg and xclass2=. ;
iwage&edg=logwage2;
ires&edg=res;
ipred&edg=pred;
icountw&edg=count / 1000;
keep rmsa iwage&edg ipred&edg ires&edg icountw&edg;
proc sort; by rmsa;
%mend;

*this macro gets native wages in 1990 by eclass;
%macro nwage90(ed);
%let edg=&ed;
data nw90&edg;
set c90.bigcells;
if native=1 and male=1 and eclass=&edg and xclass2=. ;
nwage90&edg=logwage2;
nres90&edg=res;
npred90&edg=pred;
ncountw90&edg=count/1000;
keep rmsa nwage90&edg npred90&edg nres90&edg ncountw90&edg;
proc sort; by rmsa;
%mend;



*this macro gets imm wages in 1990 by eclass;
%macro iwage90(ed);
%let edg=&ed;
data iw90&edg;
set c90.bigcells;
if native=0 and male=1 and eclass=&edg and xclass2=. ;
iwage90&edg=logwage2;
ires90&edg=res;
ipred90&edg=pred;
icountw90&edg=count / 1000;
keep rmsa iwage90&edg ipred90&edg ires90&edg icountw90&edg;
proc sort; by rmsa;
%mend;

*this macro gets native wages in 1980 by eclass;
%macro nwage80(ed);
%let edg=&ed;
data nw80&edg;
set c80.bigcells;
if native=1 and male=1 and eclass=&edg and xclass2=. ;
nwage80&edg=logwage2;
nres80&edg=res;
npred80&edg=pred;
ncountw80&edg=20*count / 1000;
keep rmsa nwage80&edg npred80&edg nres80&edg ncountw80&edg;
proc sort; by rmsa;
%mend;`



*this macro gets imm wages in 1980 by eclass;
%macro iwage80(ed);
%let edg=&ed;
data iw80&edg;
set c80.bigcells;
if native=0 and male=1 and eclass=&edg and xclass2=. ;
iwage80&edg=logwage2;
ires80&edg=res;
ipred80&edg=pred;
icountw80&edg=20*count / 1000;
keep rmsa iwage80&edg ipred80&edg ires80&edg icountw80&edg;
proc sort; by rmsa;
%mend;


data m1;
set here.allcells;
if native=. and male=. and eclass=. and xclass2=. ;
count=count/1000;
imm=imm;
mex=mex;
emp=emp;
black=black;
hisp=hispanic;
hrs=annhrs;
label count='wtd count of adult pop in city'
      imm='imm share among adult pop in city';

keep rmsa count imm mex emp black hisp dropout hs somecoll collplus;
proc sort; by rmsa;


data m80;  /*some data for 1980*/
set c80.allcells;
if native=. and male=. and eclass=. and xclass2=. ;
count80=20*count/1000;
imm80=imm;
mex80=mex;
black80=black;
hisp80=hispanic80 
educ80=educ;
drop80=dropout;
hs80=hs;
some80=somecoll;
coll80=collplus;
label count80='1980 count of adult pop in city'
      imm80='1980imm share among adult pop in city';
keep rmsa count80 imm80 mex80 black80 hisp80
          educ80 drop80 hs80 some80 coll80;
proc sort; by rmsa;

data m90;  /*some data for 1990*/
set c90.allcells;
if native=. and male=. and eclass=. and xclass2=. ;
count90=count/1000;
imm90=imm;
mex90=mex;
black90=black;
hisp90=hispanic;
educ90=educ;
drop90=dropout;
hs90=hs;
some90=somecoll;
coll90=collplus;
label count90='1990 count of adult pop in city'
      imm90='1990imm share among adult pop in city';
keep rmsa count90 imm90 mex90 black90 hisp90
          educ90 drop90 hs90 some90 coll90;
proc sort; by rmsa;

data nw;
set here.bigcells;
if native=1 and male=1 and eclass=. and xclass2=. ;
nwage=logwage2;
nres=res;
npred=pred;
ncountw=count / 1000;
keep rmsa nwage npred nres ncountw;
proc sort; by rmsa;`

data iw;
set here.bigcells;
if native=0 and male=1 and eclass=. and xclass2=. ;
iwage=logwage2;
ires=res;
ipred=pred;
icountw=count / 1000;
keep rmsa iwage ipred ires icountw;
proc sort; by rmsa;



data nw80;
set c80.bigcells;  
if native=1 and male=1 and eclass=. and xclass2=.;
nres80=res;
label nres80='residual wage native men 1980';
keep rmsa nres80;
proc sort; by rmsa;

data nw90;
set c90.bigcells;  
if native=1 and male=1 and eclass=. and xclass2=.;
nres90=res;
label nres90='residual wage native men 1990';
keep rmsa nres90;
proc sort; by rmsa;

data iw80;
set c80.bigcells;  
if native=0 and male=1 and eclass=. and xclass2=.;
ires80=res;
label ires80='residual wage imm men 1980';
keep rmsa ires80;
proc sort; by rmsa;

data iw90;
set c90.bigcells;  
if native=0 and male=1 and eclass=. and xclass2=.;
ires90=res;
label ires90='residual wage imm men 1990';
keep rmsa ires90;
proc sort; by rmsa;

data mfg80;
set c80.mfg;
mfg80=mfg;
keep rmsa mfg80;

proc sort; by rmsa;
data mfg90;
set c90.mfg;
mfg90=mfg;
keep rmsa mfg90;
proc sort; by rmsa;


data m2;
set here.cellsupply;
if native=. and male=. and eclass=. and xclass2=. ;

h=supply/1000;
h1=supply1/1000;
h2=supply2/1000;
h3=supply3/1000;
h4=supply4/1000;
h5=supply5/1000;
h6=supply6/1000;
sh1=h1/h;
sh2=h2/h;
sh3=h3/h;
sh4=h4/h;
sh5=h5/h;
sh6=h6/h;
label h1='hrs weighted supply of dropouts'
      h2='hrs weighted supply of hs'
      h3='hrs weighted supply of somecoll'
      h4='hrs weighted supply of collplus'
      h5='hrs weighted supply of exactly college'
      h6='hrs weighted supply of advanced' 
      sh1='dropout shr of hrs'
      sh2='hs shr of hrs'
      sh3='some coll shr of hrs'
      sh4='collplus shr of hrs'
      sh5='exact college (16) shr of hrs'
      sh6='advanced (>16) shr of hrs' ;

keep rmsa h h1-h6 sh1-sh6;



data m280;
set c80.cellsupply;
if native=. and male=. and eclass=. and xclass2=. ;

h80=supply/1000;
h801=supply1/1000;
h802=supply2/1000;
h803=supply3/1000;
h804=supply4/1000;
h805=supply5/1000;
h806=supply6/1000;
sh801=h801/h80;
sh802=h802/h80;
sh803=h803/h80;
sh804=h804/h80;
sh805=h805/h80;
sh806=h806/h80;
label sh801='80 dropout shr of hrs'
      sh802='80 hs shr of hrs'
      sh803='80 some coll shr of hrs'
      sh804='80 collplus shr of hrs'
      sh805='80 exact college (16) shr of hrs'
      sh806='80 advanced (>16) shr of hrs' ;

keep rmsa h80 sh801-sh806;

data m290;
set c90.cellsupply;
if native=. and male=. and eclass=. and xclass2=. ;

h90=supply/1000;
h901=supply1/1000;
h902=supply2/1000;
h903=supply3/1000;
h904=supply4/1000;
h905=supply5/1000;
h906=supply6/1000;
sh901=h901/h90;
sh902=h902/h90;
sh903=h903/h90;
sh904=h904/h90;
sh905=h905/h90;
sh906=h906/h90;
label sh901='90 dropout shr of hrs'
      sh902='90 hs shr of hrs'
      sh903='90 some coll shr of hrs'
      sh904='90 collplus shr of hrs'
      sh905='90 exact college (16) shr of hrs'
      sh906='90 advanced (>16) shr of hrs' ;

keep rmsa h90 sh901-sh906;





%all(1);
%all(2);
%all(3);
%all(4);

%nwage(1);
%nwage(2);
%nwage(3);
%nwage(4);
%iwage(1);
%iwage(2);
%iwage(3);
%iwage(4);

%nwage90(1);
%nwage90(2);
%nwage90(3);
%nwage90(4);
%iwage90(1);
%iwage90(2);
%iwage90(3);
%iwage90(4);

%nwage80(1);
%nwage80(2);
%nwage80(3);
%nwage80(4);
%iwage80(1);
%iwage80(2);
%iwage80(3);
%iwage80(4);





data inflow;  /*from inflow3: 90-2000 arrivals allocated by msa shrs in 80*/
set here.newflows90;
keep rmsa indrop inhs insome incoll innmdrop innmhs innmsome innmcoll;
proc sort; by rmsa;


data big;
merge m1 m80 m90 m2 m280 m290 
     nw1 nw2 nw3 nw4 iw1 iw2 iw3 iw4
     nw901 nw902 nw903 nw904 iw901 iw902 iw903 iw904
     nw801 nw802 nw803 nw804 iw801 iw802 iw803 iw804
     inflow nw nw80 nw90 iw iw80 iw90 mfg80 mfg90;
by rmsa;

resgap=ires-nres;
resgap1=ires1-nres1;
resgap2=ires2-nres2;
resgap3=ires3-nres3;
resgap4=ires4-nres4;

resgap901=ires901-nres901;
resgap902=ires902-nres902;
resgap903=ires903-nres903;
resgap904=ires904-nres904;

wagegap1=iwage1-nwage1;
wagegap2=iwage2-nwage2;
wagegap3=iwage3-nwage3;
wagegap4=iwage4-nwage4;
wagegap=iwage-nwage;

rels1=log(icountw1/ncountw1);
rels2=log(icountw2/ncountw2);
rels3=log(icountw3/ncountw3);
rels4=log(icountw4/ncountw4);

rels=log(icountw/ncountw);


c1=.7;
c2=1.2;
c3=.8;


nshs=c1*ncountw1+ncountw2+.5*c2*ncountw3; %native high school equivalent hours
ishs=c1*icountw1+icountw2+.5*c2*icountw3; %imm high school equivalent hours
relshs=log(ishs/nshs);

nshs90=c1*ncountw901+ncountw902+.5*c2*ncountw903; 
ishs90=c1*icountw901+icountw902+.5*c2*icountw903;
relshs90=log(ishs90/nshs90);


nscoll=ncountw4+.5*c3*ncountw3; %native college equivalent hours
iscoll=icountw4+.5*c3*icountw3; %imm college equivalent hours
relscoll=log(iscoll/nscoll);

nscoll90=ncountw904+.5*c3*ncountw903;
iscoll90=icountw904+.5*c3*icountw903;
relscoll90=log(iscoll90/nscoll90);


infl1=.001*indrop/count;
infl2=.001*inhs/count;
infl3=.001*insome/count;
infl4=.001*incoll/count;
inflall=infl1+infl2+infl3+infl4;
*without mexicans;
innmfl1=.001*innmdrop/count;
innmfl2=.001*innmhs/count;
innmfl3=.001*innmsome/count;
innmfl4=.001*innmcoll/count;

hsiv=c1*infl1+infl2+.5*c2*infl3;
colliv=.5*c3*infl3+infl4;

hsiv2=c1*innmfl1+innmfl2+.5*c2*innmfl3;
colliv2=.5*c3*innmfl3+innmfl4;

logsize80=log(count80);
logsize90=log(count90);

check1=ncountw-ncountw1-ncountw2-ncountw3-ncountw4;
check2=icountw-icountw1-icountw2-icountw3-icountw4;
check3=countw-ncountw-icountw;

proc means;
var check1-check3;

proc plot;
where (rmsa>3);
plot relshs*hsiv;
plot relshs*hsiv2;
plot relscoll*colliv;
plot relscoll*colliv2;

proc corr;
where (rmsa > 3);
var relshs hsiv hsiv2 relscoll colliv colliv2 imm80 mex80;
weight count90;

proc corr;
where (rmsa > 3);
var resgap2 relshs resgap4 relscoll imm ;
weight count90;


proc syslin;
where (rmsa > 3);

model resgap4=colliv;

model resgap=rels;
model rels=inflall;
model resgap=inflall;

model resgap2 =relshs;
model resgap2 =relshs logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 
mfg90;

model resgap2 =relshs resgap902;
model resgap2 =relshs resgap902 logsize80 logsize90 coll80 coll90 nres80 ires80
mfg80 mfg90;


model resgap4 =relscoll;
model resgap4 =relscoll logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 
mfg90;

model resgap4 =relscoll resgap904;
model resgap4 =relscoll resgap904 logsize80 logsize90 coll80 coll90 nres80 ires80
mfg80 mfg90;


model relshs  =hsiv;
model resgap2 =hsiv;
model relshs  =hsiv logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90;
model resgap2 =hsiv logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90;

model relshs  =hsiv resgap902 logsize80 logsize90 coll80 coll90 nres80 ires80
mfg80 mfg90;
model resgap2 =hsiv resgap902 logsize80 logsize90 coll80 coll90 nres80 ires80
mfg80 mfg90;



model relscoll=colliv;
model resgap4 =colliv;
model relscoll=colliv logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 
mfg90;
model resgap4 =colliv logsize80 logsize90 coll80 coll90 nres80 ires80
mfg80 mfg90;

model relscoll=colliv resgap904 logsize80 logsize90 coll80 coll90 nres80 ires80
mfg80 mfg90;
model resgap4= colliv resgap904 logsize80 logsize90 coll80 coll90 nres80 ires80
mfg80 mfg90;

weight count90;




proc syslin 2sls;
where (rmsa > 3);
endogenous relshs;
instruments hsiv; 
model resgap2=relshs;
weight count90;



proc syslin 2sls;
where (rmsa > 3);
endogenous relshs;
instruments hsiv logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90;
model resgap2=relshs logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 
mfg90;
weight count90;

proc syslin 2sls;
where (rmsa > 3);
endogenous relshs;
instruments hsiv resgap902 logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 
mfg90;
model resgap2=relshs resgap902 logsize80 logsize90 coll80 coll90 nres80 ires80
mfg80 mfg90;
weight count90;


proc syslin 2sls;
where (rmsa > 3);
endogenous relscoll;
instruments colliv; 
model resgap4=relscoll;
weight count90;

proc syslin 2sls;
where (rmsa > 3);
endogenous relscoll;
instruments colliv logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90;
model resgap4=relscoll logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 
mfg90;
weight count90;

proc syslin 2sls;
where (rmsa > 3);
endogenous relscoll;
instruments colliv resgap904 logsize80 logsize90 coll80 coll90 nres80 ires80 
mfg80 mfg90;
model resgap4=relscoll resgap904 logsize80 logsize90 coll80 coll90 nres80 ires80 
mfg80 mfg90;
weight count90;

