************************************************************************
***************Ghani - Kerr - O'Connell 		 ***********************
***************Political Reservations and Women's Entrepreneuship*******
***************Journal of Development Economics, 2014 ******************
***************Replication Backup				 ***********************
************************************************************************
***Note that this file is for a general-purpose data read-in & clean, thus
***operates on far more variables than may be necessary given final use.
*Original Author: Shanthi Nataraj
*Updated/Revised by: S. O'Connell
*Any errors or inelegancies are the sole responsibility of O'Connell.

clear
clear matrix
clear mata
cap log close

global root "C:/OpenCode/GKO_Reservations_JDE2014_ReplBackup"
include "$root/2progs/00_Set_paths.do"
************************************************************************
************************************************************************
global input "$data/NSS/NSS51_Sch2.2 (Unorg Manu)/"
**************************************** IMPORTING ROUND 51 ******************************************
* imports D146R (rural files)
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 filler 32-35 str informant 36 str responsecode 38 str surveycode 38 str reasonsubst 39 totaltime 40-42 datesurvey 43-48 blank 49-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146R.txt"
drop serialno filler blank
keep if levelno==1
save D146R1, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 filler 32-35 str indactcode 36-39 str description 40-57 typeownership 58 actregistration 59-61 premisescode 62 sitelocation 63 ancillary 64 ageenterprise 65-66 energysource 67-68 natureoperation 69 accountavailable 70 accountingperiod 71 refyearfrom 72-77 refyearto 78-83 refmonthfrom 84-89 refmonthto 90-95 nodaysworked 96-97 noofshiftsmonth 98-99 householdsize 100-101 socialgroup 102 proportionincomeag 103-105 proportionincomeenterprise 106-108 proportionincomeother 109-111 proportionincometotal 112-114 employmentstatus 115 technicalqual 116 blank 117-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146R.txt
drop serialno filler blank
keep if levelno==2
save D146R2, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoassets 32-34 recordtype 35 marketvalueassets 36-45 netopeningbalance 46-53 newpurchase 54-61 usedpurchased 62-69 ownconstruction 70-77 total 78-85 assetssold 86-93 discarded 94-101 depreciation 102-109 netclosingbalance 110-117 blank 118-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146R.txt
drop serialno blank
keep if levelno==3 & recordtype==1
reshape wide marketvalueassets netopeningbalance newpurchase usedpurchased ownconstruction total assetssold discarded depreciation netclosingbalance , i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoassets )
save D146R31, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoassets 32-34 recordtype 35 assetshiredvalue 36-45 assetshiredrent 46-53 fieldsskipped 54-117 blank 118-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146R.txt
drop serialno blank fieldsskipped
keep if levelno==3 & recordtype==2
reshape wide assetshiredvalue assetshiredrent, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoassets )
save D146R32, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoinv 32-34 typecode 35 signopeningbalance 36 openingbalance 37-44 signclosingbalance 45 closingbalance 46-53 blank 54-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146R.txt
drop serialno blank
keep if levelno==4
reshape wide signopeningbalance openingbalance signclosingbalance closingbalance, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoinv )
save D146R4, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoloan 32-34 typecode 35 outstandingbeginning 36-43 borrowing 44-51 repayment 52-59 outstandingend 60-67 blank 68-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146R.txt
drop serialno blank
keep if levelno==5
reshape wide outstandingbeginning borrowing repayment outstandingend, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoloan )
save D146R5, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoitem 32-34 typecode 35 workerfull 36-37 workerpart 38-39 salarymonth 40-47 salaryyear 48-55 bonus 56-63 totalsalary 64-72 blank 73-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146R.txt
drop serialno blank
keep if levelno==6
reshape wide workerfull workerpart salarymonth salaryyear bonus totalsalary, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoitem )
save D146R6, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnomaterials 32-34 typecode 35 str rawmatdescription 36-53 str rawmatcpncode 54-60 rawmatunitcode 61-62 rawmatmonthquantity 63-72 rawmatmonthvalue 73-82 rawmatmonthrateperunit 83-90 rawmatyearquantity 91-100 rawmatyearvalue 101-110 rawmatyearrateperunit 111-118 blank 119-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146R.txt
drop serialno blank
keep if levelno==7
reshape wide rawmatdescription rawmatcpncode rawmatunitcode rawmatmonthquantity rawmatmonthvalue rawmatmonthrateperunit rawmatyearquantity rawmatyearvalue rawmatyearrateperunit, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnomaterials )
save D146R7, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoinput 32-34 typecode 35 inputsmonthvalue 36-43 inputsyearvalue 44-51 blank 52-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146R.txt
drop serialno blank typecode
keep if levelno==8
reshape wide inputsmonthvalue inputsyearvalue, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoinput )
save D146R8, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnomaterials 32-34 typecode 35 str descriptionproducts 36-53 str cpncodeproducts 54-60 unitcodeproducts 61-62 productsmonthquantity 63-72 productsmonthvalue 73-82 productsmonthrateperunit 83-90 productsyearquantity 91-100 productsyearvalue 101-110 productsyearrateperunit 111-118 blank 119-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146R.txt
drop serialno blank
keep if levelno==9
reshape wide  description cpncode unitcode productsmonthquantity productsmonthvalue productsmonthrateperunit productsyearquantity productsyearvalue productsyearrateperunit, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnomaterials )
save D146R9, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoitem 32-34 typecode 35 str gvasignmonthvalue 36 gvamonthvalue 37-46 str gvasignyearvalue 47 gvayearvalue 48-57 blank 58-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146R.txt
drop serialno blank
keep if levelno==10
reshape wide gvasignmonthvalue gvamonthvalue gvasignyearvalue gvayearvalue , i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoitem )
save D146R10, replace

