clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"


/***************************************/
/* Gets 2000 imm share and count by eclass */
/**************************************/
use data/2000/allcells_new1.dta, clear
local education_groups 1 2 3 4 
forv i=1/4{
    local edg : word `i' of `education_groups'
    preserve
    keep if eclass == `edg'
    gen imm`edg' = imm
    gen count`edg' = count/1000
    keep rmsa imm`edg' count`edg' 
    sort rmsa
    save data/2000/all`edg'.dta, replace
    restore
}

/***************************************/
/* Gets 2000 native wages by eclass */
/**************************************/
use data/2000/bigcells_new1.dta, clear
local education_groups 1 2 3 4 
forv i=1/4{
    local edg : word `i' of `education_groups'
    preserve
    keep if native == 1 & male == 1 & eclass == `edg' 
    gen nwage`edg' = logwage2
    gen nres`edg' = res
    gen npred`edg' = pred
    gen ncountw`edg' = count/1000
    keep rmsa nwage`edg' npred`edg' nres`edg' ncountw`edg'
    sort rmsa
    save data/2000/nw`edg'.dta, replace
    restore
}

/***************************************/
/* Gets 2000 immigrant wages by eclass */
/**************************************/
use data/2000/bigcells_new1.dta, clear
local education_groups 1 2 3 4 
forv i=1/4{
    local edg : word `i' of `education_groups'
    preserve
    keep if native == 0 & male == 1 & eclass == `edg'
    gen iwage`edg' = logwage2
    gen ires`edg' = res
    gen icountw`edg' = count/1000
    keep rmsa iwage`edg' ires`edg' icountw`edg' 
    sort rmsa
    save data/2000/iw`edg'.dta, replace
    restore
}

/***************************************/
/* Gets 1990 native wages by eclass */
/**************************************/
use data/1990/bigcells_new1.dta, clear
local education_groups 1 2 3 4 
forv i=1/4{
    local edg : word `i' of `education_groups'
    preserve
    keep if native == 1 & male == 1 & eclass == `edg' 
    gen nwage90`edg' = logwage2
    gen nres90`edg' = res
    gen npred90`edg' = pred
    gen ncountw90`edg' = count/1000
    keep rmsa nwage90`edg' npred90`edg' nres90`edg' ncountw90`edg' 
    sort rmsa
    save data/1990/nw90`edg'.dta, replace
    restore
}


/***************************************/
/* Gets 1990 immigrant wages by eclass */
/**************************************/
use data/1990/bigcells_new1.dta, clear
local education_groups 1 2 3 4 
forv i=1/4{
    local edg : word `i' of `education_groups'
    preserve
    keep if native == 0 & male == 1 & eclass == `edg'
    gen iwage90`edg' = logwage2
    gen ires90`edg' = res
    gen icountw90`edg' = count/1000
    keep rmsa iwage90`edg' ires90`edg' icountw90`edg' 
    sort rmsa
    save data/1990/iw90`edg'.dta, replace
    restore
}

/***************************************/
/* Some data for 2000 */
/**************************************/
use data/2000/allcells_new2.dta, clear
replace count = count / 1000
gen imm_count = count * imm
rename hispanic hisp 
rename annhrs hrs

label variable count "wtd count of adult pop in city"
label variable imm "imm share among adult pop in city"

keep rmsa count imm_count imm dropout hs somecoll collplus
sort rmsa
save data/2000/m1.dta, replace

/***************************************/
/* Some data for 1990 */
/**************************************/
use data/1990/allcells_new2.dta, clear
gen count90 = count / 1000
gen imm_count90 = count90 * imm
rename (imm dropout hs somecoll collplus) ///
        (imm90 drop90 hs90 some90 coll90)
        
label variable count90 "1990 count of adult pop in city"
label variable imm90 "1990 imm share among adult pop in city"

keep rmsa count90 imm90 imm_count90 drop90 hs90 some90 coll90
sort rmsa
save data/1990/m90.dta, replace

/***************************************/
/* Some data for 1980 */
/**************************************/
use data/1980/allcells_new2.dta, clear
gen count80 = 20 * count / 1000
gen imm_count80 = count80 * imm
rename (imm dropout hs somecoll collplus) ///
        (imm80 drop80 hs80 some80 coll80)
        
label variable count80 "1980 count of adult pop in city"
label variable imm80 "1980imm share among adult pop in city"

keep rmsa count80 imm80 imm_count80 drop80 hs80 some80 coll80
sort rmsa
save data/1980/m80.dta, replace

/**************************************/
/* Nw data for 2000 */
/**************************************/
use data/2000/bigcells_new2.dta, clear
keep if native == 1 & male == 1 
gen nwage = logwage2 
gen nres = res
gen npred = pred
gen ncountw = count / 1000
keep rmsa nwage npred nres ncountw
sort rmsa 
save data/2000/nw.dta, replace

/**************************************/
/* Nw data for 1990 */
/**************************************/
use data/1990/bigcells_new2.dta, clear
keep if native == 1 & male == 1
gen nres90 = res
label variable nres90 "residual wage native men 1990"
keep rmsa nres90 
sort rmsa 
save data/1990/nw90.dta, replace

/**************************************/
/* Nw data for 1980 */
/**************************************/
use data/1980/bigcells_new2.dta, clear
keep if native == 1 & male == 1
gen nres80 = res
label variable nres80 "residual wage native men 1980"
keep rmsa nres80 
sort rmsa 
save data/1980/nw80.dta, replace

/**************************************/
/* Iw data for 2000 */
/**************************************/
use data/2000/bigcells_new2.dta, clear
keep if native == 0 & male == 1
gen iwage = logwage2 
gen ires = res
gen icountw = count / 1000
keep rmsa iwage ires icountw
sort rmsa 
save data/2000/iw.dta, replace

/**************************************/
/* Iw data for 1990 */
/**************************************/
use data/1990/bigcells_new2.dta, clear
keep if native == 0 & male == 1
gen ires90 = res
label variable ires90 "residual wage imm men 1990"
keep rmsa ires90
sort rmsa 
save data/1990/iw90.dta, replace

/**************************************/
/* Iw data for 1980 */
/**************************************/
use data/1980/bigcells_new2.dta, clear
keep if native == 0 & male == 1
gen ires80 = res
label variable ires80 "residual wage imm men 1980"
keep rmsa ires80
sort rmsa 
save data/1980/iw80.dta, replace

/**************************************/
/* 1990 Manufacturing */
/**************************************/
use data/1990/mfg.dta, clear
rename mfg mfg90 
keep rmsa mfg90
sort rmsa
save data/1990/mfg90.dta, replace

/**************************************/
/* 1980 Manufacturing */
/**************************************/
use data/1980/mfg.dta, clear
rename mfg mfg80 
keep rmsa mfg80
sort rmsa
save data/1980/mfg80.dta, replace

/**************************************/

/**************************************/
use data/2000/newflows.dta, clear
keep rmsa indrop inhs insome incoll
sort rmsa
save data/2000/inflow.dta, replace

local filenames	data/1980/ic_city.dta /// /* contains (# of imm from country m living in city j in 1980) / (# of imm from country m in the US in 1980) for each city
				data/2000/m1.dta ///
				data/1980/m80.dta ///
				data/1990/m90.dta ///
				data/2000/nw1.dta ///
				data/2000/nw2.dta ///
				data/2000/nw3.dta ///
				data/2000/nw4.dta ///
				data/2000/iw1.dta ///
				data/2000/iw2.dta ///
				data/2000/iw3.dta ///
				data/2000/iw4.dta ///
				data/1990/nw902.dta ///
				data/1990/nw904.dta ///
				data/1990/iw902.dta ///
				data/1990/iw904.dta ///
				data/2000/inflow.dta ///
				data/2000/nw.dta ///
				data/1990/nw90.dta ///
				data/1980/nw80.dta ///
				data/2000/iw.dta ///
				data/1990/iw90.dta ///
				data/1980/iw80.dta ///
				data/1990/mfg90.dta ///
				data/1980/mfg80.dta 

/* Merge all the datasets above */				
forvalues i=1/25{
	local filename : word `i' of `filenames'
	merge 1:1 rmsa using `filename'
	drop _merge
}

/* Merge datasets above with the dataset that contains stock of immigrants 
arriving between 1980-2000 */
gen merge_key = 1

merge m:1 merge_key using data/temp/2000/by_educ_imm_stock.dta /* contains number of HS and Coll-equiv workers that arrived from each ic between 1980-2000*/
drop _merge merge_key
  
/* Difference between the mean wage residuals of immigrants and natives in 2000 */
gen resgap2=ires2-nres2 /* eclass == 2. hs workers*/
gen resgap4=ires4-nres4 /* eclass == 4. collplus workers*/

/* Difference between the mean wage residuals of immigrants and native in 1990*/
gen resgap902=ires902-nres902 /* hs workers */
gen resgap904=ires904-nres904 /* hs workers */

gen c1 = .7
gen c2 = 1.2
gen c3 = .8

/* Relative supply of high school and college equivalent workers in 2000. Endogenous variable. */
gen nshs = c1*ncountw1+ncountw2+.5*c2*ncountw3 
gen ishs = c1*icountw1+icountw2+.5*c2*icountw3 
gen relshs = log(ishs/nshs) /* log relative supply of high school equivalent workers*/

gen nscoll = ncountw4+.5*c3*ncountw3  
gen iscoll = icountw4+.5*c3*icountw3 
gen relscoll = log(iscoll/nscoll)  /* log relative supply of college equivalent workers*/

/* Log city sizes in 1980 and 1990. */
gen logsize80 = log(count80)
gen logsize90 = log(count90)

/* Normalize instrument by city cize */
foreach var of varlist shric* {
	replace `var' = .001 * `var' / count
	}

