*inflow3 - computes imm-based inflows by "ex" = ed/exp cell to rmsa;
*output = newflows: data set with flows by skill group to each city due to imms who arrived 80-2000;

options ls=120 nocenter;

libname c80 '~/ely/data/c80/cells/' ;
libname c90 '~/ely/data/c90/cells/' ;
libname c00 '~/ely/data/c00/cells/' ;
libname c05 '~/ely/data/c05/cells/' ;

libname here '.';




  /*
proc summary data=one;
where (new=1);
class ic male;
var dropout hs somecoll college advanced collplus educ exp age x1-x4
    ex11 ex12 ex13 ex14 ex21 ex22 ex23 ex24 ex31 ex32 ex33 ex34 ex41 ex42 ex43 ex44
    rmsa0 rmsa1 female wage2 logwage2 annhrs c;
output out=here.byicnew
mean=
sum(c)=count;
weight wt;
 */

data m00;
set c00.byicnew;
if male=1;
count00m=count;

array mex (*) mex11 mex12 mex13 mex14 mex21 mex22 mex23 mex24 
              mex31 mex32 mex33 mex34 mex41 mex42 mex43 mex44;
array  ex (*)  ex11  ex12  ex13  ex14  ex21  ex22  ex23  ex24 
               ex31  ex32  ex33  ex34  ex41  ex42  ex43  ex44;

do j=1 to 16;
mex(j)=ex(j);
end;

mhrs=annhrs;
keep ic count00m mhrs mex11 mex12 mex13 mex14 mex21 mex22 mex23 mex24 
                 mex31 mex32 mex33 mex34 mex41 mex42 mex43 mex44;

data f00;
set c00.byicnew;
if male=0;
count00f=count;
array fex (*) fex11 fex12 fex13 fex14 fex21 fex22 fex23 fex24 
              fex31 fex32 fex33 fex34 fex41 fex42 fex43 fex44;
array  ex (*)  ex11  ex12  ex13  ex14  ex21  ex22  ex23  ex24 
               ex31  ex32  ex33  ex34  ex41  ex42  ex43  ex44;

do j=1 to 16;
fex(j)=ex(j);
end;
fhrs=annhrs;

keep ic count00f fhrs fex11 fex12 fex13 fex14 fex21 fex22 fex23 fex24 
                 fex31 fex32 fex33 fex34 fex41 fex42 fex43 fex44;


proc sort data=m00; by ic;
proc sort data=f00; by ic;

data one;
merge m00 f00 ;
by ic;


array mex (*) mex11 mex12 mex13 mex14 mex21 mex22 mex23 mex24 
              mex31 mex32 mex33 mex34 mex41 mex42 mex43 mex44;

array fex (*) fex11 fex12 fex13 fex14 fex21 fex22 fex23 fex24 
              fex31 fex32 fex33 fex34 fex41 fex42 fex43 fex44;

array inex (*) inex11 inex12 inex13 inex14 inex21 inex22 inex23 inex24 
              inex31 inex32 inex33 inex34 inex41 inex42 inex43 inex44;

array hinex (*) hinex11 hinex12 hinex13 hinex14 hinex21 hinex22 hinex23 hinex24 
              hinex31 hinex32 hinex33 hinex34 hinex41 hinex42 hinex43 hinex44;

do j=1 to 16;
inex(j)=count00m*mex(j) + count00f*fex(j);
hinex(j)=count00m*(mhrs/2000)*mex(j) + count00f*(fhrs/2000)*fex(j);
end;

indrop=inex11+inex12+inex13+inex14;
inhs  =inex21+inex22+inex23+inex24;
insome=inex31+inex32+inex33+inex34;
incoll=inex41+inex42+inex43+inex44;

hindrop=hinex11+hinex12+hinex13+hinex14;
hinhs  =hinex21+hinex22+hinex23+hinex24;
hinsome=hinex31+hinex32+hinex33+hinex34;
hincoll=hinex41+hinex42+hinex43+hinex44;


inall=count00m+count00f;
indroprate=indrop/inall;
inhsrate=inhs/inall;
insomerate=insome/inall;
incollrate=incoll/inall;

hinall=hindrop+hinhs+hinsome+hincoll;
hindroprate=hindrop/hinall;
hinhsrate=hinhs/hinall;
hinsomerate=hinsome/hinall;
hincollrate=hincoll/hinall;


*proc print;
*var ic inall hinall indroprate hindroprate incollrate hincollrate;


data two;
set one;
if ic ne . ;

