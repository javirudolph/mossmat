# Exploratory Analysis of VOCs
# Trying to cluster/group some of the compounds to reduce dimensionality


# load the necessary libraries
library(tidyverse)
library(vegan)
library(plotly)
library(corrplot)

# The clean RDS data file should be available locally after you run the master_cleanup.R file.This will take the master csv data file and output the RDS we use here.
# source("R/master_cleanup.R")
voc_clean <- readRDS("cleandata/voc_10.RDS")


# ANALYSIS ----------------------------------------------------------------

# Data is not in a great format. Very small numbers and many zeroes
# If we do a log transformation, we need to add a value since we have zeroes
# Also, the log transformation will give negative values, which some ordination tests don't use. Potentially use the absolute value after the transformation since we don't have a mix of positive and negative values, so I think it could be done.
# However, taking the absolute values will turn over the data. For 
# With the clean data, it's ready for ordination or clustering analysis
voc_clean[,4:78] %>% 
  mutate_all(., list( ~ ifelse(. == 0, 1, .))) %>% 
  min()

voc_ordination <- abs(log10(voc_clean[4:78] + 1e-26)) + 26


nmd_output <- metaMDS(voc_clean[,4:78])
stressplot(NMDS2)
plot(NMDS2, type = "t")


scores <- as.data.frame(scores(nmds_output)) %>% 
  mutate(samplenum = rownames(.),
         family = factor(voc_clean$famid),
         sex = factor(voc_clean$ssex))


vol.scores <- nmds_output$species %>% 
  as.data.frame() %>% 
  mutate(vol.ident = rownames(.))

p=ggplot() +
  theme_bw() +
  #geom_text(data = vol.scores, aes(x = MDS1, y = MDS2, label = vol.ident)) +
  geom_point(data = scores, aes(x = NMDS1, y = NMDS2, color = sex)) +
  scale_color_viridis_d() +
  coord_equal()

ggplotly(p)

scores %>% 
  group_by(sex) %>%
  nest() %>% 
  mutate(
    hull = map(data, ~ with(., chull(NMDS1, NMDS2))),
    out = map2(data, hull, ~ .x[.y,,drop=FALSE])
  ) %>% 
  select(-data) %>% 
  unnest() -> hullData


ggplot() +
  theme_bw() +
  #geom_text(data = spp_scores, aes(x = MDS1, y = MDS2, label = species)) +
  geom_point(data = scores, aes(x = NMDS1, y = NMDS2, color = sex)) +
  #geom_text(data = scores, aes(x = NMDS1, y = NMDS2, label = site)) + 
  geom_polygon(data = hullData, aes(x = NMDS1, y = NMDS2, fill = sex, group = sex), alpha = 0.2) +
  coord_equal() +
  scale_fill_viridis_d() +
  scale_color_viridis_d()



# Correlation
x <- voc_clean %>% 
  filter(ssex == "m")
voc_corr <- cor(x[4:78])
corrplot(voc_corr, method = "circle", type = "upper", tl.col = "black", tl.srt = 45, tl.cex = .3)
corrplot(voc_corr, method = "circle", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45, tl.cex = .3)


# 
# PCA attempt
voc_clean %>% 
  filter(ssex == "f") %>% 
  select(-famid, -ssex, -sampid) -> sub_voc

sub_voc %>% 
  min()

sub_voc %>% 
  mutate_all(., list( ~ ifelse(. == 0, 1, .))) %>% 
  min()

pca_voc <- abs(log10(voc_clean[,4:78] + 1e-30))
PCA <- vegan::rda(pca_voc, scale = FALSE)
PCA
#plot(PCA)

biplot(PCA)

dat_cca <- cca(pca_voc)
dat_cca
plot(dat_cca, display = "species", scaling = 1)

dat_dca <- decorana(pca_voc)
dat_dca
plot(dat_dca, display = "species")

dat_nmds <- metaMDS(pca_voc)
plot(dat_nmds)
stressplot(dat_nmds)
