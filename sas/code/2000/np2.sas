*np2.sas  - prepare for dfl by city;
*revised dec 27 to set educ=10 into some coll;

options ls=120 nocenter;
libname c2000 '/home/groups/sorkin/quadros/data/2000';

*follows combo which assigns msa and top125 dummy;

data c2000.np2000;
set c2000.all2000 (drop=p1 famrel ownchild paoc
age_alloc numrace marstat educ_alloc
citizen ind occ class self_alloc totearn);

female=(sex=2);

if age>=18;
if wagesal>0;  /*further cut below for logwage2 ne .  */

*further cut below for experience 1-45 yrs;

if imm=0 then pweight=pweight*2;
if pweight > 0;

length grade eclass dropout hsgrad somecoll collplus advanced inschool 3;

grade=educ;

if grade<=1 then educ=0;
 else if grade=2 then educ=3;
 else if grade=3 then educ=6;
 else if grade=4 then educ=8;
 else if grade=5 then educ=9;
 else if grade=6 then educ=10;
 else if grade=7 then educ=11;
 else if grade=8 then educ=11;
 else if grade=9 then educ=12;
 else if grade=10 then educ=13;
 else if grade=11 then educ=13;
 else if grade=12 then educ=14;
 else if grade=13 then educ=16;
 else if grade=14 then educ=18;
 else if grade=15 then educ=19;
 else if grade=16 then educ=20;

if educ<12 then eclass=1;
else if educ=12 then eclass=2;
else if educ<16 then eclass=3;
else eclass=4;

dropout=(eclass=1);
hsgrad=(eclass=2);
somecoll=(eclass=3);
collplus=(eclass=4);
advanced=(educ>16);

inschool=(enroll>1);


length exp xclass annhrs chours selfemp workly ft female c 3;
length wage wage2 exp2 exp3 logwage logwage2 4;


if eclass=1 then exp=age-16;
else if eclass=2 then exp=age-19;
else if eclass=3 then exp=age-21;
else exp=age-23;

exp2=exp*exp/100;
exp3=exp*exp*exp/1000;


if (1<=exp<=45);   /*sample cut for exp*/

if exp<=5 then xclass=1;
else if exp<=10 then xclass=2;
else if exp<=15 then xclass=3;
else if exp<=20 then xclass=4;
else if exp<=25 then xclass=5;
else if exp<=30 then xclass=6;
else if exp<=35 then xclass=7;
else if exp<=40 then xclass=8;
else if exp<=45 then xclass=9;


annhrs=weeks*hrswkly;
if annhrs>0 and wagesal>0 then wage=wagesal/annhrs;
else wage=.;

chours=annhrs;
if annhrs=0 then chours=.;

owage=wage;
if (0<wage<3.8625) then wage=3.8625;
if wage>257.5 then wage=257.5;
logwage=log(wage);

if abs(selfinc) > 0 then selfemp=1;
else selfemp=0;

wage2=wage;
if selfemp=1 then wage2=.;
logwage2=log(wage2);

if logwage2 ne .;    /* keep only wage obs */

workly=(annhrs>0);

ft=(annhrs>1400);
if annhrs=0 then ft=.;

c=1;


length ic euro hi_asian mid_asian mex 3;
length yrsinus pre_exp pre_exp1 pre_exp2  3;
length exp2 exp3 yrsinus2 icyr1-icyr38 icyrsq1-icyrsq38 4;
length euro_ed hi_asian_ed mid_asian_ed mex_ed
      euro_coll hi_asian_coll mid_asian_coll mex_coll
      euro_yrs hi_asian_yrs mid_asian_yrs mex_yrs
      euro_yrs2 hi_asian_yrs2 mid_asian_yrs2 mex_yrs2 3;


if imm=1 then do;