* Crazy attempt to merge all Round 51 D146R files into one big ol' file...
use D146R2
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146R2, replace
use D146R1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146R2
drop _merge
save D146R1, replace
use D146R31
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146R31, replace
use D146R1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146R31
* note - there are 583 cases in the master file that do not appear in D146R31.  I keep these anyway. 
drop _merge
save D146R1, replace
use D146R32
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146R32, replace
use D146R1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146R32
* note - there are 104,912 cases in the master file that do not appear in D146R32.  I keep these anyway. 
drop _merge
save D146R1, replace
use D146R4
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146R4, replace
use D146R1
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146R4
* note - there are 10,475 cases in the master file that do not appear in D146R4.  I keep these anyway. 
drop _merge
save D146R1, replace
use D146R5
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146R5, replace
use D146R1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146R5
* note - there are 108,149 cases in the master file that do not appear in D146R5.  I keep these anyway. 
drop _merge
save D146R1, replace
use D146R6
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146R6, replace
use D146R1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146R6
* note - there are 2,700 cases in the master file that do not appear in D146R6.  I keep these anyway. 
drop _merge
save D146R1, replace
use D146R7 
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146R7, replace
use D146R1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146R7
* note - there are 22,760 cases in the master file that do not appear in D146R7.  I keep these anyway. 
drop _merge
save D146R1, replace
use D146R8
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146R8, replace
use D146R1
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146R8
* note - there are 6,363 cases in the master file that do not appear in D146R8.  I keep these anyway. 
drop _merge
save D146R1, replace
use D146R9
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146R9, replace
use D146R1
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146R9
* note - there are 63,163 cases in the master file that do not appear in D146R9.  I keep these anyway. 
drop _merge
save D146R1, replace
use D146R10
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146R10, replace
use D146R1
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146R10
* note - there are 28 cases in the master file that do not appear in D146R10.  I keep these anyway. 
drop _merge
drop recordtype
save D146R1, replace

