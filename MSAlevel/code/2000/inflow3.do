clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"

/*******************************/
/* Create male file for 2000*/
/*******************************/
preserve
clear
use data/2000/byicnew.dta 

keep if male == 1
gen count00m = count

/* Recall that ex11 is eclass == 1 (dropout) & xclass2 == 1 (less than 10hrs of experience). etc*/
local numbers 11 12 13 14 21 22 23 24 31 32 33 34 41 42 43 44 
forv i=1/16{
	local n : word `i' of `numbers'
	gen mex`n' = ex`n'
}

gen mhrs = annhrs 
keep ic count00m mhrs mex11 mex12 mex13 mex14 mex21 mex22 mex23 mex24 mex31 ///
		mex32 mex33 mex34 mex41 mex42 mex43 mex44
sort ic

save data/2000/m00.dta, replace
restore


/*******************************/
/* Create female file for 2000*/
/*******************************/
preserve
clear
use data/2000/byicnew.dta 

keep if male == 0
gen count00f = count

local numbers 11 12 13 14 21 22 23 24 31 32 33 34 41 42 43 44 
forv i=1/16{
	local n : word `i' of `numbers'
	gen fex`n' = ex`n'
}

gen fhrs = annhrs 

keep ic count00f fhrs fex11 fex12 fex13 fex14 fex21 fex22 fex23 fex24 fex31 ///
		fex32 fex33 fex34 fex41 fex42 fex43 fex44	
sort ic

save data/2000/f00.dta, replace
restore


/*******************************/
/* Merge files created above. */
/*******************************/
preserve
clear
use data/2000/m00.dta
merge ic using data/2000/f00.dta

/* Erase files after merging. */
erase data/2000/m00.dta 
erase data/2000/f00.dta

local numbers 11 12 13 14 21 22 23 24 31 32 33 34 41 42 43 44 
forv i=1/16{
	local n : word `i' of `numbers'
	gen inex`n' = count00m*mex`n' + count00f*fex`n'
	gen hinex`n' = count00m*(mhrs/2000)*mex`n' + count00f*(fhrs/2000)*fex`n'
}

gen indrop = inex11 + inex12 + inex13 + inex14
gen inhs = inex21 + inex22 + inex23 + inex24 
gen insome = inex31 + inex32 + inex33 + inex34
gen incoll = inex41 + inex42 + inex43 + inex44

gen hindrop = hinex11 + hinex12 + hinex13 + hinex14
gen hinhs = hinex21 + hinex22 + hinex23 + hinex24 
gen hinsome = hinex31 + hinex32 + hinex33 + hinex34
gen hincoll = hinex41 + hinex42 + hinex43 + hinex44

gen inall = count00m + count00f
gen indroprate = indrop/inall
gen inhsrate = inhs / inall
gen incollrate = incoll / inall

save data/2000/one.dta, replace
restore

/***********************************/
/***********************************/
preserve 
clear 
use data/2000/one.dta

keep ic inex11 inex12 inex13 inex14 inex21 inex22 inex23 inex24 ///
        inex31 inex32 inex33 inex34 inex41 inex42 inex43 inex44

/* Data set now has 16 rows (inex11...inex44) x 38 cols (ic1...ic38). */
/* Next lines sum across cols to get total inflows. */
xpose, clear

rename v* inflow*

drop if _n == 1

save data/2000/tt.dta, replace
restore 

/***********************************/
/***********************************/
preserve
clear 
/* The shricXX is the (number of immigrants from country XX in the city) / (total number of immigrants from country XX) */
use data/1980/ic_city.dta
keep rmsa shric*
gen d = 1
sort d
save data/1980/shric.dta, replace
restore 

/***********************************/
/***********************************/

clear
use data/2000/tt.dta
local number_rows = _N
forv n=1/`number_rows'{
	preserve
	/* Each row of the dataset tt corresponds to a skill level. The columns contain
	the number of immigrants with that specific skill level for each IC country. */
	keep if _n == `n'
	gen d = 1
	sort d
	save data/1980/in.dta, replace
	
	clear
	use data/1980/shric.dta
	sort d
	merge d using data/1980/in.dta	
	
	/* This is the numerator of equation 7 on Card's paper. */
	forvalues i=1/35{
		gen numerator`i' = shric`i' * inflow`i'
	}

	egen inflow_skill`n' = rowtotal(numerator1-numerator35)
	keep rmsa inflow_skill`n'
	sort rmsa
	
	save data/inflow_skill`n'.dta, replace 
	restore
}


use data/inflow_skill1, clear
forv s = 2/16{
	merge rmsa using data/inflow_skill`s'
	drop _merge
	sort rmsa
	erase data/inflow_skill`s'.dta
}
*erase data/inflow_skill1
save data/by_skill_inflow.dta, replace


egen inall = rowtotal(inflow_skill1-inflow_skill16)

rename (inflow_skill1 inflow_skill2 inflow_skill3 inflow_skill4 ///
		inflow_skill5 inflow_skill6 inflow_skill7 inflow_skill8 /// 
		inflow_skill9 inflow_skill10 inflow_skill11 inflow_skill12 ///
		inflow_skill13 inflow_skill14 inflow_skill15 inflow_skill16) ///
		(inex11 inex12 inex13 inex14 ///
		inex21 inex22 inex23 inex24 ///
		inex31 inex32 inex33 inex34 ///
		inex41 inex42 inex43 inex44)

gen indrop = inex11 + inex12 + inex13 + inex14
gen inhs = inex21 + inex22 + inex23 + inex24
gen insome = inex31 + inex32 + inex33 + inex34
gen incoll = inex41 + inex42 + inex43 + inex44

gen sindrop = indrop/inall
gen sinhs = inhs/inall 
gen sinsome = insome/inall
gen sincoll = incoll/inall

save data/2000/newflows.dta, replace








		


	  


