*==============================================================================
*==============================================================================
*=     File-Name:      abus_clientelism.do                                   == 
*=     Date:           01/04/2022                                            ==
*=     Author:         Murat Abus (mabus@tamu.edu)                           ==
*=     Purpose:        Individual Level Analysis of Clientelism              == 
*=     Input File 1:   clientelism_dataset1.0.dta                            ==
*=     Output File:    n/a                                                   ==
*=     Previous file:   n/a                                                   ==
*=     Software:       Stata 16.1 IC                                         ==
*=     Machine:        Lenovo ThinkPad E570                                  == 
*=     System:         Ubuntu 20.04.3 LTS / GNOME 3.36.8                     ==
*==============================================================================
*==============================================================================

version 
clear 
pwd
log using replication, replace
*cd to the path of the dataset.

/* This .do file contains the code to replicate the results of individual-level analysis of clientelism as reported in 

Abus, Murat. 2022. "THE CORRECT FILE NAME AND CITATION HERE." 

The study utilizes a multi-level model. The original survey data come from  KONDA Barometers in 2016 and 2017. In order to control for province level variables, data were added to expand the dataset.                            */												      
cd "/home/murat/Desktop/Publications/Clientelism and Structured Voting/Project Files/Code and Data for Github"

use "clientelism_dataset1.0.dta"

describe

// This gives the descriptive statistics for the summary table in the paper:

summarize voteintakp socialsupport Wavedummy tvnews prospect persfinance  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens prospers retrospers crisis hardship minimumwage minimumwage2

// Prospective economic evaluation scale (Checking Cronbach's Alpha)
alpha crisis hardship

// This gives the pairwise correlations between the economic variables reported in the appendix:

pwcorr prospect persfinance selfprosper 	educstatgroup


//Estimating a mixed effects model (multi-level model):

melogit voteintakp socialsupport Wavedummy tvnews prospect persfinance  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

//This code gives us the Akaike and Bayesian Information Criterion:

estat ic

//If we want to check intraclass correlation, we would use

estat icc

//The table reporting the results can be reproduced with the following code: 

eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospect persfinance  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table2.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention")

// Plotting the average marginal effects for certain variables of interest:

quietly melogit voteintakp vote2015akp akpchange prospect resarearural  religiosity selfprosper persfinance agegroup gender socialsupport educstatgroup Wavedummy tvnews ethnicdummy   ginip lngdpcap17 mosqdens || province:, vce(robust)

margins, dydx(vote2015akp akpchange prospect resarearural religiosity selfprosper persfinance gender agegroup educstatgroup) post
 
// Plotting the average marginal effects for comparison. You may need to install coefplot (ssc install coefplot, replace)
coefplot, msymbol(O) xline(0) 

// Marginal Effects Plot for Main Variable of Interest
// 1. Marginal Effect of Change in Perceptions of Social Support
quietly melogit voteintakp socialsupport Wavedummy tvnews prospect persfinance  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

margins, at(akpchange=(1 2 3)) vsquish

marginsplot, recast(line) recastci(rarea) ciopts(fintensity(30))

**********End of Main Replication Files

// Robustness Checks: The following are the code to reproduce the analysis offered as robustness checks in the appendix of the paper. Two general approaches are utilized in these checks. First, based on the magnitude of the "AKP partisan" variable, these alternative specifications are meant to show that the main results are not a product of partisanship. Second, in order to account for alternative explanations and to check for robustness, diferent operationalizations of some key controls are entered into models.

