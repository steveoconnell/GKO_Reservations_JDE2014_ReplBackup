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
global input "$data/ASI/ASI2000_01/"
	
#delim ;	
clear;	
qui infix	
year	1-2
str block	3-4
str dsl	5-10
str psl	11-15
str scheme	16-16
str industrycode	17-20
str industrycode5	21-25
str state	26-27
str district	28-29
str ruralurban	30-30
rosrocode	31-35
noofunits	36-38
status	39-40
noofmanufacturingdays	41-43
noofnonmanufacturingdays	44-46
totalnoofworkingdays	47-49
costofproduction	50-61
multiplier	62-70
extra	71-166
using "$input/asi01.txt"	;
keep if block=="A"	;
drop year extra block	;
save "$work/tempA", replace	;
	
	
	
	
	
	
	
	
#delim ;	
clear;	
qui infix	
year	1-2
str block	3-4
str dsl	5-10
typeoforganisation	11-12
typeofownership	13-13
yearofinitialprod	14-17
accountingyearopening	18-26
accountingyearclosing	27-35
monthsofoperation	36-37
computers	38-38
floppy	39-39
extra	40-166
using "$input/asi01.txt"	;
keep if block=="B"	;
drop year extra block	;
save "$work/tempB", replace	;
	
	
	
	
#delim ;	
clear;	
qui infix	
year	1-2
str block	3-4
str dsl	5-10
slno	11-12
openinggross	13-24
addbyreval	25-36
addnew	37-48
deduction	49-60
closinggross	61-72
uptoyearbeg	73-84
providedyear	85-96
soldordiscarded	97-108
uptoyearend	109-120
openingnet	121-132
closingnet	133-144
extra	145-166
using "$input/asi01.txt"	;
keep if block=="C"	;
drop year extra block	;
tostring slno, replace	;
replace slno="land" if slno=="1"	;
replace slno="building" if slno=="2"	;
replace slno="plant_mach" if slno=="3"	;
replace slno="transportequip" if slno=="4"	;
replace slno="compequip" if slno=="5"	;
replace slno="otherFA" if slno=="6"	;
drop if slno=="7"	;
replace slno="totalcapitalwip" if slno=="8"	;
replace slno="totalFA" if slno=="9"	;
reshape wide openinggross-closingnet, i(dsl) j(slno) string	;
save "$work/tempC", replace	;
	
	
	
	
#delim ;	
clear;	
qui infix	
year	1-2
str block	3-4
str dsl	5-10
slno	11-12
open	13-24
close	25-36
extra	37-166
using "$input/asi01.txt"	;
keep if block=="D"	;
drop year extra block	;
tostring slno, replace	;
replace slno="rawmaterials" if slno=="1"	;
replace slno="fuellube" if slno=="2"	;
replace slno="sparesothers" if slno=="3"	;
drop if slno=="4"	;
replace slno="semifinished" if slno=="5"	;
replace slno="finishedgoods" if slno=="6"	;
replace slno="totalinventory" if slno=="7"	;
replace slno="cash" if slno=="8"	;
replace slno="sundrydebtors" if slno=="9"	;
replace slno="othercurrentasts" if slno=="10"	;
drop if slno=="11"	;
replace slno="sundrycreditors" if slno=="12"	;
replace slno="overdraftsetc" if slno=="13"	;
replace slno="othercurrentliab" if slno=="14"	;
drop if slno=="15"	;
replace slno="workingcapital" if slno=="16"	;
replace slno="outstandingloan" if slno=="17"	;
reshape wide open close, i(dsl) j(slno) string	;
save "$work/tempD", replace	;
	
	
	
	
#delim ;	
clear;	
qui infix	
year	1-2
str block	3-4
str dsl	5-10
slno	11-12
manufdays	13-20
nonmanufdays	21-28
totaldays	29-38
_avg	39-46
wagesandsalaries	47-58
bonus	59-70
contributiontopf	71-82
welfareexpense	83-94
extra	95-166
using "$input/asi01.txt"	;
keep if block=="E"	;
drop year extra block	;
tostring slno, replace	;
replace slno="men" if slno=="1"	;
replace slno="women" if slno=="2"	;
replace slno="children" if slno=="3"	;
drop if slno=="4"	;
replace slno="thrucontr" if slno=="5"	;
drop if slno=="6"	;
replace slno="supervstaff" if slno=="7"	;
replace slno="otheremployees" if slno=="8"	;
replace slno="unpaid" if slno=="9"	;
replace slno="totalEEs" if slno=="10"	;
drop if slno=="11"	;
drop if slno=="12"	;
reshape wide manufdays-welfareexp, i(dsl) j(slno) string	;
save "$work/tempE", replace	;
	
	
	
