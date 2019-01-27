clear
cd "/Users/victoriadequadros/projects/immigration_enclave/"

use year perwt czone ///
	using data/bartik_compressed.dta

keep if year == 2000
gen obs = 1
collapse (sum) obs [pw=perwt], by(czone) 

gsort -obs
gen rank_czone = _n
drop obs

save data/czone_rank.dta, replace
