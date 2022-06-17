*==============================================================================
*==============================================================================
*=     File-Name:      abus_religion.do                                      == 
*=     Date:           03/15/2021                                            ==
*=     Author:         Murat Abus (mabus@tamu.edu)                           ==
*=     Purpose:        Replicating the Analysis in Abus' Religion Paper      == 
*=     Input File 1:   religion_and_participation.dta                        ==
*=     Output File:    n/a                                                   ==
*=     Data Output:    n/a                                                   ==
*=     Software:       Stata IC 16.1                                         ==
*=     Machine:        Lenovo ThinkPad E570                                  == 
*=     System:         Ubuntu 20.04.4 LTS / GNOME 3.36.8                     ==
*==============================================================================
*==============================================================================
version
clear
pwd

// This .do file contains the code to replicate the analysis found in:
// Abus, Murat. 2022. "Correct citation goes here."

use "religion_and_participation.dta", replace

// Table 1 in the paper for summary statistics:
summarize voteintakp wave age educstat hhsizegroup retired housewife unemployed lifestyle religiosity ethnicdummy religdummy hhincgroup resarea tvnews newspaper newsdummy edgengap mosqdens sedi  

// Getting the overall average marginal effect of religoisity for the entire period over 12 waves 
// (Model 1 in Table 2)

melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

estat icc

margins, dydx(religiosity) 

eststo: quietly melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

esttab using "table2.tex", replace b(%9.3g) se label nogap onecell ///
nonumbers mtitle("Estimates") title("AKP Vote Intention")

// Model 2 in Table 2
keep if wave==1 | wave==2 | wave==3 | wave==4

melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

margins, dydx(religiosity) 

eststo: quietly melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

esttab using "table3.tex", replace b(%9.3g) se label nogap onecell ///
nonumbers mtitle("Estimates") title("AKP Vote Intention")

//Model 3 in Table 2 
keep if wave==5

melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

margins, dydx(religiosity) 

eststo: quietly melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

esttab using "table4.tex", replace b(%9.3g) se label nogap onecell ///
nonumbers mtitle("Estimates") title("AKP Vote Intention")

// Model 4 in Table 2
keep if wave==6

melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

margins, dydx(religiosity) 

eststo: quietly melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

esttab using "table5.tex", replace b(%9.3g) se label nogap onecell ///
nonumbers mtitle("Estimates") title("AKP Vote Intention")

// Model 5 in Table 2
keep if wave==7 

melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

margins, dydx(religiosity) 

eststo: quietly melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

esttab using "table6.tex", replace b(%9.3g) se label nogap onecell ///
nonumbers mtitle("Estimates") title("AKP Vote Intention")

// Model 6 in Table 2
keep if wave==8

melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

margins, dydx(religiosity) 

eststo: quietly melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

esttab using "table7.tex", replace b(%9.3g) se label nogap onecell ///
nonumbers mtitle("Estimates") title("AKP Vote Intention")

// Model 7 in Table 2
keep if wave==9

melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

margins, dydx(religiosity) 

eststo: quietly melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

esttab using "table8.tex", replace b(%9.3g) se label nogap onecell ///
nonumbers mtitle("Estimates") title("AKP Vote Intention")

// Model 8 in Table 2
keep if wave==10

melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

margins, dydx(religiosity) 

eststo: quietly melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

esttab using "table9.tex", replace b(%9.3g) se label nogap onecell ///
nonumbers mtitle("Estimates") title("AKP Vote Intention")

// Model 9 in Table 2
keep if wave==11 | wave==12

melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

margins, dydx(religiosity) 

eststo: quietly melogit voteintakp age agesq gender hhsizegroup housewife educstatgroup  hhincgroup resarea tvnews ethnicdummy religdummy religiosity mosqdens || region:, vce(robust)

esttab using "table10.tex", replace b(%9.3g) se label nogap onecell ///
nonumbers mtitle("Estimates") title("AKP Vote Intention")


// Robustness analizi ayni modeller - regional level controller iki tane yukarida hangisini kullanmadiysak onu kullanalim, ve lifestyle cluster kullanilarak yapilacak (religiositynin yerine)
