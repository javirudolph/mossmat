
#### Reading in the data ######
clustered_voc <- readRDS("/Users/lesliekollar/Desktop/mossmat/cleandata/clustered_voc_data.RDS")
str(clustered_voc)

#### 2 sex model for VOC data####
clust_1_2sex <- aov(clustered_voc$clust_01~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_1_2sex)

clust_2_2sex <- aov(clustered_voc$clust_02~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_2_2sex)

clust_3_2sex <- aov(clustered_voc$clust_03~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_3_2sex)

clust_4_2sex <- aov(clustered_voc$clust_04~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_4_2sex)

clust_5_2sex <- aov(clustered_voc$clust_05~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_5_2sex)

clust_6_2sex <- aov(clustered_voc$clust_06~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_6_2sex)

clust_7_2sex <- aov(clustered_voc$clust_07~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_7_2sex)

clust_8_2sex <- aov(clustered_voc$clust_08~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_8_2sex)

clust_9_2sex <- aov(clustered_voc$clust_09~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_9_2sex)

clust_10_2sex <- aov(clustered_voc$clust_10~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_10_2sex)

clust_11_2sex <- aov(clustered_voc$clust_11~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_11_2sex)

clust_12_2sex <- aov(clustered_voc$clust_12~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_12_2sex)

clust_13_2sex <- aov(clustered_voc$clust_13~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_13_2sex)

clust_14_2sex <- aov(clustered_voc$clust_14~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_14_2sex)

clust_15_2sex <- aov(clustered_voc$clust_15~ clustered_voc$famid + 
                      clustered_voc$ssex + clustered_voc$famid:clustered_voc$ssex)
summary(clust_15_2sex)


##### Single Sex model for VOC #####
VOCs_Female <- clustered_voc[ which(clustered_voc$ssex=='f'), ]
VOCs_Male <- clustered_voc[ which(clustered_voc$ssex=='m'), ]

#Female
Clust01_Female <- aov(VOCs_Female$clust_01~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust01_Female)

Clust02_Female <- aov(VOCs_Female$clust_02~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust01_Female)

Clust03_Female <- aov(VOCs_Female$clust_03~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust01_Female)

Clust04_Female <- aov(VOCs_Female$clust_04~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust01_Female)

Clust05_Female <- aov(VOCs_Female$clust_05~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust05_Female)

Clust06_Female <- aov(VOCs_Female$clust_06~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust06_Female)

Clust07_Female <- aov(VOCs_Female$clust_07~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust07_Female)

Clust08_Female <- aov(VOCs_Female$clust_08~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust08_Female)

Clust09_Female <- aov(VOCs_Female$clust_09~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust09_Female)

Clust10_Female <- aov(VOCs_Female$clust_10~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust10_Female)

Clust11_Female <- aov(VOCs_Female$clust_11~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust11_Female)

Clust12_Female <- aov(VOCs_Female$clust_12~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust12_Female)

Clust13_Female <- aov(VOCs_Female$clust_13~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust13_Female)

Clust14_Female <- aov(VOCs_Female$clust_14~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust14_Female)

Clust15_Female <- aov(VOCs_Female$clust_15~ VOCs_Female$famid + VOCs_Female$famid/VOCs_Female$sampid)
summary(Clust15_Female)

#Male
Clust01_Male <- aov(VOCs_Male$clust_01~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust01_Male)

Clust02_Male <- aov(VOCs_Male$clust_02~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust02_male)

Clust03_Male <- aov(VOCs_Male$clust_03~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust03_male)

Clust04_Male <- aov(VOCs_Male$clust_04~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust01_male)

Clust05_Male <- aov(VOCs_Male$clust_05~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust05_male)

Clust06_Male <- aov(VOCs_Male$clust_06~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust06_male)

Clust07_Male <- aov(VOCs_Male$clust_07~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust07_male)

Clust08_Male <- aov(VOCs_Male$clust_08~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust08_male)

Clust09_Male <- aov(VOCs_Male$clust_09~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust09_male)

Clust10_Female <- aov(VOCs_Male$clust_10~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust10_male)

Clust11_Male <- aov(VOCs_Male$clust_11~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust11_male)

Clust12_Male <- aov(VOCs_Male$clust_12~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust12_emale)

Clust13_Male <- aov(VOCs_Male$clust_13~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust13_male)

