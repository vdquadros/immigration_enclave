clear
clear matrix
capture log close
set mem 2g
set more off

/* The source directory contains the zip file exactly as downloaded from ICPSR */
local sourcedir "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/raw_data/2000/"
local targetdir "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/data/2000/"
local codedir "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/code/2000/"

cd `sourcedir'/ICPSR_13568
 
forvalues i = 1(1)56{
	* There are no file names ending in this digits. 
	if inlist(`i', 3, 7, 14, 43, 52){
		continue
	}	
	* Read files.
	else if inrange(`i', 1, 9){
		local dirname "DS000`i'"
		local filename "13568-000`i'-Data.txt"
	}
	else{
		local dirname "DS00`i'"
		local filename "13568-00`i'-Data.txt" 
	}
	
	* Read household data.
	preserve
	infix str type 1 str hhid 2-8 str statefip 10-11 str puma 14-18 str msa 28-31 ///
		  str pumatype 40-41 str p 106-107 str gq 108 if type == "H" using `dirname'/`filename'
	
	* Destring variables.
	destring hhid statefip puma msa pumatype p gq, replace
	
	* Recode MSAs based on puma and state.
	cd `codedir'
	do msarecode2000
	
	
	cd `sourcedir'/ICPSR_13568
	drop if p == 0
	gen id = _n
	expand p 
	sort hhid
	gen obs = _n
	sort obs
	save `dirname'/h`i'.dta, replace 
	restore 
	
	* Read person data.
	preserve
	infix str type 1 str pweight 13-16 str famrel 17-18 str ownchild 20 str paoc 22 ///
		  str sex 23 str age 25-26 str age_alloc 27 str dhisp 28-29 str numrace 31 ///
		  str white 32 str black 33 str race1 38 str marstat 44 str enroll 49 ///
		  str grade 51 str educ 53-54 str educ_alloc 55 str english 70 str bpl 72-74 ///
		  str citizen 76 str immyr 78-81 str mob5 83 str esr 154 str ind 211-213 ///
		  str occ 223-225 str class 234 str workly 236 str weeks 238-239 str hrswkly 241-242 ///
		  str hrswk_alloc 243 str wagesal 244-249 str ws_alloc 250 str selfinc 251-256 ///
          str self_alloc 297-303 str totearn 305-311 if type == "P"  using `dirname'/`filename'

	* Destring variables. 
	destring pweight famrel ownchild paoc sex age age_alloc dhisp numrace white ///
			 black race1 marstat enroll grade educ educ_alloc english bpl citizen ///
			 immyr mob5 esr ind occ class workly weeks hrswkly hrswk_alloc wagesal ///
			 ws_alloc selfinc self_alloc totearn, replace 
	
	gen imm = 0
	replace imm = 1 if citizen >= 4 & !missing(citizen)
			
	gen obs = _n
	sort obs
	save `dirname'/p`i'.dta, replace 
	restore
	
	* Merge household and person data. 
	use `dirname'/h`i'.dta, clear 
	merge obs using `dirname'/p`i'.dta
	assert _merge == 3
	
	* Drop random of the native obs. Keep all of the imm obs. 
	gen OK = (imm == 0)
	set seed 9211093 	
	gen random = runiform()
	sort OK random
	by OK: gen group = ceil(2 * _n/_N) if OK
	drop if group == 1
	drop OK random group
	
	* Save merged data set.
	save `targetdir'/y2000s`i'.dta, replace
	
	* Erase the person and household datasets.
	erase `dirname'/h`i'.dta
	erase `dirname'/p`i'.dta
	
	* Clear before next loop.
	clear
}

