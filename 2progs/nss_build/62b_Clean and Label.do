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

use "$intdata/master62.dta", clear

#delimit ;		
lab var centrecode "Centre code,Round,Shift";		
lab var lotfsunum "LOT/FSU number";		
lab var frame "Frame of the Survey";	lab def frame 1"list" 2"area";	label val frame frame;
lab var round "Round Number";		
lab var schedule "Schedule Number";		
lab var sample "Sample";	lab def sample 1"Central" 2"State";	label val sample sample;
lab var sector "Sector";	lab def sector 1"Rural" 2"Urban";	label val sector sector;
lab var stateregion "State-Region";		
lab var district "District";		
lab var subround "Sub-Round";		
lab var subsample "Sub-Sample";		
lab var fodsubregion "FOD Sub-Region";		
lab var stratum "Stratum";		
lab var substratum "Sub-Stratum";		
lab var segment "Segment";		
lab var sss "SSS";		
lab var enterpriseno "Enterprise Number";		
lab var level "Level ";		
lab var informantcode " Informant Code";	lab def informantcode 1"Owner-Partner" 2"Manager" 3"Other Employee";	label val informantcode informantcode;
lab var responsecode "Response Code";		
lab var surveycode "Survey Code";	lab def surveycode 1"Original Enterprise" 2"Substitute" 3"Casualty";	label val surveycode surveycode;
lab var substitutioncode "Substitution Code";		
lab var permserialno "Permanent serial no.";		
lab var timecanvass "Time to canvass(mins.)";		
lab var datesurvey "Date of Survey";		
lab var datedispatch "Date of Despatch";		
lab var uniqid "Unique ID";		
lab var NICcode "Ops & Bckgrnd - NIC Code 2004-Major Activity ";		
lab var natureops "Ops & Bckgrnd - Nature of Operation";	lab def natureops 1"perennial" 2"Seasonal" 3"Casual";	label val natureops natureops;
lab var monthsop "Ops & Bckgrnd - No. of months operated";		
lab var hourswkdyear "Ops & Bckgrnd - No. of hours worked per day-ref. year";		
lab var hrswkdmonth "Ops & Bckgrnd - No. of hours worked per day-ref. month";		
lab var mixed "Ops & Bckgrnd - Whether pursuing mixed activity?";	lab def mixed 1"Yes" 2"No";	label val mixed mixed;
lab var ownership "Ops & Bckgrnd - Type of ownership";	lab def ownership 1"M Proprietary" 2"F Proprietary" 3"HH Partnership" 4"Partnership NonHH" 5"Co-op Soc." 6"Limited Co." 9"Other";	label val ownership ownership;
lab var otheractivity "Ops & Bckgrnd - Any other economic activity?";	lab def otheractivity 1"Yes" 2"No";	label val otheractivity otheractivity;
lab var majorsrcinc "Ops & Bckgrnd - Present ent.-major source income";	lab def majorsrcinc 1"Yes" 2"No";	label val majorsrcinc majorsrcinc;
lab var pctanninc "Ops & Bckgrnd - % of annual income";		
lab var NICcode2 "Ops & Bckgrnd - NIC Code 2004-Other imp. Activity ";		
lab var edulevelowner "Ops & Bckgrnd - General edu.level of working owner";	lab def edulevelowner 1"Not Literate" 2"Literate No Formal School" 3"Literate Below Primary" 4"Primary" 5"Middle" 6"Secondary" 7"Other Secondary" 8"Diploma/Certificate" 10"Graduate" 11"Postgraduate or Above";	label val edulevelowner edulevelowner;
lab var acctsmaint "Ops & Bckgrnd - Whether accounts maintained?";	lab def acctsmaint 1"Yes w. Info Collected from Books" 2"Yes w. Info Collected Orally" 3"No";	label val acctsmaint acctsmaint;
lab var datafrom "Ops & Bckgrnd - Data collected from";		
lab var datato "Ops & Bckgrnd - Data collected to";		
	replace datafrom = substr(datafrom,3,2)+"-"+substr(datafrom,1,2)+"-"+substr(datafrom,5,2);
	g start=date(datafrom,"MD20Y");
	format start %d;
	replace datato= substr(datato,3,2)+"-"+substr(datato,1,2)+"-"+substr(datato,5,2);
	g end=date(datato,"MD20Y");
	format end %d;
	g mos_accounts=(end-start)/30;
	tab mos_accounts;
	sum mos_accounts, d;
	*br data* start end mos if mos<0;	
	replace mos_accounts=1 if abs(mos_accounts)>.5 & abs(mos_accounts)<1.5;
	replace mos_accounts=12 if abs(mos_accounts)>1.5 & abs(mos_accounts)!=.;
	replace mos_accounts=12 if abs(mos_accounts)<.5 & mos_accounts<0;
	replace mos_accounts=1 if mos_accounts<1;
	drop start end;
