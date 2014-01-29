clear
use "$data/Deflators/GHK/KarlJandocDeflators_Gupta_Hasan_Kumar_2009.dta", clear
g base2005=wpi_nic98_3dig_con if year==2005
egen baseval=sum(base2005), by (nic98_3dig_con)
g wpi_deflator=wpi_nic98_3dig_con /baseval
keep year nic98_3dig_con wpi_deflator

rename nic98 nic398


preserve
use "$work\NIC9804Crosswalk.dta", clear
keep nic498 nic304
g nic398=substr(nic498,1,3)
drop nic498
duplicates drop

	bysort nic398: g rank=_N
	tab rank
	assert rank==1
	drop rank
destring nic398, replace
tempfile nic3Xwalk
save `nic3Xwalk'

restore
merge m:1 nic398 using `nic3Xwalk'
	tab _m
	drop if _m==2
	assert _m==3
	drop _merge

drop nic398
order nic304 wpi_deflator

tempfile industry_deflator
save "$work\industry_deflator.dta", replace