keep  inex11 inex12 inex13 inex14 inex21 inex22 inex23 inex24 
      inex31 inex32 inex33 inex34 inex41 inex42 inex43 inex44;



proc transpose data=two out=tt;
proc print data=tt;

*data set tt has 16 rows (inex11...inex44) x 38 cols (ic1...ic38);
*next lines sum across cols to get total inflows ;

data checker;
set tt;
array col (*) col1-col38;
tot=0;
do j=1 to 38;
tot=tot+col(j);
end;
proc print;
var tot;




data loc80;
set c80.ic_city;
*initial imm shares: each row is a city, each col(XX) is shricXX ;
*check that rows sum to 1;
proc means n mean sum;
var shric1-shric38;




%macro inflow(ex);
%let rex=&ex;

data temp;
set loc80;
d=1;
proc sort; by d;

data in;
set tt;
if _n_=&rex;  /*get this row only*/
d=1;
proc print;
proc sort; by d;

data inflow&rex;

merge temp in; 
by d;
array shric (*) shric1-shric38;
array inflow (*) col1-col38;

total=0;
do j=1 to 38;
total=total+shric(j)*inflow(j);
end;

inflow&rex=total;
inflownm&rex=total-shric1*col1;  /*no mex*/
keep rmsa inflow&rex inflownm&rex;

proc means n mean sum;
var inflow&rex inflownm&rex;

proc sort; by rmsa;
*proc print;
*var rmsa inflow&rex;

%mend;

%inflow(1);
%inflow(2);
%inflow(3);
%inflow(4);
%inflow(5);
%inflow(6);
%inflow(7);
%inflow(8);
%inflow(9);
%inflow(10);
%inflow(11);
%inflow(12);
%inflow(13);
%inflow(14);
%inflow(15);
%inflow(16);

data here.newflows;
merge inflow1 inflow2 inflow3 inflow4 inflow5 inflow6 inflow7 inflow8
      inflow9 inflow10 inflow11 inflow12 inflow13 inflow14 inflow15 inflow16;
inex11=inflow1;
inex12=inflow2;
inex13=inflow3;
inex14=inflow4;
inex21=inflow5;
inex22=inflow6;
inex23=inflow7;
inex24=inflow8;
inex31=inflow9;
inex32=inflow10;
inex33=inflow11;
inex34=inflow12;
inex41=inflow13;
inex42=inflow14;
inex43=inflow15;
inex44=inflow16;

innmex11=inflownm1;
innmex12=inflownm2;
innmex13=inflownm3;
innmex14=inflownm4;
innmex21=inflownm5;
innmex22=inflownm6;
innmex23=inflownm7;
innmex24=inflownm8;
innmex31=inflownm9;
innmex32=inflownm10;
innmex33=inflownm11;
innmex34=inflownm12;
innmex41=inflownm13;
innmex42=inflownm14;
innmex43=inflownm15;
innmex44=inflownm16;

array inflow (*) inflow1-inflow16;
array inflownm (*) inflownm1-inflownm16;

inall=0;
innm=0;
do j=1 to 16;
inall=inall+inflow(j);
innm=innm+inflownm(j);
end;


indrop=inex11+inex12+inex13+inex14;
inhs  =inex21+inex22+inex23+inex24;
insome=inex31+inex32+inex33+inex34;
incoll=inex41+inex42+inex43+inex44;

innmdrop=innmex11+innmex12+innmex13+innmex14;
innmhs  =innmex21+innmex22+innmex23+innmex24;
innmsome=innmex31+innmex32+innmex33+innmex34;
innmcoll=innmex41+innmex42+innmex43+innmex44;

sindrop=indrop/inall;
sinhs=inhs/inall;
sinsome=insome/inall;
sincoll=incoll/inall;
smex=(inall-innm)/inall;


keep rmsa inall indrop inhs insome incoll sindrop sinhs sinsome sincoll innm smex
              innmdrop innmhs innmsome innmcoll
              inex11 inex12 inex13 inex14 inex21 inex22 inex23 inex24 
              inex31 inex32 inex33 inex34 inex41 inex42 inex43 inex44
              innmex11 innmex12 innmex13 innmex14 innmex21 innmex22 innmex23 innmex24 
              innmex31 innmex32 innmex33 innmex34 innmex41 innmex42 innmex43 innmex44;


proc corr;
var inall sindrop sinhs sinsome sincoll smex;

proc corr;
var indrop innmdrop inhs innmhs insome innmsome incoll innmcoll;f


proc means n mean sum;

proc sort;
by descending inall;
proc print;
var rmsa inall innm smex sindrop sinhs sinsome sincoll;