Clust14_Male <- aov(VOCs_Male$clust_14~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust14_male)

Clust15_Male <- aov(VOCs_Male$clust_15~ VOCs_Male$famid + VOCs_Male$famid/VOCs_Male$sampid)
summary(Clust15_male)



######################################################## Life History Traits #############################################

life_data <- readRDS("/Users/lesliekollar/Desktop/mossmat/cleandata/traits_clean.RDS")
life_data
str(life_data)


## 2 sex model

Repr0_2sex <- aov(life_data$repro~ life_data$famid + 
                    life_data$ssex + life_data$famid:life_data$ssex)
summary(Repr0_2sex)


area_2sex <- aov(life_data$area_wk3~ life_data$famid + 
                    life_data$ssex + life_data$famid:life_data$ssex)
summary(area_2sex)

perimeter_2sex <- aov(life_data$perim_wk3~ life_data$famid + 
                   life_data$ssex + life_data$famid:life_data$ssex)
summary(perimeter_2sex)

circularity_2sex <- aov(life_data$circ_wk3~ life_data$famid + 
                        life_data$ssex + life_data$famid:life_data$ssex)
summary(circularity_2sex)

perm_rate_2sex <- aov(life_data$perim_rate~ life_data$famid + 
                          life_data$ssex + life_data$famid:life_data$ssex)
summary(perm_rate_2sex)

area_rate_2sex <- aov(life_data$area_rate~ life_data$famid + 
                        life_data$ssex + life_data$famid:life_data$ssex)
summary(area_rate_2sex)


days_21_2sex <- aov(life_data$days21~ life_data$famid + 
                        life_data$ssex + life_data$famid:life_data$ssex)
summary(days_21_2sex)


days_gam_2sex <- aov(life_data$days_gam~ life_data$famid + 
                      life_data$ssex + life_data$famid:life_data$ssex)
summary(days_gam_2sex)

leaf_length_2sex <- aov(life_data$leaf_length~ life_data$famid + 
                       life_data$ssex + life_data$famid:life_data$ssex)
summary(leaf_length_2sex)

leaf_area_2sex <- aov(life_data$leaf_area~ life_data$famid + 
                          life_data$ssex + life_data$famid:life_data$ssex)
summary(leaf_area_2sex)

leaf_perim_2sex <- aov(life_data$leaf_perim~ life_data$famid + 
                          life_data$ssex + life_data$famid:life_data$ssex)
summary(leaf_perim_2sex)


### 1 sex model ###

#Subsetting data
life_Female <- life_data[ which(clustered_voc$ssex=='f'), ]
life_Male <- life_data[ which(clustered_voc$ssex=='m'), ]

#Female
Rero_female <- aov(life_Female$repro~ life_Female$famid + life_Female$famid/life_Female$sampid)
summary(Rero_female)

areaw3_1sex <- aov(life_Female$area_wk3~ life_Female$famid + life_Female$famid/life_Female$sampid)
summary(areaw3_1sex )

permw3_1sex <- aov(life_Female$perim_wk3~ life_Female$famid + life_Female$famid/life_Female$sampid)
summary(permw3_1sex)

circw3_1sex <- aov(life_Female$circ_wk3~ life_Female$famid + life_Female$famid/life_Female$sampid)
summary(circw3_1sex)

permratae_1sex <- aov(life_Female$perim_rate~ life_Female$famid + life_Female$famid/life_Female$sampid)
summary(permratae_1sex)

arearatae_1sex <- aov(life_Female$area_rate~ life_Female$famid + life_Female$famid/life_Female$sampid)
summary(arearatae_1sex)

days21_1sex <- aov(life_Female$days21~ life_Female$famid + life_Female$famid/life_Female$sampid)
summary(days21_1sex)

daysgam_1sex <- aov(life_Female$days_gam~ life_Female$famid + life_Female$famid/life_Female$sampid)
summary(daysgam_1sex)

leaf_Length_1sex <- aov(life_Female$leaf_length~ life_Female$famid + life_Female$famid/life_Female$sampid)
summary(leaf_Length_1sex)

leaf_area_1sex <- aov(life_Female$leaf_area~ life_Female$famid + life_Female$famid/life_Female$sampid)
summary(leaf_area_1sex)

leaf_perm_1sex <- aov(life_Female$leaf_perim~ life_Female$famid + life_Female$famid/life_Female$sampid)
summary(leaf_perm_1sex)

