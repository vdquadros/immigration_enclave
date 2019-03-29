*t1 follows allnp2.sas ;

options ls=120 nocenter;
libname c90 '/home/groups/sorkin/quadros/data/1990';
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
set c90.supp90;


rmsa0=(rmsa=0);
rmsa1=(rmsa=1);
male=1-female;
native=1-imm;

lw2sq=logwage2**2;

if exp<=10 then xclass2=1;
else if exp<=20 then xclass2=2;
else if exp<=30 then xclass2=3;
else xclass2=4;
c=1;

havewage2=(logwage2 ne .);
if wagesal<=0 then cwagesal=.;
else cwagesal=wagesal;

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

q1=p1+p2;
q2=p3+p4;
q3=p5+p6;
q4=p7+p8;
q5=p9+p10;

if logwage2 ne . then do;
 q1c=q1;
 q2c=q2;
 q3c=q3;
 q4c=q4;
 q5c=q5;
end;
else do;
 q1c=.;
 q2c=.;
 q3c=.;
 q4c=.;
 q5c=.;
end;

proc summary;
class rmsa native male eclass xclass2;
var emp havewage2 wagesal cwagesal annhrs cannhrs weeks hrswkly ft
    dropout hs somecoll college advanced collplus educ exp age x1-x4
    black hispanic asian euro hi_asian mid_asian mex 
    rmsa0 rmsa1 q1-q5 q1c q2c q3c q4c q5c 
    educ exp imm female c wage2 logwage2 ;
output out=here.allcells
mean=
sum(c)=count;
weight wt;

data t1;
set here.allcells;
if rmsa=. and native=. and male=. and xclass2=.;
keep imm female educ age x1 x2 x3 x4 black hispanic 
     rmsa0 rmsa1 emp annhrs cannhrs ft  q1-q5 
     q1c q2c q3c q4c q5c wage2 logwage2;

proc transpose data=t1 out=here.t1t;

proc print data=here.t1t;
format annhrs cannhrs 5.0 educ wage2 3.2 
    imm female educ age x1 x2 x3 x4 black hispanic 
     rmsa0 rmsa1 emp ft  q1-q5 
     q1c q2c q3c q4c q5c 4.3 logwage2 4.2; 

