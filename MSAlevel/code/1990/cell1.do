clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"

clear
use data/1990/np90.dta

gen ft = (annhrs > 1600 * !missing(annhrs))
gen lowhrs = (annhrs<1000)

gen college = 0
replace college = 1 if collplus==1 & advanced==0 

gen homey = 0
*code based on quantiles of bpl for people born in their current SOB;
replace homey=1 if rmsa==80 & inlist(bpl,39 ,39 ,39 ,39 ,39) & imm==0
replace homey=1 if rmsa==160 & inlist(bpl,36 ,36 ,36 ,36 ,36) & imm==0
replace homey=1 if rmsa==200 & inlist(bpl,35 ,35 ,35 ,35 ,35) & imm==0
replace homey=1 if rmsa==240 & inlist(bpl,42 ,42 ,42 ,42 ,42) & imm==0
replace homey=1 if rmsa==440 & inlist(bpl,26 ,26 ,26 ,26 ,26) & imm==0
replace homey=1 if rmsa==520 & inlist(bpl,13 ,13 ,13 ,13 ,13) & imm==0
replace homey=1 if rmsa==600 & inlist(bpl,13 ,13 ,13 ,45 ,45) & imm==0
replace homey=1 if rmsa==640 & inlist(bpl,48 ,48 ,48 ,48 ,48) & imm==0
replace homey=1 if rmsa==680 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==720 & inlist(bpl,24 ,24 ,24 ,24 ,24) & imm==0
replace homey=1 if rmsa==760 & inlist(bpl,22 ,22 ,22 ,22 ,22) & imm==0
replace homey=1 if rmsa==875 & inlist(bpl,34 ,34 ,34 ,34 ,34) & imm==0
replace homey=1 if rmsa==1000 & inlist(bpl,1 ,1 ,1 ,1 ,1) & imm==0
replace homey=1 if rmsa==1080 & inlist(bpl,16 ,16 ,16 ,16 ,16) & imm==0
replace homey=1 if rmsa==1120 & inlist(bpl,25 ,25 ,25 ,25 ,25) & imm==0
replace homey=1 if rmsa==1160 & inlist(bpl,9 ,9 ,9 ,9 ,9) & imm==0
replace homey=1 if rmsa==1280 & inlist(bpl,36 ,36 ,36 ,36 ,36) & imm==0
replace homey=1 if rmsa==1440 & inlist(bpl,45 ,45 ,45 ,45 ,45) & imm==0
replace homey=1 if rmsa==1520 & inlist(bpl,37 ,37 ,37 ,37 ,45) & imm==0
replace homey=1 if rmsa==1560 & inlist(bpl,13 ,47 ,47 ,47 ,47) & imm==0
replace homey=1 if rmsa==1600 & inlist(bpl,17 ,17 ,17 ,17 ,17) & imm==0
replace homey=1 if rmsa==1640 & inlist(bpl,21 ,39 ,39 ,39 ,39) & imm==0
replace homey=1 if rmsa==1680 & inlist(bpl,39 ,39 ,39 ,39 ,39) & imm==0
replace homey=1 if rmsa==1720 & inlist(bpl,8 ,8 ,8 ,8 ,8) & imm==0
replace homey=1 if rmsa==1760 & inlist(bpl,45 ,45 ,45 ,45 ,45) & imm==0
replace homey=1 if rmsa==1840 & inlist(bpl,39 ,39 ,39 ,39 ,39) & imm==0
replace homey=1 if rmsa==1920 & inlist(bpl,48 ,48 ,48 ,48 ,48) & imm==0
replace homey=1 if rmsa==2000 & inlist(bpl,39 ,39 ,39 ,39 ,39) & imm==0
replace homey=1 if rmsa==2020 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==2080 & inlist(bpl,8 ,8 ,8 ,8 ,8) & imm==0
replace homey=1 if rmsa==2120 & inlist(bpl,19 ,19 ,19 ,19 ,19) & imm==0
replace homey=1 if rmsa==2160 & inlist(bpl,26 ,26 ,26 ,26 ,26) & imm==0
replace homey=1 if rmsa==2320 & inlist(bpl,48 ,48 ,48 ,48 ,48) & imm==0
replace homey=1 if rmsa==2640 & inlist(bpl,26 ,26 ,26 ,26 ,26) & imm==0
replace homey=1 if rmsa==2680 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==2700 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==2760 & inlist(bpl,18 ,18 ,18 ,18 ,18) & imm==0
replace homey=1 if rmsa==2800 & inlist(bpl,48 ,48 ,48 ,48 ,48) & imm==0
replace homey=1 if rmsa==2840 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==2960 & inlist(bpl,18 ,18 ,18 ,18 ,18) & imm==0
replace homey=1 if rmsa==3000 & inlist(bpl,26 ,26 ,26 ,26 ,26) & imm==0
replace homey=1 if rmsa==3120 & inlist(bpl,37 ,37 ,37 ,37 ,37) & imm==0
replace homey=1 if rmsa==3160 & inlist(bpl,45 ,45 ,45 ,45 ,45) & imm==0
replace homey=1 if rmsa==3240 & inlist(bpl,42 ,42 ,42 ,42 ,42) & imm==0
replace homey=1 if rmsa==3280 & inlist(bpl,9 ,9 ,9 ,9 ,9) & imm==0
replace homey=1 if rmsa==3320 & inlist(bpl,15 ,15 ,15 ,15 ,15) & imm==0
replace homey=1 if rmsa==3360 & inlist(bpl,48 ,48 ,48 ,48 ,48) & imm==0
replace homey=1 if rmsa==3480 & inlist(bpl,18 ,18 ,18 ,18 ,18) & imm==0
replace homey=1 if rmsa==3560 & inlist(bpl,28 ,28 ,28 ,28 ,28) & imm==0
replace homey=1 if rmsa==3600 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==3640 & inlist(bpl,34 ,34 ,34 ,34 ,34) & imm==0
replace homey=1 if rmsa==3660 & inlist(bpl,47 ,47 ,47 ,51 ,51) & imm==0
replace homey=1 if rmsa==3720 & inlist(bpl,26 ,26 ,26 ,26 ,26) & imm==0
replace homey=1 if rmsa==3760 & inlist(bpl,20 ,29 ,29 ,29 ,29) & imm==0
replace homey=1 if rmsa==3840 & inlist(bpl,47 ,47 ,47 ,47 ,47) & imm==0
replace homey=1 if rmsa==3980 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==4000 & inlist(bpl,42 ,42 ,42 ,42 ,42) & imm==0
replace homey=1 if rmsa==4040 & inlist(bpl,26 ,26 ,26 ,26 ,26) & imm==0
replace homey=1 if rmsa==4120 & inlist(bpl,4 ,32 ,32 ,32 ,32) & imm==0
replace homey=1 if rmsa==4280 & inlist(bpl,21 ,21 ,21 ,21 ,21) & imm==0
replace homey=1 if rmsa==4400 & inlist(bpl,5 ,5 ,5 ,5 ,5) & imm==0
replace homey=1 if rmsa==4480 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==4520 & inlist(bpl,18 ,21 ,21 ,21 ,21) & imm==0
replace homey=1 if rmsa==4720 & inlist(bpl,55 ,55 ,55 ,55 ,55) & imm==0
replace homey=1 if rmsa==4880 & inlist(bpl,48 ,48 ,48 ,48 ,48) & imm==0
replace homey=1 if rmsa==4900 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==4920 & inlist(bpl,28 ,47 ,47 ,47 ,47) & imm==0
replace homey=1 if rmsa==5000 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==5015 & inlist(bpl,34 ,34 ,34 ,34 ,34) & imm==0
replace homey=1 if rmsa==5080 & inlist(bpl,55 ,55 ,55 ,55 ,55) & imm==0
replace homey=1 if rmsa==5120 & inlist(bpl,27 ,27 ,27 ,27 ,27) & imm==0
replace homey=1 if rmsa==5160 & inlist(bpl,1 ,1 ,1 ,1 ,1) & imm==0
replace homey=1 if rmsa==5170 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==5190 & inlist(bpl,34 ,34 ,34 ,34 ,34) & imm==0
replace homey=1 if rmsa==5360 & inlist(bpl,47 ,47 ,47 ,47 ,47) & imm==0
replace homey=1 if rmsa==5380 & inlist(bpl,36 ,36 ,36 ,36 ,36) & imm==0
replace homey=1 if rmsa==5480 & inlist(bpl,9 ,9 ,9 ,9 ,9) & imm==0
replace homey=1 if rmsa==5560 & inlist(bpl,22 ,22 ,22 ,22 ,22) & imm==0
replace homey=1 if rmsa==5600 & inlist(bpl,36 ,36 ,36 ,36 ,36) & imm==0
replace homey=1 if rmsa==5640 & inlist(bpl,34 ,34 ,34 ,34 ,34) & imm==0
replace homey=1 if rmsa==5720 & inlist(bpl,51 ,51 ,51 ,51 ,51) & imm==0
replace homey=1 if rmsa==5775 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==5880 & inlist(bpl,40 ,40 ,40 ,40 ,40) & imm==0
replace homey=1 if rmsa==5920 & inlist(bpl,31 ,31 ,31 ,31 ,31) & imm==0
replace homey=1 if rmsa==5945 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==5960 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==6080 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==6160 & inlist(bpl,34 ,42 ,42 ,42 ,42) & imm==0
replace homey=1 if rmsa==6200 & inlist(bpl,4 ,4 ,4 ,4 ,4) & imm==0
replace homey=1 if rmsa==6280 & inlist(bpl,42 ,42 ,42 ,42 ,42) & imm==0
replace homey=1 if rmsa==6440 & inlist(bpl,41 ,41 ,41 ,41 ,53) & imm==0
replace homey=1 if rmsa==6480 & inlist(bpl,25 ,44 ,44 ,44 ,44) & imm==0
replace homey=1 if rmsa==6640 & inlist(bpl,37 ,37 ,37 ,37 ,37) & imm==0
replace homey=1 if rmsa==6760 & inlist(bpl,51 ,51 ,51 ,51 ,51) & imm==0
replace homey=1 if rmsa==6780 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==6840 & inlist(bpl,36 ,36 ,36 ,36 ,36) & imm==0
replace homey=1 if rmsa==6920 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==7040 & inlist(bpl,17 ,17 ,29 ,29 ,29) & imm==0
replace homey=1 if rmsa==7160 & inlist(bpl,49 ,49 ,49 ,49 ,49) & imm==0
replace homey=1 if rmsa==7240 & inlist(bpl,48 ,48 ,48 ,48 ,48) & imm==0
replace homey=1 if rmsa==7320 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==7360 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==7400 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==7500 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==7510 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==7560 & inlist(bpl,42 ,42 ,42 ,42 ,42) & imm==0
replace homey=1 if rmsa==7600 & inlist(bpl,53 ,53 ,53 ,53 ,53) & imm==0
replace homey=1 if rmsa==7840 & inlist(bpl,53 ,53 ,53 ,53 ,53) & imm==0
replace homey=1 if rmsa==8000 & inlist(bpl,25 ,25 ,25 ,25 ,25) & imm==0
replace homey=1 if rmsa==8120 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==8160 & inlist(bpl,36 ,36 ,36 ,36 ,36) & imm==0
replace homey=1 if rmsa==8200 & inlist(bpl,53 ,53 ,53 ,53 ,53) & imm==0
replace homey=1 if rmsa==8280 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==8400 & inlist(bpl,39 ,39 ,39 ,39 ,39) & imm==0
replace homey=1 if rmsa==8520 & inlist(bpl,4 ,4 ,4 ,4 ,4) & imm==0
replace homey=1 if rmsa==8560 & inlist(bpl,40 ,40 ,40 ,40 ,40) & imm==0
replace homey=1 if rmsa==8720 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==8735 & inlist(bpl,6 ,6 ,6 ,6 ,6) & imm==0
replace homey=1 if rmsa==8840 & inlist(bpl,11 ,24 ,24 ,51 ,54) & imm==0
replace homey=1 if rmsa==8960 & inlist(bpl,12 ,12 ,12 ,12 ,12) & imm==0
replace homey=1 if rmsa==9040 & inlist(bpl,20 ,20 ,20 ,20 ,20) & imm==0
replace homey=1 if rmsa==9160 & inlist(bpl,10 ,10 ,10 ,10 ,24) & imm==0
replace homey=1 if rmsa==9240 & inlist(bpl,25 ,25 ,25 ,25 ,25) & imm==0
replace homey=1 if rmsa==9320 & inlist(bpl,39 ,39 ,39 ,39 ,39) & imm==0

