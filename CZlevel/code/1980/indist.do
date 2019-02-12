clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/"

use data/1980/np80.dta 

keep rczone ind imm wt female

/* Dummy for whether obs is in manufacturing. */
gen mfg = (100 <= ind3 & ind3<=392)

tab mfg imm [fweight = wt]
tab mfg female [fweight = wt]

sort rczone
collapse (mean) mfg [fweight = wt], by(rczone)
save data/1980/mfg.dta, replace 
