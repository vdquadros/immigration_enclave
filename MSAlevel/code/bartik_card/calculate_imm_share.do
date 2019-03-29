clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"

use data/1980/supp80.dta 

keep if imm==1 

keep ic wt

local incoming_countries ic 

levelsof `incoming_countries', local(countries)

foreach country in `countries' {
	gen ic_`country' = (ic == `country')
	}

drop ic

collapse (mean) ic* [fweight = wt]



