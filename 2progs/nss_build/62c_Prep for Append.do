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
***Cut Down 62 dataset to important variables, impose weights
***and prep for appending to other NSS years.

use "$intdata/master62_int", clear
g year=2006

***Keep Vars***
#delim ;

keep 
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
monthsop
mos_accounts
year
state
acctsmaint
typecontract
destagency1 
destagency2
sourceagency1
sourceagency2
enterpriseno
level
uniqid
NICcode
industrycode5
ownership
enttype
entstatus
location
registered
probelecnoavail
probpowerout
probnocapital
probnorawmats
probmkting
probother
value309
value319
value321
value322
value323
value324
value325
value326
value327
value328
value331
value332
value333
value334
value335
value336
value337
value338
value341
value349
value409
value413
value419
value421
value422
value423
value424
value429
value431
value439
value449
value501
value502
value503
value509
value601
value602
value603
value604
value605
value606
value611
value612
value613
value614
value615
value616
value619
value701
value702
value703
value704
value709
valassetsown801
valassetshired801
addstoassetsowned801
rentpayable801
valassetsown802
valassetshired802
addstoassetsowned802
rentpayable802
valassetsown803
valassetshired803
addstoassetsowned803
rentpayable803
valassetsown804
valassetshired804
addstoassetsowned804
rentpayable804
valassetsown805
valassetshired805
addstoassetsowned805
rentpayable805
valassetsown809
valassetshired809
addstoassetsowned809
rentpayable809
	outstandingend_inst
	interest_inst
	outstandingend_agency
	interest_agency
	outstandingend_moneylend
	interest_moneylend
	outstandingend_buspart
	interest_buspart
	outstandingend_contractor
	interest_contractor
	outstandingend_frfam
	interest_frfam
	outstandingend_other
	interest_other

loanamt909
interest909
NSSWeight
NSCWeight
MLTWeight
;



***do renaming;
#delim cr
rename value309 totalrawmat
	replace totalrawmat=value501 if totalrawmat==. & value501!=.
rename value319 tottrade_othactexp
rename value321 rawmat_elec
rename value322 rawmat_fuel_lube

egen totalothexp=rowtotal(rawmat_elec rawmat_fuel_lube value323 value324 value325 value326 value327 value328)
rename value349 totothexp

rename value501 totalopexp
rename value502 totaldistexp
rename value503 totalrevenue
rename value509 GVA
rename value601 workerownfullfemale
rename value602 workerhiredfullfemale
rename value603 workerotherfullfemale
rename value604 workerownpartfemale
rename value605 workerhiredpartfemale
rename value606 workerotherpartfemale
rename value611 workerownfullmale
rename value612 workerhiredfullmale
rename value613 workerotherfullmale
rename value614 workerownpartmale
rename value615 workerhiredpartmale
rename value616 workerotherpartmale
rename value619 totalemp

egen totalsalary=rowtotal(value701 value702)
egen totalbenefits=rowtotal(value703 value704)
rename value709 totalcomp

rename valassetsown809 totalvalueassetsowned
rename valassetshired809 totalvalueassetshired
rename addstoassetsowned809 totalassets_delta
rename rentpayable809 totalrentassetshired
rename loanamt909 totalloanamount
rename interest909 totalloanint

drop val* adds* rentpayable*

replace mos_accounts=1 if acctsmaint==2 | acctsmaint==3

save "$intdata/master62_clean", replace
erase "$intdata/master62_int.dta"