lab var location "Ops & Bckgrnd - Location of the enterprise";	lab def location 1"Within HH" 2"NonHH Fixed Prem & Perm Str" 3"NonHH Fixed Perm & Temp Str" 4"NonHH Fixed Prem & No Str" 5"Mobile Market" 6"No Fixed Prem";	label val location location;
lab var registered "Ops & Bckgrnd - Registered under any act?";	lab def registered 1"Yes" 2"No";	label val registered registered;
lab var rgstr1 "Ops & Bckgrnd - Registered under ";		
lab var rgsrt2 "Ops & Bckgrnd - Registered under ";		
lab var sourceagency1 "Ops & Bckgrnd - Source agency for  basic inputs";	lab def sourceagency1 1"Government" 2"Co-op or Marketing Soc." 3"Private Enterprise" 4"Contractors/Middleman" 5"Private Individual/HH" 6"No Specific Source" 9"Others";	label val sourceagency1 sourceagency1;
lab var sourceagency2 "Ops & Bckgrnd - Source agency for  basic inputs";	lab def sourceagency2 1"Government" 2"Co-op or Marketing Soc." 3"Private Enterprise" 4"Contractors/Middleman" 5"Private Individual/HH" 6"No Specific Source" 9"Others";	label val sourceagency2 sourceagency2;
lab var destagency1 "Ops & Bckgrnd - Destination agency for sale";	lab def destagency1 1"Government" 2"Co-op or Marketing Soc." 3"Private Enterprise" 4"Contractors/Middleman" 5"Private Individual/HH" 6"No Specific Source" 9"Others";	label val destagency1 destagency1;
lab var destagency2 "Ops & Bckgrnd - Destination agency for sale";	lab def destagency2 1"Government" 2"Co-op or Marketing Soc." 3"Private Enterprise" 4"Contractors/Middleman" 5"Private Individual/HH" 6"No Specific Source" 9"Others";	label val destagency2 destagency2;
lab var probelecnoavail "Ops & Bckgrnd - Problems-nonavailabilty electricity";	lab def probelecnoavail 1"Yes" 2"No";	label val probelecnoavail probelecnoavail;
lab var probpowerout "Ops & Bckgrnd - Problems-power cut";	lab def probpowerout 1"Yes" 2"No";	label val probpowerout probpowerout;
lab var probnocapital "Ops & Bckgrnd - Problems-shortage of capital";	lab def probnocapital 1"Yes" 2"No";	label val probnocapital probnocapital;
lab var probnorawmats "Ops & Bckgrnd - Problems-nonavailabilty raw mat.";	lab def probnorawmats 1"Yes" 2"No";	label val probnorawmats probnorawmats;
lab var probmkting "Ops & Bckgrnd - Problems-marketing";	lab def probmkting 1"Yes" 2"No";	label val probmkting probmkting;
lab var probother "Ops & Bckgrnd - Problems-any other";	lab def probother 1"Yes" 2"No";	label val probother probother;
lab var contractbasis "Ops & Bckgrnd - Undertake on contract basis?";	lab def contractbasis 1"Yes" 2"No";	label val contractbasis contractbasis;
lab var typecontract "Ops & Bckgrnd - Type of contract";	lab def typecontract 1"solely for enterprise/contractor" 2"Mainly contracts but also other customers" 3"mainly for customers but also contract";	label val typecontract typecontract;
lab var equipsuppl "Ops & Bckgrnd - Equipment supplied by";	lab def equipsuppl 1"Self-Procured" 2"By master Unit/Contractor" 3"Both";	label val equipsuppl equipsuppl;
lab var rawsuppl "Ops & Bckgrnd - Raw materials supplied by";	lab def rawsuppl 1"Self-Procured" 2"By master Unit/Contractor" 3"Both";	label val rawsuppl rawsuppl;
lab var designbycontr "Ops & Bckgrnd - Design specified by contractor?";	lab def designbycontr 1"Yes" 2"No";	label val designbycontr designbycontr;
lab var assist5yrs1 "Ops & Bckgrnd - Types of assistance received-5 yrs.";	lab def assist5yrs1 1"Financial Loan - Institutional" 2"Financial Loan - Non Institutional" 3"Subsidy" 4"Machinery/Equip" 5"Training" 6"Marketing" 7"Procurement of Raw Material" 8"No Assistance" 9"Others";	label val assist5yrs1 assist5yrs1;
lab var assist5yrs2 "Ops & Bckgrnd - Types of assistance received-5 yrs.";	lab def assist5yrs2 1"Financial Loan - Institutional" 2"Financial Loan - Non Institutional" 3"Subsidy" 4"Machinery/Equip" 5"Training" 6"Marketing" 7"Procurement of Raw Material" 8"No Assistance" 9"Others";	label val assist5yrs2 assist5yrs2;
lab var entstatus "Ops & Bckgrnd - Status of the enterprise-las 3 yrs.";	lab def entstatus 1"Expanding" 2"Stagnant" 3"Contracting" 4"Operating Less than 3 Years";	label val entstatus entstatus;
lab var enttype "Ops & Bckgrnd - Ent. Type during the ref. year";	lab def enttype 1"OAME" 2"NDME" 3"DME";	label val enttype enttype;
		
		
	lab def unitofQ301 1"No." 2"Kg" 3"tonne" 4"metre" 5"sq metre" 6"cu metre" 7"litre" 8"pair" 9"gram" 10"carat" 11"Kwh" 12"00s" 13"000s" 19"other";	label val unitofQ301 unitofQ301;
		
		
		
	lab def unitofQ302 1"No." 2"Kg" 3"tonne" 4"metre" 5"sq metre" 6"cu metre" 7"litre" 8"pair" 9"gram" 10"carat" 11"Kwh" 12"00s" 13"000s" 19"other";	label val unitofQ302 unitofQ302;
		
		
		
	lab def unitofQ303 1"No." 2"Kg" 3"tonne" 4"metre" 5"sq metre" 6"cu metre" 7"litre" 8"pair" 9"gram" 10"carat" 11"Kwh" 12"00s" 13"000s" 19"other";	label val unitofQ303 unitofQ303;
		
		
		
	lab def unitofQ304 1"No." 2"Kg" 3"tonne" 4"metre" 5"sq metre" 6"cu metre" 7"litre" 8"pair" 9"gram" 10"carat" 11"Kwh" 12"00s" 13"000s" 19"other";	label val unitofQ304 unitofQ304;
		
		
		
	lab def unitofQ305 1"No." 2"Kg" 3"tonne" 4"metre" 5"sq metre" 6"cu metre" 7"litre" 8"pair" 9"gram" 10"carat" 11"Kwh" 12"00s" 13"000s" 19"other";	label val unitofQ305 unitofQ305;
		
		
