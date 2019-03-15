
replace smsa = 0 if smsa == 9999
*step1 - use smsa-recodes from cg1.sas reading county eq files;
*short version drops all 9999 assignments

replace smsa=2650 if  statefip==1 & cgroup==1 
replace smsa=1000 if  statefip==1 & cgroup==8 
replace smsa=5160 if  statefip==1 & cgroup==21 
replace smsa=2720 if  statefip==5 & cgroup==13 
replace smsa=6240 if  statefip==5 & cgroup==16 
replace smsa=9340 if  statefip==6 & cgroup==6 
replace smsa=6780 if  statefip==6 & cgroup==50 
replace smsa=8040 if  statefip==9 & cgroup==2 
replace smsa=5480 if  statefip==9 & cgroup==8 
replace smsa=5480 if  statefip==9 & cgroup==9 
replace smsa=3280 if  statefip==9 & cgroup==19 
replace smsa=1170 if  statefip==9 & cgroup==21 
replace smsa=8880 if  statefip==9 & cgroup==23 
replace smsa=6015 if  statefip==12 & cgroup==3 
replace smsa=5000 if  statefip==12 & cgroup==53 
replace smsa=520  if  statefip==13 & cgroup==10 
replace smsa=4680 if  statefip==13 & cgroup==13 
replace smsa=1020 if  statefip==18 & cgroup==27 
replace smsa=8320 if  statefip==18 & cgroup==29 
replace smsa=2440 if  statefip==18 & cgroup==31 
replace smsa=4520 if  statefip==18 & cgroup==34 
replace smsa=4520 if  statefip==18 & cgroup==35 
replace smsa=3500 if  statefip==19 & cgroup==13 
replace smsa=4150 if  statefip==20 & cgroup==15 
replace smsa=1640 if  statefip==21 & cgroup==2 
replace smsa=4520 if  statefip==21 & cgroup==5 
replace smsa=4280 if  statefip==21 & cgroup==8 
replace smsa=3400 if  statefip==21 & cgroup==11 
replace smsa=1660 if  statefip==21 & cgroup==22 
replace smsa=3960 if  statefip==22 & cgroup==8 
replace smsa=5560 if  statefip==22 & cgroup==25 
replace smsa=1900 if  statefip==24 & cgroup==1 
replace smsa=9240 if  statefip==25 & cgroup==9 
replace smsa=2600 if  statefip==25 & cgroup==10 
replace smsa=4560 if  statefip==25 & cgroup==11 
replace smsa=1120 if  statefip==25 & cgroup==15 
replace smsa=1120 if  statefip==25 & cgroup==26 
replace smsa=1200 if  statefip==25 & cgroup==32 
replace smsa=2640 if  statefip==26 & cgroup==24 
replace smsa=3720 if  statefip==26 & cgroup==26 
replace smsa=6820 if  statefip==27 & cgroup==13 
replace smsa=6980 if  statefip==27 & cgroup==25 
replace smsa=3560 if  statefip==28 & cgroup==10 
replace smsa=5920 if  statefip==31 & cgroup==7 
replace smsa=5350 if  statefip==33 & cgroup==3 
replace smsa=4100 if  statefip==35 & cgroup==7 
replace smsa=8160 if  statefip==36 & cgroup==16 
replace smsa=6840 if  statefip==36 & cgroup==21 
replace smsa=6460 if  statefip==36 & cgroup==34 
replace smsa=480 if  statefip==37  & cgroup==2 
replace smsa=1300 if  statefip==37 & cgroup==13 
replace smsa=6640 if  statefip==37 & cgroup==19 
replace smsa=1010 if  statefip==38 & cgroup==2 
replace smsa=2520 if  statefip==38 & cgroup==4 
replace smsa=8080 if  statefip==39 & cgroup==38 
replace smsa=9000 if  statefip==39 & cgroup==39 
replace smsa=3400 if  statefip==39 & cgroup==59 
replace smsa=6020 if  statefip==39 & cgroup==61 
replace smsa=6480 if  statefip==44 & cgroup==4 
replace smsa=3160 if  statefip==45 & cgroup==2 
replace smsa=1660 if  statefip==47 & cgroup==7 
replace smsa=3660 if  statefip==47 & cgroup==27 
replace smsa=5040 if  statefip==48 & cgroup==28 
replace smsa=7200 if  statefip==48 & cgroup==29 
replace smsa=4080 if  statefip==48 & cgroup==34 
replace smsa=7240 if  statefip==48 & cgroup==42 
replace smsa=1260 if  statefip==48 & cgroup==50 
replace smsa=3360 if  statefip==48 & cgroup==64 
replace smsa=9000 if  statefip==54 & cgroup==1 
replace smsa=6020 if  statefip==54 & cgroup==4 
replace smsa=1480 if  statefip==54 & cgroup==9 
replace smsa=3870 if  statefip==55 & cgroup==14 

