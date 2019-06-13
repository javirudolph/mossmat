EDA and creating a clean master data file
================

  - [Introduction](#introduction)
  - [Data cleaning](#data-cleaning)
      - [Trait data](#trait-data)
          - [Leaf traits](#leaf-traits)
          - [Growth and development
            traits](#growth-and-development-traits)
          - [Reproduction variable](#reproduction-variable)
          - [Clean trait data](#clean-trait-data)
              - [Histograms raw trait data](#histograms-raw-trait-data)
              - [Histograms transformed trait
                data](#histograms-transformed-trait-data)
      - [Volatile Organic Compounds](#volatile-organic-compounds)
          - [May 30 samples](#may-30-samples)
          - [Using a 10% threshold](#using-a-10-threshold)
          - [VOC Clustering](#voc-clustering)
              - [VOC data exploration](#voc-data-exploration)
              - [Transformation and
                scaling](#transformation-and-scaling)
              - [Correlations](#correlations)
              - [Clustering](#clustering)
          - [Master dataframe](#master-dataframe)

``` r
library(tidyverse)
library(vegan)
library(plotly)
library(corrplot)
library(ggpubr)
library(Hmisc)

theme_set(theme_bw())
```

# Introduction

This document will contain pretty much everything we have done so far.
This works as a draft reference of where we are and what we have done.

# Data cleaning

Data cleaning is a really important section since lots of our functions
will throw errors with NAs, zeroes or any typos.

``` r
# Read in the raw data
rawdata <- read.csv("rawdata/LK_master.csv", stringsAsFactors = FALSE)
```

## Trait data

To make things a little easier we are going to tackle the trait data
first and then we will go on to clean VOCs. Some changes that we wish to
accomplish here include changing the variable names to simpler/shorter
ones without special characters. We would also like to remove empty rows
at the end, manage the zeroes and NAs. There are some errors in
measurements and typos that we need to address.

``` r
trait_raw <- rawdata[,1:19] %>% 
  rename(famid = `Fam..`,
         sampid = Sample.Name,
         ssex = Sample_Sex) %>% 
  drop_na(famid) %>% 
  mutate(sampid = str_replace_all(sampid, "\\(.*\\)", ""),
         sampid = str_trim(sampid, side = "both"),
         ssex = str_to_lower(as.character(ssex))) %>% 
  mutate_at(vars(starts_with("Leaf")), as.numeric) %>% 
  group_by(famid) %>% 
  arrange(sampid, .by_group = TRUE) %>% 
  ungroup
```

    ## Warning: NAs introduced by coercion
    
    ## Warning: NAs introduced by coercion
    
    ## Warning: NAs introduced by coercion

``` r
# Fix a data entry error:
# Check Github issue #5
trait_raw$Avg_21_days[which(trait_raw$Avg_21_days == 33)] <- 0.33

# Fix sex data entry error
# Check Github issue #5
trait_raw[which(trait_raw$sampid == "P_18_1_6_B"),]$ssex <- "m"
trait_raw <- trait_raw[-which(trait_raw$sampid == "P_6_6_20"),]
```

#### Leaf traits

First, we visually check for outliers or values that may not make
sense.

``` r
# Leaf data averaging -----------------------------------------------------

trait_raw[,17:19] %>% 
  gather(key = "trait", value = "value") %>% 
  ggplot(aes(x = trait, y = value)) + 
  geom_boxplot()
```

    ## Warning: Removed 56 rows containing non-finite values (stat_boxplot).

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

There are no clear outliers or errors, so these look ok to average and
we create a new data frame with the leaf data. In cases where data for
only one of the clones was available, we kept that value. For cases
where data was available for both clones we averaged it.

``` r
trait_raw[,c(2, 17:19),] %>% 
  group_by(sampid) %>% 
  summarise_at(vars(starts_with("Leaf")), mean, na.rm = TRUE) %>% 
  mutate_at(vars(starts_with("Leaf")), list(~ as.numeric(ifelse(. == "NaN", "NA", .)))) -> leaf_data
```

    ## Warning in ~as.numeric(ifelse(. == "NaN", "NA", .)): NAs introduced by
    ## coercion

    ## Warning in ~as.numeric(ifelse(. == "NaN", "NA", .)): NAs introduced by
    ## coercion

    ## Warning in ~as.numeric(ifelse(. == "NaN", "NA", .)): NAs introduced by
    ## coercion

#### Growth and development traits

We do the same thing with these other traits and it is easy to identify
three values that seem incorrect. These are in the area, circularity and
perimeter
rate.

``` r
# Growth and Development traits -------------------------------------------

trait_raw[,10:16] %>% 
  gather(key = "trait", value = "value") %>% 
  drop_na() %>% 
  ggplot(aes(x = trait, y = value)) + 
  geom_boxplot()
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
outliers <- which(trait_raw$Avg_Area._Week_3>50)
trait_raw[outliers,]
```

    ## # A tibble: 2 x 19
    ##   famid sampid Cholor. Date.PTR ssex  X._Exp Avg_Male_Buds.S~ Total._Buds
    ##   <int> <chr>  <chr>   <chr>    <chr>  <int>            <dbl>       <int>
    ## 1    36 p_6_1~ 0.669   27-May   m        100              1.7          17
    ## 2    36 p_6_1~ 0.678   24-May   m         90             NA            NA
    ## # ... with 11 more variables: Avg_Arch <dbl>, Avg_Area._Week_3 <dbl>,
    ## #   Avg_Perimeter_.Week.3 <dbl>, Avg_Circularity_Week.3 <dbl>,
    ## #   Avg_Perimeter_Rate <dbl>, Avg_Area_Rate <dbl>, Avg_21_days <dbl>,
    ## #   Avg_Days_til_Gam <dbl>, Leaf_Length_Average <dbl>,
    ## #   Leaf_Average_Area <dbl>, Leaf_perimeter_average <dbl>

``` r
trait_raw$Avg_Area._Week_3[outliers] <- trait_raw$Avg_Area._Week_3[outliers] / 1000
trait_raw$Avg_Circularity_Week.3[outliers] <- trait_raw$Avg_Circularity_Week.3[outliers] / 1000

# check again 
trait_raw[,10:16] %>% 
  gather(key = "trait", value = "value") %>% 
  drop_na() %>% 
  ggplot(aes(x = trait, y = value)) + 
  geom_boxplot()
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

These values had mistakes in the number of decimal places and included a
typo making a value be negative. After adjusting these values, we check
again for errors. The data looks ok now, so we can save the dataframe.

``` r
negs <- which(trait_raw$Avg_Perimeter_Rate < 0)
trait_raw[negs,]
```

    ## # A tibble: 1 x 19
    ##   famid sampid Cholor. Date.PTR ssex  X._Exp Avg_Male_Buds.S~ Total._Buds
    ##   <int> <chr>  <chr>   <chr>    <chr>  <int>            <dbl>       <int>
    ## 1    35 P_4_1~ 0.632   28-May   f         10               NA          NA
    ## # ... with 11 more variables: Avg_Arch <dbl>, Avg_Area._Week_3 <dbl>,
    ## #   Avg_Perimeter_.Week.3 <dbl>, Avg_Circularity_Week.3 <dbl>,
    ## #   Avg_Perimeter_Rate <dbl>, Avg_Area_Rate <dbl>, Avg_21_days <dbl>,
    ## #   Avg_Days_til_Gam <dbl>, Leaf_Length_Average <dbl>,
    ## #   Leaf_Average_Area <dbl>, Leaf_perimeter_average <dbl>

``` r
trait_raw$Avg_Perimeter_Rate[negs]
```

    ## [1] -21.40784

``` r
trait_raw$Avg_Perimeter_Rate[negs] <- trait_raw$Avg_Perimeter_Rate[negs] /-10

# Check visually
trait_raw[,10:16] %>% 
  gather(key = "trait", value = "value") %>% 
  drop_na() %>% 
  ggplot(aes(x = trait, y = value)) + 
  geom_boxplot()
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

``` r
trait_raw[,c(2, 10:16)] %>% 
  drop_na() %>% 
  distinct()-> gro_dev_data
```

#### Reproduction variable

We have different reproduction variables for males and females, so we
can scale them and that way keep them under one variable only. This
could be wrong, but I honestly don’t know what else we could
do.

``` r
# Reproduction variable ---------------------------------------------------

trait_raw %>% 
  filter(ssex == "m") %>% 
  select(sampid, ssex, Avg_Male_Buds.Stem)%>% 
  drop_na() %>% 
  group_by(sampid) %>% 
  summarise(raw_av = mean(Avg_Male_Buds.Stem)) %>% 
  mutate(reprovar = scale(raw_av),
         ssex = "m")  -> male_reprovar

trait_raw %>% 
  select(sampid, ssex, Avg_Arch) %>% 
  filter(ssex == "f") %>% 
  drop_na() %>% 
  group_by(sampid) %>% 
  summarise(raw_av = mean(Avg_Arch)) %>% 
  mutate(reprovar = scale(raw_av),
         ssex = "f") -> fem_reprovar


reprovar <- bind_rows(male_reprovar, fem_reprovar)
reprovar %>% 
  ggplot(aes(x = reprovar, fill = ssex)) +
  geom_histogram()
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

### Clean trait data

We can now join all the smaller datasets and have a master traits data
frame. These are not scaled so far and we can evaluate the changes of
scaling them vs keeping them as they
are.

``` r
# Join trait data ---------------------------------------------------------

trait_raw %>% 
  select(famid, sampid, ssex) %>% 
  distinct() %>% 
  full_join(., reprovar) %>% 
  full_join(., gro_dev_data) %>%
  full_join(., leaf_data) %>% 
  set_names(c("famid", "sampid", "ssex", "raw_repro", "repro", "area_wk3",
              "perim_wk3", "circ_wk3", "perim_rate", "area_rate",
              "days21", "days_gam", "leaf_length", "leaf_area",
              "leaf_perim")) -> traits
```

#### Histograms raw trait data

``` r
traits %>% 
  select(-c(famid, sampid, ssex, raw_repro)) %>% 
  gather(key = "trait", value = "raw_values") %>% 
  ggplot(aes(x = raw_values, y = ..density..)) +
  geom_histogram(na.rm = TRUE, fill = "#8e9998") +
  facet_wrap( ~ trait, scales = "free")
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

#### Histograms transformed trait data

If we log transform the data and then scale it, the following figure
shows the histograms for all the variables. Since we have variables in
different units, we will use the scaled traits for future analyses and
models.

``` r
names(traits)
```

    ##  [1] "famid"       "sampid"      "ssex"        "raw_repro"   "repro"      
    ##  [6] "area_wk3"    "perim_wk3"   "circ_wk3"    "perim_rate"  "area_rate"  
    ## [11] "days21"      "days_gam"    "leaf_length" "leaf_area"   "leaf_perim"

``` r
traits %>% 
  mutate_at(c(5:15), list(~ log10(. + 1))) %>% 
  mutate_at(c(5:15), scale) -> scaled_traits
```

    ## Warning in ~log10(. + 1): NaNs produced

``` r
scaled_traits %>% 
  select(-c(famid, sampid, ssex, raw_repro)) %>% 
  gather(key = "trait", value = "raw_values") %>% 
  ggplot(aes(x = raw_values, y = ..density..)) +
  geom_histogram(na.rm = TRUE, fill = "#7e9bcc") +
  facet_wrap( ~ trait, scales = "free")
```

    ## Warning: attributes are not identical across measure variables;
    ## they will be dropped

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

## Volatile Organic Compounds

Using the same raw data csv file, we are going to select only the
identifiers and the VOC data.

``` r
# Just keep volatile data and identifiers
# Also, remove the NAs, there's a lot at the end
# Remove '(2)' notation from sample ids

#names(rawdata)
voc_raw <- rawdata[,c(1,2,4,5, 20:109)] %>% 
  rename(famid = `Fam..`,
         sampid = Sample.Name,
         ssex = Sample_Sex) %>% 
  drop_na() %>% 
  mutate(sampid = str_replace_all(sampid, "\\(.*\\)", ""),
         sampid = str_trim(sampid, side = "both"))

#' Shorten voc names
oldnames <- names(voc_raw)
names(voc_raw)[5:94] <- stringr::str_trunc(oldnames[5:94], width = 6, side = "right", ellipsis = "")
```

There was an issue with the notation in one of the compounds, so we
check that and fix the notation so that R can recognize the values as
numbers.

``` r
#str(voc_raw)
#' m111.0 is a character
#voc_raw$m111.0
#' The notation is different, using a capital E
voc_raw$m111.0 <- as.numeric(str_replace(voc_raw$m111.0, "E", "e"))
```

    ## Warning: NAs introduced by coercion

### May 30 samples

Leslie mentioned that data associated to May 30 was really off, so we
are going to check that and probably remove it if the values are not
similar to the rest of the dataset. With the figure it is obvious that
we need to remove the May 30 data. With these boxplots we see that there
are some negative values. These come from subtracting the noise, so any
negative values should be zero.

``` r
voc_raw %>% 
  dplyr::select(-c(famid, sampid, ssex)) %>% 
  gather(., key = "compound", value = "value", -Date.PTR) %>% 
  ggplot(aes(x = Date.PTR, y = value)) +
  geom_boxplot() -> withMay30

voc_raw %>% 
  filter(Date.PTR != "30-May") %>%
  mutate_if(is.numeric, list(~ ifelse(. < 0, 0, .))) %>% 
  arrange(sampid, .by_group = TRUE) %>% 
  dplyr::select(-c(famid, sampid, ssex)) %>% 
  gather(., key = "compound", value = "value", -Date.PTR) %>% 
  ggplot(aes(x = Date.PTR, y = value)) +
  geom_boxplot() ->woutMay30

ggarrange(withMay30, woutMay30, nrow = 2)
```

    ## Warning: Removed 1 rows containing non-finite values (stat_boxplot).

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

### Using a 10% threshold

We are only going to keep the compounds for which at least 10% of the
samples have a value greater than zero. According to Leslie, other
sources use up to 40% of a threshold, however, we are interested in
sexual dimorphism. That means that if there is a difference in compound
production associated to the sex, then you automatically have only a 50%
chance of producing that compound. Therefore, a 10 or 20% threshold is
what would work for this project.

``` r
voc_raw %>% 
  filter(Date.PTR != "30-May") %>%
  mutate_if(is.numeric, list(~ ifelse(. < 0, 0, .))) %>% 
  arrange(sampid, .by_group = TRUE) %>% 
  dplyr::select(-Date.PTR) -> vocs

# Create a dataset with only the compounds for which at least 10% of the observations show it.
vocs %>% 
  select(-famid, -sampid, -ssex) %>% 
  mutate_if(is.numeric, function(x) ifelse(x > 0, 1, 0)) %>% 
  colSums() %>% 
  data.frame() %>% 
  rownames_to_column() %>%
  setNames(., c("voc", "count")) %>% 
  mutate(prcnt = count/nrow(vocs)) %>% 
  filter(prcnt >= 0.1) -> voc_filter

vocs %>% 
  select(famid, sampid, ssex, c(voc_filter$voc)) %>% 
  group_by(sampid) %>%
  mutate_at(vars(starts_with("m")), max) %>% 
  ungroup () %>% 
  distinct() %>% 
  mutate(ssex = str_to_lower(as.character(ssex))) -> voc_data
```

### VOC Clustering

For us to cluster the VOC data, we need to look at it first.

``` r
long_voc_data <- voc_data %>% 
  gather(., key = "voc", value = "conc", -c(famid, sampid, ssex)) %>% 
  mutate(voc = factor(voc, levels = unique(voc)))
```

#### VOC data exploration

We know we are working with very small numbers and this influences how
we will manage the data and what sort of clustering we can do for it.
With a quick check, we see that the numbers are very small and that
different compounds have very different ranges as well.

``` r
long_voc_data %>% 
  ggplot(aes(x = voc, y = conc)) + 
  geom_point() +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90))
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

After looking at the data, the first thought is to log transform it. To
check for any measurement outliers we might want to get rid of the
zeroes and transform the data to identify potential outliers.

``` r
long_voc_data %>% 
  filter(conc > 0) %>%
  ggplot(aes(x = voc, y = conc)) + 
  geom_boxplot() +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90)) +
  scale_y_log10()
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

With the information, we can clean the data again and remove these
outliers. Since the values are so small and below the machine’s
detection threshold, they are classified as zero.

``` r
# Making these outliers be zero
voc_data[voc_data < 10e-15] <- 0

long_voc_data <- voc_data %>% 
  gather(., key = "voc", value = "conc", -c(famid, sampid, ssex)) %>% 
  mutate(voc = factor(voc, levels = unique(voc)))
```

``` r
long_voc_data %>% 
  ggplot(aes(x = voc, y = conc)) + 
  geom_boxplot() +
  theme_bw() + 
  lims(y = c(1e-13, 1e-05)) +
  theme(axis.text.x = element_text(angle = 90)) +
  scale_y_log10()
```

#### Transformation and scaling

Based on PTR machines detection threshold, any values smaller than
`1e-12` are equivalent to zero. Then we will standardize the data.

``` r
log_vocs <- voc_data %>% 
  mutate_at(vars(starts_with("m")), list(~ log10(. + 1e-12)))

st_log_vocs <- log_vocs %>% 
  mutate_at(vars(starts_with("m")), scale)

long_vocs <- st_log_vocs %>% 
  gather(., key = "voc", value = "conc", -c(famid, sampid, ssex)) %>% 
  mutate(voc = factor(voc, levels = unique(voc)))
```

    ## Warning: attributes are not identical across measure variables;
    ## they will be dropped

This is how the transformed data looks like now, with a visual
differentiation between males and females. Recall that the data for VOCs
here has been log transfomed and scaled.

``` r
ggarrange(long_vocs %>% 
  ggplot(aes(x = voc, y = conc)) +
  geom_boxplot(notch = TRUE, alpha = 0.2) +
  labs(x = "VOC ID",
       y = "Log transformed and scaled concentration") +
  theme(axis.text.x = element_text(angle = 90)),
  long_vocs %>% 
  ggplot(aes(x = voc, y = conc, fill = ssex)) +
  geom_boxplot(notch = TRUE, alpha = 0.2) +
  labs(x = "VOC ID",
       y = "Log transformed and scaled concentration") +
  theme(axis.text.x = element_text(angle = 90)), nrow = 2)
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-24-1.png)<!-- -->

#### Correlations

The point of running these correlations is to get an idea of which
compounds might show up together or the opposite. We are trying to
reduce our dataset and avoid inputing 75 dependent variables into a
model with two explanatory variables. From the correlation matrix we can
see that some compounds tend to be found in clusters. We can use this
information to group the compounds and get a reduced dataset.

``` r
cor_data <- as.matrix(st_log_vocs[,4:78])

cor_res <- rcorr(x = cor_data, type = "pearson")

corrplot(cor_res$r, p.mat = cor_res$P, sig.level = 0.001, insig = "pch", tl.col = "black", tl.srt = 60, tl.cex = .4, order = "hclust", pch.cex = 0.8, pch.col = "#43484f", addrect = 17)
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

#### Clustering

Haven’t found a good reasoning to come up with a specific number of
clusters. However, by making these clusters using the correlation
matrix, we can see how variables (in this case compounds) are grouped
together.

``` r
d <- as.dist(1-cor_res$r)
hr <- hclust(d)
#names(hr)
plot(hr, hang = -1)
rect.hclust(hr, h = max(hr$height)/2)
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

Using the clustering to create a new data frame **Making clusters using
the original raw data and then transforming and scaling, after the
clusters are
formed**

``` r
# This uses the original, raw untransformed data to get the means by cluster
voc_clusters <- data.frame(clust = cutree(hr, h = max(hr$height)/2)) %>% 
  rownames_to_column(var = "voc") 


long_voc_data %>% 
  left_join(voc_clusters) %>% 
  group_by(sampid, clust, famid, ssex) %>% 
  summarise(voc_value = mean(conc)) %>% 
  mutate(voc_clust = str_pad(clust, width = 2, side = "left", pad = 0),
         voc_clust = paste0("clust_", voc_clust)) %>% 
  ungroup() %>% 
  select(-clust) -> clustered_long_vocs
```

    ## Warning: Column `voc` joining factor and character vector, coercing into
    ## character vector

``` r
clustered_long_vocs %>% 
  spread(key = voc_clust, value = voc_value) -> clustered_voc_data


clustered_log_vocs <- clustered_voc_data %>% 
  mutate_at(vars(starts_with("c")), list(~ log10(. + 1e-12)))

clustered_st_log_vocs <- clustered_log_vocs %>% 
  mutate_at(vars(starts_with("c")), scale)

clustered_long_vocs <- clustered_st_log_vocs %>% 
  gather(., key = "voc", value = "conc", -c(famid, sampid, ssex)) %>% 
  mutate(voc = factor(voc, levels = unique(voc)))
```

    ## Warning: attributes are not identical across measure variables;
    ## they will be dropped

``` r
clustered_long_vocs %>% 
  ggplot(aes(x = voc, y = conc, fill = ssex)) +
  geom_boxplot(notch = TRUE, alpha = 0.2) +
  labs(x = "VOC ID",
       y = "Log transformed and scaled concentration") +
  theme(axis.text.x = element_text(angle = 90))
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-28-1.png)<!-- -->
**Making the clusters with the data that was already transformed and
scaled** I think it makes more sense to use this one, since this is the
data we actually used to create the clusters. Our correlations and
everything else is based on this transformed data, so this is probably
what we should use to create the new dataset of clustered
VOCs.

``` r
# This one gets the clustered data by getting the mean using the transformed and scaled data.
voc_clusters <- data.frame(clust = cutree(hr, h = max(hr$height)/2)) %>% 
  rownames_to_column(var = "voc") 


long_vocs %>% 
  left_join(voc_clusters) %>% 
  group_by(sampid, clust, famid, ssex) %>% 
  summarise(voc_value = mean(conc)) %>% 
  mutate(voc_clust = str_pad(clust, width = 2, side = "left", pad = 0),
         voc_clust = paste0("clust_", voc_clust)) %>% 
  ungroup() %>% 
  select(-clust) -> clustered_long_vocs2
```

    ## Warning: Column `voc` joining factor and character vector, coercing into
    ## character vector

``` r
clustered_long_vocs2 %>% 
  spread(key = voc_clust, value = voc_value) -> clustered_voc_data2

clustered_long_vocs2 %>% 
  ggplot(aes(x = voc_clust, y = voc_value, fill = ssex)) +
  geom_boxplot(notch = TRUE, alpha = 0.2) +
  labs(x = "VOC ID",
       y = "Log transformed and scaled concentration") +
  theme(axis.text.x = element_text(angle = 90))
```

![](EDA_clean_master_files/figure-gfm/unnamed-chunk-29-1.png)<!-- -->

These are the clusters and the compounds in each cluster

| Cluster | Compound |
| ------: | :------- |
|       1 | m30.99   |
|       1 | m31.01   |
|       1 | m41.03   |
|       1 | m42.03   |
|       1 | m43.01   |
|       1 | m44.06   |
|       1 | m45.03   |
|       1 | m46.03   |
|       1 | m46.06   |
|       1 | m47.01   |
|       1 | m47.98   |
|       2 | m31.99   |
|       2 | m32.99   |
|       3 | m33.03   |
|       3 | m34.02   |
|       4 | m37.02   |
|       4 | m39.03   |
|       5 | m49.02   |
|       5 | m49.05   |
|       5 | m105\_F  |
|       5 | m141.0   |
|       6 | m49.99   |
|       6 | m86.03   |
|       7 | m55.03   |
|       7 | m57.02   |
|       7 | m59.04   |
|       7 | m69.06   |
|       7 | m87.04   |
|       8 | m57.05   |
|       8 | m62.02   |
|       8 | m63.02   |
|       8 | m71.03   |
|       8 | m79.05   |
|       8 | m83.05   |
|       8 | m85.06   |
|       8 | m89.05   |
|       8 | m89.09   |
|       8 | m97.00   |
|       9 | m61.02   |
|       9 | m99.08   |
|       9 | m101.0   |
|       9 | m106.0   |
|       9 | m108.0   |
|       9 | m109.0   |
|       9 | m113.0   |
|       9 | m115.0   |
|       9 | m121.1   |
|       9 | m124.0   |
|       9 | m139.1   |
|       9 | m143.0   |
|      10 | m69.00   |
|      11 | m73.03   |
|      11 | m75.04   |
|      11 | m77.05   |
|      11 | m91.00   |
|      11 | m93.06   |
|      11 | m95.00   |
|      11 | m149.0   |
|      12 | m81.06   |
|      12 | m135.1   |
|      12 | m163.0   |
|      13 | m98.00   |
|      13 | m100.0   |
|      13 | m119.0   |
|      13 | m125.0   |
|      14 | m103.1   |
|      14 | m107.0   |
|      15 | m111.0   |
|      15 | m127.0   |
|      15 | m129.0   |
|      15 | m130.0   |
|      16 | m137.1   |
|      16 | m150.0   |
|      16 | m151.0   |
|      17 | m204.0   |

### Master dataframe

This will create the master data frame that includes the lifehistory
traits and the VOC clustered data. All of these are already log
transformed and scaled.

``` r
clean_master <- full_join(scaled_traits, clustered_voc_data2) %>% 
  mutate_at(c(5:32), as.numeric)

saveRDS(clean_master, "cleandata/clean_master.RDS")
```