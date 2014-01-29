cap log close
clear
insheet using "$data/Reservations/Effective Rsvd Elections_byState.csv", comma names clear

keep state
tempfile state
save `state'

clear
set obs 22
g year=_n+1988

cross using `state'
order state year
sort state year

tempfile master
save `master'


insheet using "$data/Reservations/Effective Rsvd Elections_byState.csv", comma names clear
preserve
drop _expected
reshape long _, i(state) j(election)
rename _ year
drop if year==.
tempfile elections
save `elections'
restore

keep state _expected
rename _ year
drop if year==.
g expected = 1
tempfile expected
save `expected'

use `master'
merge 1:1 state year using `elections'
drop _
merge 1:1 state year using `expected', assert(1 3) nogen
gsort state +year
bysort state: g rank=_n

*****prep actual reservations
g reserved=election
replace reserved=0 if rank==1 & election==.
g first_PR_election=year if election==1
egen years_rel_PR=sum(first_PR_election), by(state)
replace years_rel_PR=year-years_rel_PR
g noPRelection = first_PR_election==2012
egen noresvs=sum(noPRelection), by(state)
drop first_PR_election



g reserved_73rdDef=reserved
replace reserved_73rdDef = reserved_73rdDef[_n-1] if state==state[_n-1] & election==. & year==year[_n-1]+1
g reservedYN_73rdDef=reserved_73rdDef!=0
by state: gen years_rsvd_73rdDef=sum(reservedYN_73rdDef)

*****prep expected reservations
gsort state +year
replace expected = 0 if expected==.
replace expected = 1 if expected[_n-1]==1 & state==state[_n-1]
egen everexpected = max(expected), by(state)

g expected_base = expected if everexpected
g expected_fill = expected_base
replace expected_fill = 1 if expected_fill == . & reserved_73rdDef!=. & reserved_73rdDef>0
drop everexpected
*****



g reserved_adj_preferred = reserved
replace reserved_adj_preferred = 1 if rank==1 & (state=="Andhra Pradesh" | state=="Karnataka")
replace reserved_adj_preferred = reserved_adj_preferred[_n-1] if state==state[_n-1] & election==. & year==year[_n-1]+1
g reservedYN_adj_preferred=reserved_adj_preferred!=0
by state: gen years_rsvd_adj_preferred=sum(reservedYN_adj_preferred)

g reserved_adj_preferred_pct = reserved_adj_preferred
replace reserved_adj_preferred_pct=25/33 if state=="Andhra Pradesh" & year<1996
replace reserved_adj_preferred_pct=25/33 if state=="Karnataka" & year<1995
g reservedYN_adj_preferred_pct=reserved_adj_preferred_pct!=0
replace reservedYN_adj_preferred_pct=reserved_adj_preferred_pct if state=="Andhra Pradesh" & year<1996
replace reservedYN_adj_preferred_pct=reserved_adj_preferred_pct if state=="Karnataka" & year<1995
by state: gen years_rsvd_adj_preferred_pct=sum(reservedYN_adj_preferred_pct)


replace reserved = 1 if rank==1 & (state=="Andhra Pradesh" | state=="West Bengal" | state=="Karnataka")
replace reserved = reserved[_n-1] if state==state[_n-1] & election==. & year==year[_n-1]+1
drop rank
assert reserved!=.
g reservedYN=reserved!=0
by state: gen years_rsvd=sum(reservedYN)

rename reserved reserved_electionnum 

drop election
label var reserved_electionnum "Current Reserved Election Number"
label var reservedYN "Currently Reserved-YN"
label var years_rsvd "Current Cumulative Years of Reserved Elections"
label var years_rel_PR "Years relative to first Panchayati Raj Election"


g newadd=0
replace newadd=1 if state=="A & N Islands" | state=="Chandigarh" | state=="Dadra & Nagar Haveli" | state=="Daman & Diu" | state=="Delhi" | state=="Jammu & Kashmir" | state=="Lakshadweep" | state=="Meghalaya" | state=="Mizoram" | state=="Nagaland" | state=="Pondicherry"
tab state newadd

replace state=upper(state)
replace years_rel_PR = . if noresvs==1
drop if year==2012
*rename state state_ORIGINAL
save "$work/Reserved Elections Data_By StateYear.dta", replace
