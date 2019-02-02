clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/"

clear
use data/2000/all2000.dta

/* Card has two variables for education: Grade and educ. I am not including both 
cause I think we don't have both and we won't use it for Table 6. But keep an eye out. 
*/

/* Sample restrictions. There's a further cut below for experience 1-45. */
keep if age >= 18 
keep if incwage > 0

/* Weight */ 
gen pweight = perwt * 2 if imm == 0
replace pweight = perwt if imm == 1

keep if pweight > 0

/* Czone rank */
drop _merge
sort czone
merge m:1 czone using data/czone_rank.dta

gen top125 = 0
replace top125 =  1 if rank_czone <= 125

/* EDUCATION */
gen eclass = .
replace eclass = 1 if educ_yrs < 12 
replace eclass = 2 if educ_yrs == 12
replace eclass = 3 if 12 < educ_yrs & educ_yrs < 16
replace eclass = 4 if eclass != 1 & eclass != 2 & eclass != 3

gen dropout = (eclass == 1)
gen hsgrad = (eclass == 2)
gen somecoll = (eclass == 3)
gen collplus = (eclass == 4)
gen advanced = educ_yrs > 16

/*
SCHOOL:
           0 n/a
           1 no, not in school
           2 yes, in school
           9 missing
*/
gen inschool = 1 if school == 2

/* EXPERIENCE */
gen exp = . 
replace exp = age-16 if eclass == 1
replace exp = age-19 if eclass == 2
replace exp = age-21 if eclass == 3
replace exp = age-23 if (eclass != 1) & (eclass != 2) & (eclass != 3) 

gen exp2 = exp*exp/100
gen exp3 = exp*exp*exp/1000

keep if (1<=exp & exp<=45)   /*sample cut for exp*/

/* More experience variable */
gen xclass = . 
replace xclass = 1 if exp <= 5
replace xclass = 2 if 5 < exp & exp <= 10 
replace xclass = 3 if 10 < exp & exp <= 15
replace xclass = 4 if 15 < exp & exp <= 20
replace xclass = 5 if 20 < exp & exp <= 25
replace xclass = 6 if 25 < exp & exp <= 30
replace xclass = 7 if 30 < exp & exp <= 35
replace xclass = 8 if 35 < exp & exp <= 40
replace xclass = 9 if 40 < exp & exp <= 45


/* WKSWORK1:
	values go from 0-52 weeks.
*/
gen annhrs = wkswork1 * uhrswork

gen wage = . 
replace wage = incwage/annhrs if (annhrs > 0 & incwage > 0)

gen ft = (annhrs > 1400) /*full time*/
replace ft = . if annhrs == 0

gen chours = annhrs 
replace chours = . if annhrs == 0

gen owage = wage
replace wage=3.8625 if (0 < wage & wage < 3.8625)
replace wage=257.5 if 257.5 < wage
gen logwage = log(wage)

/* Self employed income */
gen selfinc = inctot if classwkr == 1
gen selfemp = 0
replace selfemp = 1 if (abs(selfinc) > 0 & selfinc != .)

gen wage2 = wage
replace wage2 = . if selfemp==1 
gen logwage2 = log(wage2)

/* Keep obs that are not self employed */
keep if logwage2 != . 


/*
SEX:
           1 male
           2 female
*/
gen workly = (annhrs > 0)
gen female = (sex == 2)

/* Create variables */
gen ic = . /* immigration country */
gen yrsinus = . /* years in the us */
gen recimm = . /* recent immigrant */
gen pre_exp = . /* prior experience at arrival to the us */
gen pre_exp1 = . /* experience w/ schooling in the us */
gen pre_exp2 = . 
gen yrsinus2 = . /* years in the us squared */
gen euro = . /* european imm */
gen hi_asian = . /* hi_asian imm */ 
gen mid_asian = .  /* mid_asian imm */ 
gen mex = . /* mexican imm */
gen euro_ed = . /* european imm educ years */
gen hi_asian_ed = . /* hi_asian imm educ years */ 
gen mid_asian_ed = . /* mid_asian imm educ years */
gen mex_ed = . /* mex imm educ years */ 
gen euro_coll = .  /* european imm w/ college educ */
gen hi_asian_coll = . /* hi_asian imm w/ college educ */
gen mid_asian_coll = . /* mid_asian imm w/ college educ */
gen mex_coll = . /* mexican imm w/ college educ */
gen euro_yrs = . /* euro imm yrs in the us */ 
gen hi_asian_yrs = . /* hi_asian imm yrs in the us */ 
gen mid_asian_yrs = . /* mid_asian imm yrs in the us */ 
gen mex_yrs = . /* mexican imm yrs in the us */ 
gen euro_yrs2 = . /* euro imm yrs in us squared */
gen hi_asian_yrs2 = .  /* hi_asian imm yrs in us squared */
gen mid_asian_yrs2 = . /* mid_asian imm yrs in us squared */
gen mex_yrs2 = . /* mex imm yrs in us squared */

