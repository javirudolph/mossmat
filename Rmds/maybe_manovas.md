Not sure yet: manovas, correlations, G matrix stuff
================

  - [MANOVA](#manova)
      - [Traits](#traits)

``` r
library(tidyverse)
library(vegan)
library(corrplot)
library(ggpubr)
library(Hmisc)

theme_set(theme_bw())
```

``` r
master <- readRDS("cleandata/clean_master.RDS")
```

# MANOVA

## Traits

``` r
traits <- master[,c(1,3, 5:15)] %>% 
  drop_na()
traits.manova <- manova(cbind(repro, area_wk3, perim_wk3, circ_wk3, perim_rate, area_rate, days21, days_gam, leaf_length, leaf_area, leaf_perim) ~ famid + ssex + famid:ssex, data = traits)

sum.manova <- summary(traits.manova)
sum.manova
```

    ##             Df   Pillai approx F num Df den Df    Pr(>F)    
    ## famid        1 0.080123   2.0667     11    261   0.02309 *  
    ## ssex         1 0.139328   3.8410     11    261 3.833e-05 ***
    ## famid:ssex   1 0.085278   2.2121     11    261   0.01424 *  
    ## Residuals  271                                              
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Which ones?

``` r
summary.aov(traits.manova)
```

    ##  Response repro :
    ##              Df  Sum Sq Mean Sq F value  Pr(>F)  
    ## famid         1   2.593  2.5927  2.4906 0.11569  
    ## ssex          1   2.590  2.5898  2.4879 0.11589  
    ## famid:ssex    1   4.086  4.0863  3.9254 0.04857 *
    ## Residuals   271 282.103  1.0410                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response area_wk3 :
    ##              Df  Sum Sq Mean Sq F value    Pr(>F)    
    ## famid         1   0.373  0.3725  0.3977 0.5288101    
    ## ssex          1   0.094  0.0937  0.1000 0.7520190    
    ## famid:ssex    1  12.713 12.7125 13.5709 0.0002773 ***
    ## Residuals   271 253.859  0.9367                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response perim_wk3 :
    ##              Df  Sum Sq Mean Sq F value   Pr(>F)   
    ## famid         1   0.276  0.2762  0.2791 0.597727   
    ## ssex          1   0.580  0.5800  0.5862 0.444577   
    ## famid:ssex    1   7.922  7.9216  8.0052 0.005013 **
    ## Residuals   271 268.170  0.9896                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response circ_wk3 :
    ##              Df  Sum Sq Mean Sq F value  Pr(>F)  
    ## famid         1   0.582  0.5816  0.6118 0.43481  
    ## ssex          1   5.713  5.7128  6.0088 0.01487 *
    ## famid:ssex    1   0.198  0.1981  0.2084 0.64839  
    ## Residuals   271 257.652  0.9507                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response perim_rate :
    ##              Df  Sum Sq Mean Sq F value  Pr(>F)  
    ## famid         1   3.052 3.05202  2.9053 0.08944 .
    ## ssex          1   0.043 0.04345  0.0414 0.83900  
    ## famid:ssex    1   0.005 0.00474  0.0045 0.94647  
    ## Residuals   271 284.687 1.05051                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response area_rate :
    ##              Df  Sum Sq Mean Sq F value  Pr(>F)  
    ## famid         1   3.347  3.3473  3.4598 0.06396 .
    ## ssex          1   0.094  0.0941  0.0972 0.75540  
    ## famid:ssex    1   0.350  0.3499  0.3616 0.54811  
    ## Residuals   271 262.189  0.9675                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response days21 :
    ##              Df  Sum Sq Mean Sq F value Pr(>F)
    ## famid         1   2.426 2.42584  2.4546 0.1183
    ## ssex          1   0.852 0.85220  0.8623 0.3539
    ## famid:ssex    1   0.701 0.70125  0.7096 0.4003
    ## Residuals   271 267.822 0.98827               
    ## 
    ##  Response days_gam :
    ##              Df  Sum Sq Mean Sq F value  Pr(>F)  
    ## famid         1   2.921 2.92120  2.9238 0.08843 .
    ## ssex          1   0.004 0.00391  0.0039 0.95018  
    ## famid:ssex    1   0.003 0.00255  0.0026 0.95972  
    ## Residuals   271 270.760 0.99912                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response leaf_length :
    ##              Df  Sum Sq Mean Sq F value    Pr(>F)    
    ## famid         1   1.274  1.2735  1.4275    0.2332    
    ## ssex          1  21.698 21.6977 24.3216 1.423e-06 ***
    ## famid:ssex    1   0.686  0.6863  0.7693    0.3812    
    ## Residuals   271 241.764  0.8921                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response leaf_area :
    ##              Df  Sum Sq Mean Sq F value    Pr(>F)    
    ## famid         1   2.468  2.4678  2.5408    0.1121    
    ## ssex          1  19.746 19.7457 20.3302 9.709e-06 ***
    ## famid:ssex    1   0.239  0.2385  0.2456    0.6206    
    ## Residuals   271 263.209  0.9713                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response leaf_perim :
    ##              Df  Sum Sq Mean Sq F value    Pr(>F)    
    ## famid         1   5.741  5.7410  6.6484   0.01045 *  
    ## ssex          1  26.139 26.1395 30.2710 8.698e-08 ***
    ## famid:ssex    1   0.667  0.6674  0.7728   0.38012    
    ## Residuals   271 234.013  0.8635                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Visualize H matrix

``` r
h.mat <- sum.manova$SS[1]$famid

h.mat %>% 
  as.data.frame() %>% 
  rownames_to_column(var = "x") %>% 
  gather(key = "y", value = "value", -x) %>% 
  ggplot(aes(x = x, y = y, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "#0000FF", mid = "#FFFFFF", high ="#FF0000")+
  theme(axis.text.x = element_text(angle = 90)) +
  coord_equal() +
  geom_abline(slope = 1)
```

![](maybe_manovas_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

Visualize E matrix

``` r
e.mat <- sum.manova$SS[2]$ssex

e.mat %>% 
  as.data.frame() %>% 
  rownames_to_column(var = "x") %>% 
  gather(key = "y", value = "value", -x) %>% 
  ggplot(aes(x = x, y = y, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "#0000FF", mid = "#FFFFFF", high ="#FF0000")+
  theme(axis.text.x = element_text(angle = 90)) +
  coord_equal()+
  geom_abline(slope = 1)
```

![](maybe_manovas_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->
