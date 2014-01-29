************************************************************************
***************Ghani - Kerr - O'Connell 		 ***********************
***************Political Reservations and Women's Entrepreneuship*******
***************Journal of Development Economics, 2014 ******************
***************Replication Backup				 ***********************
************************************************************************
***Note that this file is for a general-purpose data read-in & clean, thus
***operates on far more variables than may be necessary given final use.
clear
clear matrix
clear mata
cap log close

global root "C:/OpenCode/GKO_Reservations_JDE2014_ReplBackup"
include "$root/2progs/00_Set_paths.do"
************************************************************************
************************************************************************
use "$intdata/master62_clean"
rename mos_account mos_account

append using "$intdata/master56_clean"

decode location, g (location2)
drop location
rename location location

append using "$intdata/master51_clean"

g under3yrsold=(entstatus==9 & year==2001) | (entstatus==4 & year==2006)

rename sector rural_urban
drop  centrecode-sample stateregion subround-level totalassets_delta acctsmaint natureops -  mixed roundschedule- reasonsubst

# delim ;
order
uniqid
NICcode
industrycode5
state
district
year
enttype
rural_urban
registered
age
NSSWeight
NSCWeight
MLTWeight
multiplier
ownership
monthsop
mos_account

totalemp
totalcomp
totalsalary
totalbenefits

rawmat_elec
rawmat_fuel_lube
totalrawmat
tottrade_othactexp
totothexp
totalopexp
totaldistexp
totalexp


totalrevenue
totalreceipts
GVA


totalvalueassetsowned
totalvalueassetshired
totalrentassetshired
totalloanamount
totalloanint

probelecnoavail
probpowerout
probnocapital
probnorawmats
probmkting
probother


;

# delim cr





egen x=rowtotal(totalopexp totaldistexp)
replace totalexp=x if totalexp==. & x!=.
drop x


foreach var of varlist  workerownfullfemale- workertotalpartmale {
replace `var'=0 if `var'==.
}


g MFT =( workerownfullmale+workerhiredfullmale)
g OTHMFT  =(  workerotherfullmale) 
g MPT  =(  workerownpartmale+ workerhiredpartmale ) 
g OTHMPT  =( workerotherpartmale) 


g FFT  =(  workerownfullfemale+ workerhiredfullfemale ) 
g OTHFFT  =( workerotherfullfemale) 
g FPT  =(  workerownpartfemale+ workerhiredpartfemale ) 
g OTHFPT  =( workerotherpartfemale) 


g OTHEEFT  =( OTHFFT  +OTHMFT  ) 
g OTHEEPT  =( OTHFPT  +OTHMPT  ) 

replace EEFT  =( MFT + FFT +OTHEEFT) if EEFT==.
replace EEPT =( MPT + FPT +OTHEEPT) if EEPT==.

g TOTAL_EE=EEFT+.5*EEPT
g TOTAL_M_EE=MFT+OTHMFT+.5*(MPT+OTHMPT)
g TOTAL_F_EE=FFT+OTHFFT+.5*(FPT+OTHFPT)
g totemp=EEFT+EEPT

drop  workerownfullfemale- workerotherpartmale workertotalfullfemale- workertotalpartmale totalemp

***Apply multipliers
replace multiplier = MLTWeight/100 if NSCWeight ==NSSWeight & year>=2001
replace multiplier = MLTWeight/200 if NSCWeight > NSSWeight & year>=2001 
drop NSS NSC MLT

***Clean State
replace state="A & N Islands" if state=="Andaman & Nicober"
replace state="Andhra Pradesh" if state=="Andhra Pardesh"
replace state="Chhattisgarh" if state=="Chattigarh"
replace state="Gujarat" if state=="Gujrat"
replace state="Lakshadweep" if state=="Lakshdweep"
replace state="Maharastra" if state=="Maharashtra"
replace state="Pondicheri" if state=="Pondicherry"



***CLEAN AND DROP ***
rename GVA gva
rename totalvaluea~ned value_fixed_assets

rename totalloanamount value_loans

rename monthsop monthsops
drop EEFT
drop EEPT
drop MFT
drop MPT
drop FFT
drop FPT
drop OTHMFT
drop OTHMPT
drop OTHFFT
drop OTHFPT
*drop OTHEEFT
*drop OTHEEPT
rename  TOTAL_EE totalemployees
rename totemp totalemployees_halfpart



