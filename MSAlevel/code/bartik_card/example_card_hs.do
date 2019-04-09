global data_path "../data"
adopath+"../code"
clear all
discard
set seed 12345
use $data_path/input_card, clear

set seed 12345

local controls logsize80 logsize90 coll80 coll90 ires80 nres80 mfg80 mfg90
local weight count90

local y resgap2
local x relshs
*local z shric*

local ind_stub shric*
local growth_stub hs_imm_ic*

local time_var year
local cluster_var rmsa

foreach ind_var of varlist `ind_stub'* {
	replace `ind_var' = `ind_var' * 100
	}

forvalues k = 1(1)38 {
	egen agg_sh_ind_`k' = rowtotal(shric`k')
	}

	
bartik_weight, z(`ind_stub'*) weightstub(`growth_stub'*) x(`x') y(`y') controls(`controls') weight_var(`weight')


mat beta = r(beta)
mat alpha = r(alpha)
mat G = r(G)
qui desc `ind_stub'*, varlist
local varlist = r(varlist)

clear
svmat beta
svmat alpha
svmat G


gen ind = ""
local t = 1
foreach var in `varlist' {
	if regexm("`var'", "`ind_stub'(.*)") {
		qui replace ind = regexs(1) if _n == `t'
		}
	local t = `t' + 1
	}

/* Checks */
gsort -alpha1
corr alpha1 G1 beta1
summ beta1, detail

/*
/* Merge with variance file */ 
sort ind

preserve
use $data_path/var_k, clear
sort ind 
save $data_path/var_k, replace
restore

merge ind using $data_path/var_k
drop _merge

corr alpha1 G1 beta1 var_shric

/*
Dict:

1 "mexico"
2 "phillipines"
3 "india"
4 "vietnam"
5 "el salvador"
6 "china"
7 "cuba"
8 "dominican republic"
9 "korea"
10 "jamaica"
11 "canada"
12 "colombia"
13 "guatemala"
14 "germany"
15 "haiti"
16 "poland"
17 "taiwan"
18 "england"
19 "italy"
20 "ecuador"
21 "japan"
22 "iran"
23 "honduras"
24 "peru"
25 "russia"
26 "nicaragua"
27 "guyana"
28 "pakistan"
29 "hong kong"
30 "trinidad-tobago"
31 "west europe+isreal+cyprus+auss+nz"
32 "east europe incl romania ukraine yugoslav"
33 "middle east turkey bulgaria and the stans"
34 "asia and oceania"
35 "south america"
36 "africa"
37 "caribbean + central am"
38 "other" 			
*/
