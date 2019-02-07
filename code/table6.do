clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/"


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
	keep rczone imm`edg' count`edg' 
	sort rczone
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
	keep rczone nwage`edg' npred`edg' nres`edg' ncountw`edg'
	sort rczone
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
	gen ipred`edg' = pred
	gen icountw`edg' = count/1000
	keep rczone iwage`edg' ipred`edg' ires`edg' icountw`edg' 
	sort rczone
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
	keep rczone nwage90`edg' npred90`edg' nres90`edg' ncountw90`edg' 
	sort rczone
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
	gen ipred90`edg' = pred
	gen icountw90`edg' = count/1000
	keep rczone iwage90`edg' ipred90`edg' ires90`edg' icountw90`edg' 
	sort rczone
	save data/1990/iw90`edg'.dta, replace
	restore
}


/***************************************/
/* Gets 1980 native wages by eclass */
/**************************************/
use data/1980/bigcells_new1.dta, clear
local education_groups 1 2 3 4 
forv i=1/4{
	local edg : word `i' of `education_groups'
	preserve
	keep if native == 1 & male == 1 & eclass == `edg' 
	gen nwage80`edg' = logwage2
	gen nres80`edg' = res
	gen npred80`edg' = pred
	gen ncountw80`edg' = count/1000
	keep rczone nwage80`edg' npred80`edg' nres80`edg' ncountw80`edg' 
	sort rczone
	save data/1980/nw80`edg'.dta, replace
	restore
}


/***************************************/
/* Gets 1980 immigrant wages by eclass */
/**************************************/
use data/1980/bigcells_new1.dta, clear
local education_groups 1 2 3 4 
forv i=1/4{
	local edg : word `i' of `education_groups'
	preserve
	keep if native == 0 & male == 1 & eclass == `edg'
	gen iwage80`edg' = logwage2
	gen ires80`edg' = res
	gen ipred80`edg' = pred
	gen icountw80`edg' = count/1000
	keep rczone iwage80`edg' ipred80`edg' ires80`edg' icountw80`edg' 
	sort rczone
	save data/1980/iw80`edg'.dta, replace
	restore
}


/***************************************/
/* Some data for 2000 */
/**************************************/
use data/2000/allcells_new2.dta, clear
replace count = count / 1000
rename hispanic hisp 
rename annhrs hrs

label variable count "wtd count of adult pop in city"
label variable imm "imm share among adult pop in city"

keep rczone count imm mex emp black hisp dropout hs somecoll collplus
sort rczone
save data/2000/m1.dta, replace

/***************************************/
/* Some data for 1990 */
/**************************************/
use data/1990/allcells_new2.dta, clear
gen count90 = count / 1000
rename (imm mex black hispanic educ_yrs dropout hs somecoll collplus) ///
		(imm90 mex90 black90 hisp90 educ_yrs90 drop90 hs90 some90 coll90)
		
label variable count90 "1990 count of adult pop in city"
label variable imm90 "1980imm share among adult pop in city"

keep rczone count90 imm90 mex90 black90 hisp90 educ_yrs90 drop90 hs90 some90 coll90
sort rczone
save data/1990/m90.dta, replace

/***************************************/
/* Some data for 1980 */
/**************************************/
use data/1980/allcells_new2.dta, clear
gen count80 = 20 * count / 1000
rename (imm mex black hispanic educ_yrs dropout hs somecoll collplus) ///
		(imm80 mex80 black80 hisp80 educ_yrs80 drop80 hs80 some80 coll80)
		
label variable count80 "1980 count of adult pop in city"
label variable imm80 "1980imm share among adult pop in city"

keep rczone count80 imm80 mex80 black80 hisp80 educ_yrs80 drop80 hs80 some80 coll80
sort rczone
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
keep rczone nwage npred nres ncountw
sort rczone 
save data/2000/nw.dta, replace

/**************************************/
/* Nw data for 1990 */
/**************************************/
use data/1990/bigcells_new2.dta, clear
keep if native == 1 & male == 1
gen nres90 = res
label variable nres90 "residual wage native men 1990"
keep rczone nres90 
sort rczone 
save data/1990/nw90.dta, replace

/**************************************/
/* Nw data for 1980 */
/**************************************/
use data/1980/bigcells_new2.dta, clear
keep if native == 1 & male == 1
gen nres80 = res
label variable nres80 "residual wage native men 1980"
keep rczone nres80 
sort rczone 
save data/1980/nw80.dta, replace

/**************************************/
/* Iw data for 2000 */
/**************************************/
use data/2000/bigcells_new2.dta, clear
keep if native == 0 & male == 1
gen iwage = logwage2 
gen ires = res
gen ipred = pred
gen icountw = count / 1000
keep rczone iwage ipred ires icountw
sort rczone 
save data/2000/iw.dta, replace

/**************************************/
/* Iw data for 1990 */
/**************************************/
use data/1990/bigcells_new2.dta, clear
keep if native == 0 & male == 1
gen ires90 = res
label variable ires90 "residual wage imm men 1990"
keep rczone ires90
sort rczone 
save data/1990/iw90.dta, replace

/**************************************/
/* Iw data for 1980 */
/**************************************/
use data/1980/bigcells_new2.dta, clear
keep if native == 0 & male == 1
gen ires80 = res
label variable ires80 "residual wage imm men 1980"
keep rczone ires80
sort rczone 
save data/1980/iw80.dta, replace

/**************************************/
/* 1990 Manufacturing */
/**************************************/
use data/1990/mfg.dta, clear
rename mfg mfg90 
keep rczone mfg90
sort rczone
save data/1990/mfg90.dta, replace

/**************************************/
/* 1980 Manufacturing */
/**************************************/
use data/1980/mfg.dta, clear
rename mfg mfg80 
keep rczone mfg80
sort rczone
save data/1980/mfg80.dta, replace

/**************************************/
/* Get hours supplied in 2000 */
/**************************************/
use data/2000/cellsupply_new1.dta, clear

gen h=supply/1000
gen h1=supply1/1000
gen h2=supply2/1000
gen h3=supply3/1000
gen h4=supply4/1000
gen h5=supply5/1000
gen h6=supply6/1000

gen sh1=h1/h
gen sh2=h2/h
gen sh3=h3/h
gen sh4=h4/h
gen sh5=h5/h
gen sh6=h6/h

label variable h1 "hrs weighted supply of dropouts"
label variable h2 "hrs weighted supply of hs"
label variable h3 "hrs weighted supply of somecoll"
label variable h4 "hrs weighted supply of collplus"
label variable h5 "hrs weighted supply of exactly college"
label variable h6 "hrs weighted supply of advanced"
label variable sh1 "dropout shr of hrs"
label variable sh2 "hs shr of hrs"
label variable sh3 "some coll shr of hrs"
label variable sh4 "collplus shr of hrs"
label variable sh5 "exact college (16) shr of hrs"
label variable sh6 "advanced (>16) shr of hrs"
	  
keep rczone h h1-h6 sh1-sh6
save data/2000/m2.dta, replace

/**************************************/
/* Get hours supplied in 1990 */
/**************************************/
use data/1990/cellsupply_new1.dta, clear

gen h90=supply/1000
gen h901=supply1/1000
gen h902=supply2/1000
gen h903=supply3/1000
gen h904=supply4/1000
gen h905=supply5/1000
gen h906=supply6/1000

gen sh901=h901/h90
gen sh902=h902/h90
gen sh903=h903/h90
gen sh904=h904/h90
gen sh905=h905/h90
gen sh906=h906/h90

label variable sh901 "90 dropout shr of hrs"
label variable sh902 "90 hs shr of hrs"
label variable sh903 "90 some coll shr of hrs"
label variable sh904 "90 collplus shr of hrs"
label variable sh905 "90 exact college (16) shr of hrs"
label variable sh906 "90 advanced (>16) shr of hrs"

keep rczone h90 sh901-sh906
save data/1990/m290.dta, replace

/**************************************/
/* Get hours supplied in 1980 */
/**************************************/
use data/1980/cellsupply_new1.dta, clear

gen h80=supply/1000
gen h801=supply1/1000
gen h802=supply2/1000
gen h803=supply3/1000
gen h804=supply4/1000
gen h805=supply5/1000
gen h806=supply6/1000

gen sh801=h801/h80
gen sh802=h802/h80
gen sh803=h803/h80
gen sh804=h804/h80
gen sh805=h805/h80
gen sh806=h806/h80

label variable sh801 "80 dropout shr of hrs"
label variable sh802 "80 hs shr of hrs"
label variable sh803 "80 some coll shr of hrs"
label variable sh804 "80 collplus shr of hrs"
label variable sh805 "80 exact college (16) shr of hrs"
label variable sh806 "80 advanced (>16) shr of hrs"

keep rczone h80 sh801-sh806
save data/1980/m280.dta, replace

/**************************************/

/**************************************/
use data/2000/newflows.dta, clear
keep rczone indrop inhs insome incoll
sort rczone
save data/2000/inflow.dta, replace


merge rczone using data/2000/m1.dta ///
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
				   data/1990/nw901.dta ///
				   data/1990/nw902.dta ///
				   data/1990/nw903.dta ///
				   data/1990/nw904.dta ///
				   data/1990/iw901.dta ///
				   data/1990/iw902.dta ///
				   data/1990/iw903.dta ///
				   data/1990/iw904.dta ///
				   data/1980/nw801.dta ///
				   data/1980/nw802.dta ///
				   data/1980/nw803.dta ///
				   data/1980/nw804.dta ///
				   data/1980/iw801.dta ///
				   data/1980/iw802.dta ///
				   data/1980/iw803.dta ///
				   data/1980/iw804.dta ///
				   data/2000/inflow.dta ///
				   data/2000/nw.dta ///
				   data/1990/nw90.dta ///
				   data/1980/nw80.dta ///
				   data/2000/iw.dta ///
				   data/1990/iw90.dta ///
				   data/1980/iw80.dta ///
				   data/1990/mfg90.dta ///
				   data/1980/mfg80.dta ///
				   data/2000/m2.dta ///
				   data/1980/m280.dta ///
				   data/1990/m290.dta /// 

drop if rczone == 1
drop if rczone == 0

/* Difference between the mean wage residuals of immigrants and native in 2000*/
gen resgap=ires-nres
gen resgap1=ires1-nres1 /* eclass == 1. dropout workers */
gen resgap2=ires2-nres2 /* eclass == 2. hs workers*/
gen resgap3=ires3-nres3 /* eclass == 3. somecoll workers*/
gen resgap4=ires4-nres4 /* eclass == 4. collplus workers*/

/* Difference between the mean wage residuals of immigrants and native in 1990*/
gen resgap901=ires901-nres901
gen resgap902=ires902-nres902
gen resgap903=ires903-nres903
gen resgap904=ires904-nres904

/* Difference between log wage of male immigrants and natives in 2000*/
gen wagegap1=iwage1-nwage1 /* dropout */
gen wagegap2=iwage2-nwage2 /* hs */
gen wagegap3=iwage3-nwage3 /* somecoll */
gen wagegap4=iwage4-nwage4 /* collplus */
gen wagegap=iwage-nwage /* all male */

/* Log relative suplly of immigrants and natives. */
gen rels1 = log(icountw1/ncountw1)
gen rels2 = log(icountw2/ncountw2)
gen rels3 = log(icountw3/ncountw3)
gen rels4 = log(icountw4/ncountw4)
gen rels = log(icountw/ncountw)

gen c1 = .7
gen c2 = 1.2
gen c3 = .8

/* Calculate supply of high school and college equivalent workers. */
gen nshs = c1*ncountw1+ncountw2+.5*c2*ncountw3 
gen ishs = c1*icountw1+icountw2+.5*c2*icountw3 
gen relshs = log(ishs/nshs) /* log relative supply of high school equivalent workers*/

gen nshs90 = c1*ncountw901+ncountw902+.5*c2*ncountw903
gen ishs90 = c1*icountw901+icountw902+.5*c2*icountw903
gen relshs90 = log(ishs90/nshs90)

gen nscoll = ncountw4+.5*c3*ncountw3  
gen iscoll = icountw4+.5*c3*icountw3 
gen relscoll = log(iscoll/nscoll)  /* log relative supply of college equivalent workers*/

gen nscoll90 = ncountw904+.5*c3*ncountw903
gen iscoll90 = icountw904+.5*c3*icountw903
gen relscoll90 = log(iscoll90/nscoll90)

/* Inflow of immigrants between 1980-2000 by education class. */
gen infl1 = .001*indrop/count
gen infl2 = .001*inhs/count
gen infl3 = .001*insome/count
gen infl4 = .001*incoll/count
gen inflall = infl1+infl2+infl3+infl4

/* Inflow of high school and college equivalent imm between 1980-2000. */
gen hsiv = c1*infl1+infl2+.5*c2*infl3
gen colliv = .5*c3*infl3+infl4

/* Log city sizes in 1980 and 1990. */
gen logsize80 = log(count80)
gen logsize90 = log(count90)

gen check1 = ncountw - ncountw1 - ncountw2 - ncountw3 - ncountw4
gen check2 = icountw - icountw1 - icountw2 - icountw3 - icountw4
gen check3 = count - ncountw - icountw

/**************/
/* Label variables */
/************/
label variable resgap2 "HS dep var"/* Diff between avg wage res of HS imm and native */
label variable relshs "Log rel supply imm/native" /* HS equiv workers */
label variable relscoll "Log rel supply imm/native" /* Coll equiv workers */
label variable logsize80 "Log czone size 1980"
label variable logsize90 "Log czone size 1990"
label variable coll80 "College share 1980"
label variable coll90 "College share 1990"
label variable nres80 "Wage res native 1980"
label variable ires80 "Wage res imm 1980"
label variable resgap902 "Lagged dep var"
label variable resgap4 "Coll dep var" /* Diff between avg wage residual of college equivalent imm and native */
label variable resgap904 "Lagged dep var" 
label variable mfg80 "Mfg share in 1980"
label variable mfg90 "Mfg share in 1990"

/**************************************/
/* Regressions */
/**************************************/
reg resgap4 colliv [fweight = round(count90)]

reg resgap rels [fweight = round(count90)]
reg rels inflall [fweight = round(count90)]
reg resgap inflall [fweight = round(count90)]

/************/
/* OLS */
* Dependent variable is the difference in mean wage residual between native and immigrant.
/************/
/* High school equivalent regression. Without the lagged dependent variable resgap902 */
reg resgap2 relshs [fweight = round(count90)]

	reg resgap2 relshs logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90 [fweight = round(count90)]
	estimates store m1, title(1)


/* High school equivalent regression. With the lagged dependent variable resgap902 */
reg resgap2 relshs resgap902 [fweight = round(count90)]

reg resgap2 relshs resgap902 logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90 [fweight = round(count90)]
estimates store m2, title(2)


/* College equivalent regression. Without the lagged dependent variable resgap904 */
reg resgap4 relscoll [fweight = round(count90)]

reg resgap4 relscoll logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80  mfg90 [fweight = round(count90)]
estimates store m3, title(5)


/* College equivalent regression. With the lagged dependent variable resgap904 */
reg resgap4 relscoll resgap904 [fweight = round(count90)]

reg resgap4 relscoll resgap904 logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90 [fweight = round(count90)]
estimates store m4, title(6)

/************/
/* 2SLS */
/************/
/* High school equivalent regression. Without the lagged dependent variable resgap902 */
ivregress 2sls resgap2 logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90 ///
			    (relshs = hsiv) [fweight = round(count90)]
estimates store m5, title(3)


/* High school equivalent regression. With the lagged dependent variable resgap902 */
ivregress 2sls resgap2 resgap902 logsize80 logsize90 coll80 coll90 nres80 ires80 ///
                mfg80 mfg90 (relshs = hsiv) [fweight = round(count90)] 
estimates store m6, title(4)


/* College equivalent regression. Without the lagged dependent variable resgap904 */
ivregress 2sls resgap4 logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90 ///
               (relshs = colliv) [fweight = round(count90)]
estimates store m7, title(7)


/* College equivalent regression. With the lagged dependent variable resgap904 */
ivregress 2sls resgap4 resgap904 logsize80 logsize90 coll80 coll90 nres80 ires80 ///
               mfg80 mfg90 (relshs = colliv) [fweight = round(count90)] 
estimates store m8, title(8)



estout m1 m2 m5 m6, cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(r2)
   
   
estout m3 m4 m7 m8, cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(r2)



/* 
/************/
/* Reduced form - Instrument on Dep variable */
* Dependent variable is the difference in mean wage residual between native and immigrant.
/************/

reg relshs  hsiv [fweight = round(count90)]
reg resgap2 hsiv [fweight = round(count90)]

reg relshs  hsiv logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90 [fweight = round(count90)]
reg resgap2 hsiv logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90 [fweight = round(count90)]

reg relshs  hsiv resgap902 logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 ///
	mfg90 [fweight = round(count90)]
reg resgap2 hsiv resgap902 logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 ///
	mfg90 [fweight = round(count90)]


reg relscoll colliv [fweight = round(count90)]
reg resgap4 colliv [fweight = round(count90)]

reg relscoll colliv logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80  mfg90 [fweight = round(count90)]
reg resgap4 colliv logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90 [fweight = round(count90)]

reg relscoll colliv resgap904 logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 ///
	         mfg90 [fweight = round(count90)]
reg resgap4 colliv resgap904 logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 ///
	        mfg90 [fweight = round(count90)]
















