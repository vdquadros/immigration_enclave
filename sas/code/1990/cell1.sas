*cell1 - follows np2;
*creates some summary stats by city;


options ls=120 nocenter;
libname c90 '/home/groups/sorkin/quadros/data/1990';

data nm nf im if;
set c90.np90;
ft=(annhrs>1600);
lowhrs=(annhrs<1000);

if collplus=1 and advanced=0 then college=1;
else college=0;

homey=0;

if imm=0 then do;
*code based on quantiles of pob for people born in their current SOB;
*code from home.sas;
if rmsa= 80  and pob in (39 ,39 ,39 ,39 ,39 ) then homey=1; 
if rmsa= 160  and pob in (36 ,36 ,36 ,36 ,36 ) then homey=1; 
if rmsa= 200  and pob in (35 ,35 ,35 ,35 ,35 ) then homey=1; 
if rmsa= 240  and pob in (42 ,42 ,42 ,42 ,42 ) then homey=1; 
if rmsa= 440  and pob in (26 ,26 ,26 ,26 ,26 ) then homey=1; 
if rmsa= 520  and pob in (13 ,13 ,13 ,13 ,13 ) then homey=1; 
if rmsa= 600  and pob in (13 ,13 ,13 ,45 ,45 ) then homey=1; 
if rmsa= 640  and pob in (48 ,48 ,48 ,48 ,48 ) then homey=1; 
if rmsa= 680  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 720  and pob in (24 ,24 ,24 ,24 ,24 ) then homey=1; 
if rmsa= 760  and pob in (22 ,22 ,22 ,22 ,22 ) then homey=1; 
if rmsa= 875  and pob in (34 ,34 ,34 ,34 ,34 ) then homey=1; 
if rmsa= 1000  and pob in (1 ,1 ,1 ,1 ,1 ) then homey=1; 
if rmsa= 1080  and pob in (16 ,16 ,16 ,16 ,16 ) then homey=1; 
if rmsa= 1120  and pob in (25 ,25 ,25 ,25 ,25 ) then homey=1; 
if rmsa= 1160  and pob in (9 ,9 ,9 ,9 ,9 ) then homey=1; 
if rmsa= 1280  and pob in (36 ,36 ,36 ,36 ,36 ) then homey=1; 
if rmsa= 1440  and pob in (45 ,45 ,45 ,45 ,45 ) then homey=1; 
if rmsa= 1520  and pob in (37 ,37 ,37 ,37 ,45 ) then homey=1; 
if rmsa= 1560  and pob in (13 ,47 ,47 ,47 ,47 ) then homey=1; 
if rmsa= 1600  and pob in (17 ,17 ,17 ,17 ,17 ) then homey=1; 
if rmsa= 1640  and pob in (21 ,39 ,39 ,39 ,39 ) then homey=1; 
if rmsa= 1680  and pob in (39 ,39 ,39 ,39 ,39 ) then homey=1; 
if rmsa= 1720  and pob in (8 ,8 ,8 ,8 ,8 ) then homey=1; 
if rmsa= 1760  and pob in (45 ,45 ,45 ,45 ,45 ) then homey=1; 
if rmsa= 1840  and pob in (39 ,39 ,39 ,39 ,39 ) then homey=1; 
if rmsa= 1920  and pob in (48 ,48 ,48 ,48 ,48 ) then homey=1; 
if rmsa= 2000  and pob in (39 ,39 ,39 ,39 ,39 ) then homey=1; 
if rmsa= 2020  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 2080  and pob in (8 ,8 ,8 ,8 ,8 ) then homey=1; 
if rmsa= 2120  and pob in (19 ,19 ,19 ,19 ,19 ) then homey=1; 
if rmsa= 2160  and pob in (26 ,26 ,26 ,26 ,26 ) then homey=1; 
if rmsa= 2320  and pob in (48 ,48 ,48 ,48 ,48 ) then homey=1; 
if rmsa= 2640  and pob in (26 ,26 ,26 ,26 ,26 ) then homey=1; 
if rmsa= 2680  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 2700  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 2760  and pob in (18 ,18 ,18 ,18 ,18 ) then homey=1; 
if rmsa= 2800  and pob in (48 ,48 ,48 ,48 ,48 ) then homey=1; 
if rmsa= 2840  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 2960  and pob in (18 ,18 ,18 ,18 ,18 ) then homey=1; 
if rmsa= 3000  and pob in (26 ,26 ,26 ,26 ,26 ) then homey=1; 
if rmsa= 3120  and pob in (37 ,37 ,37 ,37 ,37 ) then homey=1; 
if rmsa= 3160  and pob in (45 ,45 ,45 ,45 ,45 ) then homey=1; 
if rmsa= 3240  and pob in (42 ,42 ,42 ,42 ,42 ) then homey=1; 
if rmsa= 3280  and pob in (9 ,9 ,9 ,9 ,9 ) then homey=1; 
if rmsa= 3320  and pob in (15 ,15 ,15 ,15 ,15 ) then homey=1; 
if rmsa= 3360  and pob in (48 ,48 ,48 ,48 ,48 ) then homey=1; 
if rmsa= 3480  and pob in (18 ,18 ,18 ,18 ,18 ) then homey=1; 
if rmsa= 3560  and pob in (28 ,28 ,28 ,28 ,28 ) then homey=1; 
if rmsa= 3600  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 3640  and pob in (34 ,34 ,34 ,34 ,34 ) then homey=1; 
if rmsa= 3660  and pob in (47 ,47 ,47 ,51 ,51 ) then homey=1; 
if rmsa= 3720  and pob in (26 ,26 ,26 ,26 ,26 ) then homey=1; 
if rmsa= 3760  and pob in (20 ,29 ,29 ,29 ,29 ) then homey=1; 
if rmsa= 3840  and pob in (47 ,47 ,47 ,47 ,47 ) then homey=1; 
if rmsa= 3980  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 4000  and pob in (42 ,42 ,42 ,42 ,42 ) then homey=1; 
if rmsa= 4040  and pob in (26 ,26 ,26 ,26 ,26 ) then homey=1; 
if rmsa= 4120  and pob in (4 ,32 ,32 ,32 ,32 ) then homey=1; 
if rmsa= 4280  and pob in (21 ,21 ,21 ,21 ,21 ) then homey=1; 
if rmsa= 4400  and pob in (5 ,5 ,5 ,5 ,5 ) then homey=1; 
if rmsa= 4480  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 4520  and pob in (18 ,21 ,21 ,21 ,21 ) then homey=1; 
if rmsa= 4720  and pob in (55 ,55 ,55 ,55 ,55 ) then homey=1; 
if rmsa= 4880  and pob in (48 ,48 ,48 ,48 ,48 ) then homey=1; 
if rmsa= 4900  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 4920  and pob in (28 ,47 ,47 ,47 ,47 ) then homey=1; 
if rmsa= 5000  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 5015  and pob in (34 ,34 ,34 ,34 ,34 ) then homey=1; 
if rmsa= 5080  and pob in (55 ,55 ,55 ,55 ,55 ) then homey=1; 
if rmsa= 5120  and pob in (27 ,27 ,27 ,27 ,27 ) then homey=1; 
if rmsa= 5160  and pob in (1 ,1 ,1 ,1 ,1 ) then homey=1; 
if rmsa= 5170  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 5190  and pob in (34 ,34 ,34 ,34 ,34 ) then homey=1; 
if rmsa= 5360  and pob in (47 ,47 ,47 ,47 ,47 ) then homey=1; 
if rmsa= 5380  and pob in (36 ,36 ,36 ,36 ,36 ) then homey=1; 
if rmsa= 5480  and pob in (9 ,9 ,9 ,9 ,9 ) then homey=1; 
if rmsa= 5560  and pob in (22 ,22 ,22 ,22 ,22 ) then homey=1; 
if rmsa= 5600  and pob in (36 ,36 ,36 ,36 ,36 ) then homey=1; 
if rmsa= 5640  and pob in (34 ,34 ,34 ,34 ,34 ) then homey=1; 
if rmsa= 5720  and pob in (51 ,51 ,51 ,51 ,51 ) then homey=1; 
if rmsa= 5775  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 5880  and pob in (40 ,40 ,40 ,40 ,40 ) then homey=1; 
if rmsa= 5920  and pob in (31 ,31 ,31 ,31 ,31 ) then homey=1; 
if rmsa= 5945  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 5960  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 6080  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 6160  and pob in (34 ,42 ,42 ,42 ,42 ) then homey=1; 
if rmsa= 6200  and pob in (4 ,4 ,4 ,4 ,4 ) then homey=1; 
if rmsa= 6280  and pob in (42 ,42 ,42 ,42 ,42 ) then homey=1; 
if rmsa= 6440  and pob in (41 ,41 ,41 ,41 ,53 ) then homey=1; 
if rmsa= 6480  and pob in (25 ,44 ,44 ,44 ,44 ) then homey=1; 
if rmsa= 6640  and pob in (37 ,37 ,37 ,37 ,37 ) then homey=1; 
if rmsa= 6760  and pob in (51 ,51 ,51 ,51 ,51 ) then homey=1; 
if rmsa= 6780  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 6840  and pob in (36 ,36 ,36 ,36 ,36 ) then homey=1; 
if rmsa= 6920  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 7040  and pob in (17 ,17 ,29 ,29 ,29 ) then homey=1; 
if rmsa= 7160  and pob in (49 ,49 ,49 ,49 ,49 ) then homey=1; 
if rmsa= 7240  and pob in (48 ,48 ,48 ,48 ,48 ) then homey=1; 
if rmsa= 7320  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 7360  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 7400  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 7500  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 7510  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 7560  and pob in (42 ,42 ,42 ,42 ,42 ) then homey=1; 
if rmsa= 7600  and pob in (53 ,53 ,53 ,53 ,53 ) then homey=1; 
if rmsa= 7840  and pob in (53 ,53 ,53 ,53 ,53 ) then homey=1; 
if rmsa= 8000  and pob in (25 ,25 ,25 ,25 ,25 ) then homey=1; 
if rmsa= 8120  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 8160  and pob in (36 ,36 ,36 ,36 ,36 ) then homey=1; 
if rmsa= 8200  and pob in (53 ,53 ,53 ,53 ,53 ) then homey=1; 
if rmsa= 8280  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 8400  and pob in (39 ,39 ,39 ,39 ,39 ) then homey=1; 
if rmsa= 8520  and pob in (4 ,4 ,4 ,4 ,4 ) then homey=1; 
if rmsa= 8560  and pob in (40 ,40 ,40 ,40 ,40 ) then homey=1; 
if rmsa= 8720  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 8735  and pob in (6 ,6 ,6 ,6 ,6 ) then homey=1; 
if rmsa= 8840  and pob in (11 ,24 ,24 ,51 ,54 ) then homey=1; 
if rmsa= 8960  and pob in (12 ,12 ,12 ,12 ,12 ) then homey=1; 
if rmsa= 9040  and pob in (20 ,20 ,20 ,20 ,20 ) then homey=1; 
if rmsa= 9160  and pob in (10 ,10 ,10 ,10 ,24 ) then homey=1; 
if rmsa= 9240  and pob in (25 ,25 ,25 ,25 ,25 ) then homey=1; 
if rmsa= 9320  and pob in (39 ,39 ,39 ,39 ,39 ) then homey=1; 
end;

