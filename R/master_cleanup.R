# Created new script just to clean the data and save the RDS objects for future use.

library(tidyverse)

# VOLATILE DATA -----------------------------------------------------------

# Read the raw data file
#   This comes from the last excel sheet.
rawdata <- read.csv("rawdata/LK_master.csv")

# Just keep volatile data and identifiers
# Also, remove the NAs, there's a lot at the end
# Remove '(2)' notation from sample ids
# Remove May 30 samples
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


# The negative values come from substracting the background noise
# So, any negative value is actually 0, no reading for that compound

voc_raw %>% 
  mutate_if(is.numeric, list(~ ifelse(. < 0, 0, .))) %>% 
  arrange(sampid, .by_group = TRUE)-> voc_data

# Create a dataset with only the compounds for which at least 10% of the observations show it.
voc_data %>% 
  select(-famid, -sampid, -ssex) %>% 
  mutate_if(is.numeric, function(x) ifelse(x > 0, 1, 0)) %>% 
  colSums() %>% 
  data.frame() %>% 
  rownames_to_column() %>%
  setNames(., c("voc", "count")) %>% 
  mutate(prcnt = count/nrow(voc_data)) %>% 
  filter(prcnt >= 0.1) -> voc_filter

voc_data %>% 
  select(famid, sampid, ssex, c(voc_filter$voc)) %>% 
  group_by(sampid) %>%
  mutate_at(vars(starts_with("m")), max) %>% 
  ungroup () %>% 
  distinct() %>% 
  mutate(ssex = str_to_lower(as.character(ssex))) -> voc_clean

# Clean data with the 10% threshold, only one measurement of vocs per individual (no duplicates)
saveRDS(voc_clean, "cleandata/voc_clean10.RDS")
