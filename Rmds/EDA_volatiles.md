---
title: "Volatiles - EDA"
author: "Javiera Rudolph"
date: "5/17/2019"
output:
  html_document:
    keep_md: true
---



The original raw data excel file (LK_CompositeData_w_Partial_Flux_Final.xlsx) is fairly complicated. It has multiple sheets, references and calculations. The first sheet is the one that contains all of the data. So, I tried importing that one using the `readxl::read_xlsx` function but it failed to import. There must have been some formatting issue. I opted to use `read_csv` and transform the first sheet of the excel data into a csv file. I couldn't delete any of the morphological traits since it change the references for the volatile data. I just left it as is, removed all formating with colors, highlights, merged cells and removed the first explanatory row. All of this was done by hand and not scripted. 



```
## [1] 1419  183
```

The dimmensions associated to this don't make much sense because I was under the impression that there were 600ish samples. There must be some NAs or blank cells in here.


```
##                    Fam #              Sample Name Sample_name_double check 
##                      773                      756                      813 
##            m29.9975_FLUX m29.9975 ((NO)+) (Conc)2           m30.99783_FLUX 
##                      773                      773                      773
```
This tells me thera re more than 700 values with NAs in the dataframe. We are going to remove all the ones with NAs in the Family, because those are probably just remnants from excels autofill or something like that. 


