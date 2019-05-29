
library(tidyverse)


# Read the csv file
rawdata <- read.csv("rawdata/LK_master.csv")

# Just keep volatile data
voc_data <- rawdata[,c(1,2,4,5, 20:109)] %>% 
  filter(Date.PTR != "30-May") %>% 
  select(-Date.PTR) %>% 
  rename(famid = `Fam..`,
         sampid = Sample.Name,
         ssex = Sample_Sex) %>% 
  drop_na()


# Shorten voc names
oldnames <- names(voc_data)
names(voc_data)[4:93] <- stringr::str_trunc(oldnames[4:93], width = 6, side = "right", ellipsis = "") 

# Any negative values are zero
# Keep the maximum value for each sample
makezero <- function(x) ifelse(x < 0, 0, x)
takemax <- function(x) max(x)

voc_data %>% 
  mutate_if(is.numeric, makezero) -> max_voc
  
  