*coding of immigrants;
if pob=303 then ic=1;         /*mexico*/
else if pob=233 then ic=2 ;   /*phillip*/
else if pob=210 then ic=3 ;   /*india*/
else if pob=247 then ic=4 ;   /*vietnam*/
else if pob=312 then ic=5 ;   /*el salvador*/
else if pob=207 then ic=6 ;   /*china*/
else if pob=327 then ic=7 ;   /*cuba*/
else if pob=329 then ic=8 ;   /*dr*/
else if pob in (217,220,221) then ic=9 ;  /*korea*/
else if pob=333 then ic=10 ;  /*jamaica*/
else if pob=301 then ic=11;   /*canada*/
else if pob=364 then ic=12;   /*columbia*/
else if pob=313 then ic=13;   /*guatemala*/
else if pob=110 then ic=14;  /*germany*/
else if pob=332 then ic=15;    /*haiti */
else if pob=128 then ic=16;    /*poland*/
else if pob=240 then ic=17;    /*taiwan*/
else if (138<=pob<=145) then ic=18;  /*england*/
else if pob=120 then ic=19;      /*italy*/
else if pob=365 then ic=20;     /*ecuador*/
else if pob=215 then ic=21;     /*japan*/
else if pob=212 then ic=22;    /*iran*/
else if pob=314 then ic=23;     /*honduras*/
else if pob=370 then ic=24;     /*peru*/
else if pob in (163,165) then ic=25;  /*russia*/
else if pob=315 then ic=26;    /*nicaragua*/
else if pob=368 then ic=27;    /*guyana*/
else if pob=231 then ic=28;    /*pakistan*/
else if pob=209 then ic=29;   /*hong kong*/
else if pob=341 then ic=30;   /*trinidad-tobago*/

else if (101<=pob<=145) or (pob in (148,149))
  or (pob in (214,208,501,515))
   then ic=31;  /*west europe+isreal+cyprus+auss+nz*/

else if (pob in (100,147)) or (150<=pob<=167)
   then ic=32;  /*east europe incl romania ukraine yugoslav*/

else if (pob in (201,213,216,222,224,230,234,235,239,245,
   248,200,202,218,219,243,244,246) )
     then ic=33;  /*middle east turkey bulgaria and the stans*/

else if (pob in (205,206,211,223))
  or (225<=pob<=229) or (236<=pob<=238) or (pob=249)
   or (500<=pob<=553)
     then ic=34;   /*asia and oceana*/

else if (360<=pob<=399)
     then ic=35;  /*s america + north am nec */

else if (400<=pob<=468)
     then ic=36;  /*africa*/

else if (300<=pob<=343)
     then ic=37;  /*caribbean + central am */

else ic=38;


yrsinus=2000-immyr;
pre_exp=exp-yrsinus;  /*rough proxy for experience at arrival = pre-US exp*/

pre_exp1=(pre_exp<-4);    /*likely to have done some schooling in us */
pre_exp2=(-4<=pre_exp<0);

yrsinus2=yrsinus*yrsinus;


*construct dummies for broad groups;

euro= (ic in (11,14,16,18,19,25,31,32));  /*european pob*/
hi_asian=(ic in (3,9,17,21,22,28,29));    /*india korea taiwan japan iran pakistan hongkong*/
mid_asian=(ic in (2,4,6));                /*philippines, VN, China */
mex=(ic=1);                               /*mexico*/


euro_ed=euro*educ;
hi_asian_ed=hi_asian*educ;
mid_asian_ed=mid_asian*educ;
mex_ed=mex*educ;

euro_coll=euro*collplus;
hi_asian_coll=hi_asian*collplus;
mid_asian_coll=mid_asian*collplus;
mex_coll=mex*collplus;

euro_yrs=euro*yrsinus;
hi_asian_yrs=hi_asian*yrsinus;
mid_asian_yrs=mid_asian*yrsinus;
mex_yrs=mex*yrsinus;

euro_yrs2=euro*yrsinus2;
hi_asian_yrs2=hi_asian*yrsinus2;
mid_asian_yrs2=mid_asian*yrsinus2;
mex_yrs2=mex*yrsinus2;


end;  /* end of loop for imms*/


else if imm=0 then do;
 ic=-1;
 pre_exp=0;
 pre_exp1=0;
 pre_exp2=0;
 yrsinus=0;
 yrsinus2=0;
 euro=0;
 hi_asian=0;
 mid_asian=0;
 mex=0;
 euro_ed=0;
 hi_asian_ed=0;
 mid_asian_ed=0;
 mex_ed=0;
 euro_coll=0;
 hi_asian_coll=0;
 mid_asian_coll=0;
 mex_coll=0;
 euro_yrs=0;
 hi_asian_yrs=0;
 mid_asian_yrs=0;
 mex_yrs=0;
 euro_yrs2=0;
 hi_asian_yrs2=0;
 mid_asian_yrs2=0;
 mex_yrs2=0;
