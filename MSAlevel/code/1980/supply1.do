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


/* Data checks that Card does. The results match Card's */
use data/1980/cellsupply_new1.dta, clear

gen rsupply1=supply1/supply
gen rsupply2=supply2/supply
gen rsupply3=supply3/supply
gen rsupply4=supply4/supply
gen rsupply5=supply5/supply
gen rsupply6=supply6/supply

gen shs=.7*rsupply1+rsupply2+.5*rsupply3
gen scoll1=.5*rsupply3+rsupply4
gen scoll2=.5*rsupply3+rsupply5+1.2*rsupply6
gen logrels1=log(scoll1/shs)
gen logrels2=log(scoll2/shs)

summ rsupply1-rsupply6 shs scoll1 scoll2 logrels1 logrels2 if rmsa >=3

corr rsupply1-rsupply6 shs scoll1 scoll2 logrels1 logrels2 if rmsa >=3

gsort -supply

keep rmsa supply rsupply1-rsupply6
