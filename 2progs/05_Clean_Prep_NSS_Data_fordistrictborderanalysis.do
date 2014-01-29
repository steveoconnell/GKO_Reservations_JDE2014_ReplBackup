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
use "$intdata/ASINSS_AppendedMaster_CleanFlagged.dta", clear

/***********************	LIST OF FLAGS IN DATA
output_per_worker_flag
NSS_toobig_flag
emp_outlier_flag
services_flag
state_sample_flag
null_totalemployees_flag
no_totalemployees_flag
neg_totalemployees_flag
null_totaloutput_flag
no_totaloutput_flag
neg_totaloutput_flag
null_totalrawmaterials_flag
no_totalrawmaterials_flag
neg_totalrawmaterials_flag
null_totalfixedassets_flag
no_totalfixedassets_flag
neg_totalfixedassets_flag
high_output_flag
*/
**********************

/*THIS SET STILL OK
output_per_worker_flag
emp_outlier_flag
services_flag
high_output_flag
no_totalemployees_flag
null_totaloutput_flag
no_totaloutput_flag

*/

/*DO NOT APPLY THESE
NSS_toobig_flag
state_sample_flag

null_totalrawmaterials_flag
no_totalrawmaterials_flag
neg_totalrawmaterials_flag
null_totalfixedassets_flag
no_totalfixedassets_flag

Ineffective for NSS:
neg_totalfixedassets_flag
neg_totaloutput_flag
null_totalemployees_flag
neg_totalemployees_flag
*/

g anyflg=0
foreach var of varlist output_per_worker_flag emp_outlier_flag services_flag high_output_flag no_totalemployees_flag null_totaloutput_flag no_totaloutput_flag {
tab dataset `var'
replace anyflg=1 if `var'==1
}


tab dataset anyflg
drop if anyflg
	drop anyflg


*collapse (sum) plants-fixedcapitalformation selfemp_estab selfemp_emp new_estab_uniplant new_emp_uniplant singleunit informal_emp new_emp informal_estab formal_estab new_estab new_estab_informal new_estab_formal small_emp small_estab female_estab female_emp male_estab male_emp, by (  year state state_ORIGINAL district ruralurban organization ownership location nic304 nic404 nic3description nic204 nic2desc  fsize*  under3 enttype)
keep plants-fixedcapitalformation totalunpaidemp multiplier year state state_ORIGINAL district ruralurban organization ownership location nic304 nic404 nic204 under3 age enttype ruralurban survey traditional_loan interestamount typecontract source* dest* 

compress


*****merge in districts to get consistently-defined states
replace state_ORIG=upper(state_ORIG)
replace state_ORIG="A & N ISLANDS" if state_ORIG=="ANDAMAN AND NICOBAR ISLANDS"
replace state_ORIG="CHHATTISGARH" if state_ORIG=="CHHATISGARH"
replace state_ORIG="DADRA & NAGAR HAVELI" if state_ORIG=="DADRA  AND  NAGAR  HAVELI"
replace state_ORIG="DAMAN & DIU" if state_ORIG=="DAMAN  &  DIU "
replace state_ORIG="MAHARASHTRA" if state_ORIG=="MAHARASTRA"
replace state_ORIG="PONDICHERRY" if state_ORIG=="PONDICHERI"


*****THIS IS DONE BECAUSE WE WILL EXPLOIT THE STATE BORDERS AS OF 2005, SO WE NEED TO DISTINGUISH THESE SAME AREAS IN 1994 IN THE CONTROLS
bys survey: tab state_ORIG year
g FinalState=state_ORIG
destring district, replace
replace FinalState="JHARKHAND" if state_ORIG=="BIHAR" & year==1994 & district>=28 & district<=40
replace FinalState="CHHATTISGARH" if state_ORIG=="MADHYA PRADESH" & year==1994 & district>=39 & district<=45
replace FinalState="UTTARANCHAL" if state_ORIG=="UTTAR PRADESH" & year==1994 & ((district>=1 & district<=8) | district==13)

bys survey: tab FinalState year

rename state state_CONSISTENT
rename FinalState state



merge m:1 state year using "$work/Reserved Elections Data_By StateYear.dta"
	drop if _m==2
	assert _m==3
	drop _merge