if rmsa in (0,1) then homey=nonmover;

rmsa0=(rmsa=0);
rmsa1=(rmsa=1);
homey_0=(rmsa=0 and homey=1);
homey_1=(rmsa=1 and homey=1);

if imm=0 and female=0 then output nm;
if imm=0 and female=1 then output nf;
if imm=1 and female=0 then output im;
if imm=1 and female=1 then output if;

proc means data=nm;
var imm female logwage2 educ exp rmsa0 rmsa1 homey nonmover;
weight wt;
proc means data=nf;
var imm female logwage2 educ exp rmsa0 rmsa1 homey nonmover;
weight wt;
proc means data=im;
var imm female logwage2 educ exp rmsa0 rmsa1;
weight wt;
proc means data=if;
var imm female logwage2 educ exp rmsa0 rmsa1;
weight wt;

***models DO NOT include msa effects but include dummies for rmsa=0,1 ;


proc glm data=nm;
class eclass xclass homey;
model logwage2=exp exp2 exp3 educ eclass*xclass inschool advanced 
      ft lowhrs 
   hisp_ed hisp_coll black_ed black_coll  asian_ed asian_coll 
   homey*eclass rmsa0 rmsa1 / solution;
output out=nm2 predicted=pred residual=res;
weight wt;

proc glm data=nf;
class eclass xclass homey;
model logwage2=exp exp2 exp3 educ eclass*xclass inschool advanced 
      ft lowhrs 
   hisp_ed hisp_coll black_ed black_coll  asian_ed asian_coll 
   homey*eclass rmsa0 rmsa1 / solution;
