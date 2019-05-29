
#' load the necessary libraries
library(tidyverse)


#' Read the csv file
rawdata <- read.csv("rawdata/LK_master.csv")

#' Just keep volatile data
#' Also, remove the NAs, there's a lot at the end
#' Remove (2) notation from sample ids
#' Remove May 30 samples
voc_data <- rawdata[,c(1,2,4,5, 20:109)] %>% 
  filter(Date.PTR != "30-May") %>% 
  select(-Date.PTR) %>% 
  rename(famid = `Fam..`,
         sampid = Sample.Name,
         ssex = Sample_Sex) %>% 
  drop_na() %>% 
  mutate(sampid = str_replace_all(sampid, "\\(.*\\)", ""))

#' Shorten voc names
oldnames <- names(voc_data)
names(voc_data)[4:93] <- stringr::str_trunc(oldnames[4:93], width = 6, side = "right", ellipsis = "") 

str(voc_data)
#' m111.0 is a factor
voc_data$m111.0
#' The notation is different, using a capital E
voc_data$m111.0 <- as.numeric(str_replace(voc_data$m111.0, "E", "e"))




#' Any negative values are zero
#' Keep the maximum value for each sample
makezero <- function(x) ifelse(x < 0, 0, x)

voc_data %>% 
  mutate_if(is.numeric, makezero) %>% 
  arrange(sampid, .by_group = TRUE)-> voc_noneg
  
#' Questions here regarding the next steps
#' should we first select the max values for specific voc?
#' or should we actually create these 10, 20% cutoffs first?
#' IMO we should select the max for each sample, so each sample has only one value and then we can select 10 or 20% representation. If not, some samples would get extra?
#' 

voc_noneg %>% 
  select(-famid, -sampid, -ssex) %>% 
  mutate_if(is.numeric, function(x) ifelse(x > 0, 1, 0)) %>% 
  colSums() %>% 
  data.frame() %>% 
  rownames_to_column() %>%
  setNames(., c("voc", "count")) %>% 
  mutate(prcnt = count/548) -> voc_obs
  
  




