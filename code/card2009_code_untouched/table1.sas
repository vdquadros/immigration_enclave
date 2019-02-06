*table1 follows allnp2.sas ;
*uses acs 2005/2006 ONLY;


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
set c90.supp0506;


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


if black=1 or asian=1 or hispanic=1 then minority=1;
else minority=0;

if rmsa>3 then top124=1;
else top124=0;

c=1;

lowed=(educ<=12);

wt=wt/2;


proc means data=one;
var c imm hispanic minority q1-q5 dropout hs somecoll collplus wage2 cwagesal;
weight wt;

proc means data=one;
where (top124=0);
var c imm hispanic minority q1-q5 dropout hs somecoll collplus wage2 cwagesal;
output out=outside
mean=
sum(c)=count;
weight wt;

proc means data=one;
where (top124=1);
var c imm hispanic minority q1-q5 dropout hs somecoll collplus wage2 cwagesal;
output out=inside
mean=
sum(c)=count;
weight wt;

proc summary data=one;
class rmsa;
var c imm hispanic minority q1-q5 dropout hs somecoll collplus wage2 cwagesal;
output out=byrmsa
mean=
sum(c)=count;
weight wt;




data all;
set outside inside byrmsa;


array pct (*) imm hispanic minority q1-q5 dropout hs somecoll collplus;
do j=1 to 12;
pct(j)=pct(j)*100;
end;

share=100*count/174870327;

proc sort in=all out=here.table1;
by descending count;

proc print data=here.table1;
var rmsa count share imm hispanic minority dropout hs somecoll collplus q1 q5 
wage2;
format imm hispanic minority dropout hs somecoll collplus q1 q5 share 6.1 wage2 5.2;