end;

imm_ed=imm*educ;
imm_coll=imm*collplus;


*assign ethnicity/race;

length asian black asian_ed black_ed asian_coll black_coll insamp 3;

asian=(race1 in (6,7) and hispanic=0);
black=(race1=2 and hispanic=0);

black_ed=black*educ;
black_coll=black*collplus;

asian_ed=asian*educ;
asian_coll=asian*collplus;

hisp_ed=hispanic*educ;
hisp_coll=hispanic*collplus;

insamp=(logwage2 ne .);


recimm=(immyr>=1990);


*code from op.code fit by gender;

if female=0 then do;
c0= 0.0872 ;
c1=0;
c2=  0.4019  ;
c3     =    0.6955  ;
c4     =    0.9980  ;
c5     =    1.2802  ;
c6     =    1.5695  ;
c7     =    1.9450  ;
c8     =    2.3764  ;
c9     =    2.9685  ;
xb1=
imm            *   -0.0277  +
educ           *   -0.0620  +
exp            *   -0.1255  +
exp2           *    0.3353  +
exp3           *   -0.0282  +
inschool       *    0.1624  +
dropout        *    0.2560  +
somecoll       *   -0.1165  +
collplus       *   -0.4050  +
advanced       *    0.0382  +
asian          *    0.3268  +
black          *    0.3026  +
black_ed       *    0.0005  +
black_coll     *   -0.0449  +
asian_ed       *   -0.0230  +
asian_coll     *    0.0896  +
hisp_ed        *    0.0134  +
hisp_coll      *   -0.0261  +
imm_ed         *    0.0238  +
imm_coll       *   -0.0860  +
yrsinus        *   -0.0256  +
yrsinus2       *    0.0006  +
euro_ed        *   -0.0104  +
hi_asian_ed    *    0.0142  +
mid_asian_ed   *    0.0129  +
mex_ed         *   -0.0062  +
euro_coll      *    0.0675  +
hi_asian_coll  *   -0.1602  +
mid_asian_coll *   -0.1376  +
mex_coll       *    0.1898  +
euro_yrs       *   -0.0047  +
hi_asian_yrs   *   -0.0339  +
mid_asian_yrs  *    0.0046  +
mex_yrs        *    0.0086  +
euro_yrs2      *    0.0000  +
hi_asian_yrs2  *    0.0008  +
mid_asian_yrs2 *   -0.0002  +
mex_yrs2       *   -0.0002  +
pre_exp        *    0.0143  +
pre_exp1       *    0.1777 ;

xb=-c0-xb1;

p1=probnorm(c1-xb);
p2=probnorm(c2-xb)-probnorm(c1-xb);
p3=probnorm(c3-xb)-probnorm(c2-xb);
p4=probnorm(c4-xb)-probnorm(c3-xb);
p5=probnorm(c5-xb)-probnorm(c4-xb);
p6=probnorm(c6-xb)-probnorm(c5-xb);
p7=probnorm(c7-xb)-probnorm(c6-xb);
p8=probnorm(c8-xb)-probnorm(c7-xb);
p9=probnorm(c9-xb)-probnorm(c8-xb);
p10=1-probnorm(c9-xb);

end;




else if female=1 then do;

c0     =    0.0063  ;
c1     =    0 ;
c2     =    0.5888  ;
c3     =    0.9905  ;
c4     =    1.3532  ;
c5     =    1.6888  ;
c6     =    1.9951  ;
c7     =    2.3458  ;
c8     =    2.6625  ;
c9     =    3.0059  ;

