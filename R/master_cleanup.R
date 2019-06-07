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
#saveRDS(voc_clean, "cleandata/voc_clean10.RDS")



# TRAIT DATA --------------------------------------------------------------


# There are too many things to consider:

library(tidyverse)

# Read the raw data file
rawdata <- read.csv("rawdata/LK_master.csv", stringsAsFactors = FALSE)

# Some  changes done to the raw file
# - Keep only the trait data
# - Change variable names to simpler names
# - Remove empty rows at the end
# - Fix names for Sample IDs, some have parentheses
# - Change sex to lower case only
# - Excel formula errors are just NAs

trait_raw <- rawdata[,1:19] %>% 
  rename(famid = `Fam..`,
         sampid = Sample.Name,
         ssex = Sample_Sex) %>% 
  drop_na(famid) %>% 
  mutate(sampid = str_replace_all(sampid, "\\(.*\\)", ""),
         ssex = str_to_lower(as.character(ssex))) %>% 
  mutate_at(vars(starts_with("Leaf")), as.numeric) %>% 
  group_by(famid) %>% 
  arrange(sampid, .by_group = TRUE) %>% 
  ungroup

# Fix a data entry error:
# Check Github issue #5
trait_raw$Avg_21_days[which(trait_raw$Avg_21_days == 33)] <- 0.33

# Fix sex data entry error
# Check Github issue #5
trait_raw[which(trait_raw$sampid == "P_18_1_6_B"),]$ssex <- "m"
trait_raw <- trait_raw[-which(trait_raw$sampid == "P_6_6_20"),]

# How many families here?
length(unique(trait_raw$famid))

# How many individuals?
length(unique(trait_raw$sampid))

# These are the identifiers 
trait_identifiers <- trait_raw %>% 
  select(famid, sampid, ssex) %>% 
  distinct()


# Leaf data averaging -----------------------------------------------------

trait_raw[,c(2, 17:19),] %>% 
  group_by(sampid) %>% 
  summarise_at(vars(starts_with("Leaf")), mean) -> leaf_data


# Growth and Development traits -------------------------------------------

trait_raw[,c(2, 10:16)] %>% 
  drop_na() %>% 
  distinct() %>% 
  mutate_if(is.numeric, scale)-> gro_dev_data

# Reproduction variable ---------------------------------------------------

trait_raw %>% 
  filter(ssex == "m") %>% 
  select(sampid, ssex, Avg_Male_Buds.Stem) %>% 
  drop_na() %>% 
  group_by(sampid) %>% 
  summarise(av = mean(Avg_Male_Buds.Stem)) %>% 
  mutate(reprovar = scale(av)) %>% 
  select(sampid, reprovar) -> male_reprovar

trait_raw %>% 
  select(sampid, ssex, Avg_Arch) %>% 
  filter(ssex == "f") %>% 
  drop_na() %>% 
  group_by(sampid) %>% 
  summarise(av = mean(Avg_Arch)) %>% 
  mutate(reprovar = scale(av)) %>% 
  select(sampid, reprovar) -> fem_reprovar


reprovar <- bind_rows(male_reprovar, fem_reprovar)


# Join trait data ---------------------------------------------------------

trait_identifiers %>% 
  full_join(., reprovar) %>% 
  full_join(., gro_dev_data) %>%
  full_join(., leaf_data) %>% 
  set_names(c("famid", "sampid", "ssex", "repro", "area_wk3",
              "perim_wk3", "circ_wk3", "perim_rate", "area_rate",
              "days21", "days_gam", "lf_length", "lf_area", "lf_perim")) -> joined_traits

saveRDS(joined_traits, "cleandata/traits_clean.RDS")