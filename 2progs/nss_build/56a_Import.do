************************************************************************
***************Ghani - Kerr - O'Connell 		 ***********************
***************Political Reservations and Women's Entrepreneuship*******
***************Journal of Development Economics, 2014 ******************
***************Replication Backup				 ***********************
************************************************************************
***Note that this file is for a general-purpose data read-in & clean, thus
***operates on far more variables than may be necessary given final use.
*Original Author: Shanthi Nataraj
*Updated/Revised by: S. O'Connell
*Any errors or inelegancies are the sole responsibility of O'Connell.

clear
clear matrix
clear mata
cap log close

global root "C:/OpenCode/GKO_Reservations_JDE2014_ReplBackup"
include "$root/2progs/00_Set_paths.do"
************************************************************************
************************************************************************
global input "$data/NSS/Nss56_2.2/Data/"
**************************************** IMPORTING ROUND 56 ******************************************
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 natureoperation 60 typeownership 61 accountavailable 62 locaent 63 regis 64 regcod1 65 regcod2 66 regcod3 67 source1 68 source2 69 destin1 70 destin2 71 electconnect 72 powercut 73 capitalshortage 74 rawmaterials 75 marktgprod 76 anyotherprob 77-78 workcontbasdis 79 typecont 80 equipment 81 rawmaterial 82 design 83 typeassist1 84 typeassist2 85 typeassist3 86 mixedact 87 otherecostatus 88 progressenterprise 89 nomonthsworked 90-91 workerownfullfemale 92-94 workerownfullmale 95-97 workerownpartfemale 98-100 workerownpartmale 101-103 workerowntotal 104-106 workerhiredfullfemale 107-109 workerhiredfullmale 110-112 workerhiredpartfemale 113-115 workerhiredpartmale 116-118 workerhiredtotal 119-121 workerotherfullfemale 122-124 workerotherfullmale 125-127 workerotherpartfemale 128-130 workerotherpartmale 131-133 workerothertotal 134-136 workertotalfullfemale 137-139 workertotalfullmale 140-142 workertotalpartfemale 143-145 workertotalpartmale 146-148 workertotal 149-151 manuexpenses 152-163 tradexpenses 164-175 otherexpenses 176-187 totalexpenses 188-199 distriexpenses 200-211 prodreceipt 212-223 stockreceipt 224-235 manureceipt 236-247 tradereceipt 248-259 otherreceipt 260-271 totalreceipt 272-283 gvaprod 284-295 emolument 296-307 rent 308-319 interest 320-331 profit 332-343 gvaincome 344-355 timetaken 356-358 reasonsubst 359 using "$input/ALL201NR.txt
drop id
save "$input/ALL201NR.dta", replace
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 natureoperation 60 typeownership 61 accountavailable 62 locaent 63 regis 64 regcod1 65 regcod2 66 regcod3 67 source1 68 source2 69 destin1 70 destin2 71 electconnect 72 powercut 73 capitalshortage 74 rawmaterials 75 marktgprod 76 anyotherprob 77-78 workcontbasdis 79 typecont 80 equipment 81 rawmaterial 82 design 83 typeassist1 84 typeassist2 85 typeassist3 86 mixedact 87 otherecostatus 88 progressenterprise 89 nomonthsworked 90-91 workerownfullfemale 92-94 workerownfullmale 95-97 workerownpartfemale 98-100 workerownpartmale 101-103 workerowntotal 104-106 workerhiredfullfemale 107-109 workerhiredfullmale 110-112 workerhiredpartfemale 113-115 workerhiredpartmale 116-118 workerhiredtotal 119-121 workerotherfullfemale 122-124 workerotherfullmale 125-127 workerotherpartfemale 128-130 workerotherpartmale 131-133 workerothertotal 134-136 workertotalfullfemale 137-139 workertotalfullmale 140-142 workertotalpartfemale 143-145 workertotalpartmale 146-148 workertotal 149-151 manuexpenses 152-163 tradexpenses 164-175 otherexpenses 176-187 totalexpenses 188-199 distriexpenses 200-211 prodreceipt 212-223 stockreceipt 224-235 manureceipt 236-247 tradereceipt 248-259 otherreceipt 260-271 totalreceipt 272-283 gvaprod 284-295 emolument 296-307 rent 308-319 interest 320-331 profit 332-343 gvaincome 344-355 timetaken 356-358 reasonsubst 359 using "$input/ALL201NU.txt
drop id
save "$input/ALL201NU.dta", replace
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 natureoperation 60 nomonthsoperated 61-62 typeownership 63 mixedactivity 64 yearsalary 65-76 yearlygroupbenefits 77-88 yearlytotalsalary 89-100 loanamtlendinst 101-110 yearlyloanintlendinst 111-122 loanamtagen 123-132 yearlyloanintagen 133-144 loanamtlender 145-154 yearlyloanintlender 155-166 loanamtpartner 167-176 yearlyloanintpartner 177-188 loanamtcontrac 189-198 yearlyloanintcontrac 199-210 loanamtreltv 211-220 yearlyloanintreltv 221-232 loanamtother 233-242 yearlyloanintother 243-254 loanamttotal 255-264 yearlyloaninttotal 265-276 landown 277-286 landhired 287-296 landnetadd 297-306 yearlylandrent 307-318 plantown 319-328 planthired 329-338 plantnetadd 339-348 yearlyplantrent 349-360 transportown 361-370 transporthired 371-380 transportnetadd 381-390 yearlytransportrent 391-402 toolsown 403-412 toolshired 413-422 toolsnetadd 423-432 yearlytoolsrent 433-444 totalassetown 445-454 totalassethired 455-464 totalassetnetadd 465-474 yearlytotalassetrent 475-486 totalhiredworker 487-489 totalworker 490-492 reasonsubst 493 using "$input/ALL202NR.txt
drop id
save "$input/ALL202NR.dta", replace
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 natureoperation 60 nomonthsoperated 61-62 typeownership 63 mixedactivity 64 yearsalary 65-76 yearlygroupbenefits 77-88 yearlytotalsalary 89-100 loanamtlendinst 101-110 yearlyloanintlendinst 111-122 loanamtagen 123-132 yearlyloanintagen 133-144 loanamtlender 145-154 yearlyloanintlender 155-166 loanamtpartner 167-176 yearlyloanintpartner 177-188 loanamtcontrac 189-198 yearlyloanintcontrac 199-210 loanamtreltv 211-220 yearlyloanintreltv 221-232 loanamtother 233-242 yearlyloanintother 243-254 loanamttotal 255-264 yearlyloaninttotal 265-276 landown 277-286 landhired 287-296 landnetadd 297-306 yearlylandrent 307-318 plantown 319-328 planthired 329-338 plantnetadd 339-348 yearlyplantrent 349-360 transportown 361-370 transporthired 371-380 transportnetadd 381-390 yearlytransportrent 391-402 toolsown 403-412 toolshired 413-422 toolsnetadd 423-432 yearlytoolsrent 433-444 totalassetown 445-454 totalassethired 455-464 totalassetnetadd 465-474 yearlytotalassetrent 475-486 totalhiredworker 487-489 totalworker 490-492 reasonsubst 493 using "$input/ALL202NU.txt
drop id
save "$input/ALL202NU.dta", replace
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 natureoperation 60 nomonthsoperated 61-62 typeownership 63 mixedactivity 64 item309 65-76 item319 77-88 item321 89-100 item322 101-112 item323 113-124 item329 125-136 item331 137-148 item332 149-160 item333 161-172 item334 173-184 item335 185-196 item336 197-208 item337 209-220 item338 221-232 item339 233-244 item501 245-256 item502 257-268 item503 269-280 item509 281-292 item409 293-304 item413 305-316 item419 317-328 item439 329-340 item441 341-352 item442 353-364 item443 365-376 item444 377-388 item445 389-400 item446 401-412 item449 413-424 assetsowned 425-434 assetshired 435-444 totworker 445-447 reasonsubst 448 using "$input/ALL203NR.txt
drop id
save "$input/ALL203NR.dta", replace
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 natureoperation 60 nomonthsoperated 61-62 typeownership 63 mixedactivity 64 item309 65-76 item319 77-88 item321 89-100 item322 101-112 item323 113-124 item329 125-136 item331 137-148 item332 149-160 item333 161-172 item334 173-184 item335 185-196 item336 197-208 item337 209-220 item338 221-232 item339 233-244 item501 245-256 item502 257-268 item503 269-280 item509 281-292 item409 293-304 item413 305-316 item419 317-328 item439 329-340 item441 341-352 item442 353-364 item443 365-376 item444 377-388 item445 389-400 item446 401-412 item449 413-424 assetsowned 425-434 assetshired 435-444 totworker 445-447 reasonsubst 448 using "$input/ALL203NU.txt
drop id 
save "$input/ALL203NU.dta", replace
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 itemcode 60-62 asicc2 63-64 asicc5 65-69 valueexpenditure 70-81 totalworker 82-84 reasonsubst 85 using "$input/ALL204NR.txt
* drops id - id is just W3 for 301-305 and W4 for 501
drop id
reshape wide asicc2 asicc5 valueexpenditure, i(stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno) j(itemcode)
save "$input/ALL204NR.dta", replace
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 itemcode 60-62 asicc2 63-64 asicc5 65-69 valueexpenditure 70-81 totalworker 82-84 reasonsubst 85 using "$input/ALL204NU.txt
drop id 
reshape wide asicc2 asicc5 valueexpenditure, i(stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno) j(itemcode)
save "$input/ALL204NU.dta", replace
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 itemcode 60-62 asicc2 63-64 asicc5 65-69 valuereceipt 70-81 totalworker 82-84 reasonsubst 85 using "$input/ALL205NR.txt
drop id
reshape wide asicc2 asicc5 valuereceipt , i(stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno) j(itemcode)
save "$input/ALL205NR.dta", replace
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 itemcode 60-62 asicc2 63-64 asicc5 65-69 valuereceipt 70-81 totalworker 82-84 reasonsubst 85 using "$input/ALL205NU.txt
drop id
reshape wide asicc2 asicc5 valuereceipt , i(stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno) j(itemcode)
save "$input/ALL205NU.dta", replace
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 workerownfullfemale 60-62 workerownfullmale 63-65 workerownpartfemale 66-68 workerownpartmale 69-71 workerowntotal 72-74 workerhiredfullfemale 75-77 workerhiredfullmale 78-80 workerhiredpartfemale 81-83 workerhiredpartmale 84-86 workerhiredtotal 87-89 workerotherfullfemale 90-92 workerotherfullmale 93-95 workerotherpartfemale 96-98 workerotherpartmale 99-101 workerothertotal 102-104 workertotalfullfemale 105-107 workertotalfullmale 108-110 workertotalpartfemale 111-113 workertotalpartmale 114-116 workertotal 117-119 ntotalexpenses 120-131 mdistriexpenses 132-143 mtotalreceipt 144-155 agvaprod 156-167 memolument 168-179 mrent 180-191 minterest 192-203 mprofit 204-215 agvaincome 216-227 reasonsubst 228 investigatorperception 229 lowervalue 230-239 highervalue 240-249 using "$input/ALL206NR.txt
drop id
save "$input/ALL206NR.dta", replace
clear
qui infix str id 1-2 roundsch 3-5 subsampleorig 6 sector 7 stateregion 8-10 stratum 11-12 substratum 13 district 14-15 subround 16 subsamplerev 17 fsuno 18-22 segno 23 enterprisetype 24 entslno 25-26 svc 27 nss 28-30 nsc 31-33 mults 34-43 informantcode 44 responsecode 45 nic2 46-47 nic3 48-50 nic4 51-54 nic5 55-59 workerownfullfemale 60-62 workerownfullmale 63-65 workerownpartfemale 66-68 workerownpartmale 69-71 workerowntotal 72-74 workerhiredfullfemale 75-77 workerhiredfullmale 78-80 workerhiredpartfemale 81-83 workerhiredpartmale 84-86 workerhiredtotal 87-89 workerotherfullfemale 90-92 workerotherfullmale 93-95 workerotherpartfemale 96-98 workerotherpartmale 99-101 workerothertotal 102-104 workertotalfullfemale 105-107 workertotalfullmale 108-110 workertotalpartfemale 111-113 workertotalpartmale 114-116 workertotal 117-119 ntotalexpenses 120-131 mdistriexpenses 132-143 mtotalreceipt 144-155 agvaprod 156-167 memolument 168-179 mrent 180-191 minterest 192-203 mprofit 204-215 agvaincome 216-227 reasonsubst 228 investigatorperception 229 lowervalue 230-239 highervalue 240-249 using "$input/ALL206NU.txt
drop id
save "$input/ALL206NU.dta", replace

