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
use "$intdata/master56.dta" 
g year=2001
g uniqid=string(stateregion)+string(stratum)+string(substratum)+string(district)+string(subround)+string(subsamplerev)+string(fsuno)+string(segno)+string(enterprisetype)+string(entslno)

drop subsampleorig
drop roundsch
rename subsamplerev subsample
rename fsuno lotfsunum
rename segno segment
rename enterprisetype enttype
rename entslno enterpriseno
drop svc
rename nss NSSWeight
rename nsc NSCWeight
rename mults MLTWeight
drop informantcode
*drop responsecode
destring responsecode, replace
drop nic2
drop nic3 
rename nic4 NICcode
rename nic5 industrycode5
tostring industrycode5, replace
rename natureoperation natureops
rename typeownership ownership
rename accountavailable acctsmaint
	g mos_account=1
	replace mos_account=12 if acctsmaint==1
rename locaent location
rename regis registered
drop regcod1
drop regcod2
drop regcod3
rename source1 sourceagency1
rename source2 sourceagency2
rename destin1 destagency1
rename destin2 destagency2
rename electconnect probelecnoavail
rename powercut probpowerout
rename capitalshortage probnocapital
rename rawmaterials probnorawmats
rename marktgprod probmkting
rename anyotherprob probother
rename workcontbasdis contractbasis
rename typecont typecontract
rename equipment equipsuppl
rename rawmaterial rawsuppl
rename design designbycontr
rename typeassist1 assist5yrs1
rename typeassist2 assist5yrs2
drop typeassist3
rename mixedact mixed
drop otherecostatus
rename progressenterprise entstatus
rename nomonthsworked monthsop
	replace monthsop=. if monthsop==99
drop workerowntotal
drop workerhiredtotal
drop workerothertotal
rename workertotal totalemp
	rename manuexpenses totalrawmat
	replace totalrawmat=totalexpenses if totalrawmat==0 & totalexpenses !=.
rename tradexpenses tottrade_othactexp
rename otherexpenses totothexp
rename totalexpenses totalopexp
rename distriexpenses totaldistexp
drop prodreceipt
drop stockreceipt
drop manureceipt
drop tradereceipt
drop otherreceipt
rename totalreceipt totalrevenue
rename gvaprod GVA
drop emolument
drop rent
drop interest
drop profit
drop gvaincome
drop timetaken
drop reasonsubst
drop nomonthsoperated /*DUPLICATE VAR NO INFO LOST HERE SAME WITH NEXT*/
drop mixedactivity

rename yearsalary totalsalary
rename yearlygroupbenefits totalbenefits
rename yearlytotalsalary totalcomp
/*
drop loanamtlendinst
drop yearlyloanintlendinst
drop loanamtagen
drop yearlyloanintagen
drop loanamtlender
drop yearlyloanintlender
drop loanamtpartner
drop yearlyloanintpartner
drop loanamtcontrac
drop yearlyloanintcontrac
drop loanamtreltv
drop yearlyloanintreltv
drop loanamtother
drop yearlyloanintother
*/

rename loanamtlendinst outstandingend_inst
rename yearlyloanintlendinst interest_inst
rename loanamtagen outstandingend_agency
rename yearlyloanintagen interest_agency
rename loanamtlender outstandingend_moneylend
rename yearlyloanintlender interest_moneylend
rename loanamtpartner outstandingend_buspart
rename yearlyloanintpartner interest_buspart
rename loanamtcontrac outstandingend_contractor
rename yearlyloanintcontrac interest_contractor
rename loanamtreltv outstandingend_frfam
rename yearlyloanintreltv interest_frfam
rename loanamtother outstandingend_other
rename yearlyloanintother interest_other


rename loanamttotal totalloanamount
rename yearlyloaninttotal totalloanint
drop landown
drop landhired
drop landnetadd
drop yearlylandrent
drop plantown
drop planthired
drop plantnetadd
drop yearlyplantrent
drop transportown
drop transporthired
drop transportnetadd
drop yearlytransportrent
drop toolsown
drop toolshired
drop toolsnetadd
drop yearlytoolsrent
rename totalassetown totalvalueassetsowned
rename totalassethired totalvalueassetshired
rename totalassetnetadd totalassets_delta
rename yearlytotalassetrent totalrentassetshired
drop totalhiredworker
drop totalworker /* DUPLICATE VAR NO INFO LOST*/
drop item309
drop item319
rename item321 rawmat_elec
rename item322 rawmat_fuel_lube
drop item323
drop item329
drop item331
drop item332
drop item333
drop item334
drop item335
drop item336
drop item337
drop item338
drop item339
drop item501
drop item502
drop item503
drop item509
drop item409
drop item413
drop item419
drop item439
drop item441
drop item442
drop item443
drop item444
drop item445
drop item446
drop item449
replace totalvalueassetsowned=assetsowned if totalvalueassetsowned==. & assetsowned !=.
drop assetsowned

replace totalvalueassetshired=assetshired  if totalvalueassetshired==. & assetshired!=.
drop assetshired
drop totworker
drop asicc2301
drop asicc5301
drop valueexpenditure301
drop asicc2302
drop asicc5302
drop valueexpenditure302
drop asicc2303
drop asicc5303
drop valueexpenditure303
drop asicc2304
drop asicc5304
drop valueexpenditure304
drop asicc2305
drop asicc5305
drop valueexpenditure305
drop asicc2501
drop asicc5501
drop valueexpenditure501
drop asicc2401
drop asicc5401
drop valuereceipt401
drop asicc2402
drop asicc5402
drop valuereceipt402
drop asicc2403
drop asicc5403
drop valuereceipt403
drop asicc2404
drop asicc5404
drop valuereceipt404
drop asicc2405
drop asicc5405
drop valuereceipt405
drop asicc2503
drop asicc5503
drop valuereceipt503


#delim ;
g state=substr(string(stateregion),1,length(string(stateregion))-1);
destring state, replace;

#delim ;
lab var state "State";
lab def state
2"Andhra Pradesh"
4"Assam"
5"Bihar"
7"Gujarat"
8"Haryana"
9"Himachal Pradesh"
10"Jammu & Kashmir"
11"Karnataka"
12"Kerala"
13"Madhya Pradesh"
14"Maharashtra"
15"Manipur"
16"Meghalaya"
18"Nagaland"
19"Orissa"
20"Punjab"
21"Rajasthan"
22"Sikkim"
23"Tamil Nadu"
24"Tripura"
25"Uttar Pradesh"
26"West Bengal"
27"A & N Islands"
3"Arunachal Pradesh"
28"Chandigarh"
29"Dadra & Nagar Haveli"
31"Delhi"
6"Goa"
32"Lakshdweep"
17"Mizoram"
33"Pondicherry"
30"Daman & Diu"
35"Chattigarh"
34"Jharkhand"
36"Uttaranchal";
lab val state state;

tab state;
rename state state2;
decode state2, g (state);
drop state2;


tostring NICcode, replace;
replace NICcode="0"+NICcode if length(NICcode)==3;

save "$intdata/master56_clean", replace;
erase "$intdata/master56.dta";
