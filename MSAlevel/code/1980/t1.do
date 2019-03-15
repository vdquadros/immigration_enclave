clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"

use data/1980/supp80.dta 
	
gen rmsa0 = (rmsa ==0)
gen rmsa1 = (rmsa ==1)
gen male = 1 - female
gen native = 1 - imm

gen lw2sq = logwage2^2

gen xclass2 = 1 if exp <= 10
replace xclass2 = 2 if 10 <= exp & exp <= 20
replace xclass2 = 3 if 20 <= exp & exp <= 30
replace xclass2 = 4 if 30 < exp & !missing(exp)

replace c = 1

gen havewage2 = 1 if logwage2 != .
gen cwagesal = wagesal
replace cwagesal = . if wagesal <= 0

gen cannhrs = . 
replace cannhrs = annhrs if annhrs > 0 & !missing(annhrs)

gen hs = 1 - dropout - somecoll - collplus

gen college = 0
replace college = 1 if collplus == 1 & advanced == 0
gen x1 = (xclass2 == 1)
gen x2 = (xclass2 == 2)
gen x3 = (xclass2 == 3)
gen x4 = (xclass2 == 4)

gen hrswkly = .
replace hrswkly = annhrs / weeks if annhrs > 0 & !missing(annhrs)

gen ft = (hrswkly >= 35 & !missing(hrswkly))

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

/* The following datasets are used in Table 6.*/
preserve
# delim ;
collapse (mean) emp havewage2 wagesal cwagesal annhrs cannhrs weeks 
	hrswkly ft dropout hs somecoll college advanced collplus educ exp age x1-x4 
    black hispanic asian euro hi_asian mid_asian mex rmsa0 rmsa1 q1-q5 q1c 
	q2c q3c q4c q5c imm female wage2 logwage2 
	(sum) count=c [fweight = wt], by(rmsa native male eclass xclass2);
save data/1980/allcells.dta, replace;
#delimit cr
restore 


preserve
# delim ;
collapse (mean) emp havewage2 wagesal cwagesal annhrs cannhrs weeks 
	hrswkly ft dropout hs somecoll college advanced collplus educ exp age x1-x4 
    black hispanic asian euro hi_asian mid_asian mex rmsa0 rmsa1 q1-q5 q1c 
	q2c q3c q4c q5c imm female wage2 logwage2 
	(sum) count=c [fweight = wt], by(rmsa);
save data/1980/allcells_new2.dta, replace;
#delimit cr
restore 

/* The following datasets are used in Table 3*/
preserve
# delim ;
collapse (mean) emp havewage2 wagesal cwagesal annhrs cannhrs weeks 
	hrswkly ft dropout hs somecoll college advanced collplus educ exp age x1-x4 
    black hispanic asian euro hi_asian mid_asian mex rmsa0 rmsa1 q1-q5 q1c 
	q2c q3c q4c q5c imm female wage2 logwage2 
	(sum) count=c [fweight = wt];
gen year = 1980;
save data/1980/cell_all.dta, replace;
#delimit cr
restore 


preserve
# delim ;
keep if male == 1;
collapse (mean) emp havewage2 wagesal cwagesal annhrs cannhrs weeks 
	hrswkly ft dropout hs somecoll college advanced collplus educ exp age x1-x4 
    black hispanic asian euro hi_asian mid_asian mex rmsa0 rmsa1 q1-q5 q1c 
	q2c q3c q4c q5c imm female wage2 logwage2 
	(sum) count=c [fweight = wt];
gen year = 1980;
gen male = 1;
save data/1980/cell_male.dta, replace;
#delimit cr
restore 

preserve
# delim ;
keep if male == 0;
collapse (mean) emp havewage2 wagesal cwagesal annhrs cannhrs weeks 
	hrswkly ft dropout hs somecoll college advanced collplus educ exp age x1-x4 
    black hispanic asian euro hi_asian mid_asian mex rmsa0 rmsa1 q1-q5 q1c 
	q2c q3c q4c q5c imm female wage2 logwage2 
	(sum) count=c [fweight = wt];
gen year = 1980;
gen male = 0;
save data/1980/cell_female.dta, replace;
#delimit cr
restore 

preserve
# delim ;
keep if male == 1 & native == 1;
collapse (mean) emp havewage2 wagesal cwagesal annhrs cannhrs weeks 
	hrswkly ft dropout hs somecoll college advanced collplus educ exp age x1-x4 
    black hispanic asian euro hi_asian mid_asian mex rmsa0 rmsa1 q1-q5 q1c 
	q2c q3c q4c q5c imm female wage2 logwage2 
	(sum) count=c [fweight = wt];
gen year = 1980;
gen native = 1;
gen male = 1;
save data/1980/cell_native_male.dta, replace;
#delimit cr
restore 

preserve
# delim ;
keep if male == 0 & native == 1;
collapse (mean) emp havewage2 wagesal cwagesal annhrs cannhrs weeks 
	hrswkly ft dropout hs somecoll college advanced collplus educ exp age x1-x4 
    black hispanic asian euro hi_asian mid_asian mex rmsa0 rmsa1 q1-q5 q1c 
	q2c q3c q4c q5c imm female wage2 logwage2 
	(sum) count=c [fweight = wt];
gen year = 1980;
gen native = 1;
gen male = 0;
save data/1980/cell_native_female.dta, replace;
#delimit cr
restore 

preserve
# delim ;
keep if male == 1 & native == 0;
collapse (mean) emp havewage2 wagesal cwagesal annhrs cannhrs weeks 
	hrswkly ft dropout hs somecoll college advanced collplus educ exp age x1-x4 
    black hispanic asian euro hi_asian mid_asian mex rmsa0 rmsa1 q1-q5 q1c 
	q2c q3c q4c q5c imm female wage2 logwage2 
	(sum) count=c [fweight = wt];
gen year = 1980;
gen native = 0;
gen male = 1;
save data/1980/cell_imm_male.dta, replace;
#delimit cr
restore 

preserve
# delim ;
keep if male == 0 & native == 0;
collapse (mean) emp havewage2 wagesal cwagesal annhrs cannhrs weeks 
	hrswkly ft dropout hs somecoll college advanced collplus educ exp age x1-x4 
    black hispanic asian euro hi_asian mid_asian mex rmsa0 rmsa1 q1-q5 q1c 
	q2c q3c q4c q5c imm female wage2 logwage2 
	(sum) count=c [fweight = wt];
gen year = 1980;
gen native = 0;
gen male = 0;
save data/1980/cell_imm_female.dta, replace;
#delimit cr
restore 