/* STATEMENTS FOR IMMIGRATS */
/*note: bpl stands for birth place*/
replace ic = 38 if imm == 1 /* Base case */
replace ic=1 if bpld == 20000  & imm == 1 /*mexico*/
replace ic=2 if bpld == 51500 & imm == 1 /*phillip*/
replace ic=3 if bpld == 52100 & imm == 1/*india*/
replace ic=4 if bpld == 51800 & imm == 1/*vietnam*/
replace ic=5 if bpld == 21030 & imm == 1  /*el salvador*/
replace ic=6 if bpld == 50000 & imm == 1  /*china*/
replace ic=7 if bpld == 25000 & imm == 1  /*cuba*/
replace ic=8 if bpld == 26010 & imm == 1  /*dr*/
replace ic=9 if bpld == 50200 & imm == 1  /*korea*/
replace ic=10 if bpld == 26030 & imm == 1   /*jamaica*/ 
replace ic=11 if bpld == 15000 & imm == 1 /*canada*/
replace ic=12 if bpld == 30025 & imm == 1  /*columbia*/ 
replace ic=13 if bpld == 21040 & imm == 1  /*guatemala*/
replace ic=14 if bpld == 45300 & imm == 1  /*germany*/
replace ic=15 if bpld == 26020 & imm == 1  /*haiti*/ 
replace ic=16 if bpld == 45500 & imm == 1  /*poland */
replace ic=17 if bpld == 50040 & imm == 1  /*taiwan*/ 
replace ic=18 if bpld == 41000 & imm == 1  /*england*/
replace ic=19 if bpld == 43400 & imm == 1  /*italy*/
replace ic=20 if bpld == 30030 & imm == 1  /*ecuador*/
replace ic=21 if bpld == 50100 & imm == 1  /*japan*/
replace ic=22 if bpld == 52200 & imm == 1  /*iran*/
replace ic=23 if bpld == 21050 & imm == 1  /*honduras*/
replace ic=24 if bpld == 30050 & imm == 1  /*peru*/
replace ic=25 if bpld == 46500& imm == 1  /*russia*/
replace ic=26 if bpld == 21060 & imm == 1   /*nicaragua*/ 
replace ic=27 if bpld == 30040 & imm == 1  /*guyana*/
replace ic=28 if bpld == 52140 & imm == 1  /*pakistan*/
replace ic=29 if bpld == 50010 & imm == 1  /*hong kong*/ 
replace ic=30 if bpld == 26060 & imm == 1  /*trinidad-tobago*/ 
replace ic = 31 if (bpld == 42900 | bpld ==  53440 | bpld == 53100 | bpld == 70000 | bpld == 70010) & imm == 1/*west europe+isreal+cyprus+auss+nz*/
replace ic = 32 if (bpld == 45900 | bpld == 45600 | bpld == 46530 | bpld == 45700) & imm == 1  /*east europe incl romania ukraine yugoslav*/
replace ic = 33 if (bpld == 54700 | bpld == 54200 | bpld == 45100  | bpld == 52000 ) & imm == 1 /*middle east turkey bulgaria and afghanistan*/
replace ic = 34 if (bpld == 50900 | bpld == 51900 | bpld == 54800 | bpld ==  54900 | bpld == 55000 | bpld == 59900) & imm == 1 /*asia*/
replace ic = 35 if (bpld == 26092 | bpld == 30000 | bpld == 30090 | bpld == 19900 ) & imm == 1/*s america + north am nec */
replace ic = 36 if bpld ==  60000 & imm == 1 /*africa*/
replace ic = 37 if (bpld == 21000 | bpld == 21090) & imm == 1 /* central am*/

/* YRSUSA2:
		   0 n/a
		   1 0-5 years
		   2 6-10 years
		   3 11-15 years
		   4 16-20 years
		   5 21+ years
		   9 missing */
