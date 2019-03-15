clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/MSAlevel"

clear
use data/1980/all80.dta

/* Sample restrictions. There's a further cut below for experience 1-45.*/
keep if age >= 18 & age != . 
keep if wagesal > 0 & wagesal != . 

/* Weight */
gen wt = 1 if imm == 1
replace wt = 2 if imm != 1

/* MSA rank */
do code/1980/msarecode80.do

/* EDUCATION */
gen eclass = 4
replace eclass = 3 if educ < 16
replace eclass = 2 if educ == 12
replace eclass = 1 if educ < 12

gen dropout = (eclass == 1)
gen hsgrad = (eclass == 2)
gen somecoll = (eclass == 3)
gen collplus = (eclass == 4)
gen advanced = educ > 16 & educ != . 

gen inschool = (enroll>0) & !missing(enroll)

/* EXPERIENCE */
gen exp = . 
replace exp = age-16 if eclass == 1
replace exp = age-19 if eclass == 2
replace exp = age-21 if eclass == 3
replace exp = age-23 if (eclass != 1) & (eclass != 2) & (eclass != 3) 

gen exp2 = (exp^2)/100
gen exp3 = (exp^3)/1000

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

/* WAGES */
replace wagesal = 75000*1.43 if wagesal==75000 /* pareto fix */

/* Weeks:
	values go from 0-52 weeks.
*/
gen annhrs = weeks * hrswkly

gen wage = . 
replace wage = wagesal/annhrs if (annhrs > 0 & wagesal > 0)

gen ft = (annhrs > 1400 & !missing(annhrs)) /*full time*/
replace ft = . if annhrs == 0

gen chours = annhrs 
replace chours = . if annhrs == 0

gen owage = wage
replace wage=2.175 if (0 < wage & wage < 2.175)
replace wage=145 if 145 < wage & !missing(wage)
gen logwage = log(wage)

/* Self employed income */
replace selfinc = selfinc + farminc
gen selfemp = 0
replace selfemp = 1 if (abs(selfinc) > 0 & selfinc != .)

gen wage2 = wage
replace wage2 = . if selfemp==1 
gen logwage2 = log(wage2)

gen workly = (annhrs > 0 & !missing(annhrs))

keep if !missing(logwage2)

/* Sex */
/*
male = 0
female = 1
*/
gen female = (sex == 1)

/* Create variables */

gen ic = 0 /* immigration country */
gen yrsinus = 0 /* years in the us */
gen recimm = 0 /* recent immigrant */
gen pre_exp = 0 /* prior experience at arrival to the us */
gen pre_exp1 = 0 /* experience w/ schooling in the us */
gen pre_exp2 = 0 
gen yrsinus2 = 0 /* years in the us squared */
gen euro = 0 /* european imm */
gen hi_asian = 0 /* hi_asian imm */ 
gen mid_asian = 0  /* mid_asian imm */ 
gen mex = 0 /* mexican imm */
gen euro_ed = 0 /* european imm educ years */
gen hi_asian_ed = 0 /* hi_asian imm educ years */ 
gen mid_asian_ed = 0 /* mid_asian imm educ years */
gen mex_ed = 0 /* mex imm educ years */ 
gen euro_coll = 0  /* european imm w/ college educ */
gen hi_asian_coll = 0 /* hi_asian imm w/ college educ */
gen mid_asian_coll = 0 /* mid_asian imm w/ college educ */
gen mex_coll = 0 /* mexican imm w/ college educ */
gen euro_yrs = 0 /* euro imm yrs in the us */ 
gen hi_asian_yrs = 0 /* hi_asian imm yrs in the us */ 
gen mid_asian_yrs = 0 /* mid_asian imm yrs in the us */ 
gen mex_yrs = 0 /* mexican imm yrs in the us */ 
gen euro_yrs2 = 0 /* euro imm yrs in us squared */
gen hi_asian_yrs2 = 0  /* hi_asian imm yrs in us squared */
gen mid_asian_yrs2 = 0 /* mid_asian imm yrs in us squared */
gen mex_yrs2 = 0 /* mex imm yrs in us squared */

