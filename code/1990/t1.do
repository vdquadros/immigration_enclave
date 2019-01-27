clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/"

use data/1990/supp90.dta 
	
gen rczone0 = (rczone==0)
gen rczone1 = (rczone==1)
gen male = 1 - female
gen native = 1 - imm

gen lw2sq = logwage2^2

gen xclass2 = 1 if exp <= 10
replace xclass2 = 2 if 10 <= exp & exp <= 20
replace xclass2 = 3 if 20 <= exp & exp <= 30
replace xclass2 = 4 if xclass2 != 1 | xclass2 != 2 | xclass2 != 3

replace c = 1

gen havewage2 = 1 if logwage != .
gen cwagesal = incwage
replace cwagesal = . if incwage <= 0

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

preserve
# delim ;
collapse (mean) emp havewage2 incwage cwagesal annhrs cannhrs wkswork1 
	hrswkly ft dropout hs somecoll college advanced collplus educ_yrs exp age x1-x4 
    black hispanic asian euro hi_asian mid_asian mex rczone0 rczone1 q1-q5 q1c 
	q2c q3c q4c q5c imm female wage2 logwage2 
	(count) c [fweight = wt], by(rczone native male eclass xclass2);
save data/1980/allcells.dta, replace;
#delimit cr
restore 

/* DIDNT DO THIS FROM CARD*/
/*
data t1;
set here.allcells;
if rmsa=. and native=. and male=. and xclass2=.;
keep imm female educ age x1 x2 x3 x4 black hispanic 
     rmsa0 rmsa1 emp annhrs cannhrs ft  q1-q5 
     q1c q2c q3c q4c q5c wage2 logwage2;

proc transpose data=t1 out=here.t1t;

proc print data=here.t1t;

preserve
clear
use data/1980/allcells.dta
keep if rczone == . & native == . & male == . & xclass2 == . 
keep imm female educ age x1 x2 x3 x4 black hispanic ///
     rczone0 rczone1 emp annhrs cannhrs ft  q1-q5 ///
     q1c q2c q3c q4c q5c wage2 logwage2
	 