replace homey=nonmover if rmsa==0 | rmsa==1
gen rmsa0 = (rmsa==0)
gen rmsa1 = (rmsa==1)
gen homey_0 = (rmsa==0 & homey==1)
gen homey_1 = (rmsa==1 & homey==1)

preserve
keep if imm == 0 & female == 0
save data/1990/nm.dta, replace
summ imm female logwage2 educ exp rmsa0 rmsa1 homey nonmover [fweight = wt]
restore

preserve
keep if imm == 0 & female == 1
save data/1990/nf.dta, replace
summ imm female logwage2 educ exp rmsa0 rmsa1 homey nonmover [fweight = wt]
restore

preserve
keep if imm == 1 & female == 0
save data/1990/im.dta, replace
summ imm female logwage2 educ exp rmsa0 rmsa1 [fweight = wt]
restore

preserve
keep if imm == 1 & female == 1
save data/1990/if.dta, replace
summ imm female logwage2 educ exp rmsa0 rmsa1 [fweight = wt]
restore

***models DO NOT include msa effects but include dummies for rmsa=0,1 ;
preserve
use data/1990/nm.dta, clear
reg logwage2 exp exp2 exp3 educ eclass##xclass inschool advanced ft lowhrs hisp_ed hisp_coll black_ed black_coll asian_ed asian_coll homey##eclass rmsa0 rmsa1 [fweight=wt]
predict pred if e(sample)
predict res, residuals
save nm2.dta, replace
restore