* merges all rural files
use "$input/all202nr"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
save "$input/all202nr", replace
use "$input/all201nr"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
merge stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno using "$input/all202nr"
* Note that there are 9 cases in ALL201NR that are not in ALL202NR.  I keep these cases. 
drop _merge
save "$input/all201nr", replace
use "$input/all203nr"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
save "$input/all203nr", replace
use "$input/all201nr"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
merge stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno using "$input/all203nr"
drop _merge
save "$input/all201nr", replace
use "$input/all204nr"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
save "$input/all204nr", replace
use "$input/all201nr"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
merge stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno using "$input/all204nr"
drop _merge
save "$input/all201nr", replace
use "$input/all205nr"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
save "$input/all205nr", replace
use "$input/all201nr"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
merge stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno using "$input/all205nr"
drop _merge
save "$input/all201nr", replace

/* merging 206nr - I don't use this code now.  I'm not sure what the point of the variables in 206 is. 
use all206nr
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
save all206nr, replace
use all201nr
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
merge stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno using all206nr
drop _merge
save all201nr, replace
*/

* merges all urban files
use "$input/all202nu"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
save "$input/all202nu", replace
use "$input/all201nu"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
merge stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno using "$input/all202nu"
* Note that there are 5 cases in "$input/all201NUthat are not in "$input/all202NU.  I keep these cases. 
drop _merge
save "$input/all201nu", replace
use "$input/all203nu"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
save "$input/all203nu", replace
use "$input/all201nu"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
merge stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno using "$input/all203nu"
drop _merge
save "$input/all201nu", replace
use "$input/all204nu"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
save "$input/all204nu", replace
use "$input/all201nu"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
merge stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno using "$input/all204nu"
drop _merge
save "$input/all201nu", replace
use "$input/all205nu"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
save "$input/all205nu", replace
use "$input/all201nu"
sort stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno
merge stateregion stratum substratum district subround subsamplerev fsuno segno enterprisetype entslno using "$input/all205nu"
drop _merge
save "$input/all201nu", replace

* merges rural and urban files
use "$input/all201nr"
append using "$input/all201nu"
save "$input/all201", replace

* copies all final files then erases originals within subfolders
clear
*cd $input
use "$input/all201"
save "$intdata/master56", replace
erase "$input/all201.dta"
erase "$input/all201nr.dta"
erase "$input/all202nr.dta"
erase "$input/all203nr.dta"
erase "$input/all204nr.dta"
erase "$input/all205nr.dta" 
erase "$input/all206nr.dta"
erase "$input/all201nu.dta"
erase "$input/all202nu.dta"
erase "$input/all203nu.dta"
erase "$input/all204nu.dta"
erase "$input/all205nu.dta"
erase "$input/all206nu.dta"
clear
cap log close