// 1. [Interaction Model 1] AKP partisan interacted with perceptions of change in support
melogit voteintakp socialsupport Wavedummy tvnews prospect persfinance  i.vote2015akp##c.akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospect persfinance  i.vote2015akp##akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table4.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 2. [Interaction Model 2] AKP partisan interacted with prospective economic evaluation
melogit voteintakp socialsupport Wavedummy tvnews persfinance  i.vote2015akp##c.prospect akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews persfinance  i.vote2015akp##c.prospect akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table5.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 3. [Interaction Model 3] AKP partisan interacted with self-evaluation of prosperity
melogit voteintakp socialsupport Wavedummy tvnews prospect persfinance  i.vote2015akp##c.selfprosper akpchange educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospect persfinance  i.vote2015akp##c.selfprosper akpchange educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table6.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 4. [Interaction Model 4] AKP partisan interacted with current family finances 
melogit voteintakp socialsupport Wavedummy tvnews prospect i.vote2015akp##c.persfinance akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospect   i.vote2015akp##c.persfinance akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table7.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 5. [Interaction Model 5] AKP partisan interacted with Kurdish 
melogit voteintakp socialsupport Wavedummy tvnews prospect persfinance  i.vote2015akp##i.ethnicdummy akpchange selfprosper educstatgroup religiosity resarearural gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospect persfinance  i.vote2015akp##i.ethnicdummy akpchange selfprosper educstatgroup religiosity resarearural gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table8.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Ronustness Check)")

// 6. [Interaction Model 6] AKP partisan interacted with religiosity
melogit voteintakp socialsupport Wavedummy tvnews prospect persfinance  i.vote2015akp##c.religiosity akpchange selfprosper educstatgroup resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospect persfinance i.vote2015akp##c.religiosity akpchange selfprosper educstatgroup  resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table9.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 7. Robustness Check with a longer period of prospective evaluation (5 years)
melogit voteintakp socialsupport Wavedummy tvnews prospers persfinance  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospers persfinance  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table10.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 8. Robustness Check with a longer period of retrospective evaluation (5 years)
melogit voteintakp socialsupport Wavedummy tvnews prospect retrospers  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospect retrospers  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table11.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 9. Robustness check with the individual components of the prospective evaluation index used in the analysis. First one is expectation of an economic hardship in the next 12 months (egotropic) 
melogit voteintakp socialsupport Wavedummy tvnews hardship persfinance  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews hardship persfinance  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table12.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 10. Robustnes check with the individual components of the prospective evaluation index used in the analysis. Second one is expectation of an economic crisis in the next 1 months (sociotropic) 
melogit voteintakp socialsupport Wavedummy tvnews crisis persfinance  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews crisis persfinance  vote2015akp akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table13.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 11. In order to address concerns that the process might work differently for people of limited means, I divided the sample into two waves of 2016 and 2017 and used the minimum wage for 2016 and 2017 as an additional variable and interacted it with AKP partisan.

// 11a. Survey wave 2016, minimum wage for 2016 is utilized 
keep if Wavedummy==0

melogit voteintakp socialsupport Wavedummy tvnews prospect vote2015akp minimumwage akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospect   vote2015akp minimumwage akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table14.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 11b. Survey wave 2017, minimum wage for 2017 is utilized
keep if Wavedummy==1

melogit voteintakp socialsupport Wavedummy tvnews prospect vote2015akp akpchange minimumwage2 selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospect   vote2015akp akpchange minimumwage2 selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table15.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 11c. Interaction of AKP partisan and mimimum wage is included in the model of 11a
keep if Wavedummy==0

melogit voteintakp socialsupport Wavedummy tvnews prospect i.vote2015akp##i.minimumwage akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospect   i.vote2015akp##i.minimumwage akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table16.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")

// 11d. Interaction of AKP partisan and minimum wage is included in the model of 11b
keep if Wavedummy==1

melogit voteintakp socialsupport Wavedummy tvnews prospect i.vote2015akp##i.minimumwage2 akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

// To produce the table in the appendix
eststo: quietly melogit voteintakp socialsupport Wavedummy tvnews prospect   i.vote2015akp##i.minimumwage2 akpchange selfprosper educstatgroup religiosity resarearural ethnicdummy gender agegroup ginip lngdpcap17 mosqdens || province:, vce(robust)

esttab using "table17.tex", replace b(%9.3g) se label nogap onecell     ///
nonumbers mtitle("Estimates") title("Correlates of AKP vote intention (Robustness Check)")
 
******************End of Appendix Files

*---------------------------------END OF DO-FILE--------------------------------

