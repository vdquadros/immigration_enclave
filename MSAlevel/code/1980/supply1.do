clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"

use data/1980/np80.dta 

gen rmsa0 = (rmsa==0)
gen rmsa1 = (rmsa==1)

gen male = 1 - female 
gen native = 1 - imm

gen xclass2 = 4
replace xclass2 = 1 if exp <= 10
replace xclass2 = 2 if 10 < exp & exp <= 20
replace xclass2 = 3 if 20 < exp & exp <= 30

replace c = 1

gen hs = 1 - dropout - somecoll - collplus

gen college = 0
replace college = 1 if collplus == 1 & advanced == 0

gen hwt = annhrs * wt

/* Note that supply4 is a variable for collplus, while supply5 is a variable 
for college. It would make more sense the other way around, but that's how Card
defined it, so I'm just following. */

preserve
# delim ;
collapse (sum) supply=c supply1=dropout supply2=hs supply3=somecoll ///
			    supply4=collplus supply5=college supply6=advanced supplyimm=imm ///
				supplyfem=female [fweight = hwt], ///
				by(rmsa native male eclass xclass2);
save data/1980/cellsupply.dta, replace;
#delimit cr
restore 


preserve
# delim ;
collapse (sum) supply=c supply1=dropout supply2=hs supply3=somecoll ///
			    supply4=collplus supply5=college supply6=advanced supplyimm=imm ///
				supplyfem=female [fweight = hwt], ///
				by(rmsa);
save data/1980/cellsupply_new1.dta, replace;
#delimit cr
restore 
