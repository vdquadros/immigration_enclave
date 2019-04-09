clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"

/*
mat mCorr = (1, .6, .4\ .6, 1, .5 \ .4, .5, 1)
corr2data x y z, cstorage(full) corr(mCorr) n(100000) clear
corr
reg z x y
est store m1

estout m1, cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(r2 N) ///
   transform(@*100)
   
replace z = 100*z 
qui reg z x y
est store m2

estout m2, cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(r2 N) 
*/

use data/input_card.dta

local controls logsize80 logsize90 coll80 coll90 nres80 ires80 mfg80 mfg90

foreach var in `controls'{
	summ `var'
	replace `var' = `var'/r(sd)
	summ `var'
	disp("One done")
}

eststo m1: reg shric1 logsize80 coll80 nres80 ires80 mfg80  [fweight = round(count90)]
est store m1, title(Mexico)

eststo m2: reg shric2 logsize80 coll80 nres80 ires80 mfg80  [fweight = round(count90)]
est store m2, title(Philippines)

eststo m3: reg shric5 logsize80 coll80 nres80 ires80 mfg80  [fweight = round(count90)]
est store m3, title(El Salvador)

eststo m4: reg shric6 logsize80 coll80 nres80 ires80 mfg80  [fweight = round(count90)]
est store m4, title(China)

eststo m5: reg shric7 logsize80 coll80 nres80 ires80 mfg80  [fweight = round(count90)]
est store m5, title(Cuba)

eststo m6: reg shric31 logsize80 coll80 nres80 ires80 mfg80  [fweight = round(count90)]
est store m6, title(West Europe & others)

eststo m7: reg hsiv logsize80 coll80 coll90 nres80 ires80 mfg80  [fweight = round(count90)]
est store m7, title(Bartik - High School)

eststo m8: reg colliv logsize80 coll80 nres80 ires80 mfg80  [fweight = round(count90)]
est store m8, title(Bartik - College)

estout m1 m2 m3 m4 m5 m6 m7 m8 using card_table6.tex, replace cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(r2 N)  ///	
   transform(@*10^1 10^1) ///
   style(tex) 
 