*******************
***	MERGE IN DISTRICT NAMES & COLLAPSE ON STANDARDIZED NAME FOR FUTURE MERGES
*******************
replace year=2001 if year==2000
merge m:1 state_ORIGINAL district year survey using "$data/Districts/NSS District codes & names.dta"
replace year=2000 if year==2001
drop if _m==2
tab state_ORIGINAL _merge, mi
tab state_ORIGINAL year if _m==1
bysort state_ORIGINAL: tab district year if _m==1

replace FinalState = proper(state_ORIGINAL) if _m==1 & FinalState==""
tab FinalState _m, mi

replace district=999 if _m==1 
replace districtname="Unknown" if _m==1 

tab districtname year if state_ORIGINAL=="DELHI"
replace districtname ="Delhi" if state_ORIGINAL=="DELHI"
replace districtname ="Mumbai" if districtname=="Mumbai Suburban"
replace districtname=trim(districtname)
drop _m
***NOTE THAT THIS MERGE WAS GOOD ONLY FOR NSS NOT ASI



***SPECIFIC PREP FOR BORDER ANALYSIS
keep if year==2005 | year==1994
rename totalemployees totalpersonsengaged

foreach var of varlist plants totalpersonsengaged totaloutput loanamount totalfixedassets totalrawmaterials  Memployees Femployees{
replace `var'=`var'*multiplier
}

g origsize=totalpersonsengaged/multiplier

g start=.

g f_plants_new=plants if under3==1 & organization=="F_Individual Proprietorship"
g f_plants_old=plants if under3==0 & organization=="F_Individual Proprietorship"
g f_plants=plants if organization=="F_Individual Proprietorship"
g f_emp_new=totalpersonsengaged if under3==1 & organization=="F_Individual Proprietorship"
g f_emp_old=totalpersonsengaged if under3==0 & organization=="F_Individual Proprietorship"
g f_emp=totalpersonsengaged if organization=="F_Individual Proprietorship"
g f_output=totaloutput if organization=="F_Individual Proprietorship"
g f_assets=totalfixedassets if organization=="F_Individual Proprietorship"
g f_rawmat=totalrawmaterials if organization=="F_Individual Proprietorship"
g f_workers = Femployees
g f_workers_m_plt = Femployees if organization=="M_Individual Proprietorship"
g f_workers_f_plt = Femployees if organization=="F_Individual Proprietorship"
g f_loanamount = loanamount if organization=="F_Individual Proprietorship"

g f_newpl_HH = plants if under3==1 &  organization=="F_Individual Proprietorship" & location=="Household"
g f_oldpl_HH = plants if under3==0 &  organization=="F_Individual Proprietorship" & location=="Household"
g f_newpl_NHH = plants if under3==1 &  organization=="F_Individual Proprietorship" & location=="Non-Household"
g f_oldpl_NHH = plants if under3==0 &  organization=="F_Individual Proprietorship" & location=="Non-Household"


g m_plants_new=plants if under3==1 & organization=="M_Individual Proprietorship"
g m_plants_old=plants if under3==0 & organization=="M_Individual Proprietorship"
g m_plants=plants if organization=="M_Individual Proprietorship"
g m_emp_new=totalpersonsengaged if under3==1 & organization=="M_Individual Proprietorship"
g m_emp_old=totalpersonsengaged if under3==0 & organization=="M_Individual Proprietorship"
g m_emp=totalpersonsengaged if organization=="M_Individual Proprietorship"
g m_output=totaloutput if organization=="M_Individual Proprietorship"
g m_assets=totalfixedassets if organization=="M_Individual Proprietorship"
g m_rawmat=totalrawmaterials if organization=="M_Individual Proprietorship"
g m_workers = Memployees
g m_workers_m_plt = Memployees if organization=="M_Individual Proprietorship"
g m_workers_f_plt = Memployees if organization=="F_Individual Proprietorship"

g m_newpl_HH = plants if under3==1 &  organization=="M_Individual Proprietorship" & location=="Household"
g m_oldpl_HH = plants if under3==0 &  organization=="M_Individual Proprietorship" & location=="Household"
g m_newpl_NHH = plants if under3==1 &  organization=="M_Individual Proprietorship" & location=="Non-Household"
g m_oldpl_NHH = plants if under3==0 &  organization=="M_Individual Proprietorship" & location=="Non-Household"

