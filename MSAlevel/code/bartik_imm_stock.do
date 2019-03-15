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

save data/temp/2000/m00.dta, replace
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

save data/temp/2000/f00.dta, replace
restore


/*******************************/
/* Merge files created above. */
/*******************************/
preserve
clear
use data/temp/2000/m00.dta
merge ic using data/temp/2000/f00.dta

/* Erase files after merging. */
erase data/temp/2000/m00.dta 
erase data/temp/2000/f00.dta

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

save data/temp/2000/one.dta, replace
restore

/***********************************/
/***********************************/
clear 
use data/temp/2000/one.dta

keep ic indrop inhs insome incoll

gen c1 = .7
gen c2 = 1.2
gen c3 = .8

gen hs_imm = c1*indrop+inhs+.5*c2*incoll
gen coll_imm = .5*c3*insome+incoll

keep ic hs_imm coll_imm 

gen i = 1
reshape wide hs_imm coll_imm, i(i) j(ic)

drop i 

rename *_imm* *_imm_ic*

save data/temp/2000/by_educ_imm_stock.dta, replace





		


	  


