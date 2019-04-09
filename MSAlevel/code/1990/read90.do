clear
clear matrix
capture log close
set mem 2g
set more off

/* The source directory contains the zip file exactly as downloaded from ICPSR */
local sourcedir "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/raw_data/1990/"
local targetdir "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel/data/1990/"

cd `sourcedir'/ICPSR_09952
 
forvalues i = 1(1)56{
	* There are no file names ending in this digits. 
	if inlist(`i', 3, 7, 14, 43, 52){
		continue
	}	
	* Read files.
	else if inrange(`i', 1, 9){
		local dirname "DS000`i'"
		local filename "09952-000`i'-Data.txt"
	}
	else{
		local dirname "DS00`i'"
		local filename "09952-00`i'-Data.txt" 
	}
	
	* Read household data.
	preserve
	infix str type 1 str statefip 11-12 str puma 13-17 str msa 20-23 p 33-34 str gqinst 35 if type == "H" using `dirname'/`filename'
	
	* Destring variables.
	destring statefip puma msa p gqinst, replace
	
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
	infix str type 1 str famrel 9-10 str sex 11 str race 12-14 str age 15-16 str marstat 17 ///
		str pwgt 18-21 str dfamrel 35 str dhisp 38-40 str bpl 44-46 str citizen 47 str immyr 48-49 ///
		str enroll 50 grade 51-52 state85 60-61 str lang1 67 english 71 esr 91 hourslw 93-94 ///
        str ind 115-117 str occ 118-120 str weeks 123-124 str hrswkly 125-126 str totearn 127-132 ///
		str income 133-138 str wagesal 139-144 str selfinc 145-150 str farminc 151-156 str al_bpl 190 ///
		al_sal 224 if type == "P"  using `dirname'/`filename'

	* Destring variables. 
	destring famrel sex race age marstat pwgt dfamrel dhisp bpl citizen immyr ///
			 enroll grade state85 lang1 english esr hourslw ind occ weeks hrswkly ///
			 totearn income wagesal selfinc farminc al_bpl al_sal, replace 
			 
	gen hispanic = 1
	replace hispanic = 0 if dhisp == 0 | (6 <= dhisp & dhisp <= 199)

	gen imm = 0
	replace imm = 1 if inlist(citizen, 3, 4)
			
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
	save `targetdir'/y90s`i'.dta, replace
	
	* Erase the person and household datasets.
	erase `dirname'/h`i'.dta
	erase `dirname'/p`i'.dta
	
	* Clear before next loop.
	clear
}

* Append datasets.
use `targetdir'/y90s1, clear
forvalues i = 2(1)56{
	* There are no file names ending in this digits. 
	if inlist(`i', 3, 7, 14, 43, 52){
		continue
	}	
	append using `targetdir'y90s`i'.dta
}
save `targetdir'/all90.dta, replace


* Delete the state datasets. 
forvalues i = 1(1)56{
	* There are no file names ending in this digits. 
	if inlist(`i', 3, 7, 14, 43, 52){
		continue
	}	
	erase `targetdir'/y90s`i'.dta
}


