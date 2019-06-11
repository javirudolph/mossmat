
traits %>% 
  select(famid, sampid, ssex, area_wk3) %>% 
  drop_na(area_wk3) -> anova_data

trait_anova <- aov(area_wk3 ~ ssex + famid + ssex:famid, data = anova_data)

anova_data$residuals <- trait_anova$residuals

# Family means

anova_data %>% 
  group_by(famid) %>% 
  summarise(means = mean(residuals))

# By sex
anova_data %>% 
  filter(ssex == "f") %>% 
  group_by(famid) %>% 
  summarise(means = mean(residuals)) -> f_dat

anova_data %>% 
  filter(ssex == "m") %>% 
  group_by(famid) %>% 
  summarise(means = mean(residuals)) -> m_dat

# Filter females by male families
f_dat %>% 
  filter(famid %in% m_dat$famid) -> new_f_dat

cor(x = new_f_dat$means, y = m_dat$means)


