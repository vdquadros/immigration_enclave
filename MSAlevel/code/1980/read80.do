clear
clear matrix
capture log close
set mem 2g
set more off

/* The source directory contains the zip file exactly as downloaded from ICPSR */
local sourcedir "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/raw_data/1980/"
local targetdir "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/data/1980/"

cd `sourcedir'/ICPSR_08101
 
forvalues i = 1(1)56{
	* There are no file names ending in this digits. 
	if inlist(`i', 3, 7, 14, 43, 52){
		continue
	}	
	* Read files.
	else if inrange(`i', 1, 9){
		local dirname "DS000`i'"
		local filename "08101-000`i'-Data.txt"
	}
	else{
		local dirname "DS00`i'"
		local filename "08101-00`i'-Data.txt" 
	}
	
	* Read household data.
	preserve
	infix str type 1 str statefip 4-5 str cgroup 6-8 str smsa 10-13 p 26-27 str gq 28 str hhtype 104 ///
		str gotkids 105 if type == "H" using `dirname'/`filename'
	
	* Destring variables.
	destring statefip cgroup smsa p gq hhtype gotkids, replace
	
	drop if p == 0
	gen hhid = _n
	expand p 
	sort hhid
	gen obs = _n
	
	sort obs
	
	save `dirname'/h`i'.dta, replace 
	restore 
	
	* Read person data.
	preserve
	infix str type 1 str famrel 2-3 str sex 7 str age 8-9 str race 12-13 str hispanic 14 str bpl 22-24 ///
		str citizen 25 str immyr 26 str lang1 27 str english 31 str enroll 39 str higrad 40-41 ///
		str fingrad 42 str state75 47-48 str esr 81 str hourslw 82-83 str ind 87-89 str occ 90-92 ///
		str weeks 95-96 str hrswkly 97-98 str wagesal 101-105 str selfinc 106-110 ///
		str farminc 111-115 str income 134-138 str al_bpl 150 str al_sal 187 if type == "P"  using `dirname'/`filename'

	* Destring variables. 
	destring famrel sex age race hispanic bpl citizen immyr lang1 english ///
			 enroll higrad fingrad state75 esr hourslw ind occ weeks hrswkly wagesal ///
			 selfinc farminc income al_bpl al_sal, replace 
	
	* Define and assign labels
	label define RACE 1 "white" 2 "black" 3 "american indian" 4 "asian" 5 "asian" ///
					  6 "asian" 7 "asian" 8 "asian" 9 "asian" 10 "asian" 11 "asian" ///
					  12 "spanish" 13 "other"
	label define HISPANIC 0 "not" 1 "mex" 2 "pr" 3 "cuban" 4 "other"
	label define CITIZEN 0 "us born" 1 "native" 2 "not citizen" 3 "born abroad us parents"
	label define AL_BPL 0 "bpl not alloc" 1 "alloc" 2 "alloc" 3 "hotdeck"
	label define AL_SAL 0 "wsearn not alloc" 1 "alloc" 2 "alloc" 3 "hotdeck"
	
	label values race RACE
	label values hispanic HISPANIC
	label values citizen CITIZEN
	label values al_bpl AL_BPL
	label values al_sal AL_SAL
	
	gen educ = higrad - 2
	replace educ = educ - 1 if fingrad != 2
	replace educ = 0 if educ < 0 
	
	gen imm = 0
	replace imm = 1 if inlist(citizen, 1, 2)
			
	gen obs = _n
	sort obs
	save `dirname'/p`i'.dta, replace 
	restore
	
	* Merge household and person data. 
	use `dirname'/h`i'.dta, clear 
	merge obs using `dirname'/p`i'.dta
	
	* Drop random of the native obs. Keep all of the imm obs. 
	gen OK = (imm == 0)
	set seed 9211093 	
	gen random = runiform()
	sort OK random
	by OK: gen group = ceil(2 * _n/_N) if OK
	drop if group == 1
	drop OK random group
	
	* Save merged data set.
	save `targetdir'/y80s`i'.dta, replace
	
	* Erase the person and household datasets.
	erase `dirname'/h`i'.dta
	erase `dirname'/p`i'.dta
	
	* Clear before next loop.
	clear
}

* Append datasets.
use `targetdir'/y80s1, clear
forvalues i = 2(1)56{
	* There are no file names ending in this digits. 
	if inlist(`i', 3, 7, 14, 43, 52){
		continue
	}	
	append using `targetdir'/y80s`i'.dta
}
save `targetdir'/all80.dta, replace


* Delete the state datasets. 
forvalues i = 1(1)56{
	* There are no file names ending in this digits. 
	if inlist(`i', 3, 7, 14, 43, 52){
		continue
	}	
	erase `targetdir'/y80s`i'.dta
}


