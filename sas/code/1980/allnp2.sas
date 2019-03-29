*allnp2 based on np2-90 and built on op3.sas -- follows read80.sas;

options ls = 120 nocenter;
libname c80 '/home/groups/sorkin/quadros/data/1980' ;


data c80.supp80;
set c80.all80 (drop=hhtype gotkids famrel
state75 esr hourslw ind occ income al_pob al_sal) ;


if age>=18;  /*age 18+  */


if imm=1 then wt=1; else wt=2;

%include '/home/groups/sorkin/quadros/code/1980/smsarecode80.sas';
length top125 3;


length eclass dropout hsgrad somecoll collplus advanced 
 exp xclass 3;

if educ<12 then eclass=1;
else if educ=12 then eclass=2;
else if educ<16 then eclass=3;
else eclass=4;

dropout=(eclass=1);
hsgrad=(eclass=2);
somecoll=(eclass=3);
collplus=(eclass=4);
advanced=(educ>16);

if eclass=1 then exp=age-16;
else if eclass=2 then exp=age-19;
else if eclass=3 then exp=age-21;
else exp=age-23;

if age>=18;        /*age 18+  */
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

if wagesal=75000 then wagesal=75000*1.43;  /*pareto fix*/

annhrs=weeks*hrswkly;
if annhrs>0 and wagesal>0 then wage=wagesal/annhrs;
else wage=.;

length annhrs ft chours selfemp workly female 3;


ft=(annhrs>1400);
if annhrs=0 then ft=.;

chours=annhrs;
if annhrs=0 then chours=.;

owage=wage;
if (0<wage<2.175) then wage=2.175;
if wage>145 then wage=145;
logwage=log(wage);

selfinc=selfinc+farminc;
if abs(selfinc) > 0 then selfemp=1;
else selfemp=0;

wage2=wage;
if selfemp=1 then wage2=.;
logwage2=log(wage2);


workly=(annhrs>0);
female=(sex=1);


length ic euro hi_asian mid_asian mex 3;
length yrsinus yrsinus2 pre_exp pre_exp1 pre_exp2  3;
length euro_ed hi_asian_ed mid_asian_ed mex_ed
      euro_coll hi_asian_coll mid_asian_coll mex_coll 
      euro_yrs hi_asian_yrs mid_asian_yrs mex_yrs 
      euro_yrs2 hi_asian_yrs2 mid_asian_yrs2 mex_yrs2 3;



if imm=1 then do;
*coding of immigrants;

if pob=436 then ic=1;         /*mexico*/
else if pob=628 then ic=2 ;   /*phillip*/
else if pob=614 then ic=3 ;   /*india*/
else if pob=631 then ic=4 ;   /*vietnam*/
else if pob=433 then ic=5 ;   /*el salvador*/
else if pob=501 then ic=6 ;   /*china*/
else if pob=476 then ic=7 ;   /*cuba*/
else if pob=477 then ic=8 ;   /*dr*/
else if pob in (504,505,506) then ic=9 ;  /*korea*/
else if pob=456 then ic=10 ;  /*jamaica*/
else if pob=302 then ic=11;   /*canada*/
else if pob=415 then ic=12;   /*columbia*/
else if pob=434 then ic=13;   /*guatemala*/
else if pob in (719,747) then ic=14;  /*germany*/
else if pob=473 then ic=15;    /*haiti */
else if pob=749 then ic=16;    /*poland*/
else if pob=509 then ic=17;    /*taiwan*/
else if (769<=pob<=775) then ic=18;  /*england*/
else if pob=725 then ic=19;      /*italy*/
else if pob=416 then ic=20;     /*ecuador*/
else if pob=503 then ic=21;     /*japan*/
else if pob=615 then ic=22;    /*iran*/
else if pob=435 then ic=23;     /*honduras*/
else if pob=421 then ic=24;     /*peru*/
else if pob in (900,908) then ic=25;  /*russia*/
else if pob=437 then ic=26;    /*nicaragua*/
else if pob=419 then ic=27;    /*guyana*/
else if pob=618 then ic=28;    /*pakistan*/
else if pob=502 then ic=29;   /*hong kong*/
else if pob=461 then ic=30;   /*trinidad-tobago*/