*step 2 -- h& entered fixups for top 125 cities
*start by assigning all smas to msa=2000 version
gen msa=smsa

replace msa=200 if statefip==35 & cgroup==6 
replace msa=9999 if statefip==34 & msa==240 
replace msa=240 if statefip==26 & inlist(cgroup,32,58) 
replace msa=520 if statefip==13 & inlist(cgroup,2,10) 
replace msa=875 if statefip==34 & (1<=cgroup & cgroup<=9) 
replace msa=1080 if statefip==16 & cgroup==2 
replace msa=1160 if statefip==9 & cgroup==6 
replace msa=1520 if statefip==37 & cgroup==39 
replace msa=1520 if statefip==45 & cgroup==6  
replace msa=1600 if statefip==17 & cgroup==4 
replace msa=1640 if statefip==21 & cgroup==2 
replace msa=1680 if msa==4440 

replace msa=2800 if statefip==48 & inlist(cgroup,21,25) 
replace msa=2000 if statefip==39 & cgroup==45 
replace msa=1125 if statefip==8 & cgroup==10 
replace msa=2760 if statefip==18 & cgroup==12 
replace msa=3000 if statefip==26 & cgroup==12 
replace msa=3120 if statefip==37 & inlist(cgroup,13,7) 
replace msa=3160 if statefip==45 & cgroup==1 
replace msa=3240 if statefip==42 & cgroup==45 
replace msa=3280 if inlist(msa, 1170,5440) 
replace msa=3280 if statefip==9 & cgroup==11 
replace msa=1145 if statefip==48 & cgroup==62 
replace msa=3480 if statefip==18 & cgroup==20 
replace msa=3560 if statefip==28 & cgroup==1  

replace msa=3270 if statefip==26 & cgroup==29 
replace msa=4400 if statefip==5 & cgroup==7  
replace msa=4520 if statefip==18 & inlist(cgroup,34,35) 
replace msa=5015 if statefip==34 & inlist(cgroup,26,27,28,29,30,31,51) 
replace msa=5120 if statefip==27 & cgroup==25 
replace msa=5190 if statefip==34 & (32<=cgroup & cgroup<=37) 
replace msa=5480 if statefip==9 & inlist(cgroup,8,9) 
replace msa=5560 if statefip==22 & inlist(cgroup,19,25) 

replace msa=5720 if statefip==51 & inlist(cgroup,20,21) 
replace msa=5775 if statefip==6 & inlist(cgroup,16,17,18) 
replace msa=5920 if statefip==31 & cgroup==7  
replace msa=5945 if msa==360 
replace msa=5960 if statefip==12 & cgroup==13 
replace msa=6200 if statefip==4 & cgroup==7  
replace msa=6280 if statefip==42 & inlist(cgroup,21,34) 
replace msa=6440 if statefip==41 & cgroup==7  
replace msa=6480 if statefip==44 & cgroup==4  
replace msa=6480 if statefip==25 & inlist(cgroup,34,35) 
replace msa=6480 if msa==2480 
replace msa=6640 if statefip==37 & inlist(cgroup,19,20) 
replace msa=6760 if msa==6140 
replace msa=6840 if statefip==36 & cgroup==22 

replace msa=9999 if statefip==6 & cgroup==11 
replace msa=6920 if statefip==6 & cgroup==7  
replace msa=7240 if statefip==48 & cgroup==42 
replace msa=7510 if msa==1140 
replace msa=7560 if msa==5745 
replace msa=8000 if statefip==25 & cgroup==2  
replace msa=8160 if statefip==36 & cgroup==18 
replace msa=9999 if statefip==26 & cgroup==33 
replace msa=8735 if msa==6000 
replace msa=8840 if statefip==51 & inlist(cgroup,2,27) 
replace msa=9240 if statefip==25 & cgroup==7  
replace msa=9320 if statefip==39 & cgroup==26 
replace msa=1120 if statefip==25 & inlist(cgroup,15,25) 

