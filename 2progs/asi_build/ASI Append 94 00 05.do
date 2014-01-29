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
****APPEND SEPARATE YEARS OF DATA TOGETHER
use "$intdata/ASI0001_clean", clear
append using "$intdata/ASI0506_clean"
egen totallabourcosttotal=rowtotal(wagesandsalariestotalEEs bonustotalEEs  contributiontopftotalEEs welfareexpensetotalEEs)
destring psl, replace
append using "$intdata/ASI9495_clean.dta"

# delim ;
keep
uniqid
yearofinitialprod
state
district
ruralurban
industry*
noofunits
status
noofmanufacturingdays
totalnoofworkingdays
totalnoofshifts
lengthofshifts
monthsofoperation 
typeoforganisation
typeofownership
year
multiplier

closeoutstandingloan
interest

valueofelectricitysold
valueelectricitypurchased
electricitygenerated
electricitypurchased
electricityconsumed

totalrent

_avgmen
_avgwomen
_avgmen _avgwomen _avgchildren _avgthrucontr _avgsupervstaff _avgotheremployees _avggproprietors _avgtotalEE

_avgunpaidEE

wagesandsalariestotalEEs


totallabourcosttotal
closingnetland
closingnetbuilding
itemwiseexactvalue
grosssalevalue
valuetotalrawmaterials
totallabourcosttotal
closingnettotalFA
closingnettotalFA openingnettotalFA
valuetotalimportedmaterials
;


# delim ;	
	
	
rename yearofinitialprod startyear	;
	
	
	
	
rename noofunits plants	;
	
rename noofmanufacturingdays manufdays	;
rename totalnoofworkingdays workingdays	;
rename totalnoofshifts noofshifts	;
rename lengthofshifts lengthshifts	;
rename typeoforganisation organization	;
rename typeofownership ownership	;
rename  monthsofoperation monthsops;

	
	
	
rename closeoutstandingloan loanamount	;
rename interest interestamount	;
	
*rename electricitypurchased electricityexpense	;
*rename electricitygenerated ownelectricitygenerated	;
	
rename totalrent totalFArent	;
	
rename _avgmen Memployees	;
rename _avgwomen Femployees	;
rename _avgtotalEE totalemployees	;
rename _avgunpaidEE TOTOTHEE ;
rename wagesandsalariestotalEEs Totalemployeeswagebill	;
rename totallabourcosttotal totalemployeestotalLcost	;
	
rename itemwiseexactvalue totaloutput	;
rename grosssalevalue totalsales	;
rename valuetotalrawmaterials totalrawmaterials	;
g fixedcapitalformation= closingnettotalFA-openingnettotalFA	;
rename closingnettotalFA totalfixedassets	;
rename valuetotalimportedmaterials totalimports	;

replace industrycode5=substr("00000"+industrycode5,length("00000"+industrycode5)-4,5);
replace industrycode=substr(industrycode5,1,4) if industrycode=="9999" & year>=2000 ;
*drop industrycode5; 

#delim cr
***figure out open-closed---& drop closed
destring ruralurban, replace
replace ruralurban=2 if ruralurban==3
replace ruralurban=ruralurban-1
tab ruralurban
replace ruralurban=. if ruralurban<0 | ruralurban>2

keep if (status==0 & (year==1989 | year==1994)) | (status==1 & (year==2000 | year==2005))


drop  openingnettotalFA _avgchildren _avgotheremployees _avgsupervstaff _avgthrucontr status manufdays workingdays noofshifts lengthshifts _avggproprietors 

g survey="ASI"

save "$intdata/ASI_Allyears_Clean.dta", replace

erase "$intdata/ASI9495_clean.dta"
erase "$intdata/ASI0001_clean.dta"
erase "$intdata/ASI0506_clean.dta"
