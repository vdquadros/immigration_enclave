clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/"

clear
use data/2000/np2000.dta

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
save data/2000/nf.dta, replace
summ imm female logwage2 educ_yrs exp rczone0 rczone1 nonmover [fweight = wt]
restore

preserve
keep if imm == 1 & female == 0
save data/2000/im.dta, replace
summ imm female logwage2 educ_yrs exp rczone0 rczone1 nonmover [fweight = wt]
restore

preserve
keep if imm == 1 & female == 1
save data/2000/if.dta, replace
summ imm female logwage2 educ_yrs exp rczone0 rczone1 nonmover [fweight = wt]
restore

***models DO NOT include msa effects but include dummies for rmsa=0,1 ;
/* Card uses homey instead of nonmover, but we dont have homey */
preserve
use data/2000/nm.dta, clear
reg logwage2 exp exp2 exp3 educ eclass##xclass inschool advanced ft lowhrs hisp_ed hisp_coll black_ed black_coll asian_ed asian_coll nonmover##eclass rczone0 [fweight=wt]
predict pred if e(sample)
predict res, residuals
save data/2000/nm2.dta, replace
restore

preserve
use data/2000/nf.dta, clear
reg logwage2 exp exp2 exp3 educ eclass##xclass inschool advanced ft lowhrs hisp_ed hisp_coll black_ed black_coll asian_ed asian_coll nonmover##eclass rczone0 [fweight=wt]
predict pred if e(sample)
predict res, residuals
save data/2000/nf2.dta, replace
restore

preserve
use data/2000/im.dta, clear
reg logwage2 exp exp2 exp3 educ eclass##xclass inschool advanced ft lowhrs hisp_ed hisp_coll black_ed black_coll asian_ed asian_coll nonmover##eclass rczone0 [fweight=wt]
predict pred if e(sample)
predict res, residuals
save data/2000/im2.dta, replace
restore

preserve
use data/2000/if.dta, clear
reg logwage2 exp exp2 exp3 educ eclass##xclass inschool advanced ft lowhrs hisp_ed hisp_coll black_ed black_coll asian_ed asian_coll nonmover##eclass rczone0 [fweight=wt]
predict pred if e(sample)
predict res, residuals
save data/2000/if2.dta, replace
restore

local files nf2 im2 if2
use data/2000/nm2.dta, clear
forv i=1/3{
	local f : word `i' of `files'
	append using data/2000/`f'.dta
}

gen male=1-female
gen native=1-imm

gen lw2sq=logwage2^2
gen ressq=res^2
gen predsq=pred^2
gen respred=res*pred

gen xclass2 = 4
replace xclass2 = 1 if exp <= 10
replace xclass2 = 2 if 10 < exp & exp <= 20
replace xclass2 = 3 if 20 < exp & exp <=30

gen hs=1-dropout-somecoll-collplus

replace college = 1 if collplus == 1 & advanced == 0

corr logwage2 pred res educ exp imm female 

summ dropout hs somecoll college collplus advanced [fweight = wt]

tab xclass2 eclass

collapse (sum) count = c (mean) logwage2 lw2sq res ressq pred predsq respred imm ///
		female educ exp c dropout hs somecoll collplus college advanced [fweight = wt], ///
		by(rczone native male eclass xclass2) 
save data/2000/bigcells.dta, replace



/*
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