drop ASICCcode306;		
drop unitofQ306;		
drop quantity306;		
		
drop ASICCcode309;		
drop unitofQ309;		
drop quantity309;		
lab var value309 "Princ Op Exp:Manuf - Total Operating Expenses-Manufacturing";		
drop ASICCcode311;		
drop unitofQ311;		
drop quantity311;		
		
drop ASICCcode312;		
drop unitofQ312;		
drop quantity312;		
		
drop ASICCcode313;		
drop unitofQ313;		
drop quantity313;		
		
drop ASICCcode319;		
drop unitofQ319;		
drop quantity319;		
lab var value319 "Princ Op Exp:Trading&Oth - Total Trading and Other Activities";		
		
lab var value321 "Oth Op Exp - Electricity Charges";		
lab var value322 "Oth Op Exp - Fuel-Lubricant";		
lab var value323 "Oth Op Exp - Raw Materials for Constr of building, furniture and fixtures";		
lab var value324 "Oth Op Exp - Raw Mats for Building";		
lab var value325 "Oth Op Exp - Raw Mats for Plant and Machinery";		
lab var value326 "Oth Op Exp - Raw Mats for Transport Equip";		
lab var value327 "Oth Op Exp - Raw Mats for Software and Hardware";		
lab var value328 "Oth Op Exp - Raw Mats for Tools and other Fixed Assets";		
lab var value331 "Oth Op Exp - Rent Payable on Fixed Assets";		
lab var value332 "Oth Op Exp - Service Changes for work done by other concerns";		
lab var value333 "Oth Op Exp - Travel, freight and cartage expenses";		
lab var value334 "Oth Op Exp - Communication Expenses";		
lab var value335 "Oth Op Exp - Consumable stores, packing materials";		
lab var value336 "Oth Op Exp - Paper, Printing & Stationery expenses";		
lab var value337 "Oth Op Exp - License fees, cess charged by local bodies, other local rates";		
lab var value338 "Oth Op Exp - royalties and insurance charges";		
lab var value341 "Oth Op Exp - other expenses";		
lab var value349 "Oth Op Exp - Total Other Operating Expenses";		
		
		
	lab def unitofQ401 1"No." 2"Kg" 3"tonne" 4"metre" 5"sq metre" 6"cu metre" 7"litre" 8"pair" 9"gram" 10"carat" 11"Kwh" 12"00s" 13"000s" 19"other";	label val unitofQ401 unitofQ401;
		
		
		
	lab def unitofQ402 1"No." 2"Kg" 3"tonne" 4"metre" 5"sq metre" 6"cu metre" 7"litre" 8"pair" 9"gram" 10"carat" 11"Kwh" 12"00s" 13"000s" 19"other";	label val unitofQ402 unitofQ402;
		
		
		
	lab def unitofQ403 1"No." 2"Kg" 3"tonne" 4"metre" 5"sq metre" 6"cu metre" 7"litre" 8"pair" 9"gram" 10"carat" 11"Kwh" 12"00s" 13"000s" 19"other";	label val unitofQ403 unitofQ403;
		
		
		
	lab def unitofQ404 1"No." 2"Kg" 3"tonne" 4"metre" 5"sq metre" 6"cu metre" 7"litre" 8"pair" 9"gram" 10"carat" 11"Kwh" 12"00s" 13"000s" 19"other";	label val unitofQ404 unitofQ404;
		
		
		
	lab def unitofQ405 1"No." 2"Kg" 3"tonne" 4"metre" 5"sq metre" 6"cu metre" 7"litre" 8"pair" 9"gram" 10"carat" 11"Kwh" 12"00s" 13"000s" 19"other";	label val unitofQ405 unitofQ405;
		
		
