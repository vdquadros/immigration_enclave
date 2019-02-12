clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/"

clear
use data/supp0506.dta

gen rmsa0 = (rmsa==0)
gen rmsa1 = (rmsa==1)

gen male = 1 - female
gen native = 1 - imm

gen lw2sq=logwage2^2

gen xclass2 = 4
replace xclass2 = 3 if exp <= 30
replace xclass2 = 2 if exp <= 20
replace xclass2 = 1 if exp <= 10

gen havewage2 = (logwage2 != . )
gen cwagesal = incwage 
replace cwagesal = . if incwage <= 0

replace annhrs = 0 if annhrs == . 
gen cannhrs = . 
replace cannhrs = annhrs if annhrs > 0

gen hs = 1 - dropout - somecoll - collplus

gen college = 0
replace college = 1 if collplus == 1 & advanced == 0
gen x1 = (xclass2 == 1)
gen x2 = (xclass2 == 2)
gen x3 = (xclass2 == 3)
gen x4 = (xclass2 == 4)

gen hrswkly = .
replace hrswkly = annhrs / wkswork1 if annhrs > 0

gen ft = (hrswkly >= 35)

gen q1 = p1 + p2
gen q2 = p3 + p4
gen q3 = p5 + p6
gen q4 = p7 + p8
gen q5 = p9 + p10

gen q1c = .
gen q2c = .
gen q3c = .
gen q4c = .
gen q5c = .
replace q1c = q1 if logwage2 != .
replace q2c = q2 if logwage2 != .
replace q3c = q3 if logwage2 != .
replace q4c = q4 if logwage2 != .
replace q5c = q5 if logwage2 != .

gen minority = 0
replace minority = 1 if black == 1 | asian == 1 | hispanic == 1 

gen top124 = 0
replace top124 = 1 if rmsa > 3

gen lowed = (educ <= 6)

replace wt = round(wt / 2)

summ c imm hispanic minority q1-q5 dropout hs somecoll collplus wage2 cwagesal [fweight = wt]

gen total_pop = 175958509

preserve
# delim ;
keep if top124 == 0;
collapse (mean) imm hispanic minority q1-q5 dropout hs somecoll collplus wage2 cwagesal
	(sum) count=c [fweight = wt];
foreach var of varlist imm hispanic minority q1-q5 dropout hs somecoll collplus{;
	replace `var' = 100*`var';
};
gen top124 = 0;
save data/outside.dta, replace;
#delimit cr
restore 

preserve
# delim ;
keep if top124 == 1;
collapse (mean) imm hispanic minority q1-q5 dropout hs somecoll collplus wage2 cwagesal
	(sum) count=c [fweight = wt];
foreach var of varlist imm hispanic minority q1-q5 dropout hs somecoll collplus{;
	replace `var' = 100*`var';
};
gen top124 = 1;
save data/inside.dta, replace;
#delimit cr
restore 

preserve
# delim ;
collapse (mean) imm hispanic minority q1-q5 dropout hs somecoll collplus wage2 cwagesal
	(sum) count=c [fweight = wt], by(rmsa);
foreach var of varlist imm hispanic minority q1-q5 dropout hs somecoll collplus{;
	replace `var' = 100*`var';
};
gsort -count;
save data/byrmsa.dta, replace;
#delimit cr
restore 


collapse (mean) imm hispanic minority q1-q5 dropout hs somecoll collplus wage2 cwagesal ///
		(sum) count=c [fweight = wt]
		
foreach var of varlist imm hispanic minority q1-q5 dropout hs somecoll collplus{
	replace `var' = 100*`var'
}

append using data/inside.dta data/outside.dta data/byrmsa.dta
drop if rmsa == 0 | rmsa == 1
keep if _n <= 15

gen total_pop = 175958509
gen pop_share = 100 * count / total_pop
replace count = count / 1000

order rmsa count pop_share imm dropout collplus wage2 cwagesal
format count cwage %6.0f 
format pop_share wage2 %2.1f 
format imm dropout collplus %2.0f