xb1=
imm            *   -0.2706  +
educ           *   -0.0462  +
exp            *   -0.0744  +
exp2           *    0.2760  +
exp3           *   -0.0338  +
inschool       *   -0.0182  +
dropout        *    0.2662  +
somecoll       *   -0.2212  +
collplus       *   -0.5695  +
advanced       *   -0.2379  +
asian          *    0.0149  +
black          *    0.0587  +
black_ed       *   -0.0076  +
black_coll     *   -0.1209  +
asian_ed       *   -0.0154  +
asian_coll     *    0.1206  +
hisp_ed        *   -0.0019  +
hisp_coll      *    0.0752  +
imm_ed         *    0.0337  +
imm_coll       *    0.0863  +
yrsinus        *   -0.0227  +
yrsinus2       *    0.0005  +
euro_ed        *   -0.0046  +
hi_asian_ed    *    0.0113  +
mid_asian_ed   *    0.0136  +
mex_ed         *    0.0062  +
euro_coll      *   -0.0062  +
hi_asian_coll  *   -0.1800  +
mid_asian_coll *   -0.2430  +
mex_coll       *    0.0031  +
euro_yrs       *    0.0035  +
hi_asian_yrs   *    0.0011  +
mid_asian_yrs  *   -0.0143  +
mex_yrs        *    0.0079  +
euro_yrs2      *   -0.0001  +
hi_asian_yrs2  *    0.0000  +
mid_asian_yrs2 *    0.0003  +
mex_yrs2       *   -0.0002  +
pre_exp        *    0.0073  +
pre_exp1       *    0.0316  ;

xb=-c0-xb1;

p1=probnorm(c1-xb);
p2=probnorm(c2-xb)-probnorm(c1-xb);
p3=probnorm(c3-xb)-probnorm(c2-xb);
p4=probnorm(c4-xb)-probnorm(c3-xb);
p5=probnorm(c5-xb)-probnorm(c4-xb);
p6=probnorm(c6-xb)-probnorm(c5-xb);
p7=probnorm(c7-xb)-probnorm(c6-xb);
p8=probnorm(c8-xb)-probnorm(c7-xb);
p9=probnorm(c9-xb)-probnorm(c8-xb);
p10=1-probnorm(c9-xb);

end;

array rwt (*) rwt1-rwt10;
array p (*) p1-p10;
array ip (*) ip1-ip10;

do j=1 to 10;
rwt(j)=p(j)*pweight;
ip(j)=p(j)*imm;
end;
c=1;


length c havewage native male  3 rmsa 4;

c=1;
havewage=(logwage2 ne .);
native=1-imm;
male=1-female;

if top125=1 then rmsa=msa;
else if top125=0 and ( msa>0 and msa<9990) then rmsa=1;
else rmsa=0;

if imm=0 then recimm=0;
wt=pweight;


dev=logwage2-2.6129925;
devsq=dev*dev;


if imm=0 and (state=pob) then nonmover=1;
else nonmover=0;

keep rmsa imm female logwage2 wt p1-p10 dev devsq c age
              educ exp exp2 exp3 inschool dropout somecoll collplus advanced
              asian black hispanic black_ed black_coll asian_ed asian_coll
              hisp_ed hisp_coll imm_ed imm_coll yrsinus yrsinus2
              euro_ed hi_asian_ed mid_asian_ed mex_ed
              euro_coll hi_asian_coll mid_asian_coll mex_coll
              euro_yrs hi_asian_yrs mid_asian_yrs mex_yrs
              euro_yrs2 hi_asian_yrs2 mid_asian_yrs2 mex_yrs2
              pre_exp pre_exp1 english pob state msa nonmover
              ic euro hi_asian mid_asian mex owage annhrs xclass
              eclass grade;

proc means;
weight wt;

proc means;
where (imm=0);
weight wt;

proc means;
where (imm=1);
weight wt;


proc means;
where (grade=9 and female=0 and imm=0);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=10 and female=0 and imm=0);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=11 and female=0 and imm=0);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=12 and female=0 and imm=0);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=13 and female=0 and imm=0);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;



proc means;
where (grade=9 and female=1 and imm=0);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=10 and female=1 and imm=0);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=11 and female=1 and imm=0);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=12 and female=1 and imm=0);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=13 and female=1 and imm=0);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;


proc means;
where (grade=9 and female=1 and imm=1);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=10 and female=1 and imm=1);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=11 and female=1 and imm=1);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=12 and female=1 and imm=1);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;

proc means;
where (grade=13 and female=1 and imm=1);
var imm female educ grade logwage2 annhrs owage inschool age black hispanic ;
weight wt;