drop c1 c2 c3

drop if rmsa == 1 | rmsa == 0

/* Keep variables we need */
keep rmsa /// 
	 resgap2 resgap4 /// /* dependent vars */
	 resgap902 resgap904 /// /* lagged dependent vars*/
	 logsize80 logsize90 coll80 coll90 ires80 nres80 mfg80 mfg90 /// /* controls */
	 relshs relscoll /// /* endogenous vars */
	 shric* /// /* share of immigrants by incoming country in each city. Instrument. Lagged z_kl */
	 count90 /// /* regression weights */
	 hs_imm_ic* coll_imm_ic* /* number of hs and coll immigrant workers that came to the US between 1980-2000 */

/**************/
/* Label variables */
/************/
label variable resgap2 "HS dep var"/* Diff between avg wage res of HS imm and native */
label variable relshs "Log rel supply imm/native" /* HS equiv workers */
label variable relscoll "Log rel supply imm/native" /* Coll equiv workers */
label variable logsize80 "Log msa size 1980"
label variable logsize90 "Log msa size 1990"
label variable coll80 "College share 1980"
label variable coll90 "College share 1990"
label variable nres80 "Wage res native 1980"
label variable ires80 "Wage res imm 1980"
label variable resgap4 "Coll dep var" /* Diff between avg wage residual of college equivalent imm and native */
label variable mfg80 "Mfg share in 1980"
label variable mfg90 "Mfg share in 1990"

save data/prepared_bartik.dta, replace 
