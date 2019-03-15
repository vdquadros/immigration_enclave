clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"

/* Combine data sets and do transforms. */

local targetdir "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/data/2000/"

* Append datasets.
use `targetdir'/y2000s1, clear
forvalues i = 2(1)56{
	* There are no file names ending in this digits. 
	if inlist(`i', 3, 7, 14, 43, 52){
		continue
	}	
	append using `targetdir'/y2000s`i'.dta	
}

gen wt=2
replace wt=1 if imm==1

gen hispanic=(dhisp > 1)
gen female=(sex==2)

* Define: ethnic 1=white; 2=any black/nonHisp; 3=any hispanic; 4=asian; 
gen ethnic=1
replace ethnic=2 if black==1
replace ethnic=3 if hispanic==1
replace ethnic=4 if race1==6 | race1==7

* Hours and wages.
gen annhrs = 0
gen wage1 = .
replace annhrs = weeks*hrswkly if weeks > 0 & !missing(weeks) & hrswkly > 0 & !missing(hrswkly)
replace wage1 = wagesal/annhrs if weeks > 0 & !missing(weeks) & hrswkly > 0 & !missing(hrswkly)

* Education.
gen dropout = (educ <= 8)
gen hsgrad = (educ - 9)
gen somecoll= (10<=educ & educ<=12)
gen collplus = (educ >= 13) & !missing(educ)
gen eclass = 1*dropout+2*hsgrad+3*somecoll+4*collplus

* Code top 125 cities.
gen top125=0
replace top125=1 if msa==80
replace top125=1 if msa==160
replace top125=1 if msa==200
replace top125=1 if msa==240
replace top125=1 if msa==440
replace top125=1 if msa==520
replace top125=1 if msa==600
replace top125=1 if msa==640
replace top125=1 if msa==680
replace top125=1 if msa==720
replace top125=1 if msa==760
replace top125=1 if msa==875
replace top125=1 if msa==1000
replace top125=1 if msa==1080
replace top125=1 if msa==1120
replace top125=1 if msa==1160
replace top125=1 if msa==1280
replace top125=1 if msa==1440
replace top125=1 if msa==1520
replace top125=1 if msa==1560
replace top125=1 if msa==1600
replace top125=1 if msa==1640
replace top125=1 if msa==1680
replace top125=1 if msa==1720
replace top125=1 if msa==1760
replace top125=1 if msa==1840
replace top125=1 if msa==1920
replace top125=1 if msa==2000
replace top125=1 if msa==2020
replace top125=1 if msa==2080
replace top125=1 if msa==2120
replace top125=1 if msa==2160
replace top125=1 if msa==2320
replace top125=1 if msa==2640
replace top125=1 if msa==2680
replace top125=1 if msa==2700
replace top125=1 if msa==2760
replace top125=1 if msa==2800
replace top125=1 if msa==2840
replace top125=1 if msa==2960
replace top125=1 if msa==3000
replace top125=1 if msa==3120
replace top125=1 if msa==3160
replace top125=1 if msa==3240
replace top125=1 if msa==3280
replace top125=1 if msa==3320
replace top125=1 if msa==3360
replace top125=1 if msa==3480
replace top125=1 if msa==3560
replace top125=1 if msa==3600
replace top125=1 if msa==3640
replace top125=1 if msa==3660
replace top125=1 if msa==3720
replace top125=1 if msa==3760
replace top125=1 if msa==3840
replace top125=1 if msa==3980
replace top125=1 if msa==4000
replace top125=1 if msa==4040
replace top125=1 if msa==4120
replace top125=1 if msa==4280
replace top125=1 if msa==4400
replace top125=1 if msa==4480
replace top125=1 if msa==4520
replace top125=1 if msa==4720
replace top125=1 if msa==4880
replace top125=1 if msa==4900
replace top125=1 if msa==4920
replace top125=1 if msa==5000
replace top125=1 if msa==5015
replace top125=1 if msa==5080
replace top125=1 if msa==5120
replace top125=1 if msa==5160
replace top125=1 if msa==5170
replace top125=1 if msa==5190
replace top125=1 if msa==5360
replace top125=1 if msa==5380
replace top125=1 if msa==5480
replace top125=1 if msa==5560
replace top125=1 if msa==5600
replace top125=1 if msa==5640
replace top125=1 if msa==5720
replace top125=1 if msa==5775
replace top125=1 if msa==5880
replace top125=1 if msa==5920
replace top125=1 if msa==5945
replace top125=1 if msa==5960
replace top125=1 if msa==6080
replace top125=1 if msa==6160
replace top125=1 if msa==6200
replace top125=1 if msa==6280
replace top125=1 if msa==6440
replace top125=1 if msa==6480
replace top125=1 if msa==6640
replace top125=1 if msa==6760
replace top125=1 if msa==6780
replace top125=1 if msa==6840
replace top125=1 if msa==6920
replace top125=1 if msa==7040
replace top125=1 if msa==7160
replace top125=1 if msa==7240
replace top125=1 if msa==7320
replace top125=1 if msa==7360
replace top125=1 if msa==7400
replace top125=1 if msa==7440
replace top125=1 if msa==7500
replace top125=1 if msa==7510
replace top125=1 if msa==7560
replace top125=1 if msa==7600
replace top125=1 if msa==7840
replace top125=1 if msa==8000
replace top125=1 if msa==8120
replace top125=1 if msa==8160
replace top125=1 if msa==8200
replace top125=1 if msa==8280
replace top125=1 if msa==8400
replace top125=1 if msa==8520
replace top125=1 if msa==8560
replace top125=1 if msa==8720
replace top125=1 if msa==8735
replace top125=1 if msa==8840
replace top125=1 if msa==8960
replace top125=1 if msa==9040
replace top125=1 if msa==9160
replace top125=1 if msa==9240
replace top125=1 if msa==9320

gen c=1
save `targetdir'/all2000.dta, replace

* Delete the state datasets. 
forvalues i = 1(1)56{
	* There are no file names ending in this digits. 
	if inlist(`i', 3, 7, 14, 43, 52){
		continue
	}	
	erase `targetdir'/y2000s`i'.dta
}
