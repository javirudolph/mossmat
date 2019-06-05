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

# Fix a data entry error:
trait_raw$Avg_21_days[which(trait_raw$Avg_21_days == 33)] <- 0.33

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




# Growth and Development traits -------------------------------------------


trait_raw[,c(2, 10:16)] %>% 
  drop_na() %>% 
  distinct() -> gro_dev_data




# Can't scale anything yet until we fix the Leaf data, and the incongruence in the other samples.







# Reproduction variable ---------------------------------------------------

trait_raw %>% 
  select(sampid, ssex, Avg_Male_Buds.Stem) %>% 
  filter(ssex == "m") %>% 
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


trait_identifiers %>% 
  left_join(rbind(male_reprovar, fem_reprovar)) %>% 
  left_join(gro_dev_data) -> joined_traits


joined_traits[c(which(duplicated(joined_traits$sampid) == TRUE)),] %>% 
  View()



