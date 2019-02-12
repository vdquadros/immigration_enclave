*read2006.sas - reads acs 2006 and converts vars to 2000 census format;

options ls=120 nocenter;
libname here '.';

libname keep '/tmp/';
libname acs '~/data/census/acs/2006/';

data keep.acs2006;
set acs.pusa acs.pusb;
if agep>=16;


puman=0;
puman=puma;

state=0;
state=st;

pweight=pwgtp;
age=agep;
citizen=0;
citizen=cit;
label citizen='1-3=native 4=naturalized 5=noncit';

english=0;
english=eng;
label english='1=vg 2=well 3=not well 4=not';

marstat=0;
marstat=mar;
label marstat='1=marr 2=wid 3=div 4=sep 5=never';

mob1=0;
mob1=mig;
label mob1='mobility last yr 1=no 2=from abroad 3=other us';

veteran=0;
veteran=mil;
label veteran='1=active 2=active ly 3=earlier vet 4=trained 5=not';

famrel=0;
famrel=rel;
label famrel='0=ref 1=sp 2=son/dau 3=bro/sis 13-14=GQ';

enrolled=0;
enrolled=sch;
label enrolled='1 no schl 3 mo 2=pub schl/coll 3=priv sch/coll';

grade=0;
grade=schg;
label grade='grade attending 5=hs 6=coll 7=postgrad';

educ=0;
educ=schl;
label educ='educ 9=hs 10=<1yr coll 12=aa 13=ba 14=ma';

selfinc=0;
selfinc=semp;
label selfinc='self emp income last 12 mo';

female=0;
female=(sex='2');

sups_income=0;
sups_income=ssip;

ss_income=0;
ss_income=ssp;

wagesal=0;
wagesal=wagp;

hrswkly=0;
hrswkly=wkhp;

weeks=0;
weeks=wkw;

immyr=0;
immyr=yoep;
label immyr='yr of immigration';

disability=0;
disability=ds;
label disability='1=disability 2=not';

hispanic=0;
hispanic=hisp;
label hispanic='1=not 2=mex 3-24=other hisp';

class=0;
class=cow;
label class='1=priv 2=nonprof 3=loc 4=st 5=fed 6=selfun 7=selfinc ';

ind=0;
ind=substr(indp,1,3);
occ=0;
occ=substr(occp,1,3);

migstate=0;
migstate=migsp;
label migstate='state/country 1 yr ago 1-56=st 100-554=country' ;

ownchild=0;
ownchild=oc;
label ownchild='(OC) 1 if child of ref';

pearn=pernp;
pinc=pincp;
pob=0;
pob=pobp;

label paoc='1=own kid <6 2=own kids 6-17 3=own kids u/o 6 4=none';

povratio=0;
povratio=povpip;
label povratio='income/pov ratio 0-500';

qob=0;
qob=qtrbir;

race1=0;
race1=rac1p;
black=0;
black=racblk;

white=0;
white=racwht;

language=0;
language=lanp;
label language='lang at home 625=sp ';

welfare=0;
welfare=pap;
label welfare='pub asst income';

length state  
   age qob race1 black white female citizen immyr pob english 
   language marstat 
   mob1 migstate veteran famrel
   enrolled grade educ hrswkly weeks
   disability hispanic class ownchild 
   spanish employed workly ethnic poor 3;

*recodes as in bigread2;
 if disability=2 then disability=0; 
 spanish=hispanic;
 hispanic=(hispanic>1);
 inschool=(enroll>=2);
 imm=(citizen >=4);
 poor=(povratio < 100);

 *define ethnic 3=any hispanic 2=any black/nonHisp 3=asian 1=white;
  if hispanic=1 then ethnic=3;
  else if black =1 then ethnic=2;
  else if white =1 then ethnic=1;
  else ethnic=4;

 employed=(esr in ('1','2'));
 workly=(weeks>0);

keep serialno state puman 
pweight age qob race1 black white female sex citizen immyr pob english 
language marstat 
mob1 migstate veteran famrel
enrolled grade educ esr  selfinc welfare sups_income ss_income wagesal pearn pinc
hrswkly weeks
disability hispanic class ind indp occ ownchild paoc 
fcitp fpobp fwagp fsemp fschlp inschool spanish imm poor ethnic employed workly;

proc means;

proc univariate;
var pweight wagesal selfinc pinc;




proc freq;
tables state*imm imm*poor english*imm ethnic*imm  marstat*female
    age qob race1*black race1*white citizen immyr pob  
    language mob1 migstate veteran famrel
    enrolled grade educ esr disability spanish*hispanic class 
    ind occ ownchild paoc  fcitp fpobp fwagp fsemp fschlp /missing;

