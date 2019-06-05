# Decided to create a new script for trait data
# There are too many things to consider:

library(tidyverse)
# Load the raw data

# TRAIT DATA --------------------------------------------------------------

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


# How many families here?
length(unique(trait_raw$famid))

# How many individuals?
length(unique(trait_raw$sampid))

# These are the identifiers 
trait_identifiers <- trait_raw %>% 
  select(famid, sampid, ssex) %>% 
  distinct()

# These numbers should be the same but aren't
# There must be a duplicated value somewhere
which(trait_identifiers$sampid %>% duplicated() == TRUE)

trait_identifiers[c(109, 110, 308, 309),]

# Ok, big issue here since there is a missmatch in the ssex...
# We can check with the raw data
trait_raw %>% 
  filter(sampid %in%  c("P_18_1_6_B", "P_6_6_20")) %>% 
  View()
# Not sure what to do here and which ones to keep


# Tasks
# - Remove duplicates and scale data

trait_raw[,c(2, 10:16)] %>% 
  distinct() -> gro_dev_data

which(gro_dev_data$sampid %>% duplicated() == TRUE)

mutate_if(is.numeric, scale) %>% 
  set_names(c("sampid", "area_wk3", "perim_wk3", "circ_wk3", "perim_rate", "area_rate", "days21", "days_gam")) -> gro_dev_data

gro_dev_data %>% 
  gather(., key = "trait", value = "value", -sampid)