/*  Approx years in the US */
replace yrsinus = 2.5 if yrsusa2 == 1 & imm == 1
replace yrsinus = 7.5 if yrsusa2 == 2 & imm == 1
replace yrsinus = 12.5 if yrsusa2 == 3 & imm == 1
replace yrsinus = 17.5 if yrsusa2 == 4 & imm == 1
replace yrsinus = 30 if yrsusa2 == 5 & imm == 1

replace recimm = 1 if (yrsusa2 == 1 | yrsusa2 == 2) & imm == 1 /* recent immigrant */

/* Rough proxy for experience at arrival = pre-US exp */
replace pre_exp = exp - yrsinus if imm == 1

/* Likely to have done some schooling in the U.S. */
replace pre_exp1 = 1 if (pre_exp < -4 & imm == 1)  
replace pre_exp2 = 1 if (-4 <= pre_exp & pre_exp <0) & imm == 1

replace yrsinus2 = yrsinus*yrsinus if imm == 1

/* Construct dummies for broad groups */
replace euro = 1 if inlist(ic, 11, 14, 16, 18, 19, 25, 31, 32) & imm == 1 /*european bpl*/
replace hi_asian = 1 if inlist(ic, 3, 9, 17, 21, 22, 28, 29) & imm == 1/*india korea taiwan japan iran pakistan hongkong*/
replace mid_asian = 1 if inlist(ic, 2, 4, 6) & imm == 1/*philippines, vietnam , china */
replace mex = 1 if ic == 1 & imm == 1 /*mexico*/

replace euro_ed = euro*educ_yrs if imm == 1
replace hi_asian_ed = hi_asian*educ_yrs if imm == 1
replace mid_asian_ed = mid_asian*educ_yrs if imm == 1
replace mex_ed = mex*educ_yrs if imm == 1

replace euro_coll = euro*collplus if imm == 1
replace hi_asian_coll = hi_asian*collplus if imm == 1
replace mid_asian_coll = mid_asian*collplus if imm == 1
replace mex_coll=mex*collplus if imm == 1

replace euro_yrs = euro*yrsinus if imm == 1
replace hi_asian_yrs = hi_asian*yrsinus if imm == 1
replace mid_asian_yrs=mid_asian*yrsinus if imm == 1
replace mex_yrs = mex*yrsinus if imm == 1

replace euro_yrs2 = euro*yrsinus2 if imm == 1
replace hi_asian_yrs2 = hi_asian*yrsinus2 if imm == 1
replace mid_asian_yrs2=mid_asian*yrsinus2 if imm == 1
replace mex_yrs2 = mex*yrsinus2 if imm == 1
	
/* STATEMENTS FOR NON-IMMIGRANTS */
replace ic=-1 if imm == 0
replace pre_exp=0 if imm == 0
replace pre_exp1=0 if imm == 0
replace pre_exp2=0 if imm == 0
replace yrsinus=0 if imm == 0
replace yrsinus2=0 if imm == 0
replace euro=0 if imm == 0
replace hi_asian=0 if imm == 0
replace mid_asian=0 if imm == 0
replace mex=0 if imm == 0
replace euro_ed=0 if imm == 0
replace hi_asian_ed=0 if imm == 0
replace mid_asian_ed=0 if imm == 0
replace mex_ed=0 if imm == 0
replace euro_coll=0 if imm == 0
replace hi_asian_coll=0 if imm == 0
replace mid_asian_coll=0 if imm == 0
replace mex_coll=0 if imm == 0
replace euro_yrs=0 if imm == 0
replace hi_asian_yrs=0 if imm == 0
replace mid_asian_yrs=0 if imm == 0
replace mex_yrs=0 if imm == 0
replace euro_yrs2=0 if imm == 0
replace hi_asian_yrs2=0 if imm == 0
replace mid_asian_yrs2=0 if imm == 0
replace mex_yrs2=0 if imm == 0


/* BACK TO STATEMENTS FOR EVERYBODY */
gen imm_ed = imm * educ_yrs 
gen imm_coll = imm * collplus

/* Assign ethnicity/race. */
/* 
RACE:
           1 white
           2 black/negro
           3 american indian or alaska native
           4 chinese
           5 japanese
           6 other asian or pacific islander
           7 other race, nec
           8 two major races
           9 three or more major races
HISPAN:
           0 not hispanic
           1 mexican
           2 puerto rican
           3 cuban
           4 other
           9 not reported

*/