output out=nf2 predicted=pred residual=res;
weight wt;

proc glm data=im;
class ic eclass xclass ;
model logwage2=exp exp2 exp3 educ eclass*xclass inschool advanced
    ft lowhrs mex_ed mex_coll euro_ed euro_coll hisp_ed hisp_coll 
    hi_asian_ed hi_asian_coll mid_asian_ed mid_asian_coll
    ic ic*yrsinus ic*yrsinus2 rmsa0 rmsa1 / solution;
output out=im2 predicted=pred residual=res;
weight wt;

proc glm data=if;
class ic eclass xclass ;
model logwage2=exp exp2 exp3 educ eclass*xclass inschool advanced
    ft lowhrs mex_ed mex_coll euro_ed euro_coll hisp_ed hisp_coll 
    hi_asian_ed hi_asian_coll mid_asian_ed mid_asian_coll
    ic ic*yrsinus ic*yrsinus2 rmsa0 rmsa1 / solution;
output out=if2 predicted=pred residual=res;
weight wt;


data two;
set nm2 nf2 im2 if2;

male=1-female;
native=1-imm;

lw2sq=logwage2**2;
ressq=res**2;
predsq=pred**2;
respred=res*pred;



if exp<=10 then xclass2=1;
else if exp<=20 then xclass2=2;
else if exp<=30 then xclass2=3;
else xclass2=4;
c=1;

