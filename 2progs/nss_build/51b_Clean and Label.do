************************************************************************
***************Ghani - Kerr - O'Connell 		 ***********************
***************Political Reservations and Women's Entrepreneuship*******
***************Journal of Development Economics, 2014 ******************
***************Replication Backup				 ***********************
************************************************************************
clear
clear matrix
clear mata
cap log close

global root "C:/OpenCode/GKO_Reservations_JDE2014_ReplBackup"
include "$root/2progs/00_Set_paths.do"
************************************************************************
************************************************************************
use "$intdata/master51.dta" 

g year = 1995
g uniqid=string(stateregion)+string(district)+string(subsample)+string(subround)+string(flot)+string(villblocksrlno)+string(hamlet)+string(enterprisetype)+string(samplehhno)

rename enterprisetype enttype
rename samplehhno enterpriseno
rename levelno level
rename informant informantcode
destring informantcode, replace
drop totaltime
drop datesurvey

drop updatecode
drop multipliersubsample

rename indactcode NICcode
drop description
rename typeownership ownership
g registered=(actregistration!=0)
drop actregistration 
rename premisescode location
	tostring location, replace
	replace location="No fixed premises" if location=="1"
	replace location="Household" if location=="2"
	replace location="Non-Household" if location=="3"
	replace location="Unknown" if location=="4"
	replace location="Unknown" if location=="9"
drop sitelocation
drop ancillary
rename ageenterprise age
g mos_account=1
replace mos_account=12 if accountavailable==1

tostring natureoperation, replace
replace natureoperation="perennial" if natureoperation=="1" | natureoperation=="2" | natureoperation=="5" 
replace natureoperation="seasonal" if natureoperation=="3"
replace natureoperation="casual" if natureoperation=="4"

drop energysource  accountavailable-depreciation9

rename netclosingbalance9 totalvalueassetsowned
drop assetshiredvalue1-assetshiredrent8
rename assetshiredvalue9 totalvalueassetshired
rename assetshiredrent9 totalrentassetshired

drop signopeningbalance1-typecode

	***NEW CODE TO INCLUDE LIABILITY ACCOUNTS
	rename outstandingbeginning1 outstandingbeg_gov
	rename borrowing1 borrowings_gov
	rename repayment1 repayment_gov
	rename outstandingend1 outstandingend_gov
	rename outstandingbeginning2 outstandingbeg_statefincorp
	rename borrowing2 borrowings_statefincorp
	rename repayment2 repayment_statefincorp
	rename outstandingend2 outstandingend_statefincorp
	rename outstandingbeginning3 outstandingbeg_rrb
	rename borrowing3 borrowings_rrb
	rename repayment3 repayment_rrb
	rename outstandingend3 outstandingend_rrb
	rename outstandingbeginning4 outstandingbeg_pubbank
	rename borrowing4 borrowings_pubbank
	rename repayment4 repayment_pubbank
	rename outstandingend4 outstandingend_pubbank
	rename outstandingbeginning5 outstandingbeg_combank
	rename borrowing5 borrowings_combank
	rename repayment5 repayment_combank
	rename outstandingend5 outstandingend_combank
	rename outstandingbeginning6 outstandingbeg_coopbank
	rename borrowing6 borrowings_coopbank
	rename repayment6 repayment_coopbank
	rename outstandingend6 outstandingend_coopbank
	rename outstandingbeginning7 outstandingbeg_KVIC
	rename borrowing7 borrowings_KVIC
	rename repayment7 repayment_KVIC
	rename outstandingend7 outstandingend_KVIC
	rename outstandingbeginning8 outstandingbeg_moneylend
	rename borrowing8 borrowings_moneylend
	rename repayment8 repayment_moneylend
	rename outstandingend8 outstandingend_moneylend
	rename outstandingbeginning9 outstandingbeg_frfam
	rename borrowing9 borrowings_frfam
	rename repayment9 repayment_frfam
	rename outstandingend9 outstandingend_frfam
	rename outstandingbeginning10 outstandingbeg_other
	rename borrowing10 borrowings_other
	rename repayment10 repayment_other
	rename outstandingend10 outstandingend_other
	rename outstandingbeginning11 outstandingbeg_total
	rename borrowing11 borrowings_total



