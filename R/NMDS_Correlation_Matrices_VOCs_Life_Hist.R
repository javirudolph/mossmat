# Leslie's NMDS data
library(tidyverse)
library(vegan)
library(plotly)
library(corrplot)
# Read in data ------------------------------------------------------------
path <- "/Users/lesliekollar/Desktop"
setwd(path)
getwd()

rawdata <- read_csv("Ten_Family_combined_females_no_30.csv")

str(rawdata)
names(rawdata)


# Modify/ Fix -------------------------------------------------------------
str(voldata)
voldata$m79.05478 <- as.numeric(voldata$m79.05478)
rawdata$m111.00000_FLUX <- as.numeric(rawdata$m111.00000_FLUX)

voldata <- rawdata[,2:29] 

                   #2:50]
               #    %>% 
  select(., - m111.00000_FLUX)
voldata$m111.00000_FLUX[105] <- 0
voldata$m111.00000_FLUX <- as.numeric(voldata$m111.00000_FLUX)
which(is.na(voldata))





# Fit NMDS ----------------------------------------------------------------

testNMDS <- metaMDS(voldata)


manhattanNMDS <- metaMDS(voldata, distance = "manhattan")



# Create ggplot frames ----------------------------------------------------

nmds_output <- testNMDS
plot(nmds_output)
plot(nmds_output, type = "t")


scores <- as.data.frame(scores(nmds_output)) %>% 
  mutate(samplenum = rownames(.),
         family = factor(rawdata$Fam..))


vol.scores <- nmds_output$species %>% 
  as.data.frame() %>% 
  mutate(vol.ident = rownames(.))


# Create base ggplot

p=ggplot() +
  theme_bw() +
  #geom_text(data = vol.scores, aes(x = MDS1, y = MDS2, label = vol.ident)) +
  geom_point(data = scores, aes(x = NMDS1, y = NMDS2, color = family)) +
  scale_color_viridis_d() +
  coord_equal()

ggplotly(p)
# Family convex hull ------------------------------------------------------

scores %>% 
  group_by(family) %>%
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
  geom_point(data = scores, aes(x = NMDS1, y = NMDS2, color = family)) +
  #geom_text(data = scores, aes(x = NMDS1, y = NMDS2, label = site)) + 
  geom_polygon(data = hullData, aes(x = NMDS1, y = NMDS2, fill = family, group = family), alpha = 0.3) +
  coord_equal() +
  scale_fill_viridis_d() +
  scale_color_viridis_d()

##### Correlation matrix of males and females ######
data_female <- read.csv("Ten_Family_combined_females_no_30.csv")

correlation_female <- cor(rawdata[,30:105])

write.csv(correlation_female, "Correlation_females.csv")

corrplot(correlation_female, method = "circle", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45, tl.cex = .3)

data_female2 <- aggregate(rawdata, by=list(rawdata$Fam.., rawdata$Fam..), FUN = mean )

write.csv(rawdata, "Agg_families_females.csv")

data_males <- read.csv("Ten_Family_combined_males_no_30.csv")

correlation_male <- cor(data[,30:105])

write.csv(correlation, "Correlation_males.csv")

corrplot(correlation_male, method = "circle", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45, tl.cex = .3)

data2 <- aggregate(data, by=list(rawdata$Fam.., rawdata$Fam..), FUN = mean )
write.csv(data, "Agg_families_males.csv")

###### Combined correlation matrix #####
library(psych)
Data <- read.csv("Agg_families_ALL.csv", header=TRUE)

cor_all <- cor(Data[,2:209])

png("Plot.png", width = 20, height = 20, units = 'in', res = 300)
plot <- corrplot(cor_all,method = "circle", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45, tl.cex = .3)
dev.off()

###### Matrix with male VOCs only using family means#####

male_VOC <- read.csv("Agg_families_males_VOC_ONLY.csv")

cor_male <- cor(male_VOC[,2:77])
png("Male_VOCs.png", width =8, height = 11, units = 'in', res = 300)
plot <- corrplot(cor_male,method = "circle", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45, tl.cex = .3)
dev.off()

###### Matrix with female VOCs only using family means#####

female_VOC <- read.csv("Agg_families_females_VOC_ONLY.csv")

cor_female <- cor(female_VOC[,2:77])
png("Female_VOCs.png", width =8, height = 11, units = 'in', res = 300)
plot <- corrplot(cor_female,method = "circle", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45, tl.cex = .3)
dev.off()


###### using family medians rather than means #######

data_males2 <- aggregate(data_males, by=list(rawdata$Fam.., rawdata$Fam..), FUN = median)
write.csv(data_males2, "Agg_families_males_median.csv")
male_VOC_median <- read.csv("Agg_families_males_median_VOC_ONLY.csv", header = TRUE)


data_female2 <- aggregate(data_female, by=list(rawdata$Fam.., rawdata$Fam..), FUN = median )
write.csv(data_female2, "Agg_families_females_median.csv")
female_VOC_median <- read.csv("Agg_families_females_median_VOC_ONLY.csv", header = TRUE)

##### MATRIX WITH FEMALE OVCS ONLY USING MEDIANS FOR FAMILIES ####
female_VOC_median <- read.csv("Agg_families_females_median_VOC_ONLY.csv", header = TRUE)

