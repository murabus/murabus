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
subtitle: "This is a relatively short, practical introduction to mapping with Stata designed to get the newcomer started in no time." 
summary: "This is a relatively short, practical introduction to mapping with Stata designed to get the newcomer started in no time." 
lastmod: '2022-06-24T23:27:07+03:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

## 1. Preliminaries

```
pwd
```

```
spshape2dta tur_polbnda_adm2, replace
```
```
use "tur_polbnda_adm2.dta", clear
```

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
spset. modify coordsys(latlong, kilometers)
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
