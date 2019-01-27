*np2.sas follows read90.sas;
*based on np2-2000 version + reswageim90;


options ls = 120 nocenter;
libname c90 '/var/tmp/card/' ;
libname here '.';

data c90.np90;
set c90.all90 (drop=p1);

if age>=18;
if wagesal>0; /*wage earners only*/



pweight=pwgt;
drop pwgt;
if imm=0 then pweight=pweight*2;


%include '~/cpr/c90/msarecode90.sas';



length educ eclass dropout hsgrad somecoll collplus advanced
        exp  xclass annhrs chours ft selfemp  3;

if grade<=3 then educ=0;
 else if grade=4 then educ=3;
 else if grade=5 then educ=6;
 else if grade=6 then educ=9;
 else if grade=7 then educ=10;
 else if grade=8 then educ=11;
 else if grade=9 then educ=11;
 else if grade=10 then educ=12;
 else if grade=11 then educ=13;
 else if grade in (12,13) then educ=14;
 else if grade=14 then educ=16;
 else if grade=15 then educ=18;
 else if grade=16 then educ=19;
 else if grade=17 then educ=20;

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

if (1<=exp<=45); /*sample cut for experience*/


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
if (0<wage<2.5125) then wage=2.5125;
if wage>167.5 then wage=167.5;
logwage=log(wage);

selfinc=selfinc+farminc;
if abs(selfinc) > 0 then selfemp=1;
else selfemp=0;

wage2=wage;
if selfemp=1 then wage2=.;
logwage2=log(wage2);

if logwage2 ne . ;  /*keep only wage guys*/


workly=(annhrs>0);

ft=(annhrs>1400);
if annhrs=0 then ft=.;

female=(sex=1);
c=1;

inschool=(enroll>1);

exp2=exp*exp/100;
exp3=exp*exp*exp/1000;




if imm=1 then do;

*coding of immigrants;
if pob=315 then ic=1;         /*mexico*/
else if pob=231 then ic=2 ;   /*phillip*/
else if pob=210 then ic=3 ;   /*india*/
else if pob=242 then ic=4 ;   /*vietnam*/
else if pob=312 then ic=5 ;   /*el salvador*/
else if pob=207 then ic=6 ;   /*china*/
else if pob=337 then ic=7 ;   /*cuba*/
else if pob=339 then ic=8 ;   /*dr*/
else if pob in (217,218,219) then ic=9 ;  /*korea*/
else if pob=343 then ic=10 ;  /*jamaica*/
else if pob=301 then ic=11;   /*canada*/
else if pob=379 then ic=12;   /*columbia*/
else if pob=313 then ic=13;   /*guatemala*/
else if (110<=pob<=114) then ic=14;  /*germany*/
else if pob=342 then ic=15;    /*haiti */
else if pob=128 then ic=16;    /*poland*/
else if pob=238 then ic=17;    /*taiwan*/
else if (138<=pob<=145) then ic=18;  /*england*/
else if pob=120 then ic=19;      /*italy*/
else if pob=380 then ic=20;     /*ecuador*/
else if pob=215 then ic=21;     /*japan*/
else if pob=212 then ic=22;    /*iran*/
else if pob=314 then ic=23;     /*honduras*/
else if pob=385 then ic=24;     /*peru*/
else if pob=180 then ic=25;  /*russia*/
else if pob=316 then ic=26;    /*nicaragua*/
else if pob=383 then ic=27;    /*guyana*/
else if pob=229 then ic=28;    /*pakistan*/
else if pob=209 then ic=29;   /*hong kong*/
else if pob=351 then ic=30;   /*trinidad-tobago*/

else if (101<=pob<=131) or (133<=pob<=146) or
  (151<=pob<=179) or (pob in (214,208,501,514)) 
   then ic=31;  /*west europe+isreal+cyprus+auss+nz*/

else if (pob in (100,128,132)) or (147<=pob<=150) or (181<=pob<=199) 
   then ic=32;  /*east europe incl romania ukraine yugoslav*/

else if pob in (201,213,216,220,222,228,232,233,237,241,
   243,244,247,248,200,202,240) or (250<=pob<=254)
   or (256<=pob<=299)
     then ic=33;  /*middle east turkey bulgaria and the stans*/

else if (203<=pob<=206) or (pob in (211,221,230,239,245,246,249,255))
  or (223<=pob<=227) or (234<=pob<=236) or (500<=pob<=553)
     then ic=34;   /*asia and oceana*/

else if (300<=pob<=309) or (375<=pob<=399)
     then ic=35;  /*s america + north am nec */

else if (400<=pob<=499) 
     then ic=36;  /*africa*/

else if (310<=pob<=374) 
     then ic=37;  /*caribbean + central am */

else ic=38;

length yrsinus pre_exp pre_exp1 pre_exp2 inschool 3;
length exp2 exp3 yrsinus2 4;


if immyr=1 then yrsinus=1.5;
else if immyr=2 then yrsinus=4.5;
else if immyr=3 then yrsinus=7;
else if immyr=4 then yrsinus=9.5;
else if immyr=5 then yrsinus=12.5;
else if immyr=6 then yrsinus=17.5;
else if immyr=7 then yrsinus=22.5;
else if immyr=8 then yrsinus=27.5;
else if immyr=9 then yrsinus=35.5;
else if immyr=10 then yrsinus=45;
else yrsinus=.;

yrsinus2=yrsinus*yrsinus;
recimm=(immyr in (1,2,3,4));

pre_exp=exp-yrsinus;  /*rough proxy for experience at arrival = pre-US exp*/

pre_exp1=(pre_exp<-4);    /*likely to have done some schooling in us */
pre_exp2=(-4<=pre_exp<0);








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

end; /*end of loop for imms*/


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

length asian black asian_ed black_ed asian_coll black_coll 3;


asian=(6<=race<=36 and hispanic=0);
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


dev=logwage2-2.2559752;
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
              eclass ind;

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