rename outstandingend11 totalloanamount
rename workerfull1 MFT_1
rename workerpart1 MPT_1
drop salarymonth1
drop salaryyear1
drop bonus1
drop totalsalary1
rename workerfull2 FFT_1
rename workerpart2 FPT_1
drop salarymonth2
drop salaryyear2
drop bonus2
drop totalsalary2
rename workerfull3 MFT_2
rename workerpart3 MPT_2
drop salarymonth3
drop salaryyear3
drop bonus3
drop totalsalary3
rename workerfull4 FFT_2
rename workerpart4 FPT_2
drop salarymonth4
drop salaryyear4
drop bonus4
drop totalsalary4
rename workerfull5 MFT_3
rename workerpart5 MPT_3
drop salarymonth5
drop salaryyear5
drop bonus5
drop totalsalary5
rename workerfull6 FFT_3
rename workerpart6 FPT_3
drop salarymonth6
drop salaryyear6
drop bonus6
drop totalsalary6
rename workerfull7 MFT_4
rename workerpart7 MPT_4
drop salarymonth7
drop salaryyear7
drop bonus7
drop totalsalary7
rename workerfull8 FFT_4
rename workerpart8 FPT_5
drop salarymonth8
drop salaryyear8
drop bonus8
drop totalsalary8
rename workerfull9 OTHMFT_1
rename workerpart9 OTHMPT_1
drop salarymonth9
drop salaryyear9
drop bonus9
drop totalsalary9
rename workerfull10 OTHFFT_1
rename workerpart10 OTHFPT_1
drop salarymonth10
drop salaryyear10
drop bonus10
drop totalsalary10
rename workerfull11 OTHMFT_2
rename workerpart11 OTHMPT_2
drop salarymonth11
drop salaryyear11
drop bonus11
drop totalsalary11
rename workerfull12 OTHFFT_2
rename workerpart12 OTHFPT_2
drop salarymonth12
drop salaryyear12
drop bonus12
drop totalsalary12
rename workerfull13 EEFT_hired
rename workerpart13 EEPT_hired
drop salarymonth13
drop salaryyear13
drop bonus13
drop totalsalary13
rename workerfull14 workerotherfullmale_1
rename workerpart14 workerotherpartmale_1
drop salarymonth14
drop salaryyear14
drop bonus14
drop totalsalary14
rename workerfull15 workerotherfullfemale_1
rename workerpart15 workerotherpartfemale_1
drop salarymonth15
drop salaryyear15
drop bonus15
drop totalsalary15
rename workerfull16 workerotherfullmale_2
rename workerpart16 workerotherpartmale_2
drop salarymonth16
drop salaryyear16
drop bonus16
drop totalsalary16
rename workerfull17 workerotherfullfemale_2
rename workerpart17 workerotherpartfemale_2
drop salarymonth17
drop salaryyear17
drop bonus17
drop totalsalary17
rename workerfull18 workerownfullmale
rename workerpart18 workerownpartmale
drop salarymonth18
drop salaryyear18
drop bonus18
drop totalsalary18
rename workerfull19 workerownfullfemale
rename workerpart19 workerownpartfemale
drop salarymonth19
drop salaryyear19
drop bonus19
drop totalsalary19
drop workerfull20
drop workerpart20
drop salarymonth20
drop salaryyear20
drop bonus20
drop totalsalary20
drop workerfull21
drop workerpart21
drop salarymonth21
drop salaryyear21
drop bonus21
drop totalsalary21
rename workerfull22 EEFT
rename workerpart22 EEPT
drop salarymonth22
rename salaryyear22 totalsalary
rename bonus22 totalbonus
rename totalsalary22 totalcomp

