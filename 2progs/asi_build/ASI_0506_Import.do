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
global input "$data/ASI/ASI2005_06/"

#delim ;		
clear;		
qui infix		
year	1-2	
str block	3-4	
str dsl	5-9	
str psl	10-14	
str scheme	15-15	
str industrycode	16-19	
str industrycode5	20-24	
str state	25-26	
str district	27-28	
str ruralurban	29-29	
rosrocode	30-34	
noofunits	35-37	
status	38-39	
noofmanufacturingdays	40-42	
noofnonmanufacturingdays	43-45	
totalnoofworkingdays	46-48	
costofproduction	49-60	
multiplier	61-69	
extra	70-178	
using "$input/asi06m.txt"		;
keep if block=="A"		;
drop extra year block		;
save "$work/tempA", replace		;
		
#delim ;		
clear;		
qui infix		
year	1-2	
str block	3-4	
str dsl	5-9	
typeoforganisation	10-11	
typeofownership	12-12	
noofunits2	13-16	
unitsinstate	17-20	
yearofinitialprod	21-24	
accountingyearopening	25-33	
accountingyearclosing	34-42	
monthsofoperation	43-44	
computers	45-45	
floppy	46-46	
extra	47-178	
using "$input/asi06m.txt"		;
keep if block=="B"		;
drop extra year block		;
save "$work/tempB", replace		;
		
#delim ;		
clear;		
qui infix		
year	1-2	
str block	3-4	
str dsl	5-9	
slno	10-11	
openinggross	12-23	
addbyreval	24-35	
addnew	36-47	
deduction	48-59	
closinggross	60-71	
uptoyearbeg	72-83	
providedyear	84-95	
uptoyearend	96-107	
openingnet	108-119	
closingnet	120-131	
extra	132-178	
using "$input/asi06m.txt"		;
keep if block=="C"		;
drop extra year block		;
tostring slno, replace	;	
replace slno="land" if slno=="1"	;	
replace slno="building" if slno=="2"	;	
replace slno="plant_mach" if slno=="3"	;	
replace slno="transportequip" if slno=="4"	;	
replace slno="compequip" if slno=="5"	;	
replace slno="plollutctrl" if slno=="6"	;	
replace slno="otherFA" if slno=="7"	;	
drop if slno=="8"	;	
replace slno="totalcapitalwip" if slno=="9"	;	
replace slno="totalFA" if slno=="10"	;	
reshape wide openinggross-closingnet, i(dsl) j(slno) string	;	
save "$work/tempC", replace		;
		
#delim ;		
clear;		
qui infix		
year	1-2	
str block	3-4	
str dsl	5-9	
slno	10-11	
open	12-23	
close	24-35	
extra	36-178	
using "$input/asi06m.txt"		;
keep if block=="D"		;
drop extra year block		;
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
save "$work/tempD", replace		;
		
		
		
		
		
		
		
		
		
		
		
		
#delim ;		
clear;		
qui infix		
year	1-2	
str block	3-4	
str dsl	5-9	
slno	10-11	
manufdays	12-19	
nonmanufdays	20-27	
totaldays	28-37	
_avg	38-45	
days_paid	46-55	
wagesandsalaries	56-67	
bonus	68-79	
contributiontopf	80-91	
welfareexpense	92-103	
extra	104-178	
using "$input/asi06m.txt"		;
keep if block=="E"		;
drop extra year block		;
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
save "$work/tempE", replace		;
		
		
		
#delim ;		
clear;		
qui infix		
year	1-2	
str block	3-4	
str dsl	5-9	
workdonebyothers	10-21	
repairmaintbuilding	22-33	
repairmaintmachinery	34-45	
repairmaintothpol	46-57	
repairmaintothers	58-69	
operatingexpenses	70-81	
nonooperatingexpenses	82-93	
insurancecharges	94-105	
totalrent	106-117	
totalotherexp	118-129	
rentforbuilding	130-141	
rentoflandetc	142-153	
interest	154-165	
purchesevalueofgoodssold	166-177	
using "$input/asi06m.txt"		;
keep if block=="F"		;
drop year block		;
egen repairmainttotal=rowtotal(repairmaint*); drop repairmaintbuilding-repairmaintothers	;	
save "$work/tempF", replace		;
		
		
		
		
		
