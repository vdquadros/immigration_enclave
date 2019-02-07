clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/"

use data/1990/np90.dta 

gen rczone0 = (czone==0)
gen rczone1 = (czone==1)

gen male = 1 - female 
gen native = 1 - male

gen xclass2 = 1 if exp <= 10
replace xclass2 = 2 if 10 <= exp & exp <= 20
replace xclass2 = 3 if 20 <= exp & exp <= 30
replace xclass2 = 4 if 30 < exp

replace c = 1

gen hs = 1 - dropout - somecoll - collplus

gen college = 0
replace college = 1 if collplus == 1 & advanced == 0

gen hwt = annhrs * wt

/* Note that supply4 is a variable for collplus, while supply5 is a variable 
for college. It would make more sense the other way around, but that's how Card
defined it, so I'm just following. */
/*
preserve
# delim ;
collapse (sum) supply=c supply1=dropout supply2=hs supply3=somecoll ///
			    supply4=collplus supply5=college supply6=advanced supplyimm=imm ///
				supplyfem=female [fweight = hwt], ///
				by(rczone native male eclass xclass2);
save data/1990/cellsupply.dta, replace;
#delimit cr
restore 
*/

preserve
# delim ;
collapse (sum) supply=c supply1=dropout supply2=hs supply3=somecoll ///
			    supply4=collplus supply5=college supply6=advanced supplyimm=imm ///
				supplyfem=female [fweight = hwt], ///
				by(rczone);
save data/1990/cellsupply_new1.dta, replace;
#delimit cr
restore 
/* Didnt do this in Stata. */
/* 
data t1;
set here.cellsupply;
if native=. and male=. and eclass=. and xclass2=.;

rsupply1=supply1/supply;
rsupply2=supply2/supply;
rsupply3=supply3/supply;
rsupply4=supply4/supply;
rsupply5=supply5/supply;
rsupply6=supply6/supply;

shs=.7*rsupply1+rsupply2+.5*rsupply3;
scoll1=.5*rsupply3+rsupply4;
scoll2=.5*rsupply3+rsupply5+1.2*rsupply6;
logrels1=log(scoll1/shs);
logrels2=log(scoll2/shs);
