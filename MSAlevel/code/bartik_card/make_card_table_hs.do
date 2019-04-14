global data_path "../../data/"
adopath+"../code"
clear all
discard
set seed 12345
use $data_path/input_card, clear

local controls logsize80 logsize90 coll80 coll90 ires80 nres80 mfg80 mfg90
local weight count90

local y resgap2
local x relshs
local z hsiv

local ind_stub shric*
local growth_stub hs_imm_ic*

local time_var year
local cluster_var rmsa

forvalues k = 1(1)38 {
	egen agg_sh_ind_`k' = rowtotal(shric`k')
	}

set matsize 4000
global controls `controls'
global y `y'
global x `x'
global z `z'
global ind_stub `ind_stub'
global growth_stub `growth_stub'
global weight `weight'
tsset, clear

capture program drop test_and_compare
program define test_and_compare, rclass
	btsls, z(`2') x($x) y($y) ktype("`1'") weight_var($weight)
	local b_1 = r(beta)
	return scalar b_1 = `b_1'
	btsls, z(`2') x($x) y($y) controls($controls) ktype("`1'") weight_var($weight)
	local b_2 = r(beta)
	return scalar b_2 = `b_2'
	return scalar diff = `b_1' - `b_2'
end


capture program drop test_and_compare_chao
program define test_and_compare_chao, rclass
	overid_chao, z(shric*) x($x) y($y) weight_var($weight)
	local b_1 = r(delta)
	return scalar b_1 = `b_1'
	overid_chao, z(shric*) x($x) y($y) controls($controls)  weight_var($weight)
	local b_2 = r(delta)
	return scalar b_2 = `b_2'
	return scalar diff = `b_1' - `b_2'
end

local n = 200

