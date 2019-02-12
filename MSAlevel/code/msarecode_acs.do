/*assign msa to 9997 and 9998 cases - dc code feb 12 2004
note this also (roughly) assigns necmas in new england
though the codes are still msa/pmsa not necma */

replace msa=1000 if state==1 & puma==800 
replace msa=4120 if state==4 & puma==600 
replace msa=6200 if state==4 & puma==800 
replace msa=6240 if state==5 & puma==1600 
replace msa=7120 if state==6 & puma==3002 
replace msa=2080 if state==8 & puma==801 
replace msa=1125 if state==8 & puma==804 
replace msa=3280 if state==9 & puma==200 
replace msa=3280 if state==9 & puma==900 
replace msa=5520 if state==9 & puma==1100 
replace msa=5520 if state==9 & puma==1200 
replace msa=3280 if state==9 & puma==1300 
replace msa=8880 if state==9 & puma==1400 
replace msa=5480 if state==9 & puma==1600 
replace msa=5480 if state==9 & puma==1700 
replace msa=520 if state==13 & puma==800 
replace msa=1960 if state==17 & puma==102 
replace msa=7880 if state==17 & puma==1400 
replace msa=1600 if state==17 & puma==2600 
replace msa=6880 if state==17 & puma==2700 
replace msa=4150 if state==20 & puma==700 
replace msa=1660 if state==21 & puma==300 
replace msa=4280 if state==21 & puma==1100 
replace msa=5990 if state==21 & puma==1600 
replace msa=4520 if state==21 & puma==1800 
replace msa=3400 if state==21 & puma==2200 
replace msa=1640 if state==21 & puma==2500 
replace msa=3880 if state==22 & puma==1200 
replace msa=5560 if state==22 & puma==2001 
replace msa=3350 if state==22 & puma==2100 
replace msa=4240 if state==23 & puma==700 
replace msa=730 if state==23 & puma==900 
replace msa=1900 if state==24 & puma==100 
replace msa=9160 if state==24 & puma==700 
replace msa=6320 if state==25 & puma==100 
replace msa=9240 if state==25 & puma==1500 
replace msa=9240 if state==25 & puma==2100 
replace msa=3000 if state==26 & puma==1700 
replace msa=2640 if state==26 & puma==2302 
replace msa=440 if state==26 & puma==3000 
replace msa=3040 if state==30 & puma==200 
replace msa=5140 if state==30 & puma==700 
replace msa=6450 if state==33 & puma==300 
replace msa=5350 if state==33 & puma==600 
replace msa=4760 if state==33 & puma==700 
replace msa=4160 if state==33 & puma==1000 
replace msa=6450 if state==33 & puma==1100 
replace msa=6840 if state==36 & puma==1200 
replace msa=2335 if state==36 & puma==2700 
replace msa=2985 if state==38 & puma==500 
replace msa=8080 if state==39 & puma==2400 

*replace msa=1840 if state==39 & puma==2800
replace msa=1840 if state==39 & puma==1921
 
replace msa=6020 if state==39 & puma==3500 
replace msa=4200 if state==40 & puma==400 
replace msa=5880 if state==40 & puma==1600 
replace msa=5880 if state==40 & puma==1700 
replace msa=6440 if state==41 & puma==1200 
replace msa=6280 if state==42 & puma==2202 
replace msa=6480 if state==44 & puma==500 
replace msa=6480 if state==44 & puma==700 
replace msa=3160 if state==45 & puma==100 
replace msa=2655 if state==45 & puma==1600 
replace msa=1440 if state==45 & puma==2000 
replace msa=6660 if state==46 & puma==100 
replace msa=3840 if state==47 & puma==1200 
replace msa=4920 if state==47 & puma==3000 
replace msa=7640 if state==48 & puma==800 
replace msa=1920 if state==48 & puma==900 
replace msa=8360 if state==48 & puma==1100 
replace msa=1920 if state==48 & puma==1800 
replace msa=7200 if state==48 & puma==3000 
replace msa=640 if state==48 & puma==5100 
replace msa=8750 if state==48 & puma==6200 
replace msa=1880 if state==48 & puma==6301 
replace msa=1305 if state==50 & puma==100 
replace msa=3660 if state==51 & puma==2600 
replace msa=9000 if state==54 & puma==100 
replace msa=8840 if state==54 & puma==400 
replace msa=6020 if state==54 & puma==600 
replace msa=3400 if state==54 & puma==700 
replace msa=1480 if state==54 & puma==800 
replace msa=1350 if state==56 & puma==200 
replace msa=1580 if state==56 & puma==400

/*now assign top125;*/
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

*replace top125=1 if msa==875
replace top125=1 if msa==5602

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

*replace top125=1 if msa==2320
replace top125=1 if msa==2310

replace top125=1 if msa==2640
replace top125=1 if msa==2680
replace top125=1 if msa==2700
replace top125=1 if msa==2760
replace top125=1 if msa==2800
replace top125=1 if msa==2840

*replace top125=1 if msa==2960
replace top125=1 if msa==1602

replace top125=1 if msa==3000
replace top125=1 if msa==3120
replace top125=1 if msa==3160
replace top125=1 if msa==3240
replace top125=1 if msa==3280
replace top125=1 if msa==3320
replace top125=1 if msa==3360
replace top125=1 if msa==3480
replace top125=1 if msa==3560

*replace top125=1 if msa==3600
replace top125=1 if msa==3590

*replace top125=1 if msa==3640
replace top125=1 if msa==5603

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

*replace top125=1 if msa==5015
replace top125=1 if msa==5604

replace top125=1 if msa==5080
replace top125=1 if msa==5120
replace top125=1 if msa==5160
replace top125=1 if msa==5170
replace top125=1 if msa==5190
replace top125=1 if msa==5360

*replace top125=1 if msa==5380
replace top125=1 if msa==5601

replace top125=1 if msa==5480
replace top125=1 if msa==5560
replace top125=1 if msa==5600
replace top125=1 if msa==5640
replace top125=1 if msa==5720

*replace top125=1 if msa==5775
replace top125=1 if msa==7361

replace top125=1 if msa==5880
replace top125=1 if msa==5920

*replace top125=1 if msa==5945
replace top125=1 if msa==4482

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

*replace top125=1 if msa==8720
replace top125=1 if msa==7362

*replace top125=1 if msa==8735
replace top125=1 if msa==8730

replace top125=1 if msa==8840
replace top125=1 if msa==8960
replace top125=1 if msa==9040
replace top125=1 if msa==9160
replace top125=1 if msa==9240
replace top125=1 if msa==9320

