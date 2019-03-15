clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/"

use data/2000/supp2000.dta

gen rmsa0 = (rmsa==0)
gen rmsa1 = (rmsa==1)

gen male = 1 - female
gen native = 1 - imm

replace annhrs = 0 if annhrs == . 
gen cannhrs = . 
replace cannhrs = annhrs if annhrs > 0 & !missing(annhrs)

gen hs = 1 - dropout - somecoll - collplus

gen college = 0
replace college = 1 if collplus == 1 & advanced == 0

gen xclass2 = 4
replace xclass2 = 3 if exp <= 30
replace xclass2 = 2 if exp <= 20
replace xclass2 = 1 if exp <= 10


gen x1 = (xclass2 == 1)
gen x2 = (xclass2 == 2)
gen x3 = (xclass2 == 3)
gen x4 = (xclass2 == 4)

gen hrswkly = .
replace hrswkly = annhrs / weeks if annhrs > 0 & !missing(annhrs)
gen ft = (hrswkly >= 35 & !missing(hrswkly))

gen big3 = 1 if rmsa == 1600 | rmsa == 4480 | rmsa == 5600 

gen ric = 0 if imm == 0
replace ric=ic if imm != 0

gen post80 = .
replace post80 = 1 if imm == 1 & yrsinus <= 20 
replace post80 = 0 if imm == 1 & yrsinus > 20 & !missing(yrsinus)

gen post90 = .
replace post90 = 1 if imm == 1 & yrsinus <= 10
replace post90 = 0 if imm == 1 & yrsinus > 10 & !missing(yrsinus)

gen mided = hs + somecoll

/* Get statistics by immigration status (native vs. immigrants) */
preserve
collapse (sum) count=c (mean) post80 post90 educ dropout mided collplus wage2 logwage2 [fweight = wt], by(imm)
gen ic = -1 if imm == 0
replace ic = 0 if imm == 1
foreach var of varlist post80 post90 dropout mided collplus{
	replace `var' = 100*`var'
}
save data/p1.dta, replace
restore

/* Get statistics by country of origin*/
preserve
keep if imm == 1
collapse (sum) count=c (mean) post80 post90 educ dropout mided collplus wage2 logwage2 [fweight = wt], by(ic)
foreach var of varlist post80 post90 dropout mided collplus{
	replace `var' = 100*`var'
}
save data/p2.dta, replace
restore

/* Append datasets to create table. */
clear 
append using data/p1.dta data/p2.dta
keep if _n <= 18
gsort -count

gen total_imm = 23626536

/* Calculate share of all immigrants by country of origin. */
/* ic = -1 refers to natives. */
gen imm_share = 100 * count / total_imm if ic != -1

keep count imm_share post80 post90 educ dropout mided collplus ic
order ic count imm_share post80 post90 educ dropout mided collplus

replace count = count / 1000

label define IC 1 "mexico" ///
				2 "philippines" ///
				3 "india" ///
				4 "vietnam" ///
				5 "el salvador" ///
				6 "china" ///
				7 "cuba" ///
				8 "dominican republic" ///
				9 "korea" ///
				10 "jamaica" ///
				11 "canada" ///
				12 "colombia" ///
				13 "guatemala" ///
				14 "germany" ///
				15 "haiti" ///
				16 "poland"
				

label variable ic IC

format count %6.0f 
format imm_share post80 post90 educ dropout mided collplus %2.1f 

save data/2000/table2.dta, replace

/* Erase temp datasets */
erase data/p1.dta
erase data/p2.dta