estimates clear
qui reg `y' `x' [aweight=`weight'], cluster(rmsa)
local b1_ols = string(_b[`x'], "%12.2f")
local se1_ols = "(" + string(_se[`x'], "%12.2f") + ")"
qui reg `y' `x' [aweight=`weight']
estimates store ols1

qui reg `y' `x' `controls'  [aweight=`weight'], cluster(rmsa)
local b2_ols = string(_b[`x'], "%12.2f")
local se2_ols = "(" +  string(_se[`x'], "%12.2f") + ")"
qui reg `y' `x' `controls'  [aweight=`weight']
estimates store ols2

suest ols1 ols2, cluster(rmsa)
test [ols1_mean]`x'=[ols2_mean]`x'
local p_ols = "[" + string(r(p), "%12.2f") + "]"

bootstrap b1_bartik = r(b_1) b2_bartik = r(b_2) diff_bartik = r(diff), cluster(rmsa) reps(`n'): test_and_compare tsls hsiv
mat b = e(b)
mat V = vecdiag(e(V))
local b1_bartik = string(b[1,1], "%12.2f")
local b2_bartik = string(b[1,2], "%12.2f")
local se1_bartik = "(" + string(sqrt(V[1,1]), "%12.2f") + ")"
local se2_bartik = "(" + string(sqrt(V[1,2]), "%12.2f") + ")"
mat pval = r(table)
local p_bartik = "[" + string(pval[4,3], "%12.2f") + "]"

bootstrap b1_2sls = r(b_1) b2_2sls = r(b_2) diff_2sls = r(diff), cluster(rmsa) reps(`n'): test_and_compare tsls shric*
mat b = e(b)
mat V = vecdiag(e(V))
local b1_2sls = string(b[1,1], "%12.2f")
local b2_2sls = string(b[1,2], "%12.2f")
local se1_2sls = "(" + string(sqrt(V[1,1]), "%12.2f") + ")"
local se2_2sls = "(" + string(sqrt(V[1,2]), "%12.2f") + ")"
mat pval = r(table)
local p_2sls = "[" + string(pval[4,3], "%12.2f") + "]"

ivregress 2sls  `y'  `controls' (`x'= shric*)  [aweight=`weight'], vce(robust)
estat overid, forceweights
local J_2sls = string(r(score), "%12.2f")
local Jp_2sls = "[" + string(r(p_score), "%12.2f") + "]"

bootstrap b1_mbtsls = r(b_1) b2_mbtsls = r(b_2) diff_mbtsls = r(diff), cluster(rmsa) reps(`n'): test_and_compare mbtsls shric*
mat b = e(b)
mat V = vecdiag(e(V))
local b1_mbtsls = string(b[1,1], "%12.2f")
local b2_mbtsls = string(b[1,2], "%12.2f")
local se1_mbtsls = "(" + string(sqrt(V[1,1]), "%12.2f") + ")"
local se2_mbtsls = "(" + string(sqrt(V[1,2]), "%12.2f") + ")"
mat pval = r(table)
local p_mbtsls = "[" + string(pval[4,3], "%12.2f") + "]"


qui ivregress liml `y'  (`x' = `ind_stub'*) [aw=`weight'], cluster(rmsa)
local b1_liml = string(_b[`x'], "%12.2f")
local se1_liml = "(" + string(_se[`x'], "%12.2f") + ")"
qui ivregress liml `y'  (`x' =  `ind_stub'*) `controls' [aw=`weight'], cluster(rmsa)
estat overid, forceweights forcenonrobust
local b2_liml = string(_b[`x'], "%12.2f")
local se2_liml = "(" + string(_se[`x'], "%12.2f") + ")"
local N = e(N)
disp(`N')
local K = wordcount(e(insts)) - wordcount(e(exogr))
disp(`K')
local L = wordcount(e(exogr))
disp(`L')
local kappa = e(kappa) - 1
disp(`kappa')
local J_liml  = (`N' - `K' - `L') * (`kappa' - 1)
disp(`J_liml')
local alpha_L =  `L' / `N'
local alpha_K =  `K' / `N'
local crit = normal(sqrt((1 - `alpha_L') / ( 1- `alpha_K' - `alpha_L'))*invnorm(0.95)) 
disp chi2(`J_liml', `K'-1)

preserve
expand 2, gen(control_ind)

ivregress liml `y'  (control_ind#c.`x' =  control_ind#c.(`ind_stub'*)) c.control_ind#c.(`controls') control_ind [aw=`weight'], cluster(rmsa)
test  0.control_ind#c.relshs =  1.control_ind#c.relshs
local p_liml = "[" + string(r(p), "%12.2f") + "]"
restore

bootstrap b1_hful = r(b_1) b2_hful = r(b_2) diff_hful = r(diff), cluster(rmsa) reps(`n'): test_and_compare_chao
mat b = e(b)
mat V = vecdiag(e(V))
local b1_hful = string(b[1,1], "%12.2f")
local b2_hful = string(b[1,2], "%12.2f")
local se1_hful = "(" + string(sqrt(V[1,1]), "%12.2f") + ")"
local se2_hful = "(" + string(sqrt(V[1,2]), "%12.2f") + ")"
mat pval = r(table)
local p_hful = "[" + string(pval[4,3], "%12.2f") + "]"

overid_chao, z(`ind_stub'*) x($x) y($y) controls($controls ) weight_var($weight)
local J_hful = string(r(T), "%12.2f")
local Jp_hful = "[" + string(r(p), "%12.2f") + "]"
capture file close fh
capture erase "card_results_hs.tex"
file open fh using "card_results_hs.tex", write replace

file write fh "OLS & `b1_ols' & `b2_ols' & `p_ols' & \\" _n
file write fh "    & `se1_ols'& `se2_ols'&         & \\" _n
file write fh "2SLS (Bartik) & `b1_bartik' & `b2_bartik' & `p_bartik' & \\" _n
file write fh "    & `se1_bartik' & `se2_bartik' &         & \\" _n
file write fh "2SLS & `b1_2sls' & `b2_2sls' & `p_2sls' & \\" _n
file write fh "    & `se1_2sls'& `se2_2sls'&         & \\" _n
file write fh "MBTSLS & `b1_mbtsls' & `b2_mbtsls' & `p_mbtsls' & \\" _n
file write fh "    & `se1_mbtsls'& `se2_mbtsls'&         & \\" _n
file write fh "LIML & `b1_liml' & `b2_liml' & `p_liml' & \\" _n
file write fh "    & `se1_liml'& `se2_liml'&         & \\" _n
file write fh "HFUL & `b1_hful' & `b2_hful' & `p_hful' & `J_hful' \\" _n
file write fh "    & `se1_hful'& `se2_hful'&         &  `Jp_hful' \\" _n

file close fh


	
