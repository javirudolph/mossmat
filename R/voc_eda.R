
#' load the necessary libraries
library(tidyverse)


#' Read the csv file
rawdata <- read.csv("rawdata/LK_master.csv")

#' Just keep volatile data
#' Also, remove the NAs, there's a lot at the end
#' Remove (2) notation from sample ids
#' Remove May 30 samples
voc_raw <- rawdata[,c(1,2,4,5, 20:109)] %>% 
  filter(Date.PTR != "30-May") %>% 
  select(-Date.PTR) %>% 
  rename(famid = `Fam..`,
         sampid = Sample.Name,
         ssex = Sample_Sex) %>% 
  drop_na() %>% 
  mutate(sampid = str_replace_all(sampid, "\\(.*\\)", ""))

#' Shorten voc names
oldnames <- names(voc_raw)
names(voc_raw)[4:93] <- stringr::str_trunc(oldnames[4:93], width = 6, side = "right", ellipsis = "") 

str(voc_raw)
#' m111.0 is a factor
voc_raw$m111.0
#' The notation is different, using a capital E
voc_raw$m111.0 <- as.numeric(str_replace(voc_raw$m111.0, "E", "e"))




#' Any negative values are zero
#' Keep the maximum value for each sample
makezero <- function(x) ifelse(x < 0, 0, x)

voc_raw %>% 
  mutate_if(is.numeric, makezero) %>% 
  arrange(sampid, .by_group = TRUE)-> voc_data
  
#' Questions here regarding the next steps
#' should we first select the max values for specific voc?
#' or should we actually create these 10, 20% cutoffs first?
#' IMO we should select the max for each sample, so each sample has only one value and then we can select 10 or 20% representation. If not, some samples would get extra?
#' 


# This function works to remove the volatiles that are not found in a given percentage threshold for observations
voc_filter <- function(voc_data, threshold = NULL){
  voc_data %>% 
    select(-famid, -sampid, -ssex) %>% 
    mutate_if(is.numeric, function(x) ifelse(x > 0, 1, 0)) %>% 
    colSums() %>% 
    data.frame() %>% 
    rownames_to_column() %>%
    setNames(., c("voc", "count")) %>% 
    mutate(prcnt = count/nrow(voc_data)) %>% 
    filter(prcnt >= threshold) -> voc_filter
  
  voc_data %>% 
    select(famid, sampid, ssex, c(voc_filter$voc))
  
}

test <- voc_filter(voc_data, 0.9)

# The function works, now we need to keep only one sample, remove duplicates by taking only the max. 

voc_filter(voc_data, 0.4) %>% 
  group_by(sampid) %>%
  mutate_if(is.numeric, max) %>% 
  distinct() -> fortyprcnt_data

library(vegan)

dist <- vegdist(fortyprcnt_data[,4:52], method = "bray")
NMDS1 <- metaMDS(dist, k=2, trymax = 100, trace = F)
NMDS1
stressplot(NMDS1)
plot(NMDS1, type = "t")


NMDS2 <- metaMDS(fortyprcnt_data[,4:52], trymax = 100)
stressplot(NMDS2)
plot(NMDS2, type = "t")