#delim ;	
clear;	
qui infix	
year	1-2
str block	3-4
str dsl	5-10
workdonebyothers	11-22
repairmaintbuilding	23-34
repairmaintmachinery	35-46
repairmaintothers	47-58
operatingexpenses	59-70
nonooperatingexpenses	71-82
insurancecharges	83-94
totalrent	95-106
totalotherexp	107-118
rentforbuilding	119-130
rentoflandetc	131-142
interest	143-154
purchesevalueofgoodssold	155-166
using "$input/asi01.txt"	;
keep if block=="F"	;
drop year block	;
egen repairmainttotal=rowtotal(repairmaint*); drop repairmaintbuilding-repairmaintothers	;
save "$work/tempF", replace	;
	
	
#delim ;	
clear;	
qui infix	
year	1-2
str block	3-4
str dsl	5-10
workdoneforothers	11-22
varstockofsemifin	23-34
valueofelectricitysold	35-46
valueofownconstruction	47-58
balancegoodssold	59-70
rentreceived	71-82
totalotheroutput	83-94
rentrecvdbuilding	95-106
rentrecvdland	107-118
interestrecvd	119-130
salevaluegoodssold	131-142
extra	143-166
using "$input/asi01.txt"	;
keep if block=="G"	;
drop year block extra	;
save "$work/tempG", replace	;
	
	
	
	
	
#delim ;	
clear;	
qui infix	
year	1-2
str block	3-4
str dsl	5-10
slno	11-12
itemcode	13-17
quantityunit	18-20
quantity	21-32
purchasevalue	33-44
extra	45-56
extra1	57-166
using "$input/asi01.txt"	;
keep if block=="H"	;
drop year block extra* itemcode quantityunit  	;
keep if slno>=10 & slno<=17	;
tostring slno, replace	;
replace slno="electricitygenerated" if slno=="10"	;
replace slno="electricitypurchased" if slno=="11"	;
replace slno="fuel" if slno=="12"	;
replace slno="coal" if slno=="13"	;
replace slno="othfuel" if slno=="14"	;
replace slno="consstore" if slno=="15"	;
replace slno="totalfuelelec" if slno=="16"	;
replace slno="totalrawmaterials" if slno=="17"	;
rename purchasevalue value	;
reshape wide value quantity, i(dsl) j(slno) string	;

rename  quantityelectricitypurchased electricitypurchased ;
rename  quantityelectricitygenerated electricitygenerated ;
g electricityconsumed = electricitypurchased ;
drop quantity* ;

save "$work/tempH", replace	;
	
	
#delim ;	
clear;	
qui infix	
year	1-2
str block	3-4
str dsl	5-10
slno	11-12
quantity	13-24
value	25-36
extra	37-48
extra1	49-166
using "$input/asi01.txt"	;
keep if block=="H1"	;
drop year block extra* ;
tostring slno, replace	;
replace slno="electricitygenerated" if slno=="1"	;
replace slno="electricityconsumed" if slno=="2"	;
drop if slno!="electricitygenerated" & slno!="electricityconsumed"	;
reshape wide quantity value, i(dsl) j(slno) string	;
save "$work/tempH1", replace	;
	
	
	
	
#delim ;	
clear;	
qui infix	
year	1-2
str block	3-4
str dsl	5-10
slno	11-12
itemcode	13-17
quantitycode	18-20
quantity	21-32
purchasevalue	33-44
extra	45-56
extra1	57-166
using "$input/asi01.txt"	;
keep if block=="I"	;
drop year block extra* itemcode quantitycode quantity	;
tostring slno, replace	;
keep if slno=="7"; drop slno; rename purchasevalue valuetotalimportedmaterials	;
save "$work/tempI", replace	;
	