cor_female <- cor(female_VOC_median[,2:77])
png("Female_VOCs_median.png", width =8, height = 11, units = 'in', res = 300)
plot <- corrplot(cor_female,method = "circle", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45, tl.cex = .3)
dev.off()

##### MATRIX WITH FEMALE OVCS ONLY USING MEDIANS FOR FAMILIES ####
male_VOC_median <- read.csv("Agg_families_males_median_VOC_ONLY.csv", header = TRUE)

cor_male <- cor(male_VOC_median[,2:77])
png("Male_VOCs_median.png", width =8, height = 11, units = 'in', res = 300)
plot <- corrplot(cor_male, method = "ellipse", type = "upper", order = "AOE", tl.col = "black", tl.srt = 45, tl.cex = .3)
dev.off()

########## Combined Male and female medians #########
data <- read.csv("")

ALL <- aggregate(data, by=list(rawdata$Fam.., rawdata$Fam..), FUN = median )
write.csv(data, "Agg_families_males.csv")




##### matrix of male vs female vocs ########

male_VOC_median <-  as.matrix(male_VOC_median)
female_VOC_median <-   as.matrix(female_VOC_median)

All_VOC_median <- cor(male_VOC_median[,2:77], female_VOC_median[,2:77])
png("ALL_VOCs_median.png", width =8, height = 11, units = 'in', res = 300)
all <- corrplot(All_VOC_median, method = "circle", type="upper", order="hclust",
         tl.col = "black", tl.srt = 45, tl.cex = .3)
dev.off()

###################### Life history traits ##############################


###  male #####

male_hist <- read.csv("all_data_zero_10_Correlations_Life_Hist_only_male.csv", header=TRUE)
str(male_hist)
male_hist$Fam.. <- as.numeric(male_hist$Fam..)
male_hist <- aggregate(male_hist, by=list(male_hist$Fam.., male_hist$Fam..), FUN = median)
write.csv(male_hist, "male_life_history_median.csv")

male_hist <- read.csv( "male_life_history_median.csv", header=TRUE)


#### Male life history trait plot using median #####


male_median_hist <- cor(male_hist[,2:11])
png("Male_median_hist.png", width =8, height = 11, units = 'in', res = 300)
all <- corrplot(male_median_hist, method = "circle", type="upper", order="hclust",
                tl.col = "black", tl.srt = 45, tl.cex = 1)
dev.off()




############################### Female  ##############################

female_hist <- read.csv("all_data_zero_10_Correlations_Life_Hist_only_female.csv", header=TRUE)
str(female_hist)
female_hist$Fam.. <- as.numeric(female_hist$Fam..)
female_hist <- aggregate(female_hist, by=list(female_hist$Fam.., female_hist$Fam..), FUN = median)
write.csv(female_hist, "female_life_history_median.csv")

female_hist <- read.csv( "female_life_history_median.csv", header=TRUE)

### Female life history trait plot using median####

Female_median_hist <- cor(female_hist[,2:11])
png("Female_median_hist.png", width =8, height = 11, units = 'in', res = 300)
all <- corrplot(Female_median_hist, method = "circle", type="upper", order="hclust",
                tl.col = "black", tl.srt = 45, tl.cex = 1)
dev.off()



### Need to parse down data set. Trying to figure out which VOCs are related using NMDS

# Reading in the data
NMDS_VOC_ONLY <- read.csv("all_data_zero_10_NMDS_VOC_ONLY.csv", header = TRUE)


# Using Tidyr to make data long rather than wide #
library(tidyverse)



str(NMDS_VOC_ONLY )

# MMDS only data
voldata <- NMDS_VOC_ONLY [,4:79] 

#Running NMDS
testNMDS <- metaMDS(voldata)


#manhattanNMDS <- metaMDS(voldata, distance = "manhattan")


# Create ggplot frames ----------------------------------------------------

nmds_output <- testNMDS
plot(nmds_output)
plot(nmds_output, type = "t")


scores <- as.data.frame(scores(nmds_output)) %>% 
  mutate(samplenum = rownames(.),
         family = factor(NMDS_VOC_ONLY$Fam..))


vol.scores <- nmds_output$species %>% 
  as.data.frame() %>% 
  mutate(vol.ident = rownames(.))


# Create base ggplot

p=ggplot() +
  theme_bw() +
  #geom_text(data = vol.scores, aes(x = MDS1, y = MDS2, label = vol.ident)) +
  geom_point(data = scores, aes(x = NMDS1, y = NMDS2, color = family)) +
  scale_color_viridis_d() +
  coord_equal()

ggplotly(p)
# Family convex hull ------------------------------------------------------

scores %>% 
  group_by(family) %>%
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
  geom_point(data = scores, aes(x = NMDS1, y = NMDS2, color = family)) +
  #geom_text(data = scores, aes(x = NMDS1, y = NMDS2, label = site)) + 
  geom_polygon(data = hullData, aes(x = NMDS1, y = NMDS2, fill = family, group = family), alpha = 0.3) +
  coord_equal() +
  scale_fill_viridis_d() +
  scale_color_viridis_d()





