
*t1.sas run separately for 1980, 1990, 2000, and 2005/6;

*creates some summary stats by city;



options ls=120 nocenter;
libname cell80 '/home/groups/sorkin/quadros/data/1980' ; 
libname cell90 '/home/groups/sorkin/quadros/data/1990' ; 
libname cell00 '/home/groups/sorkin/quadros/data/2000' ; 
*libname cell05 '/home/groups/sorkin/quadros/data/1980' ; 
libname here '.';


  /*
proc summary;
class rmsa native male eclass xclass2;
var emp havewage2 wagesal cwagesal annhrs cannhrs weeks hrswkly ft
    dropout hs somecoll college advanced collplus educ exp age x1-x4
    black hispanic asian euro hi_asian mid_asian mex 
    rmsa0 rmsa1 q1-q5 q1c q2c q3c q4c q5c 
    educ exp imm female c wage2 logwage2 ;
output out=here.allcells
mean=
sum(c)=count;
weight wt;


   */


data a1;
set cell80.allcells;
if rmsa=. and native=. and male=. and eclass=. and xclass2=.;
year=1980;
count=count*5;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 


data a2;
set cell90.allcells;
if rmsa=. and native=. and male=. and eclass=. and xclass2=.;
year=1990;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a3;
set cell00.allcells;
if rmsa=. and native=. and male=. and eclass=. and xclass2=.;
year=2000;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

/*
data a4;
set cell05.allcells;
if rmsa=. and native=. and male=. and eclass=. and xclass2=.;
year=2005;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 
*/

*men;

data a5;
set cell80.allcells;
if rmsa=. and native=. and male=1 and eclass=. and xclass2=.;
year=1980;
count=count*5;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a6;
set cell90.allcells;
if rmsa=. and native=. and male=1 and eclass=. and xclass2=.;
year=1990;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a7;
set cell00.allcells;
if rmsa=. and native=. and male=1 and eclass=. and xclass2=.;
year=2000;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

/*
data a8;
set cell05.allcells;
if rmsa=. and native=. and male=1 and eclass=. and xclass2=.;
year=2005;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 
*/

*females;

data a9;
set cell80.allcells;
if rmsa=. and native=. and male=0 and eclass=. and xclass2=.;
year=1980;
count=count*5;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a10;
set cell90.allcells;
if rmsa=. and native=. and male=0 and eclass=. and xclass2=.;
year=1990;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a11;
set cell00.allcells;
if rmsa=. and native=. and male=0 and eclass=. and xclass2=.;
year=2000;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

/*
data a12;
set cell05.allcells;
if rmsa=. and native=. and male=0 and eclass=. and xclass2=.;
year=2005;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 
*/

*native men;
data a13;
set cell80.allcells;
if rmsa=. and native=1 and male=1 and eclass=. and xclass2=.;
year=1980;
count=count*5;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a14;
set cell90.allcells;
if rmsa=. and native=1 and male=1 and eclass=. and xclass2=.;
year=1990;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a15;
set cell00.allcells;
if rmsa=. and native=1 and male=1 and eclass=. and xclass2=.;
year=2000;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

/*
data a16;
set cell05.allcells;
if rmsa=. and native=1 and male=1 and eclass=. and xclass2=.;
year=2005;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 
*/

*native women;
data a17;
set cell80.allcells;
if rmsa=. and native=1 and male=0 and eclass=. and xclass2=.;
year=1980;
count=count*5;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a18;
set cell90.allcells;
if rmsa=. and native=1 and male=0 and eclass=. and xclass2=.;
year=1990;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a19;
set cell00.allcells;
if rmsa=. and native=1 and male=0 and eclass=. and xclass2=.;
year=2000;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

/*
data a20;
set cell05.allcells;
if rmsa=. and native=1 and male=0 and eclass=. and xclass2=.;
year=2005;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 
*/

*imm men;
data a21;
set cell80.allcells;
if rmsa=. and native=0 and male=1 and eclass=. and xclass2=.;
year=1980;
count=count*5;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a22;
set cell90.allcells;
if rmsa=. and native=0 and male=1 and eclass=. and xclass2=.;
year=1990;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a23;
set cell00.allcells;
if rmsa=. and native=0 and male=1 and eclass=. and xclass2=.;
year=2000;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

/*
data a24;
set cell05.allcells;
if rmsa=. and native=0 and male=1 and eclass=. and xclass2=.;
year=2005;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 
*/

*imm women;
data a25;
set cell80.allcells;
if rmsa=. and native=0 and male=0 and eclass=. and xclass2=.;
year=1980;
count=count*5;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a26;
set cell90.allcells;
if rmsa=. and native=0 and male=0 and eclass=. and xclass2=.;
year=1990;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

data a27;
set cell00.allcells;
if rmsa=. and native=0 and male=0 and eclass=. and xclass2=.;
year=2000;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 

/*
data a28;
set cell05.allcells;
if rmsa=. and native=0 and male=0 and eclass=. and xclass2=.;
year=2005;
keep year native male count wage2 imm educ dropout collplus exp emp wage2 logwage2 ; 
*/

data all;
set a1 a2 a3 a5 a6 a7 a9 a10
    a11 a13 a14 a15 a17 a18 a19
    a21 a22 a23 a25 a26 a27 ; 
if year=1980 then cpi=72.6;
if year=1990 then cpi=124.0;
if year=2000 then cpi=166.6;
if year=2005 then cpi=195.3;
if year=2005 then count=count/2;
order=_n_;

rlogwage=logwage2+log(207.3)-log(cpi);
rwage=wage2*207.3/cpi;


proc print;
var order year native male count educ exp dropout collplus emp rwage ; 

data v;
set here.compvar;
order=_n_;
yr=year;
nat=native;
mal=male;
keep order yr nat mal v vres;

proc sort data=all; by order;
proc sort data=v; by order;

data test;
merge all v;
by order;
if year=yr and native=nat and male=mal;

drop yr nat mal;

data here.table3r;
set test;
keep year native male count educ exp emp rwage v vres rlogwage;
proc print;

