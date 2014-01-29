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
include "$do/subroutines/Prep_NIC_crosswalk.do"
include "$do/subroutines/Prep_industry_deflators.do"

****************************
*****OPEN & APPEND DATA
****************************
use "$intdata/NSS_FINAL", clear
tostring district, replace
append using "$intdata/ASI_Allyears_Clean.dta"
g dataset=survey+string(year)
decode enttype, g(enttype2)
replace enttype2="ORG" if survey=="ASI"
drop enttype
rename enttype enttype


replace  plants=1 if survey=="NSS"
replace location="Non-Household" if survey=="ASI"

compress


g state_ORIGINAL=state
tab state
replace state="BIHAR" if state=="Jharkhand" | state=="JHARKHAND"
replace state="MADHYA PRADESH" if state=="CHHATISGARH" | state=="Chhattisgarh"
replace state="UTTAR PRADESH" if state=="UTTARANCHAL" | state=="Uttaranchal"
tab state


****************************
***Clean States***
****************************
replace state=upper(state)
replace state="A & N ISLANDS" if state=="ANDAMAN AND NICOBAR ISLANDS"
replace state="CHHATTISGARH" if state=="CHHATISGARH"
replace state="DADRA & NAGAR HAVELI" if state=="DADRA  AND  NAGAR  HAVELI"
replace state="DAMAN & DIU" if state=="DAMAN  &  DIU "
replace state="MAHARASHTRA" if state=="MAHARASTRA"
replace state="PONDICHERRY" if state=="PONDICHERI"
replace state="UNKNOWN" if state==""
	

****************************
***OUTPUT CLEANUP	***
*note: We replace total value of output with total value of sales where output value not available or not collected. Negative output values are recoded as missing.
****************************
***REPLACE totaloutput=totalsales in ASI 1989 & anywhere else not available
***REPLACE totaloutput=totalsales in NSS where not available
replace totaloutput=totalsales if dataset=="ASI1989"
replace totaloutput=totalsales if survey=="ASI" & totaloutput==. & totalsales!=.
replace totaloutput=totalsales if survey=="NSS" & totaloutput==. & totalsales!=.
bysort dataset: count if totaloutput<0
replace totaloutput=. if totaloutput<0
replace totalrawmaterials=totalrawmaterials+totalimports if totalimports!=.



****************************
***Crosswalk NICs***
*note: NIC codes have been updated to the 2004 NIC classification system at the 3-digit level using crosswalking files provided by CSO.
****************************


g nic387=""
g nic498=""
g nic404=""

replace nic387=substr(industrycode,1,3) if year<1998
replace nic498=substr(industrycode,1,4) if year>=1998&year<2004
replace nic404=substr(industrycode,1,4) if year>=2004


merge nic387 using "$work/NIC8798Crosswalk.dta", uniqusing sort nokeep
replace nic498 = nic498a if _==3
drop nic498a

tab year _merge
drop _merge

compress
merge nic498 using "$work/NIC9804Crosswalk.dta", uniqusing sort nokeep
replace nic404 = nic404a if _==3
drop nic404a
drop _merge

replace nic498="" if nic498=="."
replace nic404="" if nic404=="."
replace nic404="9999" if nic404=="" & nic387=="" & nic498==""
tab dataset if nic304==""
replace nic304 =substr(nic404,1,3) if nic304=="" & nic404!=""
tab dataset if nic304==""
replace nic304="999" if nic304=="" & nic387=="" & nic498==""
replace nic304="999" if nic304==""
drop nic387 nic498 industrycode


****************************
***Replace Unknown 3 digit nics from latest year which are probably recording errors***
*note: A small number of errant 3-digit NIC codes have been reclassified as unknown. Errant NIC codes are those which are not listed in the official NIC directory.
****************************
replace nic304="999" if nic304=="150"
replace nic304="999" if nic304=="190"
replace nic304="999" if nic304=="212"
replace nic304="999" if nic304=="214"
replace nic304="999" if nic304=="229"
replace nic304="999" if nic304=="264"
replace nic304="999" if nic304=="267"
replace nic304="999" if nic304=="282"
replace nic304="999" if nic304=="310"
replace nic304="999" if nic304=="452"
replace nic304="999" if nic304=="454"
replace nic304="999" if nic304=="501"
replace nic304="999" if nic304=="503"
replace nic304="999" if nic304=="505"
replace nic304="999" if nic304=="523"
replace nic304="999" if nic304=="552"
replace nic304="999" if nic304=="742"
replace nic304="999" if nic304=="911"



g nic204=substr(nic304,1,2)


**************** 
****	adjust NSS for changing reference periods
*note: We adjust accounts to reflect changed reference periods in recent NSS surveys by updating all accounts to reflect full year values.
****************
***NSS 1994: collected data for past year; do not adjust

***NSS 2000: collected data for past month; adjust all flow accounts by factor of months of operations
*note: Even though the documentation say last month collects for all estabs in NSS2000, distributions of output per worker 
*and other metrics do not not not indicate this but rather that past year was collected. Do not adjust.

