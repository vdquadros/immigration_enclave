clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"

use data/1980/np80.dta 

keep rmsa ind imm wt female

/* Dummy for whether obs is in manufacturing. */
gen mfg = (100 <= ind & ind <=392)

tab mfg imm [fweight = wt]
tab mfg female [fweight = wt]

sort rmsa
collapse (mean) mfg [fweight = wt], by(rmsa)
save data/1980/mfg.dta, replace 
