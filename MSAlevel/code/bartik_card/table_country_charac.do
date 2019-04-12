clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"
log using "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/code/bartik_card/table_country_charac_aweight", text replace


use data/input_card.dta

local controls logsize80 coll80 nres80 ires80 mfg80

/*
foreach var in `controls'{
	summ `var'
	replace `var' = `var'/r(sd)
	summ `var'
	disp("One done")
}
*/

eststo m1: reg shric1 `controls' [aweight = round(count90)]
est store m1, title(Mexico)

eststo m2: reg shric2 `controls' [aweight = round(count90)]
est store m2, title(Philippines)

eststo m3: reg shric5 `controls' [aweight = round(count90)]
est store m3, title(El Salvador)

eststo m4: reg shric6 `controls' [aweight = round(count90)]
est store m4, title(China)

eststo m5: reg shric7 `controls' [aweight = round(count90)]
est store m5, title(Cuba)

eststo m6: reg shric31 `controls' [aweight = round(count90)]
est store m6, title(West Europe & others)

eststo m7: reg hsiv `controls'  [aweight = round(count90)]
est store m7, title(Bartik - High School)

eststo m8: reg colliv `controls'  [aweight = round(count90)]
est store m8, title(Bartik - College)


estout m1 m2 m3 m4 m5 m6 using table_countries_reg.tex, replace cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(r2 N)  ///	
   transform(@*10^7 10^7) ///
   style(tex) 
 
estout m7 m8 using table_bartik_reg.tex, replace cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(r2 N)  ///	
   style(tex) 

   /* transform(@*10^1 10^1) ///

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
