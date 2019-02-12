*read80.sas - revised by dc  july 2008;

options ls = 100 nocenter;
libname c80 '/tmp/' ;

%macro read;

%do y = 1 %to 56;
  %if (&y ne 3 and &y ne 7 and &y ne 14 and &y ne 43 and &y ne 52)
	%then %do;
	
	/* Uncompress state files */
	%if &y < 10 %then %do;
	x "gunzip -c
		/accounts/projects/card/fac4/card/data/census/1980/raw/DA8101.*0&y..gz
		> /tmp/c80&y;";
	%end;

	%else %do;
	x "gunzip -c
		/accounts/projects/card/fac4/card/data/census/1980/raw/DA8101.*&y..gz
		> /tmp/c80&y;";
	%end;

	data st&y.(drop = type p i keep rv higrad fingrad);

	/* Length statement */

	length race age citizen educ imm famrel
        state pob weeks hrswkly al_pob al_sal`
         3 ;

	infile "/tmp/c80&y.";
	input type $ 1 state 4-5 cgroup 6-8 smsa 10-13 p 26-27 gq 28 hhtype 104 
          gotkids 105;

	if p = 0 then return;


	/* Read person records */

	do i = 1 to p;

	input famrel 2-3 sex 7 age 8-9 race 12-13 hispanic 14 pob 22-24
	citizen 25 immyr 26 lang1 27 english 31 enroll 39 higrad 40-41 
        fingrad 42
        state75 47-48 esr 81 hourslw 82-83 ind 87-89 occ 90-92
        weeks 95-96 hrswkly 97-98 wagesal 101-105 selfinc 106-110
        farminc 111-115 income 134-138
        al_pob 150 al_sal 187;

       label famrel='0=hh 1=sp 2=kid 3-5=rel 7=partner/roommate'
       race='1=w 2=b 3=am ind 4-11=a 12=sp 13=oth'
       hispanic='0=not 1=mex 2=pr 3=cuban 4=oth'
       citizen='0=us born 1=nat 2=not cit 3=born abroad us parents'
       al_pob='0=pob not alloc 1-3=alloc 3=hotdeck'
       al_sal='0=wsearn not alloc 1-3=alloc 3=hotdeck' ;
       
   educ=higrad-2;
   if fingrad ne 2 then educ=educ-1;
   if educ<0 then educ=0;

   imm=(citizen in (1,2));
   rv=ranuni(9211093); 
   keep=0;
   if imm=1 then keep=1;
   else if imm=0 and rv<=.5 then keep=1;
   if keep=1 then output;

  end;

proc freq;
tables imm*state / missing;

run;	

x "/bin/rm /tmp/c80&y.;";
	
  %end;
%end;
%mend;

%macro state;
%do y = 1 %to 56;
  %if (&y ne 3 and &y ne 7 and &y ne 14 and &y ne 43 and &y ne 52)
	%then %do;
	st&y.
  %end;
%end;
%mend;

/* Run macro to read in all files */
%read;
data c80.all80;
 set %state;

proc means;