drop ASICCcode406;		
drop unitofQ406;		
drop quantity406;		
		
drop ASICCcode409;		
drop unitofQ409;		
drop quantity409;		
lab var value409 "Princ Receipts - Total Receipts - Manufacturing";		
drop ASICCcode411;		
drop unitofQ411;		
drop quantity411;		
		
drop ASICCcode412;		
drop unitofQ412;		
drop quantity412;		
		
drop ASICCcode413;		
drop unitofQ413;		
drop quantity413;		
lab var value413 "Princ Receipts - Change in Stock of Semi-Finished Goods";		
		
		
		
lab var value419 "Princ Receipts - Total Receipts Minus Change in Stock of Semi-finished Goods";		
drop ASICCcode421;		
drop unitofQ421;		
drop quantity421;		
lab var value421 "Princ Receipts - Receipts from Sale of Goods Incidental to Manuf and Other Trading";		
drop ASICCcode422;		
drop unitofQ422;		
drop quantity422;		
lab var value422 "Princ Receipts - Opening Stock of Trading Goods";		
drop ASICCcode423;		
drop unitofQ423;		
drop quantity423;		
lab var value423 "Princ Receipts - Closing Stock of Trading Goods";		
drop ASICCcode424;		
drop unitofQ424;		
drop quantity424;		
lab var value424 "Princ Receipts - Change in Stock of Trading Goods";		
drop ASICCcode429;
drop unitofQ429;		
drop quantity429;		
label var value429 "Princ Receipts - Total Receipts from Sale of Goods Incidental to manuf and Other Trading Minus Change in Stock of Trading Goods";		
drop ASICCcode431;		
drop unitofQ431;		
drop quantity431;		
lab var value431 "Princ Receipts - Receipts from Other Activities";		
drop ASICCcode439;		
drop unitofQ439;		
drop quantity439;		
lab var value439 "Princ Receipts - Total Receipts from Sale of Goods Incidental & Trading Plus Other Receipts";		
		