#delim ;	
clear;	
qui infix	
year	1-2
str block	3-4
str dsl	5-10
slno	11-12
itemcode	13-17
quantityunit	18-20
qtymanufactured	21-32
qtysold	33-44
grosssalevalue	45-56
exciseduty	57-68
saletax	69-80
distexpensesother	81-92
distexpensestotal	93-104
itemwisensvunit	105-116
itemwiseexactvalue	117-128
extra	129-166
using "$input/asi01.txt"	;
keep if block=="J"	;
drop year block extra itemcode-qtysold itemwisensvunit	;
tostring slno, replace	;
keep if slno=="12"; drop slno	;
save "$work/tempJ", replace	;



use "$work/tempA", clear ;
merge dsl using 
"$work/tempB" 
"$work/tempC" 
"$work/tempD" 
"$work/tempE" 
"$work/tempF" 
"$work/tempG" 
"$work/tempH" 
"$work/tempH1" 
"$work/tempI" 
"$work/tempJ"
, unique sort;

drop _merg*;



***Fix States;
# delim ;
destring state, replace;
lab def state
28 "ANDHRA PRADESH"
12 "ARUNCHAL PRADESH"
18 "ASSAM"
10 "BIHAR"
30 "GOA"
24 "GUJARAT"
6 "HARYANA"
2 "HIMACHAL PRADESH"
1 "JAMMU & KASHMIR"
29 "KARNATAKA"
32 "KERALA"
23 "MADHYA PRADESH"
27 "MAHARASHTRA"
14 "MANIPUR"
17 "MEGHALAYA"
15 "MIZORAM"
13 "NAGALAND"
21 "ORISSA"
3 "PUNJAB"
8 "RAJASTHAN"
11 "SIKKAM"
33 "TAMIL NADU"
16 "TRIPURA"
9 "UTTAR PRADESH"
19 "WEST BENGAL"
35 "ANDAMAN AND NICOBAR ISLANDS"
4 "CHANDIGARH"
26 "DADRA  AND  NAGAR  HAVELI"
25 "DAMAN  &  DIU "
7 "DELHI"
31 "LAKSHADEEP"
34 "PONDICHERRY"
20 "JHARKHAND"
22 "CHHATISGARH"
5 "UTTARANCHAL"
, modify;
lab val state state;
decode state, g(state2);
drop state;
rename state2 state;
tab state, mi;

***Code Ownership Organization and others;

tab typeoforganisation, mi;
# delim ;
destring typeoforganisation, replace;
lab def typeoforganisation
1 "Individual Proprietorship"
2 "Joint  Family (HUF)"
3 "Partnership"
4 "Public  Limited  Company"
5 "Private Limited  Company  "
6 "Government departmental  enterprises"
7 "Public Corporation  by  special Act of Parliament  or State Legislature"
8 "Khadi & Village Industries Commission"
9 "Handlooms"
10 "Co-Operative Society"
19 "Others  (including  trusts, wakf,  boards etc.)"
;
lab val typeoforganisation typeoforganisation;
decode typeoforganisation, g(typeoforganisation2);
drop typeoforganisation;
rename typeoforganisation2 typeoforganisation;


tab typeofownership, mi;
# delim ;
destring typeofownership, replace;
lab def typeofownership
1 "Wholly Central Government"
2 "Wholly State and/or Local Government "
3 "Central  Government and State and/or Local  Government jointly "
4 "Joint  Sector Public"
5 "Joint  Sector  Private  "
6 "Wholly  private  Ownership"
;
lab val typeofownership typeofownership;
decode typeofownership, g(typeofownership2);
drop typeofownership;
rename typeofownership2 typeofownership;


g uniqid=dsl;

g year=2000;

save "$intdata/ASI0001_clean", replace;

foreach i in A B C D E F G H H1 I J {;
erase "$work/temp`i'.dta";
};
