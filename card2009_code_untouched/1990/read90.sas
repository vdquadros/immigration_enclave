*read90.sas - reads 1990 files HH and GQ from ICPSR;
*note that pairs of files are uncompressed, concatenated, then read by sas;


options ls = 100 nocenter;
libname c90 '/tmp/' ;

%macro read;

%do y = 1 %to 56;
  %if (&y ne 3 and &y ne 7 and &y ne 14 and &y ne 43 and &y ne 52)
	%then %do;
	
	/* Uncompress files and catenate */
	%if &y < 10 %then %do;
	x "nice gunzip -c 
          /accounts/fac/card/data/census/1990/data/hh0&y..txt.gz
		> /tmp/c90hh&y;";
	x "nice gunzip -c 
          /accounts/fac/card/data/census/1990/data/gq0&y..txt.gz
		> /tmp/c90gq&y;";
        %end;

	%else %do;
	x "nice gunzip -c 
          /accounts/fac/card/data/census/1990/data/hh&y..txt.gz
		> /tmp/c90hh&y;";
	x "nice gunzip -c 
          /accounts/fac/card/data/census/1990/data/gq&y..txt.gz
	     	> /tmp/c90gq&y;";
	%end;

        x "cat /tmp/c90hh&y. /tmp/c90gq&y. > /tmp/c90all&y;";


	data st&y.(drop = type p i rv keep );

	/* Length statement */

	length state famrel sex race age marstat dfamrel dhisp pob 
          imm hispanic citizen immyr enroll grade state85 
          lang1 english esr hourslw weeks hrswkly al_pob al_sal
           3 ;

	infile "/tmp/c90all&y.";
	input type $ 1 state 11-12 puma 13-17 msa 20-23
            p 33-34 gqinst 35 ;

	/* Check that this is a hh record */
	if type ne 'H' then do;
		put 'Not household' _N_ type=;
		abort;
	end;

	/* Check if there are no people in this household */
	/* If no people then return to next record */
	else if p = 0 then return;


	/* Read person records */
	else do i = 1 to p;
		input p1 $1  @;

	/* Check that this is a person record */
	if p1 ne 'P' then do;
		put 'invalid type' _N_ p1=;
		abort;
	end;

       else do;

	input famrel 9-10 sex 11 race 12-14 age 15-16 marstat 17
        pwgt 18-21 dfamrel 35 dhisp 38-40  pob 44-46
	citizen 47 immyr 48-49 enroll 50 grade 51-52 state85 60-61
        lang1 67 english 71 esr 91 hourslw 93-94
        ind 115-117 occ 118-120 weeks 123-124 hrswkly 125-126 
        totearn 127-132 income 133-138 wagesal 139-144
        selfinc 145-150 farminc 151-156 
        al_pob 190 al_sal 224;

        imm=(citizen in (3,4));
        if dhisp=0 or (6<=dhisp<=199) then hispanic=0;
          else hispanic=1;
        rv=ranuni(9211093);
        keep=0;
        if imm=1 then keep=1; else if imm=0 and rv<=.5 then keep=1;
        if keep=1 then output;
                 
	end;


	end; /* end over i */




proc means;
var state imm age wagesal weeks hrswkly;

proc freq;
tables msa*gqinst / missing;

run;	

x "/bin/rm /tmp/c90hh&y.;";
x "/bin/rm /tmp/c90gq&y.;";
x "/bin/rm /tmp/c90all&y.;";

	
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


data c90.all90;
 set %state;

proc freq;
tables gqinst state msa / missing;


