************************************************************************
***************Ghani - Kerr - O'Connell 		 ***********************
***************Political Reservations and Women's Entrepreneuship*******
***************Journal of Development Economics, 2014 ******************
***************Replication Backup				 ***********************
************************************************************************

These files provide replication backup for Ghani, Kerr & O'Connell (JDE 2014).

The do-files contained in the folder allow the user to replicate the datasets
 and analyses used in Ghani, Kerr & O'Connell (2014). Development was done on 
 64-bit Win7 PC and Stata 11.2. A user may need up to 2GB of RAM to be able
 to run the entire replication due to the size of the raw data files. 
 Some programs (notably some of the read-in programs) use syntax from 
 an earlier version of Stata.

To be able to run the do-files, the user must change the line 

	global root "..."

appearing in the header of every do-file. This must be changed to the 
directory where the downloaded replication folder was placed.


If the user wants to replicate the entire set of programs at once via batch
(Windows only), 2 items must be changed in the commands in the batch file (.bat):

1) the working directory set by 

cd "..."

should be the same as what the user sets as the working directory, as 
 $root +"/4work"

2) The location of the Stata executable file on the user's drive.


The batch file can be opened with a text editor. Whether run or not, the user 
should refer to this as the guide to correct sequencing of programs.


Finally, the following packages must be installed on the local machine to run these programs:
-estout
-spmap