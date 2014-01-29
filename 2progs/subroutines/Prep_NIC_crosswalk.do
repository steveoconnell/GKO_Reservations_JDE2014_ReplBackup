clear
insheet using "$data/Concordances/Crosswalk NIC 87 to 98.csv", clear

split nic387,p(+)
drop nic387

tempfile temp
save `temp'

local i = 1
foreach var of varlist nic387* {
use `temp' , clear
keep nic498 `var'
rename `var' nic387
drop if nic387==""
tempfile temp`i'
save `temp`i''
local max=`i'
local i=`i'+1
}

local i = 2
use `temp1', clear
while `i' <=`max' {
append using `temp`i''
local i=`i'+1
}

g length=length(nic387)
replace nic387=substr(nic387,2,3) if length==4
drop length
replace nic387=substr("000"+nic387,length("000"+nic387)-2,3)
tostring nic498, replace
replace nic498=substr("0000"+nic498,length("0000"+nic498)-3,4)
rename nic498 nic498a

save "$work/NIC8798Crosswalk.dta", replace


insheet using "$data/Concordances/Crosswalk NIC 98 to 04.csv", clear
tostring _all, replace
replace nic498=substr("0000"+nic498,length("0000"+nic498)-3,4)
replace nic404=substr("0000"+nic404,length("0000"+nic404)-3,4)
replace nic304=substr("000"+nic304,length("000"+nic304)-2,3)

gsort +nic498 +nic404
bysort nic498: g rank=_n
bysort nic498: g rank2=_N
g keep =1 if rank==1
replace keep =. if rank2>1
replace keep =1 if rank2>1 & nic498==nic404
replace keep = 1 if keep==. & rank2>1 & rank==1
keep if keep==1
drop rank* keep
bysort nic498: g rank2=_N
drop if rank2>1 & nic498!=nic404
drop rank2

rename nic404 nic404a

save "$work/NIC9804Crosswalk.dta", replace