rename totalsalary totalwages

rename rawmat_elec electricity_exp
rename rawmat_fuel_l~e petrol_lube_exp

rename tottrade_otha~p nonop_exp

rename totalopexp op_exp
rename totaldistexp total_distributivexp

rename totalrentasse~d rent_fixedassets
rename totalloanint int_paid

rename totalrevenue gross_output
rename totalreceipts gross_sales

drop probelecnoavail
drop probpowerout
drop probnocapital
drop probnorawmats
drop probmkting
drop probother





g survey="NSS"

# delim ;
order 
uniqid
year
state
district
rural_urban
enttype
ownership
registered
location
age
NICcode
industrycode5
multiplier
survey

gva
value_fixed_assets
totalvaluea~red
value_loans

monthsops
totalemployees
totalemployees_halfpart
TOTAL_M_EE
TOTAL_F_EE
OTHEEFT
OTHEEPT

totalcomp
totalwages
totalbenefits
totalbonus

electricity_exp
petrol_lube_exp
totalrawmat
nonop_exp
totothexp
op_exp
total_distributivexp
totalexp
rent_fixedassets
int_paid

gross_output
gross_sales
;


# delim ;
keep
uniqid

state
district
rural_urban
NICcode
industrycode5
age
under3yrsold




monthsops
mos_account
ownership
enttype
registered
location
year

multiplier

typecontr
source*
dest*

value_loans
int_paid

electricity_exp


rent_fixedassets

TOTAL_M_EE
TOTAL_F_EE
totalemployees
totalemployees_halfpart
OTHEEFT
OTHEEPT


totalwages


totalcomp

gross_output
gross_sales
totalrawmat

value_fixed_assets


outstandingend_inst
interest_inst
outstandingend_agency
interest_agency
outstandingend_moneylend
interest_moneylend
outstandingend_buspart
interest_buspart
outstandingend_contractor
interest_contractor
outstandingend_frfam
interest_frfam
outstandingend_other
interest_other

outstandingbeg_gov
borrowings_gov
repayment_gov
outstandingend_gov
outstandingbeg_statefincorp
borrowings_statefincorp
repayment_statefincorp
outstandingend_statefincorp
outstandingbeg_rrb
borrowings_rrb
repayment_rrb
outstandingend_rrb
outstandingbeg_pubbank
borrowings_pubbank
repayment_pubbank
outstandingend_pubbank
outstandingbeg_combank
borrowings_combank
repayment_combank
outstandingend_combank
outstandingbeg_coopbank
borrowings_coopbank
repayment_coopbank
outstandingend_coopbank
outstandingbeg_KVIC
borrowings_KVIC
repayment_KVIC
outstandingend_KVIC
outstandingbeg_moneylend
borrowings_moneylend
repayment_moneylend
outstandingbeg_frfam
borrowings_frfam
repayment_frfam
outstandingbeg_other
borrowings_other
repayment_other
outstandingbeg_total
borrowings_total
repayment11
;


# delim ;	
	
	
	
	
rename rural_urban ruralurban	;
rename NICcode industrycode	;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
rename value_loans loanamount	;
rename int_paid interestamount	;
	
rename electricity_exp electricityexpense	;
	
	
rename rent_fixedassets totalFArent	;
	
rename TOTAL_M_EE Memployees	;
rename TOTAL_F_EE Femployees	;
	
	
	
rename totalwages Totalemployeeswagebill	;
	
	
rename totalcomp totalemployeestotalLcost	;
	
rename gross_output totaloutput	;
rename gross_sales totalsales	;
rename totalrawmat totalrawmaterials	;
	
rename value_fixed_assets totalfixedassets	;




replace year=year-1;


#delim cr
***Fix organization***
g organization=ownership
drop ownership
tostring organization, replace
tab organization, mi

replace organization="Individual Proprietorship" if organization=="1" & year==1989
replace organization="Partnership" if organization=="2" & year==1989
replace organization="Partnership" if organization=="3" & year==1989
replace organization="Co-Operative Society" if organization=="4" & year==1989
replace organization="Public  Limited  Company" if organization=="5" & year==1989
replace organization="Private Limited  Company" if organization=="6" & year==1989
replace organization="Others  (including  trusts, wakf,  boards etc.)" if organization=="9" & year==1989