lab var value441 "Other Receipts - Services Provided to Others";		
lab var value442 "Other Receipts - Value of Construction of Building Furniture and Fixtures Including Own/Hired Labor Charges";		
lab var value443 "Other Receipts - Value of Consumptive Goods/Services Produced or Traded for Own use of Owner/Employees";		
lab var value444 "Other Receipts - Rent Receivable on Fixed Assets";		
lab var value445 "Other Receipts - Funding/Donations Received";		
lab var value446 "Other Receipts - Other Receipts";		
lab var value449 "Other Receipts - Total Other Receipts";		
lab var value501 "Gross Value Add - Total Operating Expenses";		
lab var value502 "Gross Value Add - Distributive Expenses";		
lab var value503 "Gross Value Add - Total Receipts";		
lab var value509 "Gross Value Add - Gross Value Added";		
		
lab var value601 "Employment -F FT Working Owner";		
lab var value602 "Employment -F FT Hired Worker";		
lab var value603 "Employment -F FT Other Worker/Helper";		
lab var value604 "Employment -F PT Working Owner";		
lab var value605 "Employment -F PT Hired Worker";		
lab var value606 "Employment -F PT Other Worker/Helper";		
lab var value611 "Employment -M FT Working Owner";		
lab var value612 "Employment -M FT Hired Worker";		
lab var value613 "Employment -M FT Other Worker/Helper";		
lab var value614 "Employment -M PT Working Owner";		
lab var value615 "Employment -M PT Hired Worker";		
lab var value616 "Employment -M PT Other Worker/Helper";		
lab var value619 "Employment -Total # Employees";		
lab var value701 "Compensation -Salary, Wages & Benefits - Working Owners";		
lab var value702 "Compensation -Salary, Wages & Benefits - Hired Workers";		
lab var value703 "Compensation -Imputed Value of Group Benefits - Working Owners";		
lab var value704 "Compensation -Imputed Value of Group Benefits - Hired Workers";		
lab var value709 "Compensation -Total Compensation/Emoluments";		
		
lab var valassetsown801 "Fixed Assets -Value of Land & Building Owned";		
lab var valassetshired801 "Fixed Assets -Value of Land & Building Hired";		
lab var addstoassetsowned801 "Fixed Assets -Change in Land & Building Assets Owned";		
lab var rentpayable801 "Fixed Assets -Rent Payable on Land & Building Assets Hired";		
lab var valassetsown802 "Fixed Assets -Value of Plant & Machinery Owned";		
lab var valassetshired802 "Fixed Assets -Value of Plant & Machinery Hired";		
lab var addstoassetsowned802 "Fixed Assets -Change in Plant & Machinery Assets Owned";		
lab var rentpayable802 "Fixed Assets -Rent Payable on Plant & Machinery Assets Hired";		
lab var valassetsown803 "Fixed Assets -Value of Transport Equip Owned";		
lab var valassetshired803 "Fixed Assets -Value of Transport Equip Hired";		
lab var addstoassetsowned803 "Fixed Assets -Change in Transport Equip Assets Owned";		
lab var rentpayable803 "Fixed Assets -Rent Payable on Transport Equip Assets Hired";		
lab var valassetsown804 "Fixed Assets -Value of Software & Hardware Owned";		
lab var valassetshired804 "Fixed Assets -Value of Software & Hardware Hired";		
lab var addstoassetsowned804 "Fixed Assets -Change in Software & Hardware Assets Owned";		
lab var rentpayable804 "Fixed Assets -Rent Payable on Software & Hardware Assets Hired";		
lab var valassetsown805 "Fixed Assets -Value of Tools and Other Fixed Assets Owned";		
lab var valassetshired805 "Fixed Assets -Value of Tools and Other Fixed Assets Hired";		
lab var addstoassetsowned805 "Fixed Assets -Change in Tools and Other Fixed Assets Assets Owned";		
lab var rentpayable805 "Fixed Assets -Rent Payable on Tools and Other Fixed Assets Assets Hired";		
lab var valassetsown809 "Fixed Assets -Value of TOTAL Owned";		
lab var valassetshired809 "Fixed Assets -Value of TOTAL Hired";		
lab var addstoassetsowned809 "Fixed Assets -Change in TOTAL Assets Owned";		
lab var rentpayable809 "Fixed Assets -Rent Payable on TOTAL Assets Hired";		
		
