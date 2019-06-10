path <- "/Users/lesliekollar/Desktop/PAG_data"
setwd(path)
getwd()

library(ggplot2)
install.packages("plotly")
install.packages("tidyverse")
install.packages("lme4")
install.packages("Matrix")
library(Martrix)
library(lme4)
library(tidyverse)
library(plotly)

#############Different Day VOC#############
data <- read.csv("Diff_Days_VOC.csv", header = TRUE)
str(data)

data$Fam.. <- as.factor(data$Fam..)
data$Length.Average <- as.numeric(data$Length.Average )
data$Area.Average <- as.numeric(data$Area.Average)
data$Perim.Average <- as.numeric(data$Perim.Average)


#Making all negative values zeros
for (i in nrow(data))
{
  if (data[i]<0) {data[i] = 0}
  else{data[i] = data[i]}
}

data[data<0] <- 0
data

## Writing out new document
write.csv(data,"Diff_days_VOC_zeros.csv")

#############Same Day VOC####################

data <- read.csv("Same_day_VOC.csv", header = TRUE)
str(data)

data$Fam.. <- as.factor(data$Fam..)
data$Length.Average <- as.numeric(data$Length.Average )
data$Area.Average <- as.numeric(data$Area.Average)
data$Perim.Average <- as.numeric(data$Perim.Average)


#Making all negative values zeros
for (i in nrow(data))
{
  if (data[i]<0) {data[i] = 0}
  else{data[i] = data[i]}
}

data[data<0] <- 0
data

## Writing out new document
write.csv(data,"Same_day_VOC_zeros.csv")

################## Dates VOCS ################

data <- read.csv("Dates_VOCS.csv", header = TRUE)
str(data)

data[] <- lapply(data, function(x) {
  if(is.factor(x)) as.numeric(as.character(x)) else x
})
sapply(data, class)

data$Fam.. <- as.factor(data$Fam..)
data$Sample.Name <- as.factor(data$Sample.Name)
data$Sample_Sex <- as.factor(data$Sample_Sex)
data$Sex.on.Dissection <- as.factor(data$Sex.on.Dissection)
data$Date.PTR <- as.factor(data$Date.PTR)

#Making all negative values zeros
for (i in nrow(data))
{
  if (data[i]<0) {data[i] = 0}
  else{data[i] = data[i]}
}

data[data<0] <- 0
data

## Writing out new document
write.csv(data,"Dates_VOC_zeros.csv")

################## Running ANOVAs to see if there is a difference between days for each compound

data2 <- read.csv("VOCS_ANOVA_Females.csv", header=TRUE)
data3 <- read.csv("VOCS_ANOVA_Males.csv", header=TRUE)

str(data2)

##Females
V1 <- aov(data3$m29.9975_FLUX~data3$Date.PTR)
summary(V1)
V2 <- aov(data3$m30.99783_FLUX~data3$Date.PTR)
summary(V2)
V3 <- aov(data3$m31.01783_FLUX~data3$Date.PTR)
summary(V3)
V4 <- aov(data3$m31.9908_FLUX2~data3$Date.PTR)
summary(V4)
V5 <- aov(data3$m32.99853_FLUX~data3$Date.PTR)
summary(V5)
V6 <- aov(data3$m33.03230_FLUX~data3$Date.PTR)
summary(V6)
V7 <- aov(data3$m33.98721_FLUX~data3$Date.PTR)
summary(V7)
V8 <- aov(data3$m34.02317_FLUX~data3$Date.PTR)
summary(V8)
V9 <- aov(data3$m37.0289_FLUX~data3$Date.PTR)
summary(V9)

#### Pulling out top ten compounds only for
data4 <- read.csv("VOC_DATA_ONLY.csv", header = TRUE)
data4

data5<-data4[,-1] #take out first row of labels. 
for(i in 1:nrow(data5)){
  myrow <- data5[i, ]
  tenbest <- c(myrow[order(myrow, decreasing = TRUE)[11]]) #here, make vector with c()
  myrow[which(myrow <= tenbest)] <- 0
  data5[i, ]<- myrow
} 
data6<-cbind(data4[,1],data5)

################### Jose Miguels Code

str(data4)

data4$M126_FLUX <- as.numeric(data4$M126_FLUX)
data4$m90.00000_FLUX <- as.numeric(data4$m90.00000_FLUX)

#concs <- rnorm(n=10, mean=10)
ids <-  data4[,1]
ids

#### Randing each row
#### THis is working! Each row is represented by 90 cells in the second column BUT THE NUMBERS ARE WEIRD
## AND CHHANGE IF I REMOVE THE SAMPLE NAMES OR KEEP THEM IN

for(i in 1:nrow(data4[,2:91])){
  raw.ranks <- rank(data4[2:91])
}

raw.ranks

write.csv(raw.ranks, "Ranks.csv")

############ THIS DOESNT WORK AT ALL.....
ranked.ids <- data4[1,]
for(i in 1:nrow(data4)){
  
  ith.rank <- raw.ranks[i]
  ith.id    <- ids[i]
  ranked.ids[ith.rank] <- ith.id
  
}

ith.rank

############ HAVENT EVEN GOTTEN THIS FAR....
par(oma=c(2,2,1,1))
plot(my.ranks, concs, pch=16, axes=F, ylab="", xlab="")
axis(side=2, cex.lab=1.5)
mtext(text="Concentration", side=2, outer=TRUE)
axis(side=1, cex.lab=1.5, labels=ranked.ids, at=1:10)
mtext(text="Ranked compounds", side=1, outer=TRUE)
box()