* imports D146U (urban files)
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 filler 32-35 str informant 36 str responsecode 38 str surveycode 38 str reasonsubst 39 totaltime 40-42 datesurvey 43-48 blank 49-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146U.txt
drop serialno filler blank
keep if levelno==1
save D146U1, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 filler 32-35 str indactcode 36-39 str description 40-57 typeownership 58 actregistration 59-61 premisescode 62 sitelocation 63 ancillary 64 ageenterprise 65-66 energysourec 67-68 natureoperation 69 accountavailable 70 accountingperiod 71 refyearfrom 72-77 refyearto 78-83 refmonthfrom 84-89 refmonthto 90-95 nodaysworked 96-97 noofshiftsmonth 98-99 householdsize 100-101 socialgroup 102 proportionincomeage 103-105 proportionincomeenterprise 106-108 proportionincomeother 109-111 proportionincometotal 112-114 employmentstatus 115 technicalqual 116 blank 117-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146U.txt
drop serialno filler blank
keep if levelno==2
save D146U2, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoassets 32-34 recordtype 35 marketvalueassets 36-45 netopeningbalance 46-53 newpurchase 54-61 usedpurchased 62-69 ownconstruction 70-77 total 78-85 assetssold 86-93 discarded 94-101 depreciation 102-109 netclosingbalance 110-117 blank 118-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146U.txt
drop serialno blank
keep if levelno==3 & recordtype==1
reshape wide marketvalueassets netopeningbalance newpurchase usedpurchased ownconstruction total assetssold discarded depreciation netclosingbalance , i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoassets )
save D146U31, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoassets 32-34 recordtype 35 assetshiredvalue 36-45 assetshiredrent 46-53 fieldsskipped 54-117 blank 118-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146U.txt
drop serialno blank fieldsskipped
keep if levelno==3 & recordtype==2
reshape wide assetshiredvalue assetshiredrent, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoassets )
save D146U32, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoinv 32-34 typecode 35 signopeningbalance 36 openingbalance 37-44 signclosingbalance 45 closingbalance 46-53 blank 54-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146U.txt
drop serialno blank
keep if levelno==4
reshape wide signopeningbalance openingbalance signclosingbalance closingbalance, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoinv )
save D146U4, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoloan 32-34 typecode 35 outstandingbeginning 36-43 borrowing 44-51 repayment 52-59 outstandingend 60-67 blank 68-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146U.txt
drop serialno blank
keep if levelno==5
reshape wide outstandingbeginning borrowing repayment outstandingend, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoloan )
save D146U5, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoitem 32-34 typecode 35 workerfull 36-37 workerpart 38-39 salarymonth 40-47 salaryyear 48-55 bonus 56-63 totalsalary 64-72 blank 73-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146U.txt
drop serialno blank
keep if levelno==6
reshape wide workerfull workerpart salarymonth salaryyear bonus totalsalary, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoitem )
save D146U6, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnomaterials 32-34 typecode 35 str rawmatdescription 36-53 str rawmatcpncode 54-60 rawmatunitcode 61-62 rawmatmonthquantity 63-72 rawmatmonthvalue 73-82 rawmatmonthrateperunit 83-90 rawmatyearquantity 91-100 rawmatyearvalue 101-110 rawmatyearrateperunit 111-118 blank 119-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146U.txt
drop serialno blank typecode
keep if levelno==7
reshape wide rawmatdescription rawmatcpncode rawmatunitcode rawmatmonthquantity rawmatmonthvalue rawmatmonthrateperunit rawmatyearquantity rawmatyearvalue rawmatyearrateperunit, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnomaterials )
save D146U7, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoinput 32-34 typecode 35 inputsmonthvalue 36-43 inputsyearvalue 44-51 blank 52-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146U.txt
drop serialno blank typecode
keep if levelno==8
reshape wide inputsmonthvalue inputsyearvalue, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoinput )
save D146U8, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnomaterials 32-34 typecode 35 str descriptionproducts 36-53 str cpncodeproducts 54-60 unitcodeproducts 61-62 productsmonthquantity 63-72 productsmonthvalue 73-82 productsmonthrateperunit 83-90 productsyearquantity 91-100 productsyearvalue 101-110 productsyearrateperunit 111-118 blank 119-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146U.txt
drop serialno blank
keep if levelno==9
reshape wide  description cpncode unitcode productsmonthquantity productsmonthvalue productsmonthrateperunit productsyearquantity productsyearvalue productsyearrateperunit, i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnomaterials )
save D146U9, replace
clear
infix serialno 1-4 roundschedule 5-7 stateregion 8-10 district 11-12 subsample 13 subround 14 flot 15-19 villblocksrlno 20-24 hamlet 25 enterprisetype 26 samplehhno 27-29 levelno 30-31 srlnoitem 32-34 typecode 35 str gvasignmonthvalue 36 gvamonthvalue 37-46 str gvasignyearvalue 47 gvayearvalue 48-57 blank 58-120 sample 121 sector 122 stratum 123-124 substratum 125 str updatecode 126 multipliersubsample 127-136 multipliercombined 137-146 using "$input/D146U.txt
drop serialno blank
keep if levelno==10
reshape wide gvasignmonthvalue gvamonthvalue gvasignyearvalue gvayearvalue , i(stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno) j( srlnoitem )
save D146U10, replace