egen workerhiredfullmale=rowtotal(MFT_*)
egen workerhiredpartmale=rowtotal(MPT_*)
egen workerhiredfullfemale=rowtotal(FFT_*)
egen workerhiredpartfemale=rowtotal(FPT_*)
egen workerotherfullmale=rowtotal(OTHMFT_*)
egen workerotherpartmale=rowtotal(OTHMPT_*)
egen workerotherfullfemale=rowtotal(OTHFFT_*)
egen workerotherpartfemale=rowtotal(OTHFPT_*)

drop MFT_*
drop MPT_*
drop FFT_*
drop FPT_*
drop OTHMFT_*
drop OTHMPT_*
drop OTHFFT_*
drop OTHFPT_*


drop workerfull23-rawmatyearquantity13
egen rawmat_fuel_lube=rowtotal(rawmatyearvalue13 rawmatyearvalue14 rawmatyearvalue15)
drop rawmatyearvalue13 rawmatyearvalue14 rawmatyearvalue15 
drop rawmatyearrateperunit13-rawmatyearquantity14
drop rawmatyearrateperunit14-rawmatyearquantity15
drop rawmatyearrateperunit15-rawmatyearquantity16
rename rawmatyearvalue16 rawmat_elec
drop rawmatyearrateperunit16-rawmatyearquantity18
rename rawmatyearvalue18 totalrawmat
	replace totalrawmat=inputsyearvalue22 if totalrawmat==. & inputsyearvalue22!=.
drop rawmatyearrateperunit18-inputsmonthvalue22
rename inputsyearvalue22 totothexp
drop inputsmonthvalue23
rename inputsyearvalue23 totalloanint
drop descriptionproducts1-gvamonthvalue5
rename gvasignyearvalue5 totalreceiptssign
rename gvayearvalue5 totalreceipts
drop gvasignmonthvalue6
drop gvamonthvalue6
rename gvasignyearvalue6 totalrevenuesign
rename gvayearvalue6 totalrevenue
drop gvasignmonthvalue7
drop gvamonthvalue7
rename gvasignyearvalue7 totalexpsign
rename gvayearvalue7 totalexp
drop gvasignmonthvalue8
drop gvamonthvalue8
rename gvasignyearvalue8 GVAsign
rename gvayearvalue8 GVA
drop energysourec
drop proportionincomeage




#delim ;
g state=substr(string(stateregion),1,length(string(stateregion))-1);
destring state, replace;

#delim ;
lab var state "State";
lab def state
2"Andhra Pradesh"
4"Assam"
5"Bihar"
7"Gujarat"
8"Haryana"
9"Himachal Pradesh"
10"Jammu & Kashmir"
11"Karnataka"
12"Kerala"
13"Madhya Pradesh"
14"Maharashtra"
15"Manipur"
16"Meghalaya"
18"Nagaland"
19"Orissa"
20"Punjab"
21"Rajasthan"
22"Sikkim"
23"Tamil Nadu"
24"Tripura"
25"Uttar Pradesh"
26"West Bengal"
27"A & N Islands"
3"Arunachal Pradesh"
28"Chandigarh"
29"Dadra & Nagar Haveli"
31"Delhi"
6"Goa"
32"Lakshdweep"
17"Mizoram"
33"Pondicherry"
30"Daman & Diu"
35"Chattigarh"
34"Jharkhand"
36"Uttaranchal";
lab val state state;

tab state;
***CHECK IF ANY MISSINGS***;
rename state state2;
decode state2, g (state);
drop state2;

destring NICcode, replace;
destring *sign, replace;
rename multipliercombined multiplier;

tostring NICcode, replace;


#delim cr

destring responsecode, replace

replace multiplier= multiplier/100

foreach i in  totalreceipts totalrevenue totalexp GVA {
replace `i'=`i'*-1 if `i'sign==1
drop `i'sign
}


save "$intdata/master51_clean", replace
erase "$intdata/master51.dta"