################# Jose Miguels original code to practice.

concs <- c(0,0,0,0,.000000567, .03345,.000000456, 0.00000234,0,0,0,0,0,0)
ids <-  letters[1:14]
raw.ranks <- rank(x=concs)
my.ranks <- (14+1) -raw.ranks

rank(order(concs))
write.csv(raw.ranks, "jp.csv")



ranked.ids <- rep("NA",14)
for(i in 1:14){
  
  ith.rank <- my.ranks[i]
  ith.id    <- ids[i]
  ranked.ids[ith.rank] <- ith.id
  
}

par(oma=c(2,2,1,1))
plot(my.ranks, concs, pch=16, axes=F, ylab="", xlab="")
axis(side=2, cex.lab=1.5)
mtext(text="Concentration", side=2, outer=TRUE)
axis(side=1, cex.lab=1.5, labels=ranked.ids, at=1:10)
mtext(text="Ranked compounds", side=1, outer=TRUE)
box()


################### use all positions 2

data5<-data4[,-1] #take out first row of labels. 
for(i in 1:nrow(data5)){
  myrow <- data5[i, ]
  onebest <- c(myrow[order(myrow, decreasing = TRUE)[11]]) #here, make vector with c()
  myrow[which(myrow <= onebest)] <- 0
  data5[i, ]<- myrow
}

data7<-cbind(data4[,1],data5)
write.csv(data7, "top_two_.csv")


data8 <- read.csv("Total_two_voc.csv", header=TRUE)

ggplot(data8, aes(x=data8$Compound, y=data8$Total.Flux)) + geom_bar(stat = "identity")+
  theme(text= element_text(size= 5),axis.text.x=element_text(angle=90, hjust=1)) +
  labs(title="Bargraph for number two compound (totals for all samples)", y="Number of flux", x="Genotype")

################################### Forget figuring out data #################################################

PAG <- read.csv("PAG_data.csv", header=TRUE)

#Making everything numeric
PAG[] <- lapply(PAG, function(x) {
  if(is.factor(x)) as.numeric(as.character(x)) else x
})
sapply(PAG, class)

PAG$Fam.. <- as.factor(PAG$Fam..)
PAG$Sample.Name <- as.factor(PAG$Sample.Nam)
PAG$Sex <- as.factor(PAG$Sex)


#Changing everything to zeros that is a negative value
for (i in nrow(PAG))
{
  if (PAG[i]<0) {PAG[i] = 0}
  else{PAG[i] = PAG[i]}
}

PAG[PAG<0] <- 0
PAG

######### Write file out to re-add names, sex, etc

PAG2 <- write.csv(PAG, "PAG2.csv")

########## Writing PAG data back in with Sample names and sex re-added

PAG3 <- read.csv("PAG2.csv", header=TRUE)

#Changing dataset to binary to count number of compounds

for (i in nrow(PAG3))
{
  if (PAG3[i]>0) {PAG3[i] = 1}
  else{PAG3[i] = PAG3[i]}
}

PAG3[PAG3>0] <- 1

PAG4 <- write.csv(PAG3, "PAG4.csv")

########################################Start Here!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
##### added total number of VOCs produced and added total flux produced across all VOCs.

PAG5 <- read.csv("PAG2_avg_missing.CSV",header=TRUE)
PAG5_female <- read.csv("PAG2_avg_missing_female.csv", header=TRUE)
PAG5_Male <- read.csv("PAG2_avg_missing_male.csv", header=TRUE)



str(PAG5)
PAG5$M126_FLUX <- as.numeric(PAG5$M126_FLUX)
PAG5$m90.00000_FLUX <- as.numeric(PAG5$m90.00000_FLUX)
PAG5$Fam.. <- as.factor(PAG5$Fam..)


######################### Zscale data ############################
PAG5 <- read.csv("PAG2_numeric.CSV",header=TRUE)
PAG5 <- scale(PAG5)
write.csv(PAG5, "Pag2_numeric_scaled.csv")

PAG5 <- read.csv("PAG2_scaled.csv", header=TRUE)
str(PAG6)

############################### Sum of flux #######################################
library(ggplot2)