* Crazy attempt to merge all Round 51 D146U files into one big ol' file...
use D146U2
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146U2, replace
use D146U1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146U2
drop _merge
save D146U1, replace
use D146U31
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146U31, replace
use D146U1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146U31
* note - there are 544 cases in the master file that do not appear in D146U31.  I keep these anyway. 
drop _merge
save D146U1, replace
use D146U32
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146U32, replace
use D146U1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146U32
* note - there are 40,585 cases in the master file that do not appear in D146U32.  I keep these anyway. 
drop _merge
save D146U1, replace
use D146U4
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146U4, replace
use D146U1
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146U4
* note - there are 4,688 cases in the master file that do not appear in D146U4.  I keep these anyway. 
drop _merge
save D146U1, replace
use D146U5
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146U5, replace
use D146U1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146U5
* note - there are 63,442 cases in the master file that do not appear in D146U5.  I keep these anyway. 
drop _merge
save D146U1, replace
use D146U6
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146U6, replace
use D146U1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146U6
* note - there are 524 cases in the master file that do not appear in D146U6.  I keep these anyway. 
drop _merge
save D146U1, replace
use D146U7 
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146U7, replace
use D146U1
sort roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146U7
* note - there are 11,635 cases in the master file that do not appear in D146U7.  I keep these anyway. 
drop _merge
save D146U1, replace
use D146U8
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146U8, replace
use D146U1
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146U8
* note - there are 2,945 cases in the master file that do not appear in D146U8.  I keep these anyway. 
drop _merge
save D146U1, replace
use D146U9
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146U9, replace
use D146U1
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146U9
* note - there are 51,533 cases in the master file that do not appear in D146U9.  I keep these anyway. 
drop _merge
save D146U1, replace
use D146U10
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
save D146U10, replace
use D146U1
sort  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno
merge  roundschedule stateregion district subsample subround flot villblocksrlno hamlet enterprisetype samplehhno using D146U10
* note - there are 15 cases in the master file that do not appear in D146U10.  I keep these anyway. 
drop _merge
drop recordtype
save D146U1, replace

* merges D146R and D146U
use D146R1
append using D146U1
save D146, replace

* copies all final files to /Users/shanthi/Documents/Economics/Trade/NSSOData/UnorganizedSectorData, then erases originals within subfolders
clear
use D146
save "$intdata/master51", replace
erase D146.dta
erase D146R1.dta
erase D146R2.dta
erase D146R31.dta
erase D146R32.dta
erase D146R4.dta
erase D146R5.dta
erase D146R6.dta
erase D146R7.dta
erase D146R8.dta
erase D146R9.dta
erase D146R10.dta
erase D146U1.dta
erase D146U2.dta
erase D146U31.dta
erase D146U32.dta
erase D146U4.dta
erase D146U5.dta
erase D146U6.dta
erase D146U7.dta
erase D146U8.dta
erase D146U9.dta
erase D146U10.dta 
clear
cap log close



