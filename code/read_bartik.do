clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/"

use year datanum serial hhwt statefip hhincome pernum perwt sex age birthyr race raced hispan hispand ///
	ancestr1 ancestr1d ancestr2 ancestr2d citizen speakeng yrsusa2 school educ educd ///
	gradeatt gradeattd empstat empstatd labforce occ classwkr classwkrd wkswork2 ///
	uhrswork inctot ftotinc incwage incbus00 incsupp incother incearn bpl ind3 ///
	cz_match cz_wt czone ///
	using data/bartik_compressed.dta

/* CITIZEN:
           0 n/a
           1 born abroad of american parents
           2 naturalized citizen
           3 not a citizen
           4 not a citizen, but has received first papers
           5 foreign born, citizenship status not reported
*/
gen imm = 0
replace imm = 1 if citizen == 2 | citizen == 3 | citizen == 4 | citizen == 5

/* Keep all observations of immigrants but randomly drop half of the observations
of no immigrants */
foreach y in 1980 1990 2000 2010{
	preserve
	keep if year == `y'
	gen OK = (imm == 0)
	set seed 9211093 	
	gen random = runiform()
	sort OK random
	by OK: gen group = ceil(2 * _n/_N) if OK
	drop if group == 1
	drop OK random group
	save temp`y'
	display("year `y' done")
	restore
}

use temp1980, clear
foreach y in 1990 2000 2010{
	append using temp`y'
	erase temp`y'.dta
}
save data/half_natives_bartik, replace
erase temp1980.dta

use data/half_natives_bartik, clear
merge m:1 year datanum serial pernum using data/ipums/usa_00002.dta
save data/ipums_merged_bartik, replace

use data/ipums_merged_bartik, clear
keep if _merge == 3 


/* EDUCATION */
/*Code book*/
/* EDUCD:
           0 n/a or no schooling
           1 n/a
           2 no schooling completed
          10 nursery school to grade 4
          11 nursery school, preschool
          12 kindergarten
          13 grade 1, 2, 3, or 4
          14 grade 1
          15 grade 2
          16 grade 3
          17 grade 4
          20 grade 5, 6, 7, or 8
          21 grade 5 or 6
          22 grade 5
          23 grade 6
          24 grade 7 or 8
          25 grade 7
          26 grade 8
          30 grade 9
          40 grade 10
          50 grade 11
          60 grade 12
          61 12th grade, no diploma
          62 high school graduate or ged
          63 regular high school diploma
          64 ged or alternative credential
          65 some college, but less than 1 year
          70 1 year of college
          71 1 or more years of college credit, no degree
          80 2 years of college
          81 associate's degree, type not specified
          82 associate's degree, occupational program
          83 associate's degree, academic program
          90 3 years of college
         100 4 years of college
         101 bachelor's degree
         110 5+ years of college
         111 6 years of college (6+ in 1960-1970)
         112 7 years of college
         113 8+ years of college
         114 master's degree
         115 professional degree beyond a bachelor's degree
         116 doctoral degree
         999 missing
*/
gen educ_yrs = . 
replace educ_yrs = 0 if inlist(educd, 0, 1, 2, 10, 11, 12, 999)
replace educ_yrs = 1 if educd == 14
replace educ_yrs = 2 if educd == 15
replace educ_yrs = 3 if educd == 16
replace educ_yrs = 4 if educd == 17
replace educ_yrs = 5 if educd == 22
replace educ_yrs = 6 if educd == 23
replace educ_yrs = 7 if educd == 25
replace educ_yrs = 8 if educd == 26
replace educ_yrs = 9 if educd == 30
replace educ_yrs = 10 if educd == 40
replace educ_yrs = 11 if inlist(educd, 50, 61)
replace educ_yrs = 12 if inlist(educd, 62, 63, 64)
replace educ_yrs = 13 if inlist(educd, 65, 70, 71)
replace educ_yrs = 14 if educd == 80
replace educ_yrs = 15 if inlist(educd, 90, 81, 82, 83) /*adding associate's degree to this category -- 3rd year of college -- is an arbitrary decision*/
replace educ_yrs = 16 if inlist(educd, 100, 101)
replace educ_yrs = 17 if educd == 110
replace educ_yrs = 18 if inlist(educd, 111, 114, 115) /* ading masters and professional degree is also arbitrary. assumes those programs last 2 years*/
replace educ_yrs = 19 if educd == 112
replace educ_yrs = 20 if educd == 113
replace educ_yrs = 21 if educd == 114
replace educ_yrs = 22 if educd == 116

preserve
keep if year == 1980
save data/1980/all80, replace
restore

preserve
keep if year == 1990
save data/1990/all90, replace
restore

preserve
keep if year == 2000
save data/2000/all2000, replace
restore


