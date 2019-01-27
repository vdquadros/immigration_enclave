clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/"

clear
use data/1980/np90.dta

gen ft = (annhrs > 1600)
gen lowhrs = (annhrs<1000)

gen college = 0
replace college = 1 if collplus==1 & advanced==0 

/* Here Card does a lot with homey and smsa. We dont have smsa, so Im skipping*/
gen rczone0 = (rczone==0)
gen rczone1 = (rczone==1)

preserve
keep if imm == 0 & female == 0
save data/1990/nm.dta, replace
summ imm female logwage2 educ_yrs exp rczone0 rczone1 nonmover [fweight = wt]
restore

preserve
keep if imm == 0 & female == 1
save data/1990/nf.dta, replace
summ imm female logwage2 educ_yrs exp rczone0 rczone1 nonmover [fweight = wt]
restore

preserve
keep if imm == 1 & female == 0
save data/1990/im.dta, replace
summ imm female logwage2 educ_yrs exp rczone0 rczone1 nonmover [fweight = wt]
restore

preserve
keep if imm == 1 & female == 1
save data/1990/if.dta, replace
summ imm female logwage2 educ_yrs exp rczone0 rczone1 nonmover [fweight = wt]
restore


/*
proc means data=nm;
var imm female logwage2 educ exp rmsa0 rmsa1 homey nonmover;
weight wt;
proc means data=nf;
var imm female logwage2 educ exp rmsa0 rmsa1 homey nonmover;
weight wt;
proc means data=im;
var imm female logwage2 educ exp rmsa0 rmsa1;
weight wt;
proc means data=if;
var imm female logwage2 educ exp rmsa0 rmsa1;
weight wt;

***models DO NOT include msa effects but include dummies for rmsa=0,1 ;


proc glm data=nm;
class eclass xclass homey;
model logwage2=exp exp2 exp3 educ eclass*xclass inschool advanced 
      ft lowhrs 
   hisp_ed hisp_coll black_ed black_coll  asian_ed asian_coll 
   homey*eclass rmsa0 rmsa1 / solution;
output out=nm2 predicted=pred residual=res;
weight wt;

proc glm data=nf;
class eclass xclass homey;
model logwage2=exp exp2 exp3 educ eclass*xclass inschool advanced 
      ft lowhrs 
   hisp_ed hisp_coll black_ed black_coll  asian_ed asian_coll 
   homey*eclass rmsa0 rmsa1 / solution;
output out=nf2 predicted=pred residual=res;
weight wt;

proc glm data=im;
class ic eclass xclass ;
model logwage2=exp exp2 exp3 educ eclass*xclass inschool advanced
    ft lowhrs mex_ed mex_coll euro_ed euro_coll hisp_ed hisp_coll 
    hi_asian_ed hi_asian_coll mid_asian_ed mid_asian_coll
    ic ic*yrsinus ic*yrsinus2 rmsa0 rmsa1 / solution;
output out=im2 predicted=pred residual=res;
weight wt;

proc glm data=if;
class ic eclass xclass ;
model logwage2=exp exp2 exp3 educ eclass*xclass inschool advanced
    ft lowhrs mex_ed mex_coll euro_ed euro_coll hisp_ed hisp_coll 
    hi_asian_ed hi_asian_coll mid_asian_ed mid_asian_coll
    ic ic*yrsinus ic*yrsinus2 rmsa0 rmsa1 / solution;
output out=if2 predicted=pred residual=res;
weight wt;


data two;
set nm2 nf2 im2 if2;

male=1-female;
native=1-imm;

lw2sq=logwage2**2;
ressq=res**2;
predsq=pred**2;
respred=res*pred;



if exp<=10 then xclass2=1;
else if exp<=20 then xclass2=2;
else if exp<=30 then xclass2=3;
else xclass2=4;
c=1;

hs=1-dropout-somecoll-collplus;
if collplus=1 and advanced=0 then college=1;
else college=0;




proc corr;
var logwage2 pred res educ exp imm female;
weight wt;


proc means;
var dropout hs somecoll college advanced collplus;
weight wt;


proc summary;
class rmsa native male eclass xclass2;
var logwage2 lw2sq res ressq pred predsq respred imm female educ exp c
      dropout hs somecoll college advanced collplus ;
output out=here.bigcells
mean=
sum(c)=count;
weight wt;

data check1;
set here.bigcells;
if native=. and male=. and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;


proc print;
var rmsa count imm logwage2 v res vres pred vpred;

proc corr;
where (rmsa>3);
var v vres imm educ exp;
weight count;



