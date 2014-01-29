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
use "$finaldata/ASINSS_st_ind_yr_analysisdataset.dta"

eststo clear
foreach i in  plants_new  emp_new     plants  workers workers_m_plt workers_f_plt   workers_ORG {
eststo: xi: areg ln_f_`i'  reservedYN_adj_preferred_pct i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster state) absorb(stateindustry)
}

cap g DV_m_analogue=.
foreach i in  plants_new  emp_new    plants   workers workers_m_plt workers_f_plt   workers_ORG {
replace DV_m_analogue = ln_m_`i'
eststo: xi: areg ln_f_`i'  reservedYN_adj_preferred_pct DV_m_analogue i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster state) absorb(stateindustry)
replace ln_m_`i' = DV_m_analogue
}

noi esttab _all using "$figures/Table 2_Final.csv", replace se ar2 star( + .1 ++ .05 +++ .01) b(%9.3f) se(%9.3f) ///
drop( _I* _cons o.* )


eststo clear
foreach i in  plants_new newpl_HH newpl_NHH plants_new_lt3 plants_new_gt4 plants_new_noloan plants_new_loan {
eststo: xi: areg ln_f_`i'  reservedYN_adj_preferred_pct i.year*i.nic304 [w=ln_st_emp_wgt], absorb(stateindustry) vce(cluster state)
}

foreach i in  plants_new newpl_HH newpl_NHH plants_new_noloan plants_new_loan plants_new_lt3 plants_new_gt4 {
replace DV_m_analogue = ln_m_`i'
eststo: xi: areg ln_f_`i'  reservedYN_adj_preferred_pct  DV_m_analogue i.year*i.nic304 [w=ln_st_emp_wgt], absorb(stateindustry) vce(cluster state)
replace ln_m_`i' = DV_m_analogue
}

noi esttab _all using "$figures/Table 3_Final.csv", replace se ar2 star( + .1 ++ .05 +++ .01) b(%9.3f) se(%9.3f) ///
drop( _I* _cons o.* )





eststo clear
foreach j in f_share_pl_1994_std share_HH_1994_std f_share_HH_1994_std f_avg_size_1994_std f_GVA_1994_std f_cap_intens_1994_std f_fin_intens_1994_std {
eststo: xi: areg ln_f_plants_new  c.`j'#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
}

replace DV_m_analogue = ln_m_plants_new
foreach j in f_share_pl_1994_std share_HH_1994_std f_share_HH_1994_std f_avg_size_1994_std f_GVA_1994_std f_cap_intens_1994_std f_fin_intens_1994_std {
eststo: xi: areg ln_f_plants_new DV_m_analogue  c.`j'#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
}
noi esttab _all using "$figures/Table 4_Final.csv", replace se ar2 star( + .1 ++ .05 +++ .01) b(%9.3f) se(%9.3f) ///
drop( _I* _cons o.* )


eststo clear

g ln_f_share_HH_1994=ln(f_share_HH_1994+1)

eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct   i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_raw#c.reservedYN_adj_preferred_pct   i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_raw_std#c.reservedYN_adj_preferred_pct   i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new  c.plantshare_mid3rd_HH#c.reservedYN_adj_preferred_pct  c.plantshare_top3rd_HH#c.reservedYN_adj_preferred_pct   i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)

eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct  ln_m_plants_new i.state*i.year  i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_raw#c.reservedYN_adj_preferred_pct ln_m_plants_new i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_raw_std#c.reservedYN_adj_preferred_pct ln_m_plants_new i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new  c.plantshare_mid3rd_HH#c.reservedYN_adj_preferred_pct c.plantshare_top3rd_HH#c.reservedYN_adj_preferred_pct  ln_m_plants_new i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)

noi esttab _all using "$figures/Appendix Table 5_Final.csv", replace se ar2 star( + .1 ++ .05 +++ .01) b(%9.3f) se(%9.3f) ///
drop( _I* _cons o.* )


eststo clear
eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_std#c.reservedYN i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt] if state!="ANDHRA PRADESH" & state!="KARNATAKA", vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 if (state!="A & N ISLANDS" & state!="CHANDIGARH" & state!="DADRA & NAGAR HAVELI" & state!="DAMAN & DIU" & state!="JAMMU & KASHMIR" & state!="LAKSHADWEEP" & state!="MEGHALAYA" & state!="MIZORAM" & state!="NAGALAND" & state!="PONDICHERRY")  [w=ln_st_emp_wgt], absorb(stateindustry) vce(cluster stateindustry)
eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 if substr(nic304,1,2)!="24" & substr(nic304,1,2)!="16" [w=ln_st_emp_wgt], absorb(stateindustry) vce(cluster stateindustry)
eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster state)  absorb(stateindustry)
eststo: xi: areg ln_f_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct reservedYN_adj_preferred_pct i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)



eststo: xi: areg ln_f_plants_new ln_m_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new ln_m_plants_new  c.f_share_HH_1994_std#c.reservedYN i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new ln_m_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt] if state!="ANDHRA PRADESH" & state!="KARNATAKA", vce(cluster stateindustry) absorb(stateindustry)
eststo: xi: areg ln_f_plants_new ln_m_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 if (state!="A & N ISLANDS" & state!="CHANDIGARH" & state!="DADRA & NAGAR HAVELI" & state!="DAMAN & DIU" & state!="JAMMU & KASHMIR" & state!="LAKSHADWEEP" & state!="MEGHALAYA" & state!="MIZORAM" & state!="NAGALAND" & state!="PONDICHERRY") [w=ln_st_emp_wgt], absorb(stateindustry) vce(cluster stateindustry)
eststo: xi: areg ln_f_plants_new ln_m_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 if substr(nic304,1,2)!="24" & substr(nic304,1,2)!="16" [w=ln_st_emp_wgt], absorb(stateindustry) vce(cluster stateindustry)
eststo: xi: areg ln_f_plants_new ln_m_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct i.state*i.year i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster state)  absorb(stateindustry)
eststo: xi: areg ln_f_plants_new ln_m_plants_new  c.f_share_HH_1994_std#c.reservedYN_adj_preferred_pct reservedYN_adj_preferred_pct i.year*i.nic304 [w=ln_st_emp_wgt], vce(cluster stateindustry)  absorb(stateindustry)

noi esttab _all using "$figures/Table 5_Final.csv", replace se ar2 star( + .1 ++ .05 +++ .01) b(%9.3f) se(%9.3f) ///
drop( _I* _cons o.* )