***NSS 2005: collected data for either past month or past year depending on whether books available; 
***		adjust flow accounts for "last month reported" firm by factor of months of operations
sum monthsops if survey=="NSS" & year==2005, d
tab monthsops if survey=="NSS" & year==2005, mi
tab mos_account if survey=="NSS" & year==2005, mi

replace monthsops=12 if monthsops==. & survey=="NSS" & year==2005 
foreach i in  totalemployeestotalLcost Totalemployeeswagebill totalrawmaterials totalFArent interestamount totaloutput totalsales {
replace `i' = `i'*monthsops if survey=="NSS" & year==2005 & mos_account==1
}


***********************************************************
*Firm's age category:
*note: We clean a small number of suspected entry errors in the 'year of first operations' variable. We topcode a constructed 'age of enterprise' variable at 99 years.
***********************************************************
tab dataset if age==.

replace startyear=. if startyear>2006
replace startyear=2000+startyear if startyear<=6

tab startyear if startyear<1000

replace startyear=1968 if startyear==168
replace startyear=1982 if startyear==182
replace startyear=1984 if startyear==184
replace startyear=1986 if startyear==186
replace startyear=1989 if startyear==189
replace startyear=1991 if startyear==191
replace startyear=1992 if startyear==192
replace startyear=1995 if startyear==195
replace startyear=1996 if startyear==196
replace startyear=1997 if startyear==197
replace startyear=1998 if startyear==198
replace startyear=1999 if startyear==199
replace startyear=2000 if startyear==200
replace startyear=2001 if startyear==201
replace startyear=2004 if startyear==204
replace startyear=2005 if startyear==205


replace startyear=1974 if startyear==974
replace startyear=1976 if startyear==976
replace startyear=1978 if startyear==978
replace startyear=1982 if startyear==982
replace startyear=1983 if startyear==983
replace startyear=1994 if startyear==994
replace startyear=1996 if startyear==996

tab startyear if startyear<1000

tab startyear if startyear>year & startyear!=.
replace startyear = year if startyear-1==year
replace startyear =. if startyear>year & startyear!=.

replace startyear=. if startyear<1000

replace age=year-startyear if age==.
replace age=0 if age<0
replace age=99 if age>99 & age!=.
sum age, d

replace under3=1 if (age<=3 & survey=="ASI") | (age<=3 & survey=="NSS" &(year==1989|year==1994))
replace under3=0 if under3==.

tab dataset under3

destring year, replace


****************************
***Change Currency Accounts from LCU to 2005 Const USD***
*note: We deflate the current rupee values using wholesale price indices of manufacturing industries used by Gupta, Hasan, and Kumar (2009), and convert to 2005 international $USD at purchasing-power parity.
****************************
***reassign a few industries to ensure match
g nic304_orig=nic304
	replace nic304="241" if nic304=="242"
	replace nic304="241" if nic304=="243"
	replace nic304="272" if nic304=="273"
	replace nic304="293" if nic304=="291"
	replace nic304="293" if nic304=="292"
	replace nic304="311" if nic304=="312"
	replace nic304="314" if nic304=="315"
	replace nic304="322" if nic304=="323"
	replace nic304="341" if nic304=="342"
	replace nic304="341" if nic304=="343"

merge m:1 nic304 year using "$work/industry_deflator"
	drop if _m==2
	tab nic304 year if _m==1
	destring nic304, replace
	assert (nic304<150 | nic304>369) if _m==1
	tostring nic304, replace
	drop _m
	
replace nic304=nic304_orig

scalar ppp_adjustor=14.66854168	/*FROM WDI, series "PPP conversion factor, GDP (LCU per international $)" for INDIA 2005 */
foreach i of varlist  totalfixedassets loanamount traditional_loan totalemployeestotalLcost Totalemployeeswagebill valueofelectricitysold valueelectricitypurchased totalrawmaterials totalFArent interestamount totaloutput totalsales closingnetland closingnetbuilding {
g `i'_LCU=`i'
replace `i' = `i'/wpi_deflator
replace `i'=`i'/ppp_adjustor
}

drop wpi_deflator



****************************
***Order Vars
****************************


#delim ;
order 

uniqid
survey
dataset
year
state
district
ruralurban
registered
organization
ownership
enttype 
organization
startyear
age
nic404
nic304
under3yrsold 
monthsops
multiplier

plants
totalfixedassets
closingnetland
closingnetbuilding
loanamount
traditional_loan
totalemployees
totalemployees_halfpart
Memployees
Femployees
totalemployeestotalLcost
Totalemployeeswagebill

totalrawmaterials
totalFArent
interestamount
totaloutput
totalsales
totalimports
fixedcapitalformation
totalfixedassets_LCU
closingnetland_LCU
closingnetbuilding_LCU
loanamount_LCU
totalemployeestotalLcost_LCU
Totalemployeeswagebill_LCU
totalrawmaterials_LCU
totalFArent_LCU
interestamount_LCU
totaloutput_LCU
totalsales_LCU
;



#delim cr
compress