#delim ;		
clear;		
qui infix		
year	1-2	
str block	3-4	
str dsl	5-9	
workdoneforothers	10-21	
varstockofsemifin	22-33	
valueofelectricitysold	34-45	
valueofownconstruction	46-57	
balancegoodssold	58-69	
rentreceived	70-81	
totalotheroutput	82-93	
rentrecvdbuilding	94-105	
rentrecvdland	106-117	
interestrecvd	118-129	
salevaluegoodssold	130-141	
extra	142-178	
using "$input/asi06m.txt"		;
keep if block=="G"		;
drop extra year block		;
save "$work/tempG", replace		;
		
		
		
#delim ;		
clear;		
qui infix		
year	1-2	
str block	3-4	
str dsl	5-9	
slno	10-11	
itemcode	12-16	
quantityunit	17-19	
quantity	20-35	
purchasevalue	36-47	
rateperunit	48-62	
extra1	63-178	
using "$input/asi06m.txt"	;	
keep if block=="H"	;	
drop year block extra* itemcode quantityunit rateperunit	;	
keep if slno>=15 & slno<=22	;	
tostring slno, replace	;	
replace slno="electricitygenerated" if slno=="15"	;
replace slno="electricitypurchased" if slno=="16"	;	
replace slno="fuel" if slno=="17"	;	
replace slno="coal" if slno=="18"	;	
replace slno="othfuel" if slno=="19"	;	
replace slno="consstore" if slno=="20"	;	
replace slno="totalfuelelec" if slno=="21"	;	
replace slno="totalrawmaterials" if slno=="22"	;	
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
str dsl	5-9	
slno	10-11	
itemcode	12-16	
quantitycode	17-19	
quantity	20-35	
purchasevalue	36-47	
rateperunit	48-62	
extra1	63-178	
using "$input/asi06m.txt"	;	
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
str dsl	5-9	
slno	10-11	
itemcode	12-16	
quantityunit	17-19	
qtymanufactured	20-35	
qtysold	36-51	
grosssalevalue	52-63	
exciseduty	64-75	
saletax	76-87	
distexpensesother	88-99	
distexpensestotal	100-111	
itemwisensvunit	112-126	
itemwiseexactvalue	127-138	
extra	139-178	
using "$input/asi06m.txt"	;	
keep if block=="J"	;	
drop year block extra itemcode-qtysold itemwisensvunit	;	
tostring slno, replace	;	
keep if slno=="12"; drop slno	;	
save "$work/tempJ", replace	;	



#delim ;
cd "$work";
use tempA, clear;
merge dsl using tempB tempC tempD tempE tempF tempG tempH tempI tempJ, sort;

drop _merge*;


#delim ;
destring state, replace ;
lab def state
35 "ANDAMAN AND NICOBAR ISLANDS"
28 "ANDHRA PRADESH"
12 "ARUNCHAL PRADESH"
18 "ASSAM"
10 "BIHAR"
4 "CHANDIGARH"
22 "CHHATISGARH"
26 "DADRA  AND  NAGAR  HAVELI"
25 "DAMAN  &  DIU "
7 "DELHI"
30 "GOA"
24 "GUJARAT"
6 "HARYANA"
2 "HIMACHAL PRADESH"
1 "JAMMU & KASHMIR"
20 "JHARKHAND"
29 "KARNATAKA"
32 "KERALA"
31 "LAKSHADEEP"
23 "MADHYA PRADESH"
27 "MAHARASHTRA"
14 "MANIPUR"
17 "MEGHALAYA"
15 "MIZORAM"
13 "NAGALAND"
21 "ORISSA"
34 "PONDICHERRY"
3 "PUNJAB"
8 "RAJASTHAN"
11 "SIKKAM"
33 "TAMIL NADU"
16 "TRIPURA"
9 "UTTAR PRADESH"
5 "UTTARANCHAL"
19 "WEST BENGAL"
;
lab val state state;
decode state, g(state2);
drop state;
rename state2 state;



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
g year=2005;
save "$intdata/ASI0506_clean", replace;

foreach i in A B C D E F G H I J {;
erase "$work/temp`i'.dta";
};