else if (700<=pob<=720) or (722<=pob<=732) or
  (746<=pob<=748) or (760<=pob<=775) or
  (pob in (645,642,810,820)) 
   then ic=31;  /*west europe+isreal+cyprus+auss+nz*/

else if (pob=721) or (733<=pob<=745) or (pob in (749,750)) or (pob=911)
    then ic=32;  /*east europe incl romania ukraine yugoslav*/

else if (640<=pob<=690) or (901<=pob<=912) 
     then ic=33;  /*middle east turkey bulgaria and the stans*/

else if (500<=pob<=631) or (800<=pob<=858) 
     then ic=34;   /*asia and oceana*/

else if (400<=pob<=424) or (200<=pob<=304)
     then ic=35;  /*s america + north am nec */

else if (110<=pob<=185) 
     then ic=36;  /*africa*/

else if (430<=pob<=477) 
     then ic=37;  /*caribbean + central am */

else ic=38;



if immyr=1 then yrsinus=2.5;
else if immyr=2 then yrsinus=7.5;
else if immyr=3 then yrsinus=12.5;
else if immyr=4 then yrsinus=17.5;
else if immyr=5 then yrsinus=25.5;
else if immyr=6 then yrsinus=40;
else yrsinus=.;

recimm=(immyr in (1,2));

pre_exp=exp-yrsinus;  /*rough proxy for experience at arrival = pre-US exp*/

pre_exp1=(pre_exp<-4);    /*likely to have done some schooling in us */
pre_exp2=(-4<=pre_exp<0);

yrsinus2=yrsinus*yrsinus;


*construct dummies for broad groups;

length euro hi_asian mid_asian mex 
       euro_ed euro_coll hi_asian_ed hi_asian_coll 
       mid_asian_ed mid_asian_coll mex_ed mex_coll 3;

euro= (ic in (11,14,16,18,19,25,31,32));  /*european pob*/
hi_asian=(ic in (3,9,17,21,22,28,29));    /*india korea taiwan japan iran pakistan hongkong*/
mid_asian=(ic in (2,4,6));                /*philippines, VN, China */
mex=(ic=1);                               /*mexico*/

length euro_ed hi_asian_ed mid_asian_ed mex_ed
      euro_coll hi_asian_coll mid_asian_coll mex_coll 3;

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


end;  /*end of loop for imms */


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

length inschool 3 exp2 exp2 4;

inschool=(enroll>0);
exp2=exp*exp/100;
exp3=exp*exp*exp/1000;


length asian black asian_ed black_ed asian_coll black_coll  3;

if hispanic>=1 then hispanic=1;

asian=( (4<=race<=11) and hispanic=0);
black=(race=2 and hispanic=0);

black_ed=black*educ;
black_coll=black*collplus;

asian_ed=asian*educ;
asian_coll=asian*collplus;

hisp_ed=hispanic*educ;
hisp_coll=hispanic*collplus;





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


length c havewage native male  3 rmsa 4;

c=1;
havewage=(logwage2 ne .);
native=1-imm;
male=1-female;

if top125=1 then rmsa=msa;
else if top125=0 and (msa>0 and msa<9990) then rmsa=1;
else rmsa=0;

if imm=0 then recimm=0;

dev=logwage2-1.7724015;
devsq=dev*dev;


if imm=0 and (state=pob) then nonmover=1;
else nonmover=0;

emp=(annhrs>0);

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
              eclass wagesal weeks selfinc wage wage2 emp;

proc means;
weight wt;

proc means;
where (imm=0);
weight wt;

proc means;
where (imm=1);
weight wt;


proc freq;
tables ic*hispanic;
weight wt;