```
## # A tibble: 6 x 182
##   `Fam #` `Sample Name` m29.9975_FLUX `m29.9975 ((NO)~ m30.99783_FLUX
##     <dbl> <chr>                 <dbl>            <dbl>          <dbl>
## 1       5 P_11_16_15     -0.00000542            -360.   -0.0000000234
## 2      33 P_24_5_18      -0.000000571            -36.6   0.0000000311
## 3       3 P_1_6_7        -0.00000105             -29.2  -0.0000000213
## 4       3 P_1_6_2        -0.00000265             -27.5   0.0000000145
## 5       3 P_1_6_2        -0.00000134             -32.3  -0.0000000154
## 6      16 P_18_1_13_B    -0.00000874            -422.   -0.0000000476
## # ... with 177 more variables: `m30.99783 ((NO)+_(15N)) (Conc)2` <dbl>,
## #   m31.01783_FLUX <dbl>, `m31.01783 (formaldehyde H+) (Conc)2` <dbl>,
## #   m31.9908_FLUX2 <dbl>, `m31.9908 ((O2)+) (Conc)22` <dbl>,
## #   m32.99853_FLUX <dbl>, `m32.99853 ((O2)+_(17O)) (Conc)2` <dbl>,
## #   m33.03230_FLUX <dbl>, `m33.03230 (methanol H+) (Conc)2` <dbl>,
## #   m33.98721_FLUX <dbl>, `m33.98721 ((O2)+_(18O)) (Conc)2` <dbl>,
## #   m34.02317_FLUX <dbl>, `m34.02317 (m34_2) (Conc)2` <dbl>,
## #   m37.0289_FLUX <dbl>, `m37.0289 (cluster (H2O)H3O+) (Conc)2` <dbl>,
## #   `m39.0326 (cluster (H2O)H3O+_(18O)) (Conc)` <dbl>, `m39.0326 (cluster
## #   (H2O)H3O+_(18O)) (Conc)2` <dbl>, m41.0375_FLUX <dbl>, `m41.0375
## #   (propyne H+) (Conc)2` <dbl>, `m42.0343 (acetonitrile H+)
## #   (Conc)` <dbl>, `m42.0343 (acetonitrile H+) (Conc)2` <dbl>, `m42.95810
## #   (m43_1) (Conc)` <dbl>, `m42.95810 (m43_1) (Conc)2` <dbl>,
## #   m43.01734_FLUX <dbl>, `m43.01734 (m43_2) (Conc)2` <dbl>,
## #   m44.0626_FLUX <dbl>, `m44.0626 (propane) (Conc)2` <dbl>,
## #   m45.0335_FLUX <dbl>, `m45.0335 (acetaldehyde H+) (Conc)2` <dbl>,
## #   m45.99328_FLUX <dbl>, `m45.99328 ((NO2)+) (Conc)2` <dbl>,
## #   m46.03111_FLUX <dbl>, `m46.03111 (m46_2) (Conc)2` <dbl>,
## #   m46.06609_FLUX <dbl>, `m46.06609 (m46_3) (Conc)2` <dbl>,
## #   m47.0128_FLUX <dbl>, `m47.0128 (formic acid H+) (Conc)2` <dbl>,
## #   m47.9847_FLUX <dbl>, `m47.9847 ((O3)+) (Conc)2` <dbl>,
## #   m49.0239_FLUX <dbl>, `m49.0239 (methanethiol H+) (Conc)2` <dbl>,
## #   m49.05240_FLUX <dbl>, `m49.05240 (ethanol H+_(18O)) (Conc)2` <dbl>,
## #   `m49.9923 (chloromethane) (Conc)` <dbl>, `m49.9923 (chloromethane)
## #   (Conc)2` <dbl>, `m55.0390 (cluster (H2O)2-H3O+) (Conc)` <dbl>,
## #   `m55.0390 (cluster (H2O)2-H3O+) (Conc)2` <dbl>, m57.02382_FLUX <dbl>,
## #   `m57.02382 (acrolein H+) (Conc)2` <dbl>, `m57.05991 (cluster
## #   (H2O)2-H3O+_(18O)) (Conc)` <dbl>, `m57.05991 (cluster
## #   (H2O)2-H3O+_(18O)) (Conc)2` <dbl>, m59.0439_FLUX <dbl>, `m59.0439
## #   (acetone H+) (Conc)2` <dbl>, m61.0290_FLUX <dbl>, `m61.0290 (acetic
## #   acid H+) (Conc)2` <dbl>, m62.0294_FLUX <dbl>, `m62.0294 (acetic acid
## #   H+_(13C)) (Conc)2` <dbl>, m63.023_FLUX <dbl>, `m63.023 (ethanethiol
## #   H+) (Conc)2` <dbl>, m69.00377_FLUX <dbl>, `m69.00377 ((C4H4O)H+)
## #   (Conc)2` <dbl>, m69.06994_FLUX <dbl>, `m69.06994 (isoprene H+)
## #   (Conc)2` <dbl>, m71.0354_FLUX <dbl>, `m71.0354 (crotonaldehyde H+)
## #   (Conc)2` <dbl>, `m73.0376 (butyraldehyde H+) (Conc)` <dbl>, `m73.0376
## #   (butyraldehyde H+) (Conc)2` <dbl>, m75.0446_FLUX <dbl>, `m75.0446
## #   (propionic acid H+) (Conc)2` <dbl>, m77.0597_FLUX <dbl>, `m77.0597
## #   (propylene glycol H+) (Conc)2` <dbl>, m79.05478_FLUX <dbl>, `m79.05478
## #   (benzene H+) (Conc)2` <dbl>, m81.0699_FLUX <dbl>, `m81.0699
## #   (cyclohexadiene H+) (Conc)2` <dbl>, m83.0585_FLUX <dbl>, `m83.0585
## #   (methylfuran H+) (Conc)2` <dbl>, m85.0648_FLUX <dbl>, `m85.0648
## #   (cyclopentanone H+) (Conc)2` <dbl>, m86.0362_FLUX <dbl>, `m86.0362
## #   ((C4H6O2)+) (Conc)2` <dbl>, m87.0441_FLUX <dbl>, `m87.0441 ((C4H6O2)H+
## #   (acid)) (Conc)2` <dbl>, `m89.05810 (butyric acid H+) (Conc)` <dbl>,
## #   `m89.05810 (butyric acid H+) (Conc)2` <dbl>, m89.09610_FLUX <dbl>,
## #   `m89.09610 (MTBE) (Conc)2` <dbl>, m90.00000_FLUX <dbl>, `m90.00000
## #   (nominal 90) (Conc)2` <dbl>, m91.00000_FLUX <dbl>, `m91.00000 (nominal
## #   91) (Conc)2` <dbl>, `m92.00000 (nominal 92) (Conc)` <dbl>, `m92.00000
## #   (nominal 92) (Conc)2` <dbl>, m93.0699_FLUX <dbl>, `m93.0699 (toluene
## #   H+) (Conc)2` <dbl>, M94_FLUX <dbl>, m942 <dbl>,
## #   `m95.00000-FLUX` <dbl>, `m95.00000 (nominal 95) (Conc)2` <dbl>,
## #   m97.00000_FLUX <dbl>, ...
```


Now, we have a total of 646 observations, from which there are 46 families and 374 samples.

I'm going to rename the columns to make the work easier and with this, I'll create a key of names for the volatiles.



So far, the name key and the data are ready to start exploring.






Some of the questions that arise from this dataset (which is only including volatiles and identifier, no sex is included):
 - What does the *Sample Name* stand for? And how many of each should we have. Some seem to be repeated numbers, but not all. 
 - What does the name of each volatile correspond to? What is the difference between **FLUX** and **(Conc)2**? Are they in any specific units?
 

 
