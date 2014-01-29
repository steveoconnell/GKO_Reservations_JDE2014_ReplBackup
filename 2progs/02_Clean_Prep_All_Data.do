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
include "$do/subroutines/Clean_Prep_Reservations_Data.do"

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


*****keep cleaning up state names
replace state_ORIG=upper(state_ORIG)
replace state_ORIG="A & N ISLANDS" if state_ORIG=="ANDAMAN AND NICOBAR ISLANDS"
replace state_ORIG="CHHATTISGARH" if state_ORIG=="CHHATISGARH"
replace state_ORIG="DADRA & NAGAR HAVELI" if state_ORIG=="DADRA  AND  NAGAR  HAVELI"
replace state_ORIG="DAMAN & DIU" if state_ORIG=="DAMAN  &  DIU "
replace state_ORIG="MAHARASHTRA" if state_ORIG=="MAHARASTRA"
replace state_ORIG="PONDICHERRY" if state_ORIG=="PONDICHERI"


bys survey: tab state_ORIG year

merge m:1 state year using "$work/Reserved Elections Data_By StateYear.dta"
	drop if _m==2
	assert _m==3
	drop _merge


save "$intdata\ASINSS_Summary.dta", replace


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
, by(state nic304 survey year reserved_electionnum reservedYN reservedYN* years_rsvd years_rel_PR expected_base expected_fill)

order m_workers_ORG f_workers_ORG, after(end)

***CLEAN OUT EXISTING ASI DATA FOR COLLAPSE
foreach i of varlist start-end loanamount totaloutput {
replace `i' = . if survey=="ASI"
}

***COLLAPSE DOWN TO STATE YEAR
collapse (sum) totalpersonsengaged loanamount totaloutput start-end  m_workers_ORG f_workers_ORG ///
, by(state nic304 year reserved_electionnum reservedYN reservedYN* years_rsvd years_rel_PR expected_base expected_fill)


foreach i of varlist f_plants_new f_plants f_emp_new f_emp f_output f_workers f_workers_m_plt ///
m_plants_new m_plants m_emp_new m_emp m_output m_workers m_workers_m_plt  m_workers_ORG f_workers_ORG f_plants_old m_plants_old f_workers_f_plt m_workers_f_plt f_emp_old m_emp_old f_newpl_HH f_oldpl_HH f_newpl_NHH f_oldpl_NHH m_newpl_HH m_oldpl_HH m_newpl_NHH m_oldpl_NHH f_gov_dest_new m_gov_dest_new f_plants_new_loan m_plants_new_loan f_plants_new_noloan m_plants_new_noloan f_plants_new_lt3 f_plants_new_gt4 m_plants_new_lt3 m_plants_new_gt4 ///
{
g ln_`i' = ln(`i'+1)
}




