*table2 follows allnp2.sas ;
*uses 2000 data only;

options ls=120 nocenter;
libname c90 '/var/tmp/card/';
libname here '.'; 


  /*

keep rmsa imm female logwage2 wt p1-p10 dev devsq c age 
              educ exp exp2 exp3 inschool dropout somecoll collplus advanced 
              asian black hispanic black_ed black_coll asian_ed asian_coll
              hisp_ed hisp_coll imm_ed imm_coll yrsinus yrsinus2
              euro_ed hi_asian_ed mid_asian_ed mex_ed 
              euro_coll hi_asian_coll mid_asian_coll mex_coll
              euro_yrs hi_asian_yrs mid_asian_yrs mex_yrs
              euro_yrs2 hi_asian_yrs2 mid_asian_yrs2 mex_yrs2 
              pre_exp pre_exp1 english pob state msa nonmover 
              ic euro hi_asian mid_asian mex owage annhrs xclass 
              eclass wagesal weeks selfinc wage wage2 emp;

  */


data one;
set c90.supp2000;

rmsa0=(rmsa=0);
rmsa1=(rmsa=1);
male=1-female;
native=1-imm;

if annhrs=. then annhrs=0;
if annhrs>0 then cannhrs=annhrs;
else cannhrs=.;

hs=1-dropout-somecoll-collplus;
if collplus=1 and advanced=0 then college=1;
else college=0;
x1=(xclass2=1);
x2=(xclass2=2);
x3=(xclass2=3);
x4=(xclass2=4);

if annhrs>0 then hrswkly=annhrs/weeks;
else hrswkly=.;
ft=(hrswkly>=35);

big3=(rmsa in (1600,4480,5600));


if imm=0 then ric=0;
else ric=ic;

if imm=1 and yrsinus<=20 then post80=1;
else if imm=1 then post80=0;
else post80=.;

if imm=1 and yrsinus<=10 then post90=1;
else if imm=1 then post90=0;
else post90=.;

mided=hs+somecoll;

proc summary data=one;
class imm;
var c post80 post90 educ dropout mided collplus wage2 logwage2;
output out=p1
mean=
sum(c)=count;
weight wt;

proc summary data=one;
where (imm=1);
class ic;
var c post80 post90 educ dropout mided collplus wage2 logwage2;
output out=p2
mean=
sum(c)=count;
weight wt;


data p1b;
set p1;
if imm=. then ic=-2;
else if imm=0 then ic=-1;
else if imm=1 then ic=0;
keep ic count post80 post90 educ dropout mided collplus wage2 logwage2;

data p2b;
set p2;
if ic ne .;
keep ic count post80 post90 educ dropout mided collplus wage2 logwage2;


data here.table2;
set p1b p2b;

array pct (*) post80 post90 dropout mided collplus;
do j=1 to 5;
pct(j)=pct(j)*100;
end;

proc print;
var ic count post80 post90 educ dropout mided collplus wage2 logwage2;
format post80 post90 educ dropout mided collplus 4.1 wage2 5.2;
