
# libs
library(corrplot)
library(tidyverse)

# Traits

traits <- readRDS("cleandata/traits_clean.RDS")

res.man <- manova(cbind(repro, area_wk3, perim_wk3, circ_wk3, perim_rate, area_rate, days21, days_gam, leaf_length, leaf_area, leaf_perim) ~ famid + ssex + famid:ssex, data = traits)

summary(res.man)

summary.aov(res.man)


res_dat <- cbind(res.man$model[,-1], res.man$residuals)

fam.means <- res_dat %>%
  group_by(famid) %>% 
  mutate_at(vars(3:13), mean) %>% 
  ungroup() %>% 
  select(-ssex) %>% 
  distinct()

fem.means <- res_dat %>% 
  filter(ssex == "f") %>% 
  group_by(famid) %>% 
  mutate_at(vars(3:13), mean) %>% 
  ungroup() %>% 
  select(-ssex) %>% 
  distinct()


male.means <- res_dat %>% 
  filter(ssex == "m") %>% 
  group_by(famid) %>% 
  mutate_at(vars(3:13), mean) %>% 
  ungroup() %>% 
  select(-ssex) %>% 
  distinct()





# Correlations for all 
all.corr <- fam.means %>% 
  select(-c(famid)) %>% 
  cor()
corrplot(all.corr, method = "circle", type = "upper", tl.col = "black", tl.cex = 0.8, tl.srt = 45)

# Correlations for females
fem.corr <- fem.means %>% 
  select(-c(famid)) %>% 
  cor()
corrplot(fem.corr, method = "circle", type = "upper", tl.col = "black", tl.cex = 0.8, tl.srt = 45)


# Correlations for males
male.corr <- male.means %>% 
  select(-c(famid)) %>% 
  cor()
corrplot(male.corr, method = "circle", type = "upper", tl.col = "black", tl.cex = 0.8, tl.srt = 45)


# Correlations between males and females

fem.means %>% 
  filter(famid %in% male.means$famid) -> new.fem.means

ssex.corr <- cor(x = male.means[,-1], y = new.fem.means[,-1])
corrplot(ssex.corr, method = "circle", tl.col = "black", tl.cex = 0.8, tl.srt = 45)
