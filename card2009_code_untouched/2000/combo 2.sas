
options ls=100 nocenter;
libname c90 '/tmp';
libname here '.'; 

*step2 : combine data sets and do transforms;

data c90.all2000;
set c90.ni1
    c90.ni2
    c90.ni3
    c90.ni4
    c90.ni5
    c90.ni6
    c90.ni7
    c90.ni8
    c90.ni9
    c90.ni10
    c90.ni11
    c90.ni12
    c90.ni13
    c90.ni14
    c90.ni15
    c90.ni16
    c90.ni17
    c90.ni18
    c90.ni19
    c90.ni20
    c90.ni21
    c90.ni22
    c90.ni23
    c90.ni24
    c90.ni25
    c90.ni26
    c90.ni27
    c90.ni28
    c90.ni29
    c90.ni30
    c90.ni31
    c90.ni32
    c90.ni33
    c90.ni34
    c90.ni35
    c90.ni36
    c90.ni37
    c90.ni38
    c90.ni39
    c90.ni40
    c90.ni41
    c90.ni42
    c90.ni43
    c90.ni44
    c90.ni45
    c90.ni46
    c90.ni47
    c90.ni48
    c90.ni49
    c90.ni50
    c90.ni51 ;

if imm=1 then wt=1;
else wt=2;


 length female hispanic ethnic 3;

 hispanic=(dhisp>1);
 female=(sex=2);

 *define ethnic 3=any hispanic 2=any black/nonHisp 3=asian 1=white;
  if hispanic=1 then ethnic=3;
  else if black =1 then ethnic=2;
  else if race1 in (6,7) then ethnic=4;
  else ethnic=1;

length annhrs wage1 twage1 logwage1 emp 3;

if weeks>0 and hrswkly>0 then do;
 annhrs=weeks*hrswkly;
 wage1=wagesal/annhrs;
 end;
else do;
 annhrs=0;
 wage1=.;
 end;

emp=(annhrs>0);

twage1=wage1;
if (0<wage1<3) then twage1=3;
if wage1>300 then twage1=300;
if wage1>0 then logwage1=log(twage1);


length dropout hsgrad somecoll collplus eclass 3;

dropout=(educ<=8);
hsgrad=(educ=9);
somecoll=(10<=educ<=12);
collplus=(educ>=13);
eclass=1*dropout+2*hsgrad+3*somecoll+4*collplus;


*code top 125 cities;

top125=0;
if msa=80  then top125=1;
else if msa=160  then top125=1;
else if msa=200  then top125=1;
else if msa=240  then top125=1;
else if msa=440  then top125=1;
else if msa=520  then top125=1;
else if msa=600  then top125=1;
else if msa=640  then top125=1;
else if msa=680  then top125=1;
else if msa=720  then top125=1;
else if msa=760  then top125=1;
else if msa=875  then top125=1;
else if msa=1000  then top125=1;
else if msa=1080  then top125=1;
else if msa=1120  then top125=1;
else if msa=1160  then top125=1;
else if msa=1280  then top125=1;
else if msa=1440  then top125=1;
else if msa=1520  then top125=1;
else if msa=1560  then top125=1;
else if msa=1600  then top125=1;
else if msa=1640  then top125=1;
else if msa=1680  then top125=1;
else if msa=1720  then top125=1;
else if msa=1760  then top125=1;
else if msa=1840  then top125=1;
else if msa=1920  then top125=1;
else if msa=2000  then top125=1;
else if msa=2020  then top125=1;
else if msa=2080  then top125=1;
else if msa=2120  then top125=1;
else if msa=2160  then top125=1;
else if msa=2320  then top125=1;
else if msa=2640  then top125=1;
else if msa=2680  then top125=1;
else if msa=2700  then top125=1;
else if msa=2760  then top125=1;
else if msa=2800  then top125=1;
else if msa=2840  then top125=1;
else if msa=2960  then top125=1;
else if msa=3000  then top125=1;
else if msa=3120  then top125=1;
else if msa=3160  then top125=1;
else if msa=3240  then top125=1;
else if msa=3280  then top125=1;
else if msa=3320  then top125=1;
else if msa=3360  then top125=1;
else if msa=3480  then top125=1;
else if msa=3560  then top125=1;
else if msa=3600  then top125=1;
else if msa=3640  then top125=1;
else if msa=3660  then top125=1;
else if msa=3720  then top125=1;
else if msa=3760  then top125=1;
else if msa=3840  then top125=1;
else if msa=3980  then top125=1;
else if msa=4000  then top125=1;
else if msa=4040  then top125=1;
else if msa=4120  then top125=1;
else if msa=4280  then top125=1;
else if msa=4400  then top125=1;
else if msa=4480  then top125=1;
else if msa=4520  then top125=1;
else if msa=4720  then top125=1;
else if msa=4880  then top125=1;
else if msa=4900  then top125=1;
else if msa=4920  then top125=1;
else if msa=5000  then top125=1;
else if msa=5015  then top125=1;
else if msa=5080  then top125=1;
else if msa=5120  then top125=1;
else if msa=5160  then top125=1;
else if msa=5170  then top125=1;
else if msa=5190  then top125=1;
else if msa=5360  then top125=1;
else if msa=5380  then top125=1;
else if msa=5480  then top125=1;
else if msa=5560  then top125=1;
else if msa=5600  then top125=1;
else if msa=5640  then top125=1;
else if msa=5720  then top125=1;
else if msa=5775  then top125=1;
else if msa=5880  then top125=1;
else if msa=5920  then top125=1;
else if msa=5945  then top125=1;
else if msa=5960  then top125=1;
else if msa=6080  then top125=1;
else if msa=6160  then top125=1;
else if msa=6200  then top125=1;
else if msa=6280  then top125=1;
else if msa=6440  then top125=1;
else if msa=6480  then top125=1;
else if msa=6640  then top125=1;
else if msa=6760  then top125=1;
else if msa=6780  then top125=1;
else if msa=6840  then top125=1;
else if msa=6920  then top125=1;
else if msa=7040  then top125=1;
else if msa=7160  then top125=1;
else if msa=7240  then top125=1;
else if msa=7320  then top125=1;
else if msa=7360  then top125=1;
else if msa=7400  then top125=1;
else if msa=7440  then top125=1;
else if msa=7500  then top125=1;
else if msa=7510  then top125=1;
else if msa=7560  then top125=1;
else if msa=7600  then top125=1;
else if msa=7840  then top125=1;
else if msa=8000  then top125=1;
else if msa=8120  then top125=1;
else if msa=8160  then top125=1;
else if msa=8200  then top125=1;
else if msa=8280  then top125=1;
else if msa=8400  then top125=1;
else if msa=8520  then top125=1;
else if msa=8560  then top125=1;
else if msa=8720  then top125=1;
else if msa=8735  then top125=1;
else if msa=8840  then top125=1;
else if msa=8960  then top125=1;
else if msa=9040  then top125=1;
else if msa=9160  then top125=1;
else if msa=9240  then top125=1;
else if msa=9320  then top125=1;


c=1;
length c top125 3;



proc summary;
class msa ;
var c imm dropout collplus top125;
output out=here.bymsa
mean(imm)=imm
mean(dropout)=dropout
mean(collplus)=collplus
mean(top125)=top125
sum(c)=count
sum(imm)=countimm
n(c)=nobs
n(imm)=nimm;
weight wt;

proc sort data=here.bymsa;
by descending count;

proc print data=here.bymsa;
var msa top125 count nobs imm nimm dropout collplus;
format msa 4. top125 2. count 8. nobs nimm 8. imm dropout collplus 6.4  ;

