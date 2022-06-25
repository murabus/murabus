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

[Shapefiles](https://data.humdata.org/dataset/turkey-administrative-boundaries-levels-0-1-2) 

We will need the **turkey_administrativelevels0_1_2.zip** file. This zip file contains the administrative boundaries for the country, provinces, and districts. In this tutorial, we will create a detailed map, and we will need to use the ...

We will need the following files:

1. tur_polbnda_adm2.cpg
2. tur_polbnda_adm2.dbf
3. tur_polbnda_adm2.prj
4. tur_polbnda_adm2.sbn
5. tur_polbnda_adm2.sbx
6. tur_polbnda_adm2.shp
7. tur_polbnda_adm2.shp.xml
8. tur_polbnda_adm2.shx






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
grmap
```

```
spset, modify coordsys(latlong, kilometers)
```

```
save "tur_polbnda_adm2.dta", replace
```

## 2.

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

## 3. 

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
