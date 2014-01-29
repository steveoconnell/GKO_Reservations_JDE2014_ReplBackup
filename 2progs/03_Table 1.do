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
use "$intdata/ASINSS_Summary.dta", clear

rename totalemployees totalpersonsengaged
tempfile master
save `master'

***OUTPUT TABLES OF SUMMARY STATISTICS - BY STATE , M/F, and YEAR
foreach var of varlist plants  totalpersonsengaged totalunpaidemp totaloutput Femployees Memployees {
replace `var'=`var'*multiplier
}
tempfile temp
save `temp'

g organization2="All others"
replace organization2 =organization if organization =="F_Individual Proprietorship"| organization =="M_Individual Proprietorship"
tab organization
collapse (sum) plants  totalpersonsengaged totaloutput Femployees Memployees, by(survey year organization2 location)
ds, has(type numeric)
format %18.0g `r(varlist)'
outsheet using "$figures/Table1_input.csv", comma replace

erase "$intdata/ASINSS_Summary.dta"

