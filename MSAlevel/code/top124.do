clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/"

clear
use data/raw_acs.dta

keep state metaread puma perwt

rename metaread msa 

drop if msa == 0

gen wt = perwt
replace wt = round(wt/2)

gen c = 1

/*****/
preserve
do code/msarecode_acs.do 

collapse (sum) count=c [fweight = wt], by(msa)

gsort -count 

gen top124_recoded = msa if _n <= 125

drop count
drop msa
drop if missing(top124_recoded) 

gen d = 1
sort d top124_recoded
save data/top124_recoded.dta, replace
restore
/*****/



/*****/
preserve
collapse (sum) count=c [fweight = wt], by(msa)

gsort -count 

gen top124_notrecoded = msa if _n <= 125

drop msa 
drop count
drop if missing(top124_notrecoded)

gen d = 1
sort d top124_notrecoded
save data/top124_notrecoded.dta, replace
restore
/*****/


/*****/
use data/top124_recoded, clear

merge d using data/top124_notrecoded.dta

drop _merge 
sort d top124_recoded top124_notrecoded
save data/top124.dta, replace
/*****/


import delimited data/card_top124, clear
rename ïcardtop124 card_top124

gen d = 1
sort d card_top124

merge d using data/top124.dta
drop d
drop _merge
sort card_top124


