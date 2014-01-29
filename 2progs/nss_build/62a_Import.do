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
global NSS62 "$data/NSS/Nss62_2.2/Data/"

foreach i in AH1C22 AH2C22 AH3C22 AH4C22 AH5C22 AH6C22 AH7C22 AH8C22 ALHCS22 {	
#delim ;
clear;
qui infix	
centrecode	1 -3
lotfsunum	4 -8
frame	9
round	10 -11
schedule	12 -14
sample	15
sector	16
stateregion	17 -19
district	20 -21
subround	22
subsample	23
fodsubregion	24 -27
stratum	28 -29
substratum	30 -31
segment	32
sss	33
enterpriseno	34 -35
level	36 -37
fill	38 -42
informantcode	43
responsecode	44
surveycode	45
substitutioncode	46
permserialno	47 -51
timecanvass	52 -54
datesurvey	55 -60
datedispatch	61 -66
specchara	67 -68
blank	69 -126
NSSWeight	127-129
NSCWeight	130-132
MLTWeight	133-142
using "$NSS62//`i'.TXT" ;	
drop fill specchara blank;	
keep if level==1;	
g uniqid=string(lotfsunum) +string(segment) +string(sss)+string(enterpriseno);	
save temp1, replace;	
clear;	
	
	
	
	
qui infix	
centrecode	1 -3
lotfsunum	4 -8
frame	9
round	10 -11
schedule	12 -14
sample	15
sector	16
stateregion	17 -19
district	20 -21
subround	22
subsample	23
fodsubregion	24 -27
stratum	28 -29
substratum	30 -31
segment	32
sss	33
enterpriseno	34 -35
level	36 -37
fill	38 -42
NICcode	43 -48
natureops	49
monthsop	50 -51
hourswkdyear	52 -53
hrswkdmonth	54 -55
mixed	56
ownership	57
otheractivity	58
majorsrcinc	59
pctanninc	60 -61
NICcode2	62
edulevelowner	63 -64
acctsmaint	65
str datafrom	66 -71
str datato	72 -77
location	78
registered	79
rgstr1	80 -81
rgsrt2	82 -83
sourceagency1	84
sourceagency2	85
destagency1	86
destagency2	87
probelecnoavail	88
probpowerout	89
probnocapital	90
probnorawmats	91
probmkting	92
probother	93
contractbasis	94
typecontract	95
equipsuppl	96
rawsuppl	97
designbycontr	98
assist5yrs1	99
assist5yrs2	100
entstatus	101
enttype	102
specchara	103 -104
blank	107 -126
NSSWeight	127-129
NSCWeight	130-132
MLTWeight	133-142
using "$NSS62//`i'.TXT" ;	
drop fill specchara blank;	
keep if level==2;	
g uniqid=string(lotfsunum) +string(segment) +string(sss)+string(enterpriseno);	
save temp2, replace;	
clear;	
	
	
	
	
qui infix	
centrecode	1 -3
lotfsunum	4 -8
frame	9
round	10 -11
schedule	12 -14
sample	15
sector	16
stateregion	17 -19
district	20 -21
subround	22
subsample	23
fodsubregion	24 -27
stratum	28 -29
substratum	30 -31
segment	32
sss	33
enterpriseno	34 -35
level	36 -37
fill	38 -39
itemcode	40 -42
ASICCcode	43 -47
unitofQ	48 -49
quantity	50 -61
value	62 -73
specchara	74 -75
blank	76 -126
NSSWeight	127-129
NSCWeight	130-132
MLTWeight	133-142
using "$NSS62//`i'.TXT" ;	
drop fill specchara blank;	
keep if level==3;	
g uniqid=string(lotfsunum) +string(segment) +string(sss)+string(enterpriseno);	
reshape wide  ASICCcode- value, i( uniqid) j( itemcode);	
save temp3, replace;	
clear;	
	
	
	
qui infix	
centrecode	1 -3
lotfsunum	4 -8
frame	9
round	10 -11
schedule	12 -14
sample	15
sector	16
stateregion	17 -19
district	20 -21
subround	22
subsample	23
fodsubregion	24 -27
stratum	28 -29
substratum	30 -31
segment	32
sss	33
enterpriseno	34 -35
level	36 -37
fill	38 -39
itemcode	40 -42
value	43 -54
specchara	55 -56
blank	57 -126
NSSWeight	127-129
NSCWeight	130-132
MLTWeight	133-142
using "$NSS62//`i'.TXT" ;	
drop fill specchara blank;	
keep if level==4;	
g uniqid=string(lotfsunum) +string(segment) +string(sss)+string(enterpriseno);	
reshape wide  value, i( uniqid) j( itemcode);	
save temp4, replace;	
clear;	
	
	
qui infix	
centrecode	1 -3
lotfsunum	4 -8
frame	9
round	10 -11
schedule	12 -14
sample	15
sector	16
stateregion	17 -19
district	20 -21
subround	22
subsample	23
fodsubregion	24 -27
stratum	28 -29
substratum	30 -31
segment	32
sss	33
enterpriseno	34 -35
level	36 -37
fill	38 -39
itemcode	40 -42
ASICCcode	43 -47
unitofQ	48 -49
quantity	50 -61
value	62 -73
sign	74
specchara	75 -76
blank	77 -126
NSSWeight	127-129
NSCWeight	130-132
MLTWeight	133-142
using "$NSS62//`i'.TXT" ;	
drop fill specchara blank;	
keep if level==5;	
g uniqid=string(lotfsunum) +string(segment) +string(sss)+string(enterpriseno);	
replace value = -1*value if sign==1;	
drop sign;	
drop if itemcode==.;
reshape wide  ASICCcode- value, i( uniqid) j( itemcode);	
save temp5, replace;	
clear;	
	
	
qui infix	
centrecode	1 -3
lotfsunum	4 -8
frame	9
round	10 -11
schedule	12 -14
sample	15
sector	16
stateregion	17 -19
district	20 -21
subround	22
subsample	23
fodsubregion	24 -27
stratum	28 -29
substratum	30 -31
segment	32
sss	33
enterpriseno	34 -35
level	36 -37
fill	38 -39
itemcode	40 -42
value	43 -54
sign	55
specchara	56 -57
blank	58 -126
NSSWeight	127-129
NSCWeight	130-132
MLTWeight	133-142
using "$NSS62//`i'.TXT" ;	
drop fill specchara blank;	
keep if level==6;	
g uniqid=string(lotfsunum) +string(segment) +string(sss)+string(enterpriseno);	
replace value = -1*value if sign==1;	
drop sign;	
reshape wide  value, i( uniqid) j( itemcode);	
save temp6, replace;	
clear;	
	
	
	
qui infix	
centrecode	1 -3
lotfsunum	4 -8
frame	9
round	10 -11
schedule	12 -14
sample	15
sector	16
stateregion	17 -19
district	20 -21
subround	22
subsample	23
fodsubregion	24 -27
stratum	28 -29
substratum	30 -31
segment	32
sss	33
enterpriseno	34 -35
level	36 -37
fill	38 -39
itemcode	40 -42
value	43 -54
specchara	55 -56
blank	57 -126
NSSWeight	127-129
NSCWeight	130-132
MLTWeight	133-142
using "$NSS62//`i'.TXT" ;	
drop fill specchara blank;	
keep if level==7;	
g uniqid=string(lotfsunum) +string(segment) +string(sss)+string(enterpriseno);	
reshape wide  value, i( uniqid) j( itemcode);	
save temp7, replace;	
clear;	
	
qui infix	
centrecode	1 -3
lotfsunum	4 -8
frame	9
round	10 -11
schedule	12 -14
sample	15
sector	16
stateregion	17 -19
district	20 -21
subround	22
subsample	23
fodsubregion	24 -27
stratum	28 -29
substratum	30 -31
segment	32
sss	33
enterpriseno	34 -35
level	36 -37
fill	38 -39
serialno	40 -42
valassetsown	43 -54
valassetshired	55 -66
addstoassetsowned	67 -78
sign	79
rentpayable	80 -91
specchara	92 -93
blank	94 -126
NSSWeight	127-129
NSCWeight	130-132
MLTWeight	133-142
using "$NSS62//`i'.TXT" ;	
drop fill specchara blank;	
keep if level==8;	
g uniqid=string(lotfsunum) +string(segment) +string(sss)+string(enterpriseno);	
replace addstoassets = -1*addstoassets if sign==1;	
drop sign;	
drop if serialno==.;
reshape wide   valassetsown- rentpayable, i( uniqid) j( serialno);	
save temp8, replace;	
clear;	
	
	
	
qui infix	
centrecode	1 -3
lotfsunum	4 -8
frame	9
round	10 -11
schedule	12 -14
sample	15
sector	16
stateregion	17 -19
district	20 -21
subround	22
subsample	23
fodsubregion	24 -27
stratum	28 -29
substratum	30 -31
segment	32
sss	33
enterpriseno	34 -35
level	36 -37
fill	38 -39
serialno	40 -42
loanamt	43 -54
interest	55 -66
specchara	67 -68
blank	69 -126
NSSWeight	127-129
NSCWeight	130-132
MLTWeight	133-142
using "$NSS62//`i'.TXT" ;	
drop fill specchara blank;	
keep if level==9;	
g uniqid=string(lotfsunum) +string(segment) +string(sss)+string(enterpriseno);	
drop if serialno==.;	
reshape wide   loanamt- interest, i( uniqid) j( serialno);	
save temp9, replace;	
clear;	

use temp1, clear;	
merge	
centrecode	
lotfsunum	
frame	
round	
schedule	
sample	
sector	
stateregion	
district	
subround	
subsample	
fodsubregion	
stratum	
substratum	
segment	
sss	
enterpriseno	
uniqid	
using temp2 temp3 temp4 temp5 temp6 temp7 temp8 temp9, sort;	
	
save temp_`i', replace;	
};	


use temp_AH1C22 ,clear;	
erase temp_AH1C22.dta;
	
foreach i in AH2C22 AH3C22 AH4C22 AH5C22 AH6C22 AH7C22 AH8C22 ALHCS22 {	;
append using temp_`i';	
erase temp_`i'.dta;
};	
drop _merge*;	

save "$intdata/master62", replace;

forval i = 1/9 {;
erase temp`i'.dta;
};