****************
***	INSPECT AND CREATE FLAGS TO CLEAN DATA OF OUTLIERS & OTHER PECULIARITIES
*note: We inspect the data in an intensive manner to identify outliers and other idiosyncrasies that would affect summary statistics or econometric estimations.
****************
***NOTE: ALL ACCOUNTS HAVE ALREADY BEEN MADE ANNUAL
****************
***	Calculate Yearly LOGW per WORKER
****************
g W_per_worker=Totalemployeeswagebill/totalemployees
	g logW=log(W_per_worker)
g monthly_wage_per_worker=W_per_worker
replace monthly_wage_per_worker=W_per_worker/12

g Y_per_worker=totaloutput/totalemployees
g monthly_Y_per_worker=Y_per_worker
replace monthly_Y_per_worker=Y_per_worker/12

	g logY_per_EE=log(Y_per_worker)


****************
***	CLEAN OUTLIERS
****************
***Investigate cause of high output per worker means in ASI 1989
****************

tabstat Y_per_worker, by (dataset) stat (mean p50 sd)
***NOTICE V HIGH MEAN IN ASI 1989

sum Y_per_worker if year==1989 & survey=="ASI", d
tab dataset 
tab dataset if Y_per_worker>1000000&Y_per_worker!=.

g output_per_worker_flag= Y_per_worker>1000000 & Y_per_worker!=.
tab dataset output_per_worker_flag, mi
***recheck effect of dropping outliers on means
tabstat Y_per_worker if output_per_worker_flag==0, by (dataset) stat (mean p50 sd)
sum Y_per_worker if year==1989 & survey=="ASI" & output_per_worker_flag==0, d
***LOOKS FIXED TO ME***

*note: This inspection results in a data flag, 'output_per_worker_flag' which captures any firms with >1MM output per worker in 2005 USD @ PPP. This is a reasonable indication of eporting or recording error in the establishment level observations.


****************************
***CREATE ADDITIONAL OUTLIER AND DROP FLAGS
*note: We create a number of additional flags indicating various outliers or other issues which may affect summary stats or econometrics.
****************************

****************************
***DROP KNOWN OUTLIERS***
*note: We flag 1 observation which is an obvious outlier in total employment by 'emp_outlier_flag'. 
*note: We drop 8 observations with unrecorded state codes in 1989.
****************************
g NSS_toobig_flag =survey=="NSS" & totalemployees>20 & totalemployees!=.
g emp_outlier_flag =uniqid=="000233131702317"
drop if state=="UNKNOWN"



****************************
***FLAG  potential service industries given nic description***
*note: NIC codes which indicates service industries (coverred in NSS survey sample) have been identified and flagged by the 'services_flag' variable. Note that the deflated/converted accounts for these observations will be null as deflators were unavailable.
****************************
g services_flag=0
replace services_flag=1 if nic304=="371"
replace services_flag=1 if nic304=="372"
replace services_flag=1 if nic304=="401"
replace services_flag=1 if nic304=="402"
replace services_flag=1 if nic304=="403"
replace services_flag=1 if nic304=="410"
replace services_flag=1 if nic304=="502"
replace services_flag=1 if nic304=="504"
replace services_flag=1 if nic304=="526"
replace services_flag=1 if nic304=="630"
replace services_flag=1 if nic304=="725"
replace services_flag=1 if nic304=="749"
replace services_flag=1 if nic304=="900"
replace services_flag=1 if nic304=="921"
replace services_flag=1 if nic304=="930"
replace services_flag=1 if nic304=="999"
replace services_flag=1 if nic304=="014"
replace services_flag=1 if nic304=="142"


****************************
***Clean out states***
*note: We flag Arunachal Pradesh, Mizoram, Sikkim and Union Territory of Lakshadweep with 'state_sample_flag' as these states are covered only in the NSS sample. 
****************************

tab state, mi

g state_sample_flag=0
replace state_sample_flag=1 if state=="ARUNACHAL PRADESH"
replace state_sample_flag=1 if state=="LAKSHADWEEP"
replace state_sample_flag=1 if state=="MIZORAM"
replace state_sample_flag=1 if state=="SIKKIM"
replace state_sample_flag=1 if state=="UNKNOWN"



**************
********	Flag other stuff
*note: We flag other observations with null, zero or negative values in production function accounts.
**************

foreach i in totalemployees totaloutput totalrawmaterials totalfixedassets {
g null_`i'_flag=`i'==. 
g no_`i'_flag=`i'==0
g neg_`i'_flag=`i'<0
}
	

**************
********	Flag other stuff
*note: We flag a observations that are outliers in total output (GT 1 trillion 2005 USD @PPP) by 'high_output_flag'.
**************
count if totaloutput>1000000000 & totaloutput!=.
tab dataset if totaloutput>1000000000 & totaloutput!=.
sum totaloutput, d
g high_output_flag=totaloutput>1000000000
sum totaloutput if high_output_flag==0, d




egen totalunpaidemp=rowtotal(OTHEEFT OTHEEPT TOTOTHEE)
drop OTHEEFT OTHEEPT TOTOTHEE
****************************
***Save Master Dataset
****************************
compress


save "$intdata/ASINSS_AppendedMaster_CleanFlagged.dta", replace

erase "$intdata/ASI_Allyears_Clean.dta"
erase "$intdata/NSS_FINAL.dta"