replace organization="M_Individual Proprietorship" if organization=="1" & year==1994
replace organization="F_Individual Proprietorship" if organization=="2" & year==1994
replace organization="Partnership" if organization=="3" & year==1994
replace organization="Partnership" if organization=="4" & year==1994
replace organization="Co-Operative Society" if organization=="5" & year==1994
replace organization="Public  Limited  Company" if organization=="6" & year==1994
replace organization="Private Limited  Company" if organization=="7" & year==1994
replace organization="Others  (including  trusts, wakf,  boards etc.)" if organization=="8" & year==1994
replace organization="Others  (including  trusts, wakf,  boards etc.)" if organization=="9" & year==1994
replace organization="Others  (including  trusts, wakf,  boards etc.)" if organization=="0" & year==1994
replace organization="Others  (including  trusts, wakf,  boards etc.)" if organization=="." & year==1994


replace organization="M_Individual Proprietorship" if organization=="1" & year>1996
replace organization="F_Individual Proprietorship" if organization=="2" & year>1996
replace organization="Partnership" if organization=="3" & year>1996
replace organization="Partnership" if organization=="4" & year>1996
replace organization="Co-Operative Society" if organization=="5" & year>1996
replace organization="Private Limited  Company" if organization=="6" & year>1996
replace organization="Others  (including  trusts, wakf,  boards etc.)" if organization=="9" & year>1996

tab organization, mi


tab location, mi
replace location="Unknown" if location==""
replace location="Household" if location=="Within HH"
replace location="Non-Household" if location=="NonHH Fixed Perm & Temp Str"
replace location="Non-Household" if location=="NonHH Fixed Prem & No Str"
replace location="Non-Household" if location=="NonHH Fixed Prem & Perm Str"
replace location="Non-Household" if location=="Mobile Market"
replace location="Non-Household" if location=="No Fixed Prem"
replace location="Non-Household" if location=="No fixed premises"


label drop sector
replace ruralurban=ruralurban-1

# delim cr
*****Clean up financing accounts
foreach var of varlist outstandingbeg_* borrowings_* repayment_* outstandingend_* interest_* {
replace `var' = 0 if `var'==.
}

g traditional_loan = outstandingend_inst +outstandingend_agency  if year>=2000
replace traditional_loan = outstandingend_gov + outstandingend_statefincorp + outstandingend_rrb + outstandingend_pubbank + outstandingend_combank + outstandingend_coopbank + outstandingend_KVIC if year<2000


#delim ;
drop
outstandingend_inst
interest_inst
outstandingend_agency
interest_agency
outstandingend_moneylend
interest_moneylend
outstandingend_buspart
interest_buspart
outstandingend_contractor
interest_contractor
outstandingend_frfam
interest_frfam
outstandingend_other
interest_other

outstandingbeg_gov
borrowings_gov
repayment_gov
outstandingend_gov
outstandingbeg_statefincorp
borrowings_statefincorp
repayment_statefincorp
outstandingend_statefincorp
outstandingbeg_rrb
borrowings_rrb
repayment_rrb
outstandingend_rrb
outstandingbeg_pubbank
borrowings_pubbank
repayment_pubbank
outstandingend_pubbank
outstandingbeg_combank
borrowings_combank
repayment_combank
outstandingend_combank
outstandingbeg_coopbank
borrowings_coopbank
repayment_coopbank
outstandingend_coopbank
outstandingbeg_KVIC
borrowings_KVIC
repayment_KVIC
outstandingend_KVIC
outstandingbeg_moneylend
borrowings_moneylend
repayment_moneylend
outstandingbeg_frfam
borrowings_frfam
repayment_frfam
outstandingbeg_other
borrowings_other
repayment_other
outstandingbeg_total
borrowings_total
repayment11
;
#delim cr

g survey="NSS"
save "$intdata/NSS_FINAL", replace

erase "$intdata/master51_clean.dta"
erase "$intdata/master56_clean.dta"
erase "$intdata/master62_clean.dta"
