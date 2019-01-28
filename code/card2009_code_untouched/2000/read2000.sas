*read 2000 census;
*5pct file in raw form;
*keep all imms and 1/2 of natives;

options ls = 100 nocenter;
libname c90 '/tmp';



%macro read;

%do y =1  %to 51;

x "gunzip -c /accounts/fac/card/data/census/2000/data/s&y..dat.gz
  > /tmp/s&y..dat;";

data c90.ni&y. ;
infile "/tmp/s&y..dat" lrecl =316;

*read h record;


length state pumatype nperson gq 3;


input type $ 1 hhid 2-8 state 10-11 puma 14-18 msa 28-31
       pumatype 40-41 nperson 106-107 gq 108;

*assign msa to 9997 and 9998 cases - dc code feb 12 2004;
*note this also (roughly) assigns necmas in new england;
*though the codes are still msa/pmsa not necma;
if state=1   and puma=800  then msa=1000 ;
if state=4   and puma=600  then msa=4120 ;
if state=4   and puma=800  then msa=6200 ;
if state=5   and puma=1600  then msa=6240 ;
if state=6   and puma=3002  then msa=7120 ;
if state=8   and puma=801  then msa=2080 ;
if state=8   and puma=804  then msa=1125 ;
if state=9   and puma=200  then msa=3280 ;
if state=9   and puma=900  then msa=3280 ;
if state=9   and puma=1100  then msa=5520 ;
if state=9   and puma=1200  then msa=5520 ;
if state=9   and puma=1300  then msa=3280 ;
if state=9   and puma=1400  then msa=8880 ;
if state=9   and puma=1600  then msa=5480 ;
if state=9   and puma=1700  then msa=5480 ;
if state=13   and puma=800  then msa=520 ;
if state=17   and puma=102  then msa=1960 ;
if state=17   and puma=1400  then msa=7880 ;
if state=17   and puma=2600  then msa=1600 ;
if state=17   and puma=2700  then msa=6880 ;
if state=20   and puma=700  then msa=4150 ;
if state=21   and puma=300  then msa=1660 ;
if state=21   and puma=1100  then msa=4280 ;
if state=21   and puma=1600  then msa=5990 ;
if state=21   and puma=1800  then msa=4520 ;
if state=21   and puma=2200  then msa=3400 ;
if state=21   and puma=2500  then msa=1640 ;
if state=22   and puma=1200  then msa=3880 ;
if state=22   and puma=2001  then msa=5560 ;
if state=22   and puma=2100  then msa=3350 ;
if state=23   and puma=700  then msa=4240 ;
if state=23   and puma=900  then msa=730 ;
if state=24   and puma=100  then msa=1900 ;
if state=24   and puma=700  then msa=9160 ;
if state=25   and puma=100  then msa=6320 ;
if state=25   and puma=1500  then msa=9240 ;
if state=25   and puma=2100  then msa=9240 ;
if state=26   and puma=1700  then msa=3000 ;
if state=26   and puma=2302  then msa=2640 ;
if state=26   and puma=3000  then msa=440 ;
if state=30   and puma=200  then msa=3040 ;
if state=30   and puma=700  then msa=5140 ;
if state=33   and puma=300  then msa=6450 ;
if state=33   and puma=600  then msa=5350 ;
if state=33   and puma=700  then msa=4760 ;
if state=33   and puma=1000  then msa=4160 ;
if state=33   and puma=1100  then msa=6450 ;
if state=36   and puma=1200  then msa=6840 ;
if state=36   and puma=2700  then msa=2335 ;
if state=38   and puma=500  then msa=2985 ;
if state=39   and puma=2400  then msa=8080 ;
if state=39   and puma=2800  then msa=1840 ;
if state=39   and puma=3500  then msa=6020 ;
if state=40   and puma=400  then msa=4200 ;
if state=40   and puma=1600  then msa=5880 ;
if state=40   and puma=1700  then msa=5880 ;
if state=41   and puma=1200  then msa=6440 ;
if state=42   and puma=2202  then msa=6280 ;
if state=44   and puma=500  then msa=6480 ;
if state=44   and puma=700  then msa=6480 ;
if state=45   and puma=100  then msa=3160 ;
if state=45   and puma=1600  then msa=2655 ;
if state=45   and puma=2000  then msa=1440 ;
if state=46   and puma=100  then msa=6660 ;
if state=47   and puma=1200  then msa=3840 ;
if state=47   and puma=3000  then msa=4920 ;
if state=48   and puma=800  then msa=7640 ;
if state=48   and puma=900  then msa=1920 ;
if state=48   and puma=1100  then msa=8360 ;
if state=48   and puma=1800  then msa=1920 ;
if state=48   and puma=3000  then msa=7200 ;
if state=48   and puma=5100  then msa=640 ;
if state=48   and puma=6200  then msa=8750 ;
if state=48   and puma=6301  then msa=1880 ;
if state=50   and puma=100  then msa=1305 ;
if state=51   and puma=2600  then msa=3660 ;
if state=54   and puma=100  then msa=9000 ;
if state=54   and puma=400  then msa=8840 ;
if state=54   and puma=600  then msa=6020 ;
if state=54   and puma=700  then msa=3400 ;
if state=54   and puma=800  then msa=1480 ;
if state=56   and puma=200  then msa=1350 ;
if state=56   and puma=400  then msa=1580 ;

 if nperson = 0 then return;
 else do i = 1 to nperson;




 input type $ 1 pweight 13-16 famrel 17-18 ownchild 20 paoc 22
       sex 23 age 25-26 age_alloc 27 dhisp 28-29
       numrace 31 white 32 black 33 race1 38
       marstat 44 enroll 49
       grade 51 educ 53-54 educ_alloc 55 english 70
       pob 72-74 citizen 76 immyr 78-81 mob5 83
       esr 154 ind 211-213
       occ 223-225 class 234 workly 236 weeks 238-239
       hrswkly 241-242 hrswk_alloc 243
       wagesal 244-249 ws_alloc 250 selfinc 251-256
       self_alloc pinc 297-303 totearn 305-311 ;


 length famrel ownchild paoc sex age age_alloc dhisp 
       numrace white black race1
       marstat enroll grade educ x_alloc english 
       pob citizen immyr mob5 esr 
       class workly weeks hrswkly hrswk_alloc 
       ws_alloc self_alloc 3;


 if type ne 'P' then do;
  put 'Not person' _N_ type=;
  abort;
 end;

 imm=(citizen >=4);


 rv=ranuni(8855111);

 if imm=1 then keep=1;
 else if imm=0 and rv<=.5 then keep=1;
 else keep=0;
 if (keep=1 and (16<=age)) then output;
end;

proc freq;
tables msa*state;


proc means;
   

x "/bin/rm /tmp/s&y..dat;";
%end;
%mend;


%read;