hs=1-dropout-somecoll-collplus;
if collplus=1 and advanced=0 then college=1;
else college=0;




proc corr;
var logwage2 pred res educ exp imm female;
weight wt;


proc means;
var dropout hs somecoll college advanced collplus;
weight wt;


proc summary;
class rmsa native male eclass xclass2;
var logwage2 lw2sq res ressq pred predsq respred imm female educ exp c
      dropout hs somecoll college advanced collplus ;
output out=c90.bigcells
mean=
sum(c)=count;
weight wt;

data check1;
set c90.bigcells;
if native=. and male=. and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;

proc print;
var rmsa count imm logwage2 v res vres pred vpred;

proc corr;
where (rmsa>3);
var v vres imm educ exp;
weight count;

data check2;
set c90.bigcells;
if rmsa=. and native=1 and male=1 and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;

proc print;
var rmsa count imm logwage2 v res vres pred vpred;


data check3;
set c90.bigcells;
if rmsa=. and native=1 and male=0 and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;

proc print;
var rmsa count imm logwage2 v res vres pred vpred;


data check4;
set c90.bigcells;
if rmsa=. and native=0 and male=1 and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;


proc print;
var rmsa count imm logwage2 v res vres pred vpred;


data check5;
set c90.bigcells;
if rmsa=. and native=0 and male=0 and eclass=. and xclass2=.;
v=lw2sq-logwage2**2;
vres=ressq-res*res;
vpred=predsq-pred*pred;


proc print;
var rmsa count imm logwage2 v res vres pred vpred;
proc corr;
where (rmsa>3);
var v vres imm educ exp;
weight count;