gen hispanic = 0
replace hispanic = 1 if inlist(hispan, 1, 2, 3, 4)
gen asian = 0
replace asian = 1 if (inlist(race, 4, 5, 6) & hispanic == 0)
gen black = 0
replace black = 1 if race == 2 & hispan == 0

gen black_ed = black*educ_yrs
gen black_coll = black*collplus

gen asian_ed = asian*educ_yrs
gen asian_coll = asian*collplus

gen hisp_ed = hispanic*educ_yrs
gen hisp_coll = hispanic*collplus

/* Code from op.code fit by gender */ 
gen xb1 = . 
gen xb = . 
gen p1 = . 
gen p2 = . 
gen p3 = . 
gen p4 = . 
gen p5 = . 
gen p6 = . 
gen p7 = . 
gen p8 = . 
gen p9 = .
gen p10 = .
gen c0 = . 
gen c1 = . 
gen c2 = . 
gen c3 = .
gen c4 = .
gen c5 = .
gen c6 = .
gen c7 = .
gen c8 = . 
gen c9 = . 

/* Statements for males */
replace c0 = 0.0872 if female == 0
replace c1 = 0 if female == 0
replace c2 = 0.4019 if female == 0
replace c3 = 0.6955 if female == 0
replace c4 = 0.9980 if female == 0
replace c5 = 1.2802 if female == 0
replace c6 = 1.5695 if female == 0
replace c7 = 1.9450 if female == 0
replace c8 = 2.3764 if female == 0
replace c9 = 2.9685 if female == 0

replace xb1 = imm      *   -0.0277  + ///
		educ_yrs       *   -0.0620  + ///
		exp            *   -0.1255  + ///
		exp2           *    0.3353  + ///
		exp3           *   -0.0282  + ///
		inschool       *    0.1624  + ///
		dropout        *    0.2560  + ///
		somecoll       *   -0.1165  + ///
		collplus       *   -0.4050  + ///
		advanced       *    0.0382  + ///
		asian          *    0.3268  + ///
		black          *    0.3026  + ///
		black_ed       *    0.0005  + ///
		black_coll     *   -0.0449  + ///
		asian_ed       *   -0.0230  + ///
		asian_coll     *    0.0896  + ///
		hisp_ed        *    0.0134  + ///
		hisp_coll      *   -0.0261  + ///
		imm_ed         *    0.0238  + ///
		imm_coll       *   -0.0860  + ///
		yrsinus        *   -0.0256  + ///
		yrsinus2       *    0.0006  + ///
		euro_ed        *   -0.0104  + ///
		hi_asian_ed    *    0.0142  + ///
		mid_asian_ed   *    0.0129  + ///
		mex_ed         *   -0.0062  + ///
		euro_coll      *    0.0675  + ///
		hi_asian_coll  *   -0.1602  + ///
		mid_asian_coll *   -0.1376  + ///
		mex_coll       *    0.1898  + ///
		euro_yrs       *   -0.0047  + ///
		hi_asian_yrs   *   -0.0339  + ///
		mid_asian_yrs  *    0.0046  + ///
		mex_yrs        *    0.0086  + ///
		euro_yrs2      *    0.0000  + ///
		hi_asian_yrs2  *    0.0008  + ///
		mid_asian_yrs2 *   -0.0002  + ///
		mex_yrs2       *   -0.0002  + ///
		pre_exp        *    0.0143  + ///
		pre_exp1       *    0.1777 if female == 0
		
replace xb = -c0 - xb1 if female == 0

replace p1=normal(c1-xb) if female == 0
replace p2=normal(c2-xb)-normal(c1-xb) if female == 0
replace p3=normal(c3-xb)-normal(c2-xb) if female == 0
replace p4=normal(c4-xb)-normal(c3-xb) if female == 0
replace p5=normal(c5-xb)-normal(c4-xb) if female == 0
replace p6=normal(c6-xb)-normal(c5-xb) if female == 0
replace p7=normal(c7-xb)-normal(c6-xb) if female == 0
replace p8=normal(c8-xb)-normal(c7-xb) if female == 0
replace p9=normal(c9-xb)-normal(c8-xb) if female == 0
replace p10=1-normal(c9-xb) if female == 0