ggplot(PAG5_female, aes(x=PAG5_female$SUM_Flux)) + 
  geom_histogram(binwidth = 1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for Female Flux", x="Number of Flux", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$SUM_Flux)) + 
  geom_histogram(binwidth = 1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for male Flux", x="Number of Flux", y="Frequency")

#######Figuring out how to transform ###########

log_SF <- read.csv("Log_sum_Flux.csv", header=TRUE)
sqrt_SF <- read.csv("sqrt_sum_Flux.csv", header=TRUE)
log_sumFlux <- log10(PAG6$SUM_Flux)
log_sumFlux2 <- log10(PAG5$SUM_Flux)
sqrt_sumFlux <- sqrt(PAG6$SUM_Flux)
write.csv(log_sumFlux2, "log_sumFlux2.csv")

PAG7 <- read.csv("PAG2_avg_missing_clones_combined_transformed.csv", header=TRUE)
PAG8 <- read.csv("PAG2_avg_missing_transformed.csv", header=TRUE)
str(PAG8)
PAG8$Fam.. <- as.factor(PAG8$Fam..)
PAG8$Clone <- as.factor(PAG8$Clone)
PAG8$Individual <- as.factor(PAG8$Individual)

ggplot(PAG8, aes(x=PAG8$SUM_flux)) + 
  geom_histogram(binwidth = .1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for  Flux", x="Number of Flux", y="Frequency")



#2 sex model for Sum of flux
DS_FLUX_ALL <- aov(PAG7$Sum_flux~ PAG7$Fam.. + 
                PAG7$Sex + PAG7$Fam..:PAG7$Sex)

anova(DS_FLUX_ALL)
print(DS_FLUX_ALL)
summary(DS_FLUX_ALL)

#single sex model for sum of flux
SS_FLUX_Female <- aov(PAG5_female$SUM_Flux~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_FLUX_Female)
print(SS_FLUX_Female)
summary(SS_FLUX_Female)

Sex_var_Flux_females <- ( 0.000053652-0.000019779 )/(0.000053652+0.000019779 )*100
Sex_var_Flux_females

SS_FLUX_male <- aov(PAG5_Male$SUM_Flux~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_FLUX_male)
print(SS_FLUX_male)
summary(SS_FLUX_male)


####Figuring out autosomal variation and sex chrhomosome

#Family- Family(indiviual) =  Only autosomal
Sex_var_Flux_males <- (  0.00513145-0.00037281)/(0.00513145+0.00037281)*100
Sex_var_Flux_males


PAG5_female$SUM_Flux <- as.numeric(PAG5_female$SUM_Flux)
PAG5_Male$SUM_Flux <- as.numeric(PAG5_Male$SUM_Flux)

par(mfrow=c(1,2))
hist(PAG5_female$SUM_Flux, breaks=30 , xlim=c(0,50) , col=rgb(1,0,0,0.5) , xlab="height" , ylab="nbr of plants" , main="" )
hist(PAG5_Male$SUM_Flux, breaks=30 , xlim=c(0,50) , col=rgb(0,0,1,0.5) , xlab="height" , ylab="nbr of plants" , main="")



################################### Sum of volatiles ##################
VOC_ONLY <- read.csv("PAG2_avg_missing_clones_combined_VOC_ONLY.csv", header=TRUE)
str(VOC_ONLY)
VOC_ONLY$Sum_VOCS <- as.numeric(VOC_ONLY$Sum_VOCS)


VOC_ONLY2 <- read.csv("PAG2_avg_missing_VOC_ONLY.csv", header=TRUE)
str(VOC_ONLY2)
VOC_ONLY2$Sum_VOCS <- as.numeric(VOC_ONLY2$Sum_VOCS)

ggplot(PAG5_female, aes(x=PAG5_female$Sum_VOCS)) + 
  geom_histogram(binwidth = 1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for Female number of vocs", x="Number of vocs", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$Sum_VOCS)) + 
  geom_histogram(binwidth = 1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for male VOC", x="Number of voc", y="Frequency")


ggplot(VOC_ONLY, aes(x=VOC_ONLY$Sum_VOCS)) + 
  geom_histogram(binwidth = 1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for VOC", x="Number of voc", y="Frequency")

#2 sex model for Sum of VOCs
DS_VOC_ALL <- aov(VOC_ONLY$Sum_VOCS~ VOC_ONLY$Fam.. + 
                    VOC_ONLY$Sex + VOC_ONLY$Fam..:VOC_ONLY$Sex)

anova(DS_VOC_ALL)
print(DS_VOC_ALL)
summary(DS_VOC_ALL)

#single sex model for sum of VOCs
SS_VOC_ALL <- aov(VOC_ONLY2$Sum_VOCS~ VOC_ONLY2$Fam.. + VOC_ONLY2$Fam../VOC_ONLY2$Individual + (1|VOC_ONLY2$Clone))  
anova(SS_VOC_ALL)
print(SS_VOC_ALL)
summary(SS_VOC_ALL)

SS_VOC_Female <- aov(PAG5_female$Sum_VOCS~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_VOC_Female)
print(SS_VOC_Female)
summary(SS_VOC_Female)

Sex_var_VOC_females <- ((1296.68- 435.33)/(1296.68+ 435.33))*100
Sex_var_VOC_females


SS_VOC_male <- aov(PAG5_Male$Sum_VOCS~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_VOC_male)
print(SS_VOC_male)
summary(SS_VOC_male)

##### Autosomal variation
Sex_var_VOC_males <- ((2505.32- 16.92)/(2505.32+ 16.92))*100
Sex_var_VOC_males


par(mfrow=c(1,2))
hist(PAG5_female$Sum_VOCS, breaks=30 , xlim=c(0,50) , col=rgb(1,0,0,0.5) , xlab="height" , ylab="nbr of plants" , main="" )
hist(PAG5_Male$Sum_VOCS, breaks=30 , xlim=c(0,50) , col=rgb(0,0,1,0.5) , xlab="height" , ylab="nbr of plants" , main="")

PAG9_female <- read.csv("PAG2_avg_missing_clones_combined_VOC_ONLY_Female.csv", header=TRUE)
PAG9_male <- read.csv("PAG2_avg_missing_clones_combined_VOC_ONLY_male.csv", header=TRUE)
PAG9_female$Sum_VOCS <- as.numeric(PAG9_female$Sum_VOCS)
PAG9_male$Sum_VOCS <- as.numeric(PAG9_male$Sum_VOCS)

hist(PAG9_female$Sum_VOCS, breaks=20,  xlim=c(0,100), ylim=c(0,30), col=rgb(1,0,0,1), xlab="Number of different compounds", 
     ylab="Frequency of plants", main="Distribution for number of different compounds", cex.lab= 1.5, cex.main=1.75 )
hist(PAG9_male$Sum_VOCS, breaks=20, xlim=c(0,100), ylim=c(0,30), col=rgb(0,0,1,0.5), add=T)
legend("topright", legend=c("Female","Male"), col=c(rgb(1,0,0,1), 
                                                      rgb(0,0,1,0.5)), pt.cex=2, pch=15 )


################################ EXPRESSION##########################
install.packages("MASS")
library(MASS)

boxcox(PAG5$X..Exp.~ PAG5$Fam.. + 
         PAG5$Sex + PAG5$Fam..:PAG5$Sex)


hist(log2(PAG5$X..Exp.)) 

ggplot(PAG5_female, aes(x=PAG5_female$X..Exp.)) + 
  geom_histogram(binwidth = 1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for Female expression", x="expression", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$X..Exp.)) + 
  geom_histogram(binwidth = 1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for male expression", x="expression", y="Frequency")

ggplot(PAG5, aes(x=PAG5$X..Exp.)) + 
  geom_histogram(binwidth = 1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for male expression", x="expression", y="Frequency")

#2 sex model for Expression
DS_Exp_ALL <- aov(PAG6$X..Exp.~ PAG6$Fam.. + 
                    PAG6$Sex + PAG6$Fam..:PAG6$Sex)

anova(DS_Exp_ALL)
print(DS_Exp_ALL)
summary(DS_Exp_ALL)

#single sex model for Expression
SS_EXP_Female <- aov(PAG5_female$X..Exp.~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_EXP_Female)
print(SS_EXP_Female)
summary(SS_EXP_Female)

SS_EXP_male <- aov(PAG5_Male$X..Exp.~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_EXP_male)
print(SS_EXP_male)
summary(SS_EXP_male)


#### Sex chromo and autosomal variation
Sex_var_Exp <- ((33388.36-0.66)/(33388.36+0.66))*100
Sex_var_Exp


PAG7_female <- read.csv("PAG2_avg_missing_clones_combined_Female.csv", header=TRUE)
PAG7_male <- read.csv("PAG2_avg_missing_clones_combined_Male.csv", header=TRUE)
str(PAG7_female)


par(mfrow=c(1,2))
hist(PAG7_female$X..Exp., breaks=30 , xlim=c(0,100) , col=rgb(1,0,0,0.5) , xlab="height" , ylab="nbr of plants" , main="" )
hist(PAG7_male$X..Exp., breaks=30 , xlim=c(0,100) , col=rgb(0,0,1,0.5) , xlab="height" , ylab="nbr of plants" , main="")


hist(PAG7_female$X..Exp., breaks = 50, xlim=c(0,100), col=rgb(1,0,0,0.5), xlab="Percent of expressing tissue", 
     ylab="Frequency of plants", main="Distribution for percent of sex expressing tissue" )
hist(PAG7_male$X..Exp.,breaks = 50, xlim=c(0,100), col=rgb(0,0,1,0.5), add=T)
legend("topleft", legend=c("Females","Males"), col=c(rgb(1,0,0,0.5), 
                                                      rgb(0,0,1,0.5)), pt.cex=2, pch=15 )
############################## MALE SEX BUDS ################################


ggplot(PAG5_Male, aes(x=PAG5_Male$Total.Buds)) + 
  geom_histogram(binwidth = 1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for male sex buds", x="sex buds", y="Frequency")


SS_Buds_male <- aov(PAG5_Male$Total.Buds~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_Buds_male)
print(SS_Buds_male)
summary(SS_Buds_male)


Sex_var_tBuds_male <- (( 0.058-13.668)/(0.058+13.668))*100
Sex_var_tBuds_male

############################## MALE SEX BUDS per stem################################


ggplot(PAG5_Male, aes(x=PAG5_Male$Avg.Male.Buds.Stem)) + 
  geom_histogram(binwidth = 1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for male sex buds", x="sex buds", y="Frequency")

SS_SBuds_male <- aov(PAG5_Male$Avg.Male.Buds.Stem~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_SBuds_male)
print(SS_SBuds_male)
summary(SS_SBuds_male)

Sex_var_Buds_stem_male <- ((0.15089-0.00272)/(0.15089+0.00272))*100
Sex_var_Buds_stem_male
############################## FEMALE SEX BUDS #############################

ggplot(PAG5_female, aes(x=PAG5_female$Avg..Arch.)) + 
  geom_histogram(binwidth = 1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for Female archegonia", x="archegonia", y="Frequency")

SS_Buds_Female <- aov(PAG5_female$Avg..Arch.~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_Buds_Female)
print(SS_Buds_Female)
summary(SS_Buds_Female)


Sex_var_female <- ((125.815-85.422)/(125.815+85.422)*100)
Sex_var_female

################################# CHLORO ####################################

ggplot(PAG5_female, aes(x=PAG5_female$Cholor.)) + 
  geom_histogram(binwidth = 0.01, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for Female Chloro", x="Chloro", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$Cholor.)) + 
  geom_histogram(binwidth = .01, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for male Chloro", x="Chloro", y="Frequency")

ggplot(PAG5, aes(x=PAG5$Cholor.)) + 
  geom_histogram(binwidth = .01, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for Chloro", x="Chloro", y="Frequency")

#2 sex model for CHLORO
DS_CHLORO_ALL <- aov(PAG6$Cholor.~ PAG6$Fam.. + 
                    PAG6$Sex + PAG6$Fam..:PAG6$Sex)

anova(DS_CHLORO_ALL)
print(DS_CHLORO_ALL)
summary(DS_CHLORO_ALL)

#single sex model for CHLORO
SS_chloro_Female <- aov(PAG5_female$Cholor.~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_chloro_Female)
print(SS_chloro_Female)
summary(SS_chloro_Female)

Sex_var_CHLORO_females <- ((  0.003298- 0.0032055)/( 0.003298+ 0.0032055))*100
Sex_var_CHLORO_females

SS_chloro_male <- aov(PAG5_Male$Cholor.~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_chloro_male)
print(SS_chloro_male)
summary(SS_chloro_male)

Sex_var_CHLORO_males <- (( 0.00762825- 0.00000642)/(0.00762825+ 0.00000642))*100
Sex_var_CHLORO_males

par(mfrow=c(1,2))
hist(PAG7_female$Cholor., breaks=100 , binwidth= 0.0001, xlim=c(0,1) , col=rgb(1,0,0,0.5) , xlab="height" , ylab="nbr of plants" , main="" )
hist(PAG7_male$Cholor., breaks=100 , binwidth= 0.0001, xlim=c(0,1) , col=rgb(0,0,1,0.5) , xlab="height" , ylab="nbr of plants" , main="")


hist(PAG7_female$Cholor., breaks=80, xlim=c(0.5,.8), ylim =  c(0,30), col=rgb(1,0,0,1), xlab=" chlorophyll fluorescence (FV/FM)", 
     ylab="Number of plants", main="Distribution of the chlorophyll fluorescence measurements", cex.lab= 1.5, cex.main=1.7  )
hist(PAG7_male$Cholor., breaks=20, xlim=c(0.5,.8), ylim= c(0,30), col=rgb(0,0,1,0.5), add=T)
legend("topleft", legend=c("Females","Males"), col=c(rgb(1,0,0,1), 
                                                     rgb(0,0,1,0.5)), pt.cex=5, pch=20 )

################################ AVERAGE PERIMETER #################################

ggplot(PAG5_female, aes(x=PAG5_female$Avg.Perim...Week.3.)) + 
  geom_histogram(binwidth = 0.05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for Female perm", x="perimeter", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$Avg.Perim...Week.3.)) + 
  geom_histogram(binwidth = .05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for male perm", x="perimeter", y="Frequency")

ggplot(PAG5, aes(x=PAG5$Avg.Perim...Week.3.)) + 
  geom_histogram(binwidth = .05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for perm", x="perimeter", y="Frequency")

#2 sex model for AVERAGE GROWTH PERIMETER
DS_PERM_ALL <- aov(PAG6$Avg.Perim...Week.3.~ PAG6$Fam.. + 
                       PAG6$Sex + PAG6$Fam..:PAG6$Sex)

anova(DS_PERM_ALL)
print(DS_PERM_ALL)
summary(DS_PERM_ALL)

#single sex model for AVERAGE GROWTH PERIMETER
SS_gperimeter_Female <- aov(PAG5_female$Avg.Perim...Week.3.~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_gperimeter_Female)
print(SS_gperimeter_Female)
summary(SS_gperimeter_Female)

Sex_var_perm_growth_females <- ((22.0473- 6.9241)/(22.0473+ 6.92411)*100)
Sex_var_perm_growth_females

SS_gperimeter_male <- aov(PAG5_Male$Avg.Perim...Week.3.~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_gperimeter_male)
print(SS_gperimeter_male)
summary(SS_gperimeter_male)


Sex_var_perm_growth_males <- ((3.0442-0.4271)/(3.0442+0.4271)*100)
Sex_var_perm_growth_males

############ Barplot for perimeter after 3 weeks #############
ggplot(barplot_data, aes(fill=barplot_data$Sex, y=barplot_data$Avg.Perim...Week.3., x=barplot_data$Fam..))+ 
  scale_fill_brewer(palette = "Set1")+
  labs(main= "Male and female perimeter of growth after 3 weeks", xlab= "Family", ylab="Perimeter (mm) after 3 weeks")+
  geom_bar( stat="identity")

ggplot(barplot_data, aes(fill=barplot_data$Sex,  width = 0.4,y=barplot_data$Avg.Perim...Week.3., x=barplot_data$Fam..)) + 
  geom_bar(position="dodge", stat="identity")+
  scale_fill_brewer(palette = "Set1")+
  labs(title="Male and female perimeter of growth after 3 weeks", x="Family", y="Perimeter (mm)")

############################# AVERAGE AREA ########################

ggplot(PAG5_female, aes(x=PAG5_female$Avg.Area..Week.3.)) + 
  geom_histogram(binwidth = 0.05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for Female area", x="area", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$Avg.Area..Week.3.)) + 
  geom_histogram(binwidth = .1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for male area", x="area", y="Frequency")

ggplot(PAG5, aes(x=PAG5$Avg.Area..Week.3.)) + 
  geom_histogram(binwidth = .1, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for area", x="area", y="Frequency")

#2 sex model for AVERAGE GROWTH AREA
DS_AREA_ALL <- aov(PAG6$Avg.Area..Week.3.~ PAG6$Fam.. + 
                     PAG6$Sex + PAG6$Fam..:PAG6$Sex)

anova(DS_AREA_ALL)
print(DS_AREA_ALL)
summary(DS_AREA_ALL)

#single sex model for AVERAGE GROWTH AREA
SS_garea_Female <- aov(PAG5_female$Avg.Area..Week.3.~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_garea_Female)
print(SS_garea_Female)
summary(SS_garea_Female)

Sex_var_area_growth_female <- (( 0.936080- 0.066971)/(  0.936080+ 0.066971)*100)
Sex_var_area_growth_female

SS_garea_male <- aov(PAG5_Male$Avg.Area..Week.3.~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_garea_male)
print(SS_garea_male)
summary(SS_garea_male)


Sex_var_area_growth_male <- (( 0.247855- 0.104006)/( 0.247855+ 0.104006)*100)
Sex_var_area_growth_male

##### Bar plot  for growth area ######
barplot_data <- read.csv("PAG2_avg_missing_clones_combined_barplots.csv", header=TRUE)



# Grouped
ggplot(barplot_data, aes(fill=barplot_data$Sex,  width = 0.4,y=barplot_data$Avg.Area..Week.3., x=barplot_data$Fam..)) + 
  geom_bar(position="dodge", stat="identity")+
  scale_fill_brewer(palette = "Set1")+
  labs(title="Male and female area of growth after 3 weeks", x="Family", y="Area (mm^2)")



# Stacked
ggplot(barplot_data, aes(fill=barplot_data$Sex, y=(barplot_data$Avg.Area..Week.3.), x=barplot_data$Fam..))+ 
  scale_fill_brewer(palette = "Set1")+
  labs(main= "Male and female area of growth after 3 weeks", xlab= "Family", ylab="Area (mm^2) after 3 weeks")+
  geom_bar( stat="identity")


# color with RcolorBrewer
ggplot(barplot_data, aes(fill=barplot_data$Sex, y=barplot_data$Avg.Area..Week.3., x=barplot_data$Fam..)) + 
  geom_bar( stat="identity", position="fill") +    
  scale_fill_brewer(palette = "Set1")

# Faceting
ggplot(barplot_data, aes(fill=barplot_data$Sex, y=barplot_data$Avg.Area..Week.3., x=barplot_data$Fam.., main= "Male and 
                         female area of growth after 3 weeks")) +
  geom_bar( stat="identity") +    
  facet_wrap(~barplot_data$Fam..)

########################## AVERAGE CIRC ##################################
ggplot(PAG5_female, aes(x=PAG5_female$Avg.Circ...Week.3.)) + 
  geom_histogram(binwidth = 0.05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for Female circ", x="circularity", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$Avg.Circ...Week.3.)) + 
  geom_histogram(binwidth = .05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for male circularity", x="circularity", y="Frequency")

ggplot(PAG5, aes(x=PAG5$Avg.Circ...Week.3.)) + 
  geom_histogram(binwidth = .05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for circularity", x="circularity", y="Frequency")

#2 sex model for AVERAGE GROWTH CIRCULARITY
DS_CIRC_ALL <- aov(PAG6$Avg.Circ...Week.3.~ PAG6$Fam.. + 
                     PAG6$Sex + PAG6$Fam..:PAG6$Sex)

anova(DS_CIRC_ALL)
print(DS_CIRC_ALL)
summary(DS_CIRC_ALL)

#single sex model for AVERAGE GROWTH CIRCULARITY
SS_CIRC_ALL <- aov(PAG5$Avg.Circ...Week.3.~ PAG5$Fam.. + PAG5$Fam../PAG5$Individual + (1|PAG5$Clone))  
anova(SS_CIRC_ALL)
print(SS_CIRC_ALL)
summary(SS_CIRC_ALL)

Sex_var_circ_growth <- (( 0.037654-0.089931)/(0.037654+0.089931)*100)
Sex_var_circ_growth

hist(PAG7_female$Avg.Circ...Week.3., breaks=20, xlim=c(0,1), col=rgb(1,0,0,0.5), xlab="Circularity at 3 weeks", 
     ylab="Number of plants", main="Distribtion for circularity of 3 weeks" )
hist(PAG7_male$Avg.Circ...Week.3., breaks=20, xlim=cc(0,1), col=rgb(0,0,1,0.5), add=T)
legend("topright", legend=c("Females","Males"), col=c(rgb(1,0,0,0.5), 
                                                     rgb(0,0,1,0.5)), pt.cex=2, pch=15 )

######################### GAMETOPHORES AFTER 21 DAYS #####################

boxcox(PAG5$Avg.21.days~ PAG5$Fam.. + PAG5$Fam../PAG5$Individual + (1|PAG5$Clone))

ggplot(PAG5_female, aes(x=PAG5_female$Avg.21.days)) + 
  geom_histogram(binwidth = 0.5, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for 21 days", x="number of gam after 21 days", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$Avg.21.days)) + 
  geom_histogram(binwidth = .5, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for 21 days", x="number of gam after 21 days", y="Frequency")

ggplot(PAG5, aes(x=PAG5$Avg.21.days)) + 
  geom_histogram(binwidth = .5, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for 21 days", x="number of gam after 21 days", y="Frequency")

#2 sex model for AVERAGE GAMETOPHORES AFTER 21 DAYS
DS_21GAM_ALL <- aov(PAG6$Avg.21.days~ PAG6$Fam.. + 
                     PAG6$Sex + PAG6$Fam..:PAG6$Sex)

anova(DS_21GAM_ALL)
print(DS_21GAM_ALL)
summary(DS_21GAM_ALL)

#single sex model for AVERAGE GAMETOPHORES AFTER 21 DAYS
SS_gam_Female <- aov(PAG5_female$Avg.21.days~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_gam_Female)
print(SS_gam_Female)
summary(SS_gam_Female)

Sex_var_21days_females <- (( 37.713- 10.099)/(37.713+ 10.099)*100)
Sex_var_21days_females

SS_gam_male <- aov(PAG5_Male$Avg.21.days~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_gam_male)
print(SS_gam_male)
summary(SS_gam_male)


Sex_var_21days_males <- ((  20.825-10.025)/(20.825+10.025)*100)
Sex_var_21days_males

################### DAYS TILL GAMETOPHORES ################

ggplot(PAG5_female, aes(x=PAG5_female$Avg.Days.til.Gam)) + 
  geom_histogram(binwidth = 0.5, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for days", x="number of days till gam", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$Avg.Days.til.Gam)) + 
  geom_histogram(binwidth = .5, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for days", x="number of days till gam", y="Frequency")

ggplot(PAG5, aes(x=PAG5$Avg.Days.til.Gam)) + 
  geom_histogram(binwidth = .5, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for days", x="number of days till gam", y="Frequency")


#2 sex model for DAYS TILL GAM
DS_DAYS_ALL <- aov(PAG6$Avg.Days.til.Gam~ PAG6$Fam.. + 
                      PAG6$Sex + PAG6$Fam..:PAG6$Sex)

anova(DS_DAYS_ALL)
print(DS_DAYS_ALL)
summary(DS_DAYS_ALL)

#single sex model for DAYS TILL GAM
SS_days_Female <- aov(PAG5_female$Avg.Days.til.Gam~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_days_Female)
print(SS_days_Female)
summary(SS_days_Female)

Sex_var_Days_females <- ((1931.19-  393.12)/(1931.19+  393.12)*100)
Sex_var_Days_females

SS_days_male <- aov(PAG5_Male$Avg.Days.til.Gam~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_days_male)
print(SS_days_male)
summary(SS_days_male)

Sex_var_Days_males <- ((854.26- 0.74)/(854.26+ 0.74)*100)
Sex_var_Days_males


############################ AVERAGE LEAF LENGTH #################

ggplot(PAG5_female, aes(x=PAG5_female$Length.Average..mm.)) + 
  geom_histogram(binwidth = 0.05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for leaf length", x="leaf length", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$Length.Average..mm.)) + 
  geom_histogram(binwidth = .05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for leaf length", x="leaf length", y="Frequency")

ggplot(PAG5, aes(x=PAG5$Length.Average..mm.)) + 
  geom_histogram(binwidth = .05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for leaf length", x="leaf length", y="Frequency")

#2 sex model for leaf length
DS_LENGTH_ALL <- aov(PAG6$Length.Average..mm.~ PAG6$Fam.. + 
                     PAG6$Sex + PAG6$Fam..:PAG6$Sex)

anova(DS_LENGTH_ALL)
print(DS_LENGTH_ALL)
summary(DS_LENGTH_ALL)

#single sex model for leaf length
SS_leaflength_Female <- aov(PAG5_female$Length.Average..mm.~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_leaflength_Female)
print(SS_leaflength_Female)
summary(SS_leaflength_Female)

Sex_var_length_leaf_females <- ((0.07837-0.05536)/(0.07837+0.05536)*100)
Sex_var_length_leaf_females

SS_leaflength_male <- aov(PAG5_Male$Length.Average..mm.~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_leaflength_male)
print(SS_leaflength_male)
summary(SS_leaflength_male)

Sex_var_length_leaf_males <- ((  0.18207-0.00815)/(0.18207+0.00815)*100)
Sex_var_length_leaf_males

hist(PAG7_female$Length.Average..mm., breaks=30, xlim=c(0,3), col=rgb(1,0,0,1), xlab="Leaf length (mm)", 
     ylab="Number of plants", main="Distribution for leaf length (mm)", cex.lab= 1.5, cex.main=1.75 )
hist(PAG7_male$Length.Average..mm., breaks=30, xlim=cc(0,3), col=rgb(0,0,1,0.5), add=T)
legend("topright", legend=c("Females","Males"), col=c(rgb(1,0,0,1), 
                                                      rgb(0,0,1,0.5)), pt.cex=2, pch=15 )


################################ AVERAGE LEAF AREA  ########################

ggplot(PAG5_female, aes(x=PAG5_female$Average.Area..mm.)) + 
  geom_histogram(binwidth = 0.05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for leaf area", x="leaf area", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$Average.Area..mm.)) + 
  geom_histogram(binwidth = .05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for leaf area", x="leaf area", y="Frequency")

ggplot(PAG5, aes(x=PAG5$Average.Area..mm.)) + 
  geom_histogram(binwidth = .05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for leaf area", x="leaf area", y="Frequency")

#2 sex model for leaf area
DS_LAREA_ALL <- aov(PAG6$Average.Area..mm.~ PAG6$Fam.. + 
                       PAG6$Sex + PAG6$Fam..:PAG6$Sex)

anova(DS_LAREA_ALL)
print(DS_LAREA_ALL)
summary(DS_LAREA_ALL)

#single sex model for leaf area
SS_leafarea_Female <- aov(PAG5_female$Average.Area..mm.~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_leafarea_Female)
print(SS_leafarea_Female)
summary(SS_leafarea_Female)

Sex_var_leaf_area_females <- ((0.230589-  0.006108)/(0.230589 + 0.006108)*100)
Sex_var_leaf_area_females

SS_leafarea_male <- aov(PAG5_Male$Average.Area..mm.~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_leafarea_male)
print(SS_leafarea_male)
summary(SS_leafarea_male)

Sex_var_leaf_area_males <- ((0.065512- 0.000491 )/(0.065512+ 0.000491)*100)
Sex_var_leaf_area_males


##### Bar plot ######
barplot_data <- read.csv("PAG2_avg_missing_clones_combined_barplots.csv", header=TRUE)

# Stacked
ggplot(barplot_data, aes(fill=barplot_data$Sex, y=barplot_data$Average.Area..mm., x=(barplot_data$Fam..)))+ 
  scale_fill_brewer(palette = "Set1")+
  labs(main= "Male and female area of leaves", xlab= "Family", ylab="Area (mm^2)", cex.axis= 1, cex.main=1.7)+
  geom_bar( stat="identity")

ggplot(barplot_data, aes(fill=barplot_data$Sex,  width = 0.4,y=barplot_data$Average.Area..mm., x=barplot_data$Fam..)) + 
  geom_bar(position="dodge", stat="identity")+
  scale_fill_brewer(palette = "Set1")+
  labs(title="Male and female leaf area (mm^2)", x="Family", y="Leaf area (mm^2)", cex.main=1.7)


############################### AVERAGE LEAF PERIMETER ######################

ggplot(PAG5_female, aes(x=PAG5_female$perim.average..mm.)) + 
  geom_histogram(binwidth = 0.05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for leaf perm", x="leaf perm", y="Frequency")

ggplot(PAG5_Male, aes(x=PAG5_Male$perim.average..mm.)) + 
  geom_histogram(binwidth = .05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for leaf perm", x="leaf perm", y="Frequency")

ggplot(PAG5, aes(x=PAG5$perim.average..mm.)) + 
  geom_histogram(binwidth = .05, aes(fill = ..count..)) +
  scale_fill_gradient("Count", low="blue", high="red") +
  labs(title="Histogram for leaf perm", x="leaf perm", y="Frequency")

#2 sex model for leaf PERIMETER
DS_LPERM_ALL <- aov(PAG6$perim.average..mm.~ PAG6$Fam.. + 
                      PAG6$Sex + PAG6$Fam..:PAG6$Sex)

anova(DS_LPERM_ALL)
print(DS_LPERM_ALL)
summary(DS_LPERM_ALL)

#single sex model for leaf PERIMETER
SS_leafperm_Female <- aov(PAG5_female$perim.average..mm.~ PAG5_female$Fam.. + PAG5_female$Fam../PAG5_female$Individual + (1 | PAG5_female$Clone))  
anova(SS_leafperm_Female)
print(SS_leafperm_Female)
summary(SS_leafperm_Female)

Sex_var_leaf_perm_females <- ((25.6929-1.1491)/(25.6929+1.1491)*100)
Sex_var_leaf_perm_females

SS_leafperm_male <- aov(PAG5_Male$perim.average..mm.~ PAG5_Male$Fam.. + PAG5_Male$Fam../PAG5_Male$Individual + (1 | PAG5_Male$Clone))  
anova(SS_leafperm_male)
print(SS_leafperm_male)
summary(SS_leafperm_male)

Sex_var_leaf_perm_males <- ((2.9455-0.9401)/(2.9455+0.9401)*100)
Sex_var_leaf_perm_males

hist(PAG7_female$perim.average..mm., breaks=30, xlim=c(0,10), col=rgb(1,0.5,0,1), xlab="Perimeter (mm)", 
     ylab="Number of plants", main="Distribution for leaf perimeter (mm)" )
hist(PAG7_male$perim.average..mm., breaks=30, xlim=cc(0,10), col=rgb(0,0,1,1), add=T)
legend("topleft", legend=c("Females","Males"), col=c(rgb(1,0,0,0.5), 
                                                      rgb(0,0,1,0.5)), pt.cex=2, pch=15 )


#sex model:RUN Manova
          #want to show sexes are different
          #average clones and use individual as error
          #Will tell us if families have different mean
          #Do families differ in sex dimorphism
          #Correlations will also be output tools
          
#Individual sex: Family and individual nested within family and clones as error term.  
              #Using RemL we can estimate proportion of variance
              #among family variance - additive genetic variance. Among individual variance in family which is 
              #autosomal contribution to total variance
              
 ################# combinging clones ############################

PAG6 <- aggregate(PAG5, by=list(PAG5$Sample..Name, PAG5$Sex), FUN = mean)
write.csv(PAG6, "PAG2_avg_missing_clones_combined.csv")          

################## reading combined data back together #################
PAG6 <- read.csv("PAG2_avg_missing_clones_combined.csv", header=TRUE)         






