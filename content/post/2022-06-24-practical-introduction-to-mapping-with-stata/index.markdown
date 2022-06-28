---
title: Practical Introduction to Mapping with Stata
authors: 
  - admin
date: '2022-06-24'
slug: practical-introduction-to-mapping-with-stata
categories:
  - Tutorial
tags:
  - Stata
  - Mapping
  - Chloropleth map
subtitle: "This is a relatively short, practical introduction to mapping with Stata designed to get the newcomer started in no time and provide a quick refresher as needed." 
summary: "This is a relatively short, practical introduction to mapping with Stata designed to get the newcomer started in no time and provide a quick refresher as needed." 
lastmod: '2022-06-24'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

In this tutorial, we will draw a chloropleth map (assigning various colors to levels of a variable to show intensity) of mosque density in Turkey at the district level.[^1] In this first step of spatial analysis, we need two separate things: A map with the required boundaries marking the units we are interested in, and substantive data corresponding to the geographical units marked by the borders in the map. The map files are freely available on the internet, and the one we will use can be obtained from  [Shapefiles](https://data.humdata.org/dataset/turkey-administrative-boundaries-levels-0-1-2). We will need the **turkey_administrativelevels0_1_2.zip** file. This zip file contains the administrative boundaries for the country, provinces, and districts. In this tutorial, we are creating a map at the district level and this is the second level. After unzipping the file, extract the following files to a folder of your choice:[^2]

1. tur_polbnda_adm2.cpg
2. tur_polbnda_adm2.dbf
3. tur_polbnda_adm2.prj
4. tur_polbnda_adm2.sbn
5. tur_polbnda_adm2.sbx
6. tur_polbnda_adm2.shp
7. tur_polbnda_adm2.shp.xml
8. tur_polbnda_adm2.shx

Now that we have our shapefile in folder, we will need to generate / get our substantive data for the variable that we want to map.[^3]For this tutorial, grab the [substantive dataset](https://github.com/murabus/religion_data/blob/main/abus_mosque_density.dta) and place it in the same folder as with the shapefiles.[^4] 

Before we get down to it, two words of advice: First, it is important to realize these types of detailed maps do not show causation *per se* (Healy 2018, 182).[^5] Second, I intentionally did not provide a .do file so that the reader will type the commands themselves, and generate their own .do files with the comments that they think will be useful in the future. This - I have been led to believe - is a best practice in learning.



## 1. Preliminaries

liausefhrlwiu lOEWDFHew lwiuedfioawuef, asdjflkasjdfhl 

```
pwd
```

```
spshape2dta tur_polbnda_adm2, replace
```
We will see the following output on the console, confirming that Stata used all the shapefiles to create a .dta file that we can manipulate.

![my-first-image](image1.png)


```
use "tur_polbnda_adm2.dta", clear
describe
```
![my-second-image](image2.png)
Looking at the generated dataset

![my-third-image](image3.png)




```
encode pcode, generate(dcode)
drop pcode
rename dcode pcode
sort pcode
gen id = _n 
```

```
describe
```

```
save "tur_polbnda_adm2.dta", replace
```

```
spset
```

```
* ssc install grmap
grmap
```

```
spset, modify coordsys(latlong, kilometers)
```

```
save "tur_polbnda_adm2.dta", replace
```

## 2. Merging Datasets

```
use "abus_mosque_density.dta", clear
describe
```

```
use "tur_polbnda_adm2.dta", clear
```

```
use "abus_mosque_density.dta", clear    
```

```
merge 1:1 pcode id using "tur_polbnda_adm2.dta"
```

```
drop _merge
```

## 3. The Map!

```
grmap mosquedens, clnumber(7) clmethod(custom) ///
clbreaks(0 1 2 3 4 6 20) fcolor(Greys) legcount
```

```
save "mosquedensity.gph", replace
```

```
graph export "mosquedensity.pdf", replace
graph export "mosquedensity.svg", replace
```

[^1]: For a more detailed and formal introduction, please see the multi-part series of [Asjad Naqvi](https://medium.com/the-stata-guide/covid-19-visualizations-with-stata-part-4-maps-fbd4fe2642f6).
[^2]: Note that for this particular case, the .zip file included files ending with "0", "1", and "2". These correspond to the administrative units of the country. Files with "0" would be used to draw the country borders, files with "1" would be used to draw the province borders and here we are using the files with "2" to draw the district borders. By the same logic, there are separate shapefiles containing information about the railways, waterways, roads, etc.
[^3]: This tutorial assumes that the files be placed in a single folder. Beyond that there is no assumption about any particular folder-subfolder structure choice.
[^4]: Note that I compiled this dataset to reflect mosque density for each of 973 administrative districts in Turkey.
[^5]: Healy, Kieran. 2018. *Data Visualization: A Practical Introduction.* Princeton University Press. 
