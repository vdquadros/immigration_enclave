clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"

use data/1980/supp80.dta 

keep if imm == 1

gen rmsa0 = (rmsa==0)
gen rmsa1 = (rmsa==1)
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


gen ex11 = (eclass==1)*(xclass2==1)
gen ex12 = (eclass==1)*(xclass2==2)
gen ex13 = (eclass==1)*(xclass2==3)
gen ex14 = (eclass==1)*(xclass2==4)
gen ex21 = (eclass==2)*(xclass2==1)
gen ex22 = (eclass==2)*(xclass2==2)
gen ex23 = (eclass==2)*(xclass2==3)
gen ex24 = (eclass==2)*(xclass2==4)
gen ex31 = (eclass==3)*(xclass2==1)
gen ex32 = (eclass==3)*(xclass2==2)
gen ex33 = (eclass==3)*(xclass2==3)
gen ex34 = (eclass==3)*(xclass2==4)
gen ex41 = (eclass==4)*(xclass2==1)
gen ex42 = (eclass==4)*(xclass2==2)
gen ex43 = (eclass==4)*(xclass2==3)
gen ex44 = (eclass==4)*(xclass2==4)

forvalues i=1/38{
	gen ic`i' = 1 if ic == `i'
}

preserve
# delim ;
collapse (mean) dropout hs somecoll college advanced collplus educ exp age 
				x1-x4 ex11 ex12 ex13 ex14 ex21 ex22 ex23 ex24 ex31 ex32 ex33 ex34 
				ex41 ex42 ex43 ex44 rmsa0 rmsa1 female wage2 logwage2 annhrs 
		 (sum) count=c [fweight = wt], by(ic male);
save data/1980/byic.dta, replace;
#delimit cr
restore 

preserve 
# delim ; 
collapse (sum) ic1-ic38 [fweight = wt], by(rmsa);
save data/1980/citydist, replace;
#delim cr w
restore

clear
use data/1980/citydist 

forv i=1/38{
	egen total_ic`i' = sum(ic`i')
	gen shric`i' = ic`i' / total_ic`i'
}

keep rmsa shric1-shric38
drop total*

save data/1980/ic_city.dta, replace