/* STATEMENTS FOR IMMIGRATS */
replace ic=1 if bpl==436 & imm==1 & ic==0 /*mexico*/
replace ic=2 if bpl==628 & imm==1 & ic==0 /*phillip*/
replace ic=3 if bpl==614 & imm==1 & ic==0 /*india*/
replace ic=4 if bpl==631 & imm==1 & ic==0 /*vietnam*/
replace ic=5 if bpl==433 & imm==1 & ic==0 /*el salvador*/
replace ic=6 if bpl==501 & imm==1 & ic==0 /*china*/
replace ic=7 if bpl==476 & imm==1 & ic==0 /*cuba*/
replace ic=8 if bpl==477 & imm==1 & ic==0 /*dr*/
replace ic=9 if inlist(bpl, 504,505,506) & imm==1 & ic==0 /*korea*/
replace ic=10 if bpl==456 & imm==1 & ic==0 /*jamaica*/
replace ic=11 if bpl==302 & imm==1 & ic==0 /*canada*/
replace ic=12 if bpl==415 & imm==1 & ic==0 /*columbia*/
replace ic=13 if bpl==434 & imm==1 & ic==0 /*guatemala*/
replace ic=14 if inlist(bpl, 719,747)& imm==1 & ic==0 /*germany*/
replace ic=15 if bpl==473 & imm==1 & ic==0 /*haiti */
replace ic=16 if bpl==749 & imm==1 & ic==0 /*poland*/
replace ic=17 if bpl==509 & imm==1 & ic==0 /*taiwan*/
replace ic=18 if 769<=bpl & bpl <=775& imm==1 & ic==0 /*england*/
replace ic=19 if bpl==725 & imm==1 & ic==0 /*italy*/
replace ic=20 if bpl==416& imm==1 & ic==0 /*ecuador*/
replace ic=21 if bpl==503& imm==1 & ic==0 /*japan*/
replace ic=22 if bpl==615 & imm==1 & ic==0 /*iran*/
replace ic=23 if bpl==435& imm==1 & ic==0 /*honduras*/
replace ic=24 if bpl==421& imm==1 & ic==0 /*peru*/
replace ic=25 if inlist(bpl, 900,908)& imm==1 & ic==0 /*russia*/
replace ic=26 if bpl==437 & imm==1 & ic==0 /*nicaragua*/
replace ic=27 if bpl==419 & imm==1 & ic==0 /*guyana*/
replace ic=28 if bpl==618 & imm==1 & ic==0 /*pakistan*/
replace ic=29 if bpl==502 & imm==1 & ic==0 /*hong kong*/
replace ic=30 if bpl==461 & imm==1 & ic==0 /*trinidad-tobago*/
replace ic=31 if ((700<=bpl & bpl<=720) | (722<=bpl & bpl<=732) |(746<=bpl & bpl <=748) /// 
                | (760<=bpl & bpl<=775) | inlist(bpl, 645,642,810,820)) & imm==1 & ic==0  /*west europe+isreal+cyprus+auss+nz*/
replace ic=32 if ((bpl==721) | (733<=bpl & bpl<=745) | inlist(bpl, 749,750) | bpl==911) & imm==1 & ic==0 /*east europe incl romania ukraine yugoslav*/ 
replace ic = 33 if ((640<=bpl & bpl<=690) | (901 <= bpl & bpl <= 912)) & imm==1 & ic==0/*middle east turkey bulgaria and the stans*/
replace ic = 34 if ((500 <= bpl & bpl <= 631) | (800 <= bpl & bpl <= 858)) & imm==1 & ic==0 /*asia and oceana*/
replace ic = 35 if ((400 <= bpl & bpl <= 424) | (200 <= bpl & bpl <= 304)) & imm==1 & ic==0 /*s america + north am nec */
replace ic = 36 if (110 <= bpl & bpl <= 185) & imm==1 & ic==0 /*africa*/
replace ic = 37 if (430 <= bpl & bpl <= 477) & imm==1 & ic==0 /*caribbean + central am */
replace ic = 38 if imm==1 & ic==0 

/*  Approx years in the US */
replace yrsinus = 2.5 if immyr == 1 & imm == 1
replace yrsinus = 7.5 if immyr == 2 & imm == 1
replace yrsinus = 12.5 if immyr == 3 & imm == 1
replace yrsinus = 17.5 if immyr == 4 & imm == 1
replace yrsinus = 25.5 if immyr == 5 & imm == 1
replace yrsinus = 40 if immyr == 6 & imm == 1

replace recimm = 1 if (immyr == 1 | immyr == 2) & imm == 1 /* recent immigrant */

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

replace euro_ed = euro*educ if imm == 1
replace hi_asian_ed = hi_asian*educ if imm == 1
replace mid_asian_ed = mid_asian*educ if imm == 1
replace mex_ed = mex*educ if imm == 1

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
gen imm_ed = imm * educ 
gen imm_coll = imm * collplus

/* Assign ethnicity/race. */
replace hispanic = 1 if hispanic >= 1 & !missing(hispanic)
gen asian = 0
replace asian = 1 if (4<=race & race<= 11 & hispanic == 0)
gen black = 0
replace black = 1 if race == 2 & hispanic == 0

gen black_ed = black*educ
gen black_coll = black*collplus

gen asian_ed = asian*educ
gen asian_coll = asian*collplus

gen hisp_ed = hispanic*educ
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
		educ           *   -0.0620  + ///
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
		educ           *   -0.0462  + ///
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

gen c = 1
gen havewage = (logwage2 != .)
gen native = 1 - imm
gen male = 1 - female

gen rmsa = 0
replace rmsa = msa if top125 == 1
replace rmsa = 1 if (top125 == 0) & (0<msa & msa<9990)

replace recimm = 0 if imm == 0

gen dev = logwage2 - 1.7724015
gen devsq = dev*dev

gen nonmover = 0 
replace nonmover = 1 if imm == 0 & statefip == bpl

keep rmsa imm female logwage2 wt p1-p10 dev devsq c age ///
	educ exp exp2 exp3 inschool dropout somecoll collplus advanced ///
	asian black hispanic black_ed black_coll asian_ed asian_coll ///
	hisp_ed hisp_coll imm_ed imm_coll yrsinus yrsinus2 ///
	euro_ed hi_asian_ed mid_asian_ed mex_ed ///
	euro_coll hi_asian_coll mid_asian_coll mex_coll  ///
	euro_yrs hi_asian_yrs mid_asian_yrs mex_yrs ///
	euro_yrs2 hi_asian_yrs2 mid_asian_yrs2 mex_yrs2  ///
	pre_exp pre_exp1 english bpl statefip msa nonmover ///
	ic euro hi_asian mid_asian mex owage annhrs xclass ///
	eclass ind

/* Checks */
summ 
summ [fweight = wt]
summ if imm == 0 [fweight = wt]
summ if imm == 1 [fweight = wt]
tab ic hispanic

/* Save */
save data/1980/np80, replace