g f_gov_source = plants if (sourceagency1==1 | sourceagency2==1) &  organization=="F_Individual Proprietorship"
g f_gov_dest = plants if (destagency1==1 | destagency2==1) &  organization=="F_Individual Proprietorship"
g f_gov_dest_new = plants if (destagency1==1 | destagency2==1) &  organization=="F_Individual Proprietorship" & under3==1

g m_gov_source = plants if (sourceagency1==1 | sourceagency2==1) &  organization=="M_Individual Proprietorship"
g m_gov_dest = plants if (destagency1==1 | destagency2==1) &  organization=="M_Individual Proprietorship"
g m_gov_dest_new = plants if (destagency1==1 | destagency2==1) &  organization=="M_Individual Proprietorship" & under3==1

g f_plants_new_loan = plants if under3==1 & organization=="F_Individual Proprietorship" & loanamount>0 & loanamount!=.
g m_plants_new_loan = plants if under3==1 & organization=="M_Individual Proprietorship" & loanamount>0 & loanamount!=.

g f_plants_new_noloan = plants if under3==1 & organization=="F_Individual Proprietorship" & (loanamount==0 | loanamount==.)
g m_plants_new_noloan = plants if under3==1 & organization=="M_Individual Proprietorship" & (loanamount==0 | loanamount==.)



g m_workers_ORG = m_workers if survey=="ASI"
g f_workers_ORG = f_workers if survey=="ASI"


g f_plants_new_lt3=plants if under3==1 & organization=="F_Individual Proprietorship" & survey=="NSS" & origsize<=3
g f_plants_new_gt4=plants if under3==1 & organization=="F_Individual Proprietorship" & survey=="NSS" & origsize>=4 & origsize !=.

g m_plants_new_lt3=plants if under3==1 & organization=="M_Individual Proprietorship" & survey=="NSS" & origsize<=3
g m_plants_new_gt4=plants if under3==1 & organization=="M_Individual Proprietorship" & survey=="NSS" & origsize>=4 & origsize !=.

g end=.
collapse (sum) totalpersonsengaged loanamount totaloutput start-end ///
, by(FinalState nic304 districtname survey year reserved_electionnum reservedYN reservedYN* years_rsvd years_rel_PR )

order m_workers_ORG f_workers_ORG, after(end)

***CLEAN OUT EXISTING ASI DATA FOR COLLAPSE
foreach i of varlist start-end loanamount totaloutput {
replace `i' = . if survey=="ASI"
}

collapse (sum) totalpersonsengaged loanamount totaloutput start-end  m_workers_ORG f_workers_ORG, by(FinalState year districtname years_rel_PR)
drop start end



g start=.
g f_entship_rate=f_plants_new/f_plants
g m_entship_rate=m_plants_new/m_plants
g f_entship_rate_emp=f_emp_new/f_emp
g m_entship_rate_emp=m_emp_new/m_emp
g fm_entrant_ratio=f_plants_new/m_plants_new
g fm_entrantemp_ratio=f_emp_new/m_emp_new
g end=.
keep FinalState year districtname years_rel_PR f_plants_new f_plants f_emp_new f_workers f_workers_m_plt f_workers_f_plt   f_workers_ORG ///
m_plants_new m_plants m_emp_new m_workers m_workers_m_plt m_workers_f_plt   m_workers_ORG ///
totalpersonsengaged
*start-end  m_plants_new m_plants f_emp_new f_emp m_emp_new m_emp 
*drop start end
replace FinalState=upper(FinalState)

drop if districtname=="Unknown"

*save "$work/district-level f_entship figures_long.dta", replace
reshape wide f_plants_new f_plants f_emp_new f_workers f_workers_m_plt f_workers_f_plt   f_workers_ORG  m_plants_new m_plants m_emp_new m_workers m_workers_m_plt m_workers_f_plt   m_workers_ORG years_rel_PR totalpersonsengaged, i(FinalState districtname) j(year )
save "$work/district-level f_entship figures_2005.dta", replace



erase "$intdata/ASINSS_AppendedMaster_CleanFlagged.dta"