/* Statements for females */
replace c0 = 0.0063 if female == 1
replace c1 = 0 if female == 1
replace c2 = 0.5888 if female == 1
replace c3 = 0.9905 if female == 1
replace c4 = 1.3532 if female == 1
replace c5 = 1.6888 if female == 1
replace c6 = 1.9951 if female == 1
replace c7 = 2.3458 if female == 1
replace c8 = 2.6625 if female == 1
replace c9 = 3.0059 if female == 1

replace xb1 = imm      *   -0.2706  + ///
		educ_yrs           *   -0.0462  + ///
		exp            *   -0.0744  + ///
		exp2           *    0.2760  + ///
		exp3           *   -0.0338  + ///
		inschool       *   -0.0182  + ///
		dropout        *    0.2662  + ///
		somecoll       *   -0.2212  + ///
		collplus       *   -0.5695  + ///
		advanced       *   -0.2379  + ///
		asian          *    0.0149  + ///
		black          *    0.0587  + ///
		black_ed       *   -0.0076  + ///
		black_coll     *   -0.1209  + ///
		asian_ed       *   -0.0154  + ///
		asian_coll     *    0.1206  + ///
		hisp_ed        *   -0.0019  + ///
		hisp_coll      *    0.0752  + ///
		imm_ed         *    0.0337  + ///
		imm_coll       *    0.0863  + ///
		yrsinus        *   -0.0227  + ///
		yrsinus2       *    0.0005  + ///
		euro_ed        *   -0.0046  + ///
		hi_asian_ed    *    0.0113  + ///
		mid_asian_ed   *    0.0136  + ///
		mex_ed         *    0.0062  + ///
		euro_coll      *   -0.0062  + ///
		hi_asian_coll  *   -0.1800  + ///
		mid_asian_coll *   -0.2430  + ///
		mex_coll       *    0.0031  + ///
		euro_yrs       *    0.0035  + ///
		hi_asian_yrs   *    0.0011  + ///
		mid_asian_yrs  *   -0.0143  + ///
		mex_yrs        *    0.0079  + ///
		euro_yrs2      *   -0.0001  + ///
		hi_asian_yrs2  *    0.0000  + ///
		mid_asian_yrs2 *    0.0003  + ///
		mex_yrs2       *   -0.0002  + ///
		pre_exp        *    0.0073  + ///
		pre_exp1       *    0.0316 if female == 1

replace xb = -c0 - xb1 if female == 1

replace p1=normal(c1-xb) if female == 1
replace p2=normal(c2-xb)-normal(c1-xb) if female == 1
replace p3=normal(c3-xb)-normal(c2-xb) if female == 1
replace p4=normal(c4-xb)-normal(c3-xb) if female == 1
replace p5=normal(c5-xb)-normal(c4-xb) if female == 1
replace p6=normal(c6-xb)-normal(c5-xb) if female == 1
replace p7=normal(c7-xb)-normal(c6-xb) if female == 1
replace p8=normal(c8-xb)-normal(c7-xb) if female == 1
replace p9=normal(c9-xb)-normal(c8-xb) if female == 1
replace p10=1-normal(c9-xb) if female == 1


forvalues i=1/10 {
gen rwt`i' = p`i'*pweight 
gen ip`i' = p`i'*imm
}
		
		
gen c = 1
gen havewage = (logwage != .)
gen native = 1 - imm
gen male = 1 - female

gen rczone = 0
replace rczone = czone if top125 == 1
replace rczone = 1 if (top125 == 0 & czone != .)

replace recimm = 0 if imm == 0
gen wt = pweight

gen dev = logwage2 - 2.2559752
gen devsq = dev*dev

gen nonmover = 0 
replace nonmover = 1 if imm == 0 & state == bpl


keep rczone imm female logwage2 wt p1-p10 dev devsq c age ///
	educ_yrs exp exp2 exp3 inschool dropout somecoll collplus advanced ///
	asian black hispanic black_ed black_coll asian_ed asian_coll ///
	hisp_ed hisp_coll imm_ed imm_coll yrsinus yrsinus2 ///
	euro_ed hi_asian_ed mid_asian_ed mex_ed ///
	euro_coll hi_asian_coll mid_asian_coll mex_coll  ///
	euro_yrs hi_asian_yrs mid_asian_yrs mex_yrs ///
	euro_yrs2 hi_asian_yrs2 mid_asian_yrs2 mex_yrs2  ///
	pre_exp pre_exp1 bpl state czone nonmover ///
	ic euro hi_asian mid_asian mex owage annhrs xclass ///
	eclass
	
save data/2000/np2000.dta, replace 