preserve
use data/1990/nf.dta, clear
reg logwage2 exp exp2 exp3 educ eclass##xclass inschool advanced ft lowhrs hisp_ed hisp_coll black_ed black_coll asian_ed asian_coll homey##eclass rmsa0 rmsa1 [fweight=wt]
predict pred if e(sample)
predict res, residuals
save nf2.dta, replace
restore

preserve
use data/1990/im.dta, clear
reg logwage2 exp exp2 exp3 educ eclass##xclass inschool advanced ft lowhrs hisp_ed hisp_coll black_ed black_coll asian_ed asian_coll homey##eclass rmsa0 rmsa1 [fweight=wt]
predict pred if e(sample)
predict res, residuals
save im2.dta, replace
restore

preserve
use data/1990/if.dta, clear
reg logwage2 exp exp2 exp3 educ eclass##xclass inschool advanced ft lowhrs hisp_ed hisp_coll black_ed black_coll asian_ed asian_coll homey##eclass rmsa0  rmsa1 [fweight=wt]
predict pred if e(sample)
predict res, residuals
save if2.dta, replace
restore

local files nf2 im2 if2
use nm2.dta, clear
forv i=1/3{
	local f : word `i' of `files'
	append using `f'.dta
}

gen male=1-female
gen native=1-imm

gen lw2sq=logwage2^2
gen ressq=res^2
gen predsq=pred^2
gen respred=res*pred

gen xclass2 = 4
replace xclass2 = 1 if exp <= 10
replace xclass2 = 2 if 10 < exp & exp <= 20
replace xclass2 = 3 if 20 < exp & exp <= 30

gen hs=1-dropout-somecoll-collplus

replace college = 1 if collplus == 1 & advanced == 0

corr logwage2 pred res educ exp imm female 

summ dropout hs somecoll college collplus advanced [fweight = wt]

tab xclass2 eclass

/* This will be used in Table 6. */
preserve
collapse (sum) count = c (mean) logwage2 lw2sq res ressq pred predsq respred imm ///
		female educ exp c dropout hs somecoll collplus college advanced [fweight = wt], ///
		by(rmsa native male eclass xclass2) 
save data/1990/bigcells.dta, replace
restore


preserve
collapse (sum) count = c (mean) logwage2 lw2sq res ressq pred predsq respred imm ///
		female educ exp c dropout hs somecoll collplus college advanced [fweight = wt], ///
		by(rmsa native male eclass)
save data/1990/bigcells_new1.dta, replace
restore


preserve
collapse (sum) count = c (mean) logwage2 lw2sq res ressq pred predsq respred imm ///
		female educ exp c dropout hs somecoll collplus college advanced [fweight = wt], ///
		by(rmsa native male)
save data/1990/bigcells_new2.dta, replace
restore

/* Calculate overall veriance of log wages and also residual variance of log */
/* wage by immigration status and gender. This will be used in Table 3. */
preserve
keep if native == 1 & male == 1
collapse (sum) count = c (mean) logwage2 lw2sq res ressq pred predsq respred [fweight = wt]
gen v = lw2sq-logwage2^2
gen vres=ressq-res*res
gen year = 1990
gen native = 1
gen male = 1
save compvar_nm90.dta, replace
restore 

preserve
keep if native == 1 & male == 0
collapse (sum) count = c (mean) logwage2 lw2sq res ressq pred predsq respred [fweight = wt]
gen v = lw2sq-logwage2^2
gen vres=ressq-res*res
gen year = 1990
gen native = 1
gen male = 0
save compvar_nf90.dta, replace
restore 

preserve
keep if native == 0 & male == 1
collapse (sum) count = c (mean) logwage2 lw2sq res ressq pred predsq respred [fweight = wt]
gen v = lw2sq-logwage2^2
gen vres=ressq-res*res
gen year = 1990
gen native = 0
gen male = 1
save compvar_im90.dta, replace
restore 

preserve
keep if native == 0 & male == 0
collapse (sum) count = c (mean) logwage2 lw2sq res ressq pred predsq respred [fweight = wt]
gen v = lw2sq-logwage2^2
gen vres=ressq-res*res
gen year = 1990
gen native = 0
gen male = 0
save compvar_if90.dta, replace
restore 

clear
append using compvar_nm90.dta compvar_nf90.dta compvar_im90.dta compvar_if90.dta
keep year native male v vres 
order year native male v vres 
save data/1990/compvar_1990.dta, replace

erase nm2.dta 
erase nf2.dta
erase im2.dta 
erase if2.dta
erase compvar_nm90.dta 
erase compvar_nf90.dta 
erase compvar_im90.dta 
erase compvar_if90.dta

