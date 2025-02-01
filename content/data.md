---
title: ""
author: Murat Abus
date: '2024-12-28'
---

<font size="7"><p style="text-align: center; color:#ae1717;">Data</p>
<hr/> </font>

<font size="3">

For various projects, I used data from publicly available sources to calculate new variables. These data are at the district and regional level in Turkey:

1. **Mosque Density**: Number of mosques per district is available from the Directorate of Religious Affairs, however it is not possible to use this as a control without standardizing. I divided the number of mosques by the district population and generated a mosque density variable (per 10,000 people) that can be used as one more proxy for religiosity. In order to facilitate merging with existing datasets, the mosque density data have district pcodes. For a visualization of the data, you may [visit this page](https://www.muratabus.com/post/practical-introduction-to-mapping-with-stata/).

    The data can be accessed on my GitHub repo:
    
    [Mosque Density](https://github.com/murabus/mosque_density) 

2. **Educational Gender Gap**: I calculated this variable to quantify the over-time change in the difference in educational attainment between women and men in Turkey at the district level. Based on availability of local education data, I calculated educational gender gap for the years 1985, 1990, 2000, 2008, 2011, 2015, and 2018. In one of the first applications of its kind, I validated the concept and used it as the main independent variable in my article about the vote shift in the 2018 parliamentary election in Turkey.[^1] The variable ranges from a theoretical -1 to 1. The increase in the variable denotes a worsening situation for women in overall educational attainment. Negative values show higher women educational attainment levels compared to men and positive values denote the opposite. The district level data have the pcodes for districts for easier merging with existing datasets.  

    The data can be accessed on my GitHub repo:
    
    [Educational Gender Gap - Districts](https://github.com/murabus/Educational_Gender_Gap)
    
    [Educational Gender Gap - Regions (NUTS-1)](https://github.com/murabus/Educational_Gender_Gap)


[^1]: Abus, Murat. 2024. "A Theory of Gender's Effect on Vote Shift with a Test Based on Turkish Elections."*Mediterranean Politics* 29(5): 729-754. 

</font>