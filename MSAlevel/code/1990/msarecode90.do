replace msa = 9999 if inlist(msa, 0, 9996, 9997, 9998, 9999) | missing(msa)
gen omsa=msa

*step1 - use smsa-recodes from fixmsa.sas (based on smsa9997.sas)


*allocate mixed pumas to msa if 50% or more of pop in msa
*smsa9997.sas createdfrom county eq file, edited by dc 07-2008

replace msa=1000 if statefip==1 & puma== 200 
replace msa=5160 if statefip== 1 & puma== 800 
replace msa=2180 if statefip== 1 & puma==1100 
replace msa=5240 if statefip== 1 & puma==1500 
replace msa=2880 if statefip== 1 & puma==2000 
replace msa=3440 if statefip== 1 & puma==2300 
replace msa=2720 if statefip== 5 & puma== 800 
replace msa=6240 if statefip== 5 & puma==1300 
replace msa=4400 if statefip== 5 & puma==1600 
replace msa=2080 if statefip== 8 & puma==1400 
replace msa=3280 if statefip== 9 & puma== 200 
replace msa=1170 if statefip== 9 & puma== 600 
replace msa=3280 if statefip== 9 & puma== 900 
replace msa=8040 if statefip== 9 & puma==1200 
replace msa=5760 if statefip== 9 & puma==1400 
replace msa=1160 if statefip== 9 & puma==1500 
replace msa=8880 if statefip== 9 & puma==1900 
replace msa=5480 if statefip== 9 & puma==2100 
replace msa=5480 if statefip== 9 & puma==2200 
replace msa=5020 if statefip== 9 & puma==2500 
replace msa=5520 if statefip== 9 & puma==2600 
replace msa=3600 if statefip==12 & puma== 200 
replace msa=2750 if statefip==12 & puma== 300 
replace msa=6015 if statefip==12 & puma== 400 
replace msa=8240 if statefip==12 & puma== 600 
replace msa=5345 if statefip==12 & puma==2400 
replace msa= 120 if statefip==13 & puma== 200 
replace msa= 520 if statefip==13 & puma== 600 
replace msa= 520 if statefip==13 & puma== 800 
replace msa= 500 if statefip==13 & puma== 900 
replace msa=1800 if statefip==13 & puma==2900 
replace msa= 520 if statefip==13 & puma==3000 
replace msa=4680 if statefip==13 & puma==3100 
replace msa=3740 if statefip==17 & puma==2900 
replace msa=2440 if statefip==18 & puma==2400 
replace msa=3760 if statefip==20 & puma==1100 
replace msa=8440 if statefip==20 & puma==1400 
replace msa=4150 if statefip==20 & puma==1500 
replace msa=3400 if statefip==21 & puma==1100 
replace msa=1640 if statefip==21 & puma==1400 
replace msa=4280 if statefip==21 & puma==1600 
replace msa=4520 if statefip==21 & puma==1900 
replace msa=3960 if statefip==22 & puma== 700 
replace msa=5560 if statefip==22 & puma==1700 
replace msa=5560 if statefip==22 & puma==2300 
replace msa=4240 if statefip==23 & puma== 500 
replace msa=6400 if statefip==23 & puma== 600 
replace msa=1900 if statefip==24 & puma== 100 
replace msa=6320 if statefip==25 & puma== 100 
replace msa=8000 if statefip==25 & puma== 700 
replace msa=9240 if statefip==25 & puma==1000 
replace msa=9240  if statefip==25 & puma==1100 
replace msa=2600 if statefip==25 & puma==1200 
replace msa=4160 if statefip==25 & puma==1700 
replace msa=1200 if statefip==25 & puma==3800 
replace msa=6060 if statefip==25 & puma==4200 
replace msa=5400 if statefip==25 & puma==4300 
replace msa=5320 if statefip==26 & puma==1200 
replace msa=2160 if statefip==26 & puma==2200 
replace msa=5120 if statefip==27 & puma== 900 
replace msa=3560 if statefip==28 & puma==1000 
replace msa=7000 if statefip==29 & puma== 200 
replace msa=3040 if statefip==30 & puma== 400 
replace msa=6720 if statefip==32 & puma== 400 
replace msa=6450 if statefip==33 & puma== 400 
replace msa=4160 if statefip==33 & puma== 601 
replace msa=6450 if statefip==33 & puma== 602 
replace msa= 560 if statefip==34 & puma== 300 
replace msa=5640 if statefip==34 & puma==4000 
replace msa=8680 if statefip==36 & puma== 600 
replace msa=2975 if statefip==36 & puma== 700 
replace msa=8160 if statefip==36 & puma==1400 
replace msa=2335 if statefip==36 & puma==3400 
replace msa=6460 if statefip==36 & puma==4000 
replace msa=3290 if statefip==37 & puma== 700 
replace msa=1520 if statefip==37 & puma==1200 
replace msa=3120 if statefip==37 & puma==2200 
replace msa=6640  if statefip==37 & puma==2400 
replace msa=2520  if statefip==38 & puma== 400 
replace msa=2985  if statefip==38 & puma== 500 
replace msa=8080  if statefip==39 & puma==2000 
replace msa=9000 if statefip==39 & puma==2500 
replace msa=6020  if statefip==39 & puma==2900 
replace msa=3400  if statefip==39 & puma==3500 
replace msa=6440  if statefip==41 & puma==1000 
replace msa=6280  if statefip==42 & puma==1400 
replace msa= 845  if statefip==42 & puma==3800 
replace msa=6480 if statefip==44 & puma== 400 
replace msa=6480 if statefip==44 & puma== 600 
replace msa=6480  if statefip==44 & puma== 700 
replace msa=6060  if statefip==44 & puma== 800 
replace msa=3160 if statefip==45 & puma== 100 
replace msa=6660  if statefip==46 & puma== 100 
replace msa=7760 if statefip==46 & puma== 500 
replace msa=7640  if statefip==48 & puma== 700 
replace msa=8360 if statefip==48 & puma== 900 
replace msa=2800 if statefip==48 & puma==1800 
replace msa=7200 if statefip==48 & puma==3500 
replace msa=4080 if statefip==48 & puma==3900 
replace msa=7240 if statefip==48 & puma==4600 
replace msa=7160 if statefip==49 & puma== 200 
replace msa=7160 if statefip==49 & puma== 300 
replace msa=1305 if statefip==50 & puma== 100 
replace msa=6800 if statefip==51 & puma== 500 
replace msa=1540 if statefip==51 & puma==1300 
replace msa=4640 if statefip==51 & puma==1400 
replace msa=6760 if statefip==51 & puma==2400 
replace msa=5720 if statefip==51 & puma==2800 
replace msa=5720 if statefip==51 & puma==3300 
replace msa=9000 if statefip==54 & puma== 100 
replace msa=6020 if statefip==54 & puma== 300 
replace msa=1480 if statefip==54 & puma== 700 
replace msa=3400 if statefip==54 & puma== 800 
replace msa=3870 if statefip==55 & puma==1300 
replace msa=1580 if statefip==56 & puma== 100 
replace msa=1350  if statefip==56 & puma== 200 