*identreplace top125=1 ify top 125 cities
gen top125=0
replace top125=1 if msa==80
replace top125=1 if msa==160
replace top125=1 if msa==200
replace top125=1 if msa==240
replace top125=1 if msa==440
replace top125=1 if msa==520
replace top125=1 if msa==600
replace top125=1 if msa==640
replace top125=1 if msa==680
replace top125=1 if msa==720
replace top125=1 if msa==760
replace top125=1 if msa==875
replace top125=1 if msa==1000
replace top125=1 if msa==1080
replace top125=1 if msa==1120
replace top125=1 if msa==1160
replace top125=1 if msa==1280
replace top125=1 if msa==1440
replace top125=1 if msa==1520
replace top125=1 if msa==1560
replace top125=1 if msa==1600
replace top125=1 if msa==1640
replace top125=1 if msa==1680
replace top125=1 if msa==1720
replace top125=1 if msa==1760
replace top125=1 if msa==1840
replace top125=1 if msa==1920
replace top125=1 if msa==2000
replace top125=1 if msa==2020
replace top125=1 if msa==2080
replace top125=1 if msa==2120
replace top125=1 if msa==2160
replace top125=1 if msa==2320
replace top125=1 if msa==2640
replace top125=1 if msa==2680
replace top125=1 if msa==2700
replace top125=1 if msa==2760
replace top125=1 if msa==2800
replace top125=1 if msa==2840
replace top125=1 if msa==2960
replace top125=1 if msa==3000
replace top125=1 if msa==3120
replace top125=1 if msa==3160
replace top125=1 if msa==3240
replace top125=1 if msa==3280
replace top125=1 if msa==3320
replace top125=1 if msa==3360
replace top125=1 if msa==3480
replace top125=1 if msa==3560
replace top125=1 if msa==3600
replace top125=1 if msa==3640
replace top125=1 if msa==3660
replace top125=1 if msa==3720
replace top125=1 if msa==3760
replace top125=1 if msa==3840
replace top125=1 if msa==3980
replace top125=1 if msa==4000
replace top125=1 if msa==4040
replace top125=1 if msa==4120
replace top125=1 if msa==4280
replace top125=1 if msa==4400
replace top125=1 if msa==4480
replace top125=1 if msa==4520
replace top125=1 if msa==4720
replace top125=1 if msa==4880
replace top125=1 if msa==4900
replace top125=1 if msa==4920
replace top125=1 if msa==5000
replace top125=1 if msa==5015
replace top125=1 if msa==5080
replace top125=1 if msa==5120
replace top125=1 if msa==5160
replace top125=1 if msa==5170
replace top125=1 if msa==5190
replace top125=1 if msa==5360
replace top125=1 if msa==5380
replace top125=1 if msa==5480
replace top125=1 if msa==5560
replace top125=1 if msa==5600
replace top125=1 if msa==5640
replace top125=1 if msa==5720
replace top125=1 if msa==5775
replace top125=1 if msa==5880
replace top125=1 if msa==5920
replace top125=1 if msa==5945
replace top125=1 if msa==5960
replace top125=1 if msa==6080
replace top125=1 if msa==6160
replace top125=1 if msa==6200
replace top125=1 if msa==6280
replace top125=1 if msa==6440
replace top125=1 if msa==6480
replace top125=1 if msa==6640
replace top125=1 if msa==6760
replace top125=1 if msa==6780
replace top125=1 if msa==6840
replace top125=1 if msa==6920
replace top125=1 if msa==7040
replace top125=1 if msa==7160
replace top125=1 if msa==7240
replace top125=1 if msa==7320
replace top125=1 if msa==7360
replace top125=1 if msa==7400
replace top125=1 if msa==7440
replace top125=1 if msa==7500
replace top125=1 if msa==7510
replace top125=1 if msa==7560
replace top125=1 if msa==7600
replace top125=1 if msa==7840
replace top125=1 if msa==8000
replace top125=1 if msa==8120
replace top125=1 if msa==8160
replace top125=1 if msa==8200
replace top125=1 if msa==8280
replace top125=1 if msa==8400
replace top125=1 if msa==8520
replace top125=1 if msa==8560
replace top125=1 if msa==8720
replace top125=1 if msa==8735
replace top125=1 if msa==8840
replace top125=1 if msa==8960
replace top125=1 if msa==9040
replace top125=1 if msa==9160
replace top125=1 if msa==9240
replace top125=1 if msa==9320
