clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"

append using data/1980/cell_all.dta ///
			 data/1980/cell_male.dta ///
			 data/1980/cell_female.dta ///
			 data/1980/cell_native_male.dta ///
			 data/1980/cell_native_female.dta ///
			 data/1980/cell_imm_male.dta ///
			 data/1980/cell_imm_female.dta ///
			 data/1990/cell_all.dta ///
			 data/1990/cell_male.dta ///
			 data/1990/cell_female.dta ///
			 data/1990/cell_native_male.dta ///
			 data/1990/cell_native_female.dta ///
			 data/1990/cell_imm_male.dta ///
			 data/1990/cell_imm_female.dta ///
			 data/2000/cell_all.dta ///
			 data/2000/cell_male.dta ///
			 data/2000/cell_female.dta ///
			 data/2000/cell_native_male.dta ///
			 data/2000/cell_native_female.dta ///
			 data/2000/cell_imm_male.dta ///
			 data/2000/cell_imm_female.dta ///
			 
/* Replace only for cell_all */						 
replace count = count * 5 if missing(male) & missing(native)

replace count = count/2 if year == 200506

gen cpi = . 
replace cpi = 72.6 if year == 1980
replace cpi = 124.0 if year == 1990
replace cpi = 166.6 if year == 2000
replace cpi = 195.3 if year == 200506

gen rlogwage = logwage2+log(207.3)-log(cpi)
gen rwage = wage2*207.3/cpi

replace emp = 100 * emp

keep year native male educ exp emp rwage
order year native male educ exp emp rwage

sort year native male 

/*
foreach y in 1980 1990 2000{
	merge 1:1 year native male using data/`y'/compvar_`y'.dta
	drop _merge
}

/*
format  educ_yrs exp emp %2.1f 
format  rwage %2.2f 