lab var loanamt901 "Loan Outstanding -LOAN AMOUNT from Central & State Level Term Lending Inst, Govt, Banks & Societies";		
lab var interest901 "Loan Outstanding -INTEREST PAYABLE to Central & State Level Term Lending Inst, Govt, Banks & Societies";		
lab var loanamt902 "Loan Outstanding -LOAN AMOUNT from Other Inst Agencies";		
lab var interest902 "Loan Outstanding -INTEREST PAYABLE to Other Inst Agencies";		
lab var loanamt903 "Loan Outstanding -LOAN AMOUNT from Moneylenders";		
lab var interest903 "Loan Outstanding -INTEREST PAYABLE to Moneylenders";		
lab var loanamt904 "Loan Outstanding -LOAN AMOUNT from Business Partners";		
lab var interest904 "Loan Outstanding -INTEREST PAYABLE to Business Partners";		
lab var loanamt905 "Loan Outstanding -LOAN AMOUNT from Suppliers/Contractors";		
lab var interest905 "Loan Outstanding -INTEREST PAYABLE to Suppliers/Contractors";		
lab var loanamt906 "Loan Outstanding -LOAN AMOUNT from Friends & Relatives";		
lab var interest906 "Loan Outstanding -INTEREST PAYABLE to Friends & Relatives";		
lab var loanamt907 "Loan Outstanding -LOAN AMOUNT from Others";		
lab var interest907 "Loan Outstanding -INTEREST PAYABLE to Others";		
lab var loanamt909 "Loan Outstanding -TOTAL LOAN AMOUNT";		
lab var interest909 "Loan Outstanding -TOTAL INTEREST PAYABLE";		

rename loanamt901 outstandingend_inst;
rename interest901 interest_inst;
rename loanamt902 outstandingend_agency;
rename interest902 interest_agency;
rename loanamt903 outstandingend_moneylend;
rename interest903 interest_moneylend;
rename loanamt904 outstandingend_buspart;
rename interest904 interest_buspart;
rename loanamt905 outstandingend_contractor;
rename interest905 interest_contractor;
rename loanamt906 outstandingend_frfam;
rename interest906 interest_frfam;
rename loanamt907 outstandingend_other;
rename interest907 interest_other;


g state=substr(string(stateregion),1,length(string(stateregion))-1);	
destring state, replace;	
	
lab var state "State";	
lab def state	
28"Andhra Pardesh"	
12"Arunachal Pradesh"	
18"Assam"	
10"Bihar"	
30"Goa"	
24"Gujrat"	
6"Haryana"	
2"Himachal Pradesh"	
1"Jammu & Kashmir"	
29"Karnataka"	
32"Kerala"	
23"Madhya Pradesh"	
27"Maharastra"	
14"Manipur"	
17"Meghalaya"	
15"Mizoram"	
13"Nagaland"	
21"Orissa"	
3"Punjab"	
8"Rajasthan"	
11"Sikkim"	
33"Tamil Nadu"	
16"Tripura"	
9"Uttar Pradesh"	
19"West Bengal"	
35"Andaman & Nicober"	
4"Chandigarh"	
26"Dadra & Nagar Haveli"	
25"Daman & Diu"	
7"Delhi"	
31"Lakshadweep"	
34"Pondicheri"	
22"Chhattisgarh"	
20"Jharkhand"	
5"Uttaranchal"	;
lab val state state;	

tab state;
rename state state2;
decode state2, g (state);
drop state2;

tostring NICcode, replace;
replace NICcode="0"+NICcode if length(NICcode)==4;

g industrycode5=NICcode ;

save "$intdata/master62_int", replace;
erase "$intdata/master62.dta";
