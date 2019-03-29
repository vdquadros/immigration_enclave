*supply1 follows np2.sas ;

options ls=120 nocenter;
libname c90 '/var/tmp/card/';
libname here '.'; 


data one;
set c90.np80;

rmsa0=(rmsa=0);
rmsa1=(rmsa=1);

male=1-female;
native=1-imm;

if exp<=10 then xclass2=1;
else if exp<=20 then xclass2=2;
else if exp<=30 then xclass2=3;
else xclass2=4;
c=1;




hs=1-dropout-somecoll-collplus;
if collplus=1 and advanced=0 then college=1;
else college=0;

hwt=annhrs*wt;



proc summary;
class rmsa native male eclass xclass2;
var dropout hs somecoll college advanced collplus c imm female;
output out=here.cellsupply
sum(c)=supply
sum(dropout)=supply1
sum(hs)=supply2
sum(somecoll)=supply3
sum(collplus)=supply4
sum(college)=supply5
sum(advanced)=supply6
sum(imm)=supplyimm
sum(female)=supplyfem;
weight hwt;



data t1;
set here.cellsupply;
if native=. and male=. and eclass=. and xclass2=.;

rsupply1=supply1/supply;
rsupply2=supply2/supply;
rsupply3=supply3/supply;
rsupply4=supply4/supply;
rsupply5=supply5/supply;
rsupply6=supply6/supply;

shs=.7*rsupply1+rsupply2+.5*rsupply3;
scoll1=.5*rsupply3+rsupply4;
scoll2=.5*rsupply3+rsupply5+1.2*rsupply6;
logrels1=log(scoll1/shs);
logrels2=log(scoll2/shs);


proc means;
where (rmsa ne .);
var rsupply1-rsupply6 shs scoll1 scoll2 logrels1 logrels2;

proc corr;
where (rmsa>3);
var rsupply1-rsupply6 shs scoll1 scoll2 logrels1 logrels2;



proc sort; by descending supply;

proc print;
var rmsa supply rsupply1-rsupply6;