*step 2 -- h& entered fixups for top 125 cities

replace msa=200 if statefip==35 & puma==300 
replace msa=9999 if statefip==34 & msa==240 
replace msa=440 if statefip==26 & inlist(msa,4300, 2900) 
replace msa=520 if statefip==13 & inlist(msa,600, 2500) 
replace msa=640 if statefip==48 & puma==5200 
replace msa=9999 if statefip==1  & puma==200 
replace msa=1080 if statefip==16 & puma==200 
replace msa=1280 if msa==5700 
replace msa=1600 if msa==3690 
replace msa=1600 if msa==3965 
replace msa=1600 if msa==620  
replace msa=1600 if statefip==17 & puma==3600 
replace msa=1640 if statefip==21 & puma==1400 
replace msa=1680 if msa==4440  
replace msa=1680 if statefip==39 & puma==400 

replace msa=1920 if statefip==48 & puma==1400 
replace msa=2760 if statefip==18 & puma==2700 
replace msa=2800 if statefip==48 & puma==1800 
replace msa=2840 if statefip==6  & puma==2700 
replace msa=3000 if statefip==26 & puma==1200 
replace msa=3120 if statefip==37 & puma==1700 
replace msa=3160 if statefip==45 & puma==2100 
replace msa=3280 if msa==1170  
replace msa=3280 if msa==5020  
replace msa=3280 if msa==5440  
replace msa=3480 if statefip==18 & puma==2200 
replace msa=3480 if msa==400  

replace msa=3720 if statefip==26 & inlist(puma,2400,2600) 
replace msa=3720 if msa==780 
replace msa=4120 if statefip==4 & puma==300 
replace msa=5120 if statefip==27 & puma==900 
replace msa=5560 if statefip==22 & inlist(puma,2300,1700) 

replace msa=5640 if statefip==34 & puma==4000 
replace msa=5720 if statefip==51 & puma==2800 
replace msa=5945 if msa==360  
replace msa=5960 if statefip==12 & puma==1500 
replace msa=6200 if statefip==4  & puma==700 
replace msa=6280 if msa==845  
replace msa=6280 if statefip==42 & inlist(puma,1500,3800) 
replace msa=6440 if msa==8725  
replace msa=6440 if statefip==53 & inlist(puma,1901, 1902) 
replace msa=6480 if inlist(msa,2480,6060) 
replace msa=6640 if statefip==37 & inlist(puma,2400, 2600) 
replace msa=6840 if statefip==36 & puma==2200 

replace msa=9999 if statefip==6  & puma==1000 
replace msa=7240 if statefip==48 & puma==4600 
replace msa=7510 if statefip==12 & inlist(puma,3101, 3102) 
replace msa=9999 if statefip==42 & puma==3200 
replace msa=8000 if statefip==25 & puma==500 
replace msa=8160 if statefip==36 & puma==1800 
replace msa=8735 if msa==6000 
replace msa=8840 if statefip==51 & inlist(puma,1200,2200) 
replace msa=8840 if statefip==54 & puma==500 
replace msa=9320 if statefip==39 & puma==1500 
replace msa=1120 if msa==7090 

*identify top 125 cities
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