foreach i in f m {
g ln_`i'_avg_size=ln(`i'_emp/`i'_plants)
g ln_`i'_labor_prod=ln(`i'_output/`i'_emp)
g ln_`i'_GVA=ln((`i'_output-`i'_rawmat)/`i'_emp)
g ln_`i'_cap_intens=ln(`i'_assets /`i'_emp)
}

g emp1994 = totalpersonsengaged if year==1994
egen _1994emp4wgt = sum(emp1994 ), by(state nic304)

g ln_st_emp_wgt_ind1994=ln(_1994emp4wgt)
drop _1994emp4wgt emp1994 
*replace ln_st_emp_wgt = 0 if ln_st_emp_wgt<0 //cant have negative weights (created by the log)
drop if ln_st_emp_wgt<=0 
******
**SET 1994 CONDITIONS ON ALL OBS FOR STATE INDUSTRY
******
g HH_plants = f_newpl_HH +f_oldpl_HH +m_newpl_HH +m_oldpl_HH 
g f_HH_plants = f_newpl_HH +f_oldpl_HH 

foreach i in f_plants_new f_plants f_emp_new f_emp f_output ///
f_rawmat f_assets f_workers f_workers_m_plt f_workers_ORG f_plants_old f_workers_f_plt m_plants_new m_plants loanamount f_loanamount totaloutput HH_plants f_HH_plants ///
m_emp_new m_emp m_output ///
m_rawmat m_assets m_workers m_workers_m_plt m_workers_ORG m_plants_old m_workers_f_plt ///
{
g `i'_1994 = `i' if year==1994
egen `i'_1994ind = sum(`i'_1994), by(nic304)
drop `i'_1994
}


foreach i in f_gov_source f_gov_dest  m_gov_source m_gov_dest f_plants m_plants {
g `i'_2000 = `i' if year==2000
egen `i'_2000ind = sum(`i'_2000), by(nic304)
drop `i'_2000
}



g f_avg_size_1994=ln(f_emp_1994ind/f_plants_1994ind)
	g avg_size_1994 =ln((f_emp_1994ind+m_emp_1994ind)/(f_plants_1994ind+m_plants_1994ind))
g f_labor_prod_1994=ln(f_output_1994ind/f_emp_1994ind)
	g labor_prod_1994 = ln((f_output_1994ind+m_output_1994ind)/(f_emp_1994ind+m_emp_1994ind))
g f_GVA_1994=ln((f_output_1994ind-f_rawmat_1994ind)/f_emp_1994ind)
	g GVA_1994 = ln((f_output_1994ind+m_output_1994ind-f_rawmat_1994ind-m_rawmat_1994ind)/(f_emp_1994ind+m_emp_1994ind))
g f_cap_intens_1994=ln((f_assets_1994ind+1)/f_emp_1994ind)
	g cap_intens_1994 =ln((f_assets_1994ind+m_assets_1994ind+1)/(f_emp_1994ind+m_emp_1994ind))
g f_share_pl_1994 = ln((f_plants_1994ind+1)/(f_plants_1994ind+m_plants_1994ind))
g f_share_ent_1994 = ln((f_plants_new_1994ind+1)/(f_plants_new_1994ind+m_plants_new_1994ind))
g f_fin_intens_1994 = ln((f_loanamount_1994ind+1)/(f_output_1994ind +1))
g fin_intens_1994 = ln(loanamount_1994ind/totaloutput_1994ind+1)

g f_gov_source_2000 = ln((f_gov_source_2000ind+1)/f_plants_2000ind)
g f_gov_dest_2000 = ln((f_gov_dest_2000ind+1)/f_plants_2000ind)

g m_gov_source_2000 = ln((m_gov_source_2000ind+1)/m_plants_2000ind)
g m_gov_dest_2000 = ln((m_gov_dest_2000ind+1)/m_plants_2000ind)

g gov_source_2000 = ln((f_gov_source_2000ind+m_gov_source_2000ind+1)/(m_plants_2000ind+f_plants_2000ind))
g gov_dest_2000 = ln((f_gov_dest_2000ind+m_gov_dest_2000ind+1)/(m_plants_2000ind+f_plants_2000ind))

 
g share_HH_1994 = ln((HH_plants_1994ind+1)/(f_plants_1994ind+m_plants_1994ind))
g f_share_HH_1994 = ln((f_HH_plants_1994ind+1)/(f_plants_1994ind+m_plants_1994ind))

g f_share_pl_1994_raw = (f_plants_1994ind)/(f_plants_1994ind+m_plants_1994ind)
g share_HH_1994_raw = (HH_plants_1994ind)/(f_plants_1994ind+m_plants_1994ind)
g f_share_HH_1994_raw = (f_HH_plants_1994ind)/(f_plants_1994ind+m_plants_1994ind)


g ln_f_share_pl_1994= ln(f_share_pl_1994+1)
g ln_f_share_ent_1994= ln(f_share_ent_1994+1)
sum f_share_pl_1994 , d

egen cut33= pctile(f_share_pl_1994),p(33)
egen cut67= pctile(f_share_pl_1994),p(67)

g plantshare_mid3rd =f_share_pl_1994>=cut33&f_share_pl_1994<cut67
g plantshare_top3rd =f_share_pl_1994>=cut67 & f_share_pl_1994!=.

drop cut33 cut67
egen cut33= pctile(f_share_HH_1994),p(33)
egen cut67= pctile(f_share_HH_1994),p(67)

g plantshare_mid3rd_HH =f_share_HH_1994>=cut33&f_share_HH_1994<cut67
g plantshare_top3rd_HH =f_share_HH_1994>=cut67 & f_share_HH_1994!=.


egen stateyear = group(state year)
egen stateindustry = group(state nic304)



foreach i in f_share_pl_1994 share_HH_1994 f_share_HH_1994 f_avg_size_1994 f_GVA_1994 f_cap_intens_1994  f_fin_intens_1994 f_share_pl_1994_raw share_HH_1994_raw f_share_HH_1994_raw {
egen `i'_std=std(`i')
}

compress

label data "GKO (JDE 2014) - Political Reservations - Replication Dataset"

save "$finaldata/ASINSS_st_ind_yr_analysisdataset.dta", replace
