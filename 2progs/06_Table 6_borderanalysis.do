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
*****create matrix from shapefile
shp2dta using "$data/Maps/Layer files/WB Shapefile/Districts_FINAL.shp", database(indiadb) coordinates(indiacoord) genid(id) replace

****create contiguity matrix
use indiadb, clear
spmat contiguity steve using indiacoord, id(id) saving(districtneighbors.txt,replace)

use indiadb, clear
keep id STATE Final_1
rename Final_1 districtname
tempfile districtname
save `districtname'

use indiadb, clear
keep id STATE
tempfile masterdistlist
save `masterdistlist'
insheet using districtneighbors.txt, clear

split v1,p(" ")
drop v1
rename v11 target
forval i =2/13 {
local j = `i'-1
rename v1`i' neighbor`j'
}
drop if _n==1 & target=="592"
reshape long neighbor, i(target) j(number)
drop if neighbor==""
drop number
destring target neighbor, replace

rename target id
merge m:1 id using `masterdistlist'
drop if _m==2
assert _m==3
drop _m
	rename id target
	rename STATE	state_target
	
rename neighbor id
merge m:1 id using `masterdistlist'
drop if _m==2
assert _m==3
drop _m
	rename id neighbor
	rename STATE	state_neighbor
		
g crossborder=state_target!=state_neighbor

egen mindist=rowmin(target neighbor)
egen maxdist=rowmax( target neighbor)
g uniq_dist_border=string(mindist)+"-"+string(maxdist)
drop mindist maxdist

keep if crossborder

foreach i in target neighbor {
rename `i' id
rename state_`i' STATE
merge m:1 id STATE using `districtname'
	drop if _m==2
	assert _m==3
	drop _m
rename districtname districtname_`i'
rename id `i' 
rename STATE state_`i' 
}

save "$work/crossborder districts.dta", replace

***use mapfile after paring down to cross-border districts
desc
assert state_target!=state_neighbor
assert crossborder==1

***keep only unique pairings
gsort +uniq_dist_border +state_target
bys uniq_dist_border: g rank=_n
tab rank /*every pair should be duplicated once due to data setup*/
*keep if rank==2
*drop rank

encode state_target, g(state1)
encode state_neighbor, g(state2)

g statepair=""
replace statepair=state_target+"-"+state_neighbor if state1<state2
replace statepair=state_neighbor+"-"+state_target if state1>state2
drop state1 state2

replace state_target=upper(state_target)
replace state_neighbor=upper(state_neighbor)

rename state_target FinalState
rename districtname_target districtname

merge m:1 FinalState districtname using "$work/district-level f_entship figures_2005.dta"
	drop if _m==2  /* this is for states not appearing in the base matrix as target states because they do not have any cross-state borders */
	drop if _m==1 /*this is for states with no data or that have been dropped as being late adopters or other reasons */
	drop _m

foreach var of varlist  years_rel_PR1994-   f_workers_ORG2005 {
rename `var' `var'_target
}
rename FinalState state_target
rename districtname districtname_target 

rename state_neighbor FinalState
rename districtname_neighbor districtname	

merge m:1 FinalState districtname using "$work/district-level f_entship figures_2005.dta"
	drop if _m==2  /* this is for states not appearing in the base matrix as target states because they do not have any cross-state borders */
	drop if _m==1 /*this is for states with no data or that have been dropped as being late adopters or other reasons */
	drop _m

rename FinalState state_neighbor 
rename districtname	districtname_neighbor 

foreach var of varlist   years_rel_PR1994-   f_workers_ORG2005 {
rename `var' `var'_neighbor
}


foreach i in plants_new  emp_new     plants  workers workers_m_plt workers_f_plt   workers_ORG {
g ratio_f_`i'_2005= ln((f_`i'2005_target+1)/(f_`i'2005_neighbor+1))
g ratio_f_`i'_1994= ln((f_`i'1994_target+1)/(f_`i'1994_neighbor+1))
g ratio_m_`i'_2005= ln((m_`i'2005_target+1)/(m_`i'2005_neighbor+1))
g ratio_m_`i'_1994= ln((m_`i'1994_target+1)/(m_`i'1994_neighbor+1))
}


g weight=ln(totalpersonsengaged1994_target+1)*ln(totalpersonsengaged1994_neighbor+1)

/*check that this variable encapsulates cumulative exposure to 73rd Amendment */
tab state_target, sum(years_rel_PR2005_target)

g resvs_gap_2005=years_rel_PR2005_target-years_rel_PR2005_neighbor
sum resvs_gap_2005, d

tab state_target if years_rel_PR2005_target==. 
drop if years_rel_PR2005_target==. | years_rel_PR2005_neighbor==.   /*drop all nonadopters from the base dataset */
count
eststo clear


g ctrl1994=.
foreach i in plants_new  emp_new     plants  workers workers_m_plt workers_f_plt {
replace ctrl1994=ratio_f_`i'_1994 
eststo: xi: reg ratio_f_`i'_2005 ctrl1994 resvs_gap_2005 i.state_target i.state_neighbor if rank==1 [w=weight], cluster( statepair)
}

g mctrl2005=.
foreach i in plants_new  emp_new     plants  workers workers_m_plt workers_f_plt {
replace ctrl1994=ratio_f_`i'_1994 
replace mctrl2005=ratio_m_`i'_2005
eststo: xi: reg ratio_f_`i'_2005 ctrl1994  mctrl2005  resvs_gap_2005 i.state_target i.state_neighbor if rank==1 [w=weight], cluster( statepair)
}

cap log c
esttab _all using "$figures/Table 6_border analysis.csv", replace se ar2 star( + .1 ++ .05 +++ .01) b(%9.3f) se(%9.3f) drop(o.* _cons) indicate("Target state FE=_Istate_tar*" "Neighbor state FE=_Istate_nei*")
