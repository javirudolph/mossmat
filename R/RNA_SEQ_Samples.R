############# Set pathway#######

path <- "/Users/lesliekollar/Desktop"
setwd(path)
getwd()

## loading packages
library(ggplot2)

##reading in data
all_data <- read.csv("LK_CompositeData_w_Partial_Flux_Final_RNASEQ.csv", header=TRUE)
str(all_data)

### Turning all negative values into zeros. Most negatives are in the voc
for (i in nrow(all_data))
{
  if (all_data[i]<0) {all_data[i] = 0}
  else{all_data[i] = all_data[i]}
}
all_data[all_data<0] <- 0
all_data

### Changing all to numeric

all_data[] <- lapply(all_data, function(x) {
  if(is.factor(x)) as.numeric(as.character(x)) else x
})
sapply(all_data, class)

### Checking to see if normally distributed
all_data$X <- as.factor(all_data$X)

all_data$Cholor. <- as.numeric(all_data$Cholor.)
hist(all_data$Cholor.)

all_data$X..Exp. <- as.numeric(all_data$X..Exp.)
hist(all_data$X..Exp.)

ggplot(data=all_data, aes(y=all_data$m29.9975_FLUX, x=all_data$X)) 

## Write out data so that I can re-add the columns that were messed up by the zeros

write.csv(all_data, "all_data_zeros.csv")

## Write data back in 

Clones_same <- read.csv("clones_same_day_2.csv", header=TRUE)
Clones_diff <- read.csv("clones_diff_days_2.csv", header=TRUE)
all_data_zeros <- read.csv("all_data_zeros.csv", header=TRUE)

str(all_data_zeros$Date)
all_data_zeros$Fam.. <- as.factor(all_data_zeros$Fam..)


#### Comparing clones and families for each mass at each date. NO OUTLIERS REMOVED!


#M29.9975
log(all_data_zeros$m29.9975_FLUX)
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m29.9975_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.00001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m29.9975_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m29.9975_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m29.9975_FLUX, group= (Clones_same$Sample.Name), colour=(Clones_same$Sample.Name)))+
   geom_point(size=5)  #+ geom_path(group= (Clones_same$Sample.Name))#+ geom_smooth(aes(col=(Clones_same$Sample.Name)), method="lm", se=F) #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m29.9975_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point(size=5) #+geom_path(group= (Clones_same$Sample.Name)) #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #mm31.01783_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m31.01783_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m31.01783_FLUXX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m31.01783_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m31.01783_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() +geom_path(group= Clones_diff$Sample.Name)#+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m31.01783_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() +geom_path(group= Clones_diff$Sample.Name)#+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m31.9908_FLUX2
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m31.9908_FLUX2, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m31.9908_FLUX2, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m31.9908_FLUX2X, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m31.9908_FLUX2, group= factor(Clones_same$Fam..), colour=factor(Clones_same$Fam..)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m31.9908_FLUX2, group= factor(Clones_diff$Fam..), colour=factor(Clones_diff$Fam..)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
#m32.99853_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m32.99853_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m32.99853_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m32.99853_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m32.99853_FLUX, group= factor(Clones_same$Fam..), colour=factor(Clones_same$Fam..)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m32.99853_FLUX, group= factor(Clones_diff$Fam..), colour=factor(Clones_diff$Fam..)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m33.03230_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m33.03230_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m33.03230_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m33.03230_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m33.03230_FLUX, group= factor(Clones_same$Fam..), colour=factor(Clones_same$Fam..)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m33.03230_FLUX, group= factor(Clones_diff$Fam..), colour=factor(Clones_diff$Fam..)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 

 #m33.98721_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m33.98721_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m33.98721_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m33.98721_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m33.98721_FLUX, group= factor(Clones_same$Fam..), colour=factor(Clones_same$Fam..)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m33.98721_FLUX, group= factor(Clones_diff$Fam..), colour=factor(Clones_diff$Fam..)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))  
 
 #m34.02317_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m34.02317_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m34.02317_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m34.02317_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m34.02317_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m34.02317_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

 #m37.0289_FLUX
 
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m37.0289_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m37.0289_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m37.0289_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m37.0289_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m37.0289_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))
 
 #$m39.0326..cluster..H2O.H3O._.18O....Conc.
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m39.0326..cluster..H2O.H3O._.18O....Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m39.0326..cluster..H2O.H3O._.18O....Conc., group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m39.0326..cluster..H2O.H3O._.18O....Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m39.0326..cluster..H2O.H3O._.18O....Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m39.0326..cluster..H2O.H3O._.18O....Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))
 
 #m41.0375_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m41.0375_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m41.0375_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m41.0375_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m41.0375_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m41.0375_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m42.0343..acetonitrile.H....Conc.
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m42.0343..acetonitrile.H....Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m42.0343..acetonitrile.H....Conc., group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m42.0343..acetonitrile.H....Conc.X, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m42.0343..acetonitrile.H....Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m42.0343..acetonitrile.H....Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m42.0343..acetonitrile.H....Conc.
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m42.95810..m43_1...Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m42.95810..m43_1...Conc., group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m42.95810..m43_1...Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m42.95810..m43_1...Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m42.95810..m43_1...Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #mm43.01734_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m43.01734_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m43.01734_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m43.01734_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m43.01734_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m43.01734_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #mm44.0626_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m44.0626_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m44.0626_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m44.0626_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m44.0626_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m44.0626_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m45.0335_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m45.0335_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m45.0335_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m45.0335_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m45.0335_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m45.0335_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 
 #mm45.99328...NO2.....Conc.2
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m45.99328...NO2.....Conc.2, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m45.99328...NO2.....Conc.2, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m45.99328...NO2.....Conc.2, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m45.99328...NO2.....Conc.2, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m45.99328...NO2.....Conc.2, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m46.03111_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m46.03111_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m46.03111_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m46.03111_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m46.03111_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m46.03111_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m46.03111_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m46.06609_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m46.06609_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m46.06609_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m46.06609_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m46.06609_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #mm47.0128_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m47.0128_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m47.0128_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m47.0128_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m47.0128_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m47.0128_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #mm47.0128_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m47.9847_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m47.9847_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m47.9847_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m47.9847_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m47.9847_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #mmm49.0239_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m49.0239_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m49.0239_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m49.0239_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m49.0239_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m49.0239_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m49.05240_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m49.05240_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m49.05240_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m49.05240_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m49.05240_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m49.05240_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m49.05240_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m49.9923..chloromethane...Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m49.9923..chloromethane...Conc., group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m49.05240_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m49.05240_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m49.05240_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #mm55.0390..cluster..H2O.2.H3O....Conc.
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m55.0390..cluster..H2O.2.H3O....Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m55.0390..cluster..H2O.2.H3O....Conc., group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m55.0390..cluster..H2O.2.H3O....Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m55.0390..cluster..H2O.2.H3O....Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m55.0390..cluster..H2O.2.H3O....Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m57.02382_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m57.02382_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m57.02382_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m57.02382_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m57.02382_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m57.02382_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m57.05991..cluster..H2O.2.H3O._.18O....Conc.
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m57.05991..cluster..H2O.2.H3O._.18O....Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m57.05991..cluster..H2O.2.H3O._.18O....Conc., group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m57.05991..cluster..H2O.2.H3O._.18O....Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m57.05991..cluster..H2O.2.H3O._.18O....Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m57.05991..cluster..H2O.2.H3O._.18O....Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m59.0439_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m59.0439_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m59.0439_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m59.0439_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m59.0439_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #m61.0290_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m61.0290_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
   geom_point() + scale_y_continuous(limits = c(0,.0001))
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m61.0290_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
   geom_point() + scale_y_continuous(limits = c(0,.00001))
 ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m61.0290_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m61.0290_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
   geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
 #mm62.0294_FLUX
 ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m62.0294_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
   scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m62.0294_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m62.0294_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m62.0294_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
 
#m$m63.023_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m63.023_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m63.023_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m63.023_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m63.023_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 

#m$m63.023_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m69.00377_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m69.00377_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m69.00377_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m69.00377_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 

#m69.06994_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m69.06994_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m69.06994_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m69.06994_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m69.06994_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 

#mm71.0354_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m71.0354_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m71.0354_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m71.0354_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m71.0354_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 

#mm73.0376..butyraldehyde.H....Conc.
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m73.0376..butyraldehyde.H....Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m73.0376..butyraldehyde.H....Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m73.0376..butyraldehyde.H....Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m73.0376..butyraldehyde.H....Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 

#m75.0446_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m75.0446_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m75.0446_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m75.0446_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m75.0446_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 

#m75.0446_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m77.0597_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m77.0597_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m77.0597_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m77.0597_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 

#m77.0597..propylene.glycol.H....Conc.2
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m77.0597..propylene.glycol.H....Conc.2, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m77.0597..propylene.glycol.H....Conc.2, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m77.0597..propylene.glycol.H....Conc.2, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m77.0597..propylene.glycol.H....Conc.2, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 

#m79.05478..benzene.H....Conc.2
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m79.05478..benzene.H....Conc.2, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m79.05478..benzene.H....Conc.2, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m79.05478..benzene.H....Conc.2, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m79.05478..benzene.H....Conc.2, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 

#mm81.0699_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m81.0699_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m81.0699_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m81.0699_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m81.0699_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m83.0585_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m83.0585_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m83.0585_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m83.0585_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m83.0585_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#mmm85.0648_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m85.0648_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m85.0648_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m85.0648_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m85.0648_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m86.0362_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m86.0362_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m86.0362_FLUXX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m86.0362_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m86.0362_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m87.0441_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m87.0441_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m87.0441_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m87.0441_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m87.0441_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m87.0441_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m87.0441_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001))m61.0290_FLUXm59.0439_FLUX, group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m87.0441_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m87.0441_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m87.0441_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#mm89.05810..butyric.acid.H....Conc.
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m89.05810..butyric.acid.H....Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m89.05810..butyric.acid.H....Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m89.05810..butyric.acid.H....Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m89.05810..butyric.acid.H....Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m89.09610_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m89.09610_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m89.09610_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m89.09610_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m89.09610_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m90.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m90.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m90.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m90.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m90.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m91.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m91.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m91.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m91.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m91.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m92.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m92.00000..nominal.92...Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m92.00000..nominal.92...Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m92.00000..nominal.92...Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m92.00000..nominal.92...Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#M93
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m93.0699_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m93.0699_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m93.0699_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m93.0699_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#M94
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$M94_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$M94_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$M94_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$M94_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#M95
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m95.00000.FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m95.00000.FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m95.00000.FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m95.00000.FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#M97
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m97.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m97.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m97.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m97.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#M98
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m98.00000..nominal.98...Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m98.00000..nominal.98...Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m98.00000..nominal.98...Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m98.00000..nominal.98...Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))


#Mm99.080..cyclohexanone.H....Conc.
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m99.080..cyclohexanone.H....Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m99.080..cyclohexanone.H....Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m99.080..cyclohexanone.H....Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m99.080..cyclohexanone.H....Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m100.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m100.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m100.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m100.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m100.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m101.00000_flux
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m101.00000_flux, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m101.00000_flux, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m101.00000_flux, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m101.00000_flux, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m103.1117_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m103.1117_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m103.1117_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m103.1117_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m103.1117_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m104_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m104_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m104_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m104_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m104_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m105_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m105_FLUK, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m105_FLUK, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m105_FLUK, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m105_FLUK, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#$m106.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m106.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m106.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m106.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m106.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))


#m107.0855_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m107.0855_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m107.0855_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m107.0855_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m107.0855_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))


#m108.0000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m108.0000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m108.0000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m108.0000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m108.0000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m109.00000..nominal.109...Conc.
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m109.00000..nominal.109...Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m109.00000..nominal.109...Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m109.00000..nominal.109...Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m109.00000..nominal.109...Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#mm110.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m110.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m110.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m110.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m110.00000_FLU, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))


#m111.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m111.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m111.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m111.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m111.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))


#m113.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m113.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m113.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m113.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m113.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m114.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m114.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m114.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m114.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m114.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m115.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m115.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m115.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m115.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m115.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))


#m119.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m119.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m119.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m119.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m119.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m121.1012_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m121.1012_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m121.1012_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m121.1012_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m121.1012_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))


#m124.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m124.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m124.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m124.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m124.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m125.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m125.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m125.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m125.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m125.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#M126_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$M126_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$M126_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$M126_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$M126_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m127.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m127.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m127.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m127.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m127.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m128.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m128.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m128.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m128.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m128.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m129.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m129.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m129.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m129.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m129.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m130.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m130.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m130.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m130.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m130.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))


#m135.1168_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m135.1168_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m135.1168_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m135.1168_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m135.1168_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m137.1325..terpenes.H....Conc.
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m137.1325..terpenes.H....Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m137.1325..terpenes.H....Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m137.1325..terpenes.H....Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m137.1325..terpenes.H....Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))


#m138.00000..nominal.138...Conc.
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m138.00000..nominal.138...Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m138.00000..nominal.138...Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m138.00000..nominal.138...Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m138.00000..nominal.138...Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m139.1481..menthol.dehydrated...Conc.
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m139.1481..menthol.dehydrated...Conc., group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m139.1481..menthol.dehydrated...Conc., group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m139.1481..menthol.dehydrated...Conc., group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m139.1481..menthol.dehydrated...Conc., group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m141.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m141.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m141.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m141.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m141.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m143.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m143.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m143.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m143.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m143.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m148.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m148.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m148.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m148.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m148.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m149.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m149.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m149.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m149.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m149.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m150.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m150.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m150.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m150.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m150.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))


#m151.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m151.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m151.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m151.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m151.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m153
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m153, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m153, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m153, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m153, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m163.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m163.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m163.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m163.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m163.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

#m204.00000_FLUX
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m204.00000_FLUX, group= factor(all_data_zeros$Sample_Sex), colour=factor(all_data_zeros$Sample_Sex)))+ geom_point()+
  scale_y_continuous(limits = c(0,.001)), group= factor(all_data_zeros$Fam..), colour=factor(all_data_zeros$Fam..)))+
  geom_point() + scale_y_continuous(limits = c(0,.0001))
ggplot(all_data_zeros, aes(all_data_zeros$Date, all_data_zeros$m204.00000_FLUX, group= factor(all_data_zeros$Clone), colour=factor(all_data_zeros$Clone)))+
  geom_point() + scale_y_continuous(limits = c(0,.00001))
ggplot(Clones_same, aes(Clones_same$Date, Clones_same$m204.00000_FLUX, group= factor(Clones_same$Sample.Name), colour=factor(Clones_same$Sample.Name)))+
  geom_point() # + scale_y_continuous(limits = c(0,.0000000001)) 
ggplot(Clones_diff, aes(Clones_diff$Date, Clones_diff$m204.00000_FLUX, group= factor(Clones_diff$Sample.Name), colour=factor(Clones_diff$Sample.Name)))+
  geom_point() #+ geom_line()#+ scale_y_continuous(limits = c(0,.00001))

### Running PCOA without averaging clones and without removing outliers.

install.packages("vegan")
install.packages("ca")

library(vegan)
library(ca)


NMDA_data <- read.csv("all_data_zeros_PCOA_scale.csv", header=TRUE)
str(NMDA_data)

## Scaling data

ZNMDS <- scale(NMDA_data)
write.csv(ZNMDS, "Scaled_VOC.csv")
ZNMDS

#################### Plotting NMDS without removing outliers

NMDS_zdata <- read.csv("all_data_zeros_PCOA.csv", header = TRUE)
labels <- read.csv("Scaled_voc.csv", header=TRUE)
## Distance Matrix
Bray <- vegdist(ZNMDS,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(labels)
ordiplot(nmdsBird,type = "n",xlim=c(-20,50), ylim=c(-10,50))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
#orditorp(nmdsBird,display="species",air=0.01,cex=1.25)
#legend(-.55, .5, labels$Fam.., cex=0.8, col = labels$Fam.., pch=15:15)


#ordihull(nmdsBird, treat, display = "si",lty=1, col="green", show.groups="Historical")
#ordihull(nmdsBird, treat,display = "si", lty=1, col= "blue", show.groups="Current")


####################################################  Removed outliers on 5/30  ##############################################

DATA_no_outliers <- read.csv("all_data_zeros_no_outliers.csv", header=TRUE)

NMDA_data_no_outliers <- read.csv("all_data_zeros_no_outliers_Missing_sample_info.csv", header=TRUE)
str(NMDA_data_no_outliers)

## Scaling data

ZNMDS <- scale(NMDA_data_no_outliers)
write.csv(ZNMDS, "Scaled_VOC_no_outliers.csv")
ZNMDS

#################### Plotting NMDS REMOVED OUTLIERS!

NMDS_zdata <- read.csv("Scaled_VOC_no_outliers_includes_Sample_info.csv", header = TRUE)
#labels <- read.csv("Scaled_voc.csv", header=TRUE)

## Distance Matrix
Bray <- vegdist(ZNMDS,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-60,300), ylim=c(-60,200))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
#orditorp(nmdsBird,display="species",air=0.01,cex=1.25)
#legend(-.55, .5, labels$Fam.., cex=0.8, col = labels$Fam.., pch=15:15)


#ordihull(nmdsBird, treat, display = "si",lty=1, col="green", show.groups="Historical")
#ordihull(nmdsBird, treat,display = "si", lty=1, col= "blue", show.groups="Current")

################################## REMOVED ALL OF 5/30 ##############################


DATA_no_outliers_5_30 <- read.csv("all_data_zeros_no_outliers_5_30.csv", header=TRUE)

NMDA_data_no_outliers <- read.csv("all_data_zeros_no_outliers_5_30_Missing_sample_info.csv", header=TRUE)

str(NMDA_data_no_outliers)

## Scaling data

ZNMDS <- scale(NMDA_data_no_outliers)
write.csv(ZNMDS, "Scaled_VOC_no_outliers_5_30.csv")
ZNMDS

#################### Plotting NMDS REMOVED OUTLIERS!

NMDS_zdata <- read.csv("Scaled_VOC_no_outliers_5_30_includes_Sample_info.csv", header = TRUE)
#labels <- read.csv("Scaled_voc.csv", header=TRUE)

## Distance Matrix
Bray <- vegdist(ZNMDS,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-100,500), ylim=c(-120,200))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)

################### REMOVING OUTLIERS USING OUTLIERD ############################ Did not work.
outliers <- read.csv("all_data_zeros_remove_outliers.csv", header = TRUE)

## INSTALLING OUTLIERD PACKAGE FROM BIOCONDUCTOR
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("OutlierD", version = "3.8")

library(OutlierDM)
library(OutlierD)

str(outliers)
outliers$m90.00000_FLUX  <- as.numeric(outliers$m90.00000_FLUX)
outliers <- na.omit(outliers)
fit1 <- odm(x=outliers[,3:93], k=3, method = "iqr", quantreg = "nonlin")

#################### Removed all VOCs with less than 70% of samples having that volatile##################################

Seventy <- read.csv("all_data_zeros_70_percent.csv", header=TRUE)
Seventy_scaled <- read.csv("all_data_zeros_70_percent_Scaled.csv", header=TRUE)



## There are not 600 0's
ggplot(Seventy, aes(x= Seventy$m39.0326..cluster..H2O.H3O._.18O....Conc.)) + geom_histogram(bins = 50)
ggplot(Seventy, aes(x= Seventy$m41.0375_FLUX)) + geom_histogram(bins = 50)
ggplot(Seventy, aes(x= Seventy$m45.0335_FLUX)) + geom_histogram(bins = 50)


scaled_seventy <- scale(Seventy_scaled)
write.csv(scaled_seventy,"Scaled_Seventy_percent.csv")

Bray <- vegdist(scaled_seventy,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-2,3), ylim=c(-2,3))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
orditorp(nmdsBird,display="species",col=labels$Fam.., air=0.01,cex=.75)

plot(nmdsBird,xlim=c(-1,2), ylim=c(-1,2))

####  Combining all replicates into single individuals #############

data <- aggregate(Seventy, by= list(Seventy$Sample.0me, Seventy$Fam..), mean )
write.csv(data, "Family_70.csv")
Seventy_clones_combined <- read.csv("Family_70_scaled.csv", header=TRUE)
Seventy_clones <- read.csv("Family_70.csv", header=TRUE)

scale_seventy <- scale(Seventy_clones_combined)

Bray <- vegdist(scale_seventy,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-10,100), ylim=c(-20,80))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
#orditorp(nmdsBird,display="species",col=labels$Fam.., air=0.01,cex=.75)

plot(nmdsBird)

#### Aggregate by entire family

data <- aggregate(Seventy_clones, by=list(Seventy_clones$Fam.., Seventy_clones$Fam..), FUN=mean)
write.csv(data, "Seventy_Family_combined.csv")
Seventy_family <- read.csv("Seventy_Family_combined.csv", header=TRUE)

scale_seventy_family <- scale(Seventy_family)

Bray <- vegdist(scale_seventy_family,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-20,100), ylim=c(-20,40))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
#orditorp(nmdsBird,display="species",col=labels$Fam.., air=0.01,cex=.75)

plot(nmdsBird)

########################################## NMDS using 80's #################################
Eighty_no <- read.csv("all_data_zeros_80_no_factors.csv", header = TRUE)
Eighty <- read.csv("all_data_zeros_80.csv", header = TRUE)


scale_eighty <- scale(Eighty_no)

Bray <- vegdist(scale_eighty,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)

plot(nmdsBird)
treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-20,200), ylim=c(-20,60))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)

## Combining all replicates into single individuals
str(Eighty)
Eighty$Clone <- as.factor(Eighty$Clone)
data <- aggregate(Eighty, by= list(Eighty$Sample..0me, Eighty$Fam..), mean )
write.csv(data, "Family_80.csv")
Eighty_clones_combined <- read.csv("Family_80_2_scaled.csv", header=TRUE)
Eighty_clones <- read.csv("Family_80_2.csv", header=TRUE)

scale_Eighty <- scale(Eighty_clones_combined)

Bray <- vegdist(scale_Eighty,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-20,100), ylim=c(-20,40))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
#orditorp(nmdsBird,display="species",col=labels$Fam.., air=0.01,cex=.75)

plot(nmdsBird)

## Aggregating by family

data <- aggregate(Eighty_clones, by=list(Eighty_clones$Fam.., Eighty_clones$Fam..), FUN=mean)
write.csv(data, "Eighty_Family_combined.csv")
Eighty_family <- read.csv("Eighty_Family_combined.csv", header=TRUE)

scale_eighty_family <- scale(Eighty_family)

Bray <- vegdist(scale_eighty_family,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-50,100), ylim=c(-10,40))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
#orditorp(nmdsBird,display="species",col=labels$Fam.., air=0.01,cex=.75)

plot(nmdsBird)


########################################## NMDS using 50's #################################
Fifty_no <- read.csv("all_data_zeros_50_no_factors.csv", header = TRUE)


Fifty <- read.csv("all_data_zeros_50.csv", header = TRUE)


scale_fifty <- scale(Fifty_no)

Bray <- vegdist(scale_fifty,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)

plot(nmdsBird)
treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-2,1), ylim=c(-1,1))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)

## Combining all replicates into single individuals

data <- aggregate(Fifty, by= list(Fifty$Sample.0me, Fifty$Fam..), mean )
write.csv(data, "Family_50.csv")
Fifty_clones_combined <- read.csv("Family_50_scaled.csv", header=TRUE)
Fifty_clones <- read.csv("Family_50.csv", header=TRUE)

scale_Fifty <- scale(Fifty_clones_combined)

Bray <- vegdist(scale_Fifty,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-20,200), ylim=c(-20,40))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
#orditorp(nmdsBird,display="species",col=labels$Fam.., air=0.01,cex=.75)

plot(nmdsBird)

## Aggregating by family

data <- aggregate(Fifty_clones, by=list(Fifty_clones$Fam.., Fifty_clones$Fam..), FUN=mean)
write.csv(data, "Fifty_Family_combined.csv")
Fifty_family <- read.csv("Fifty_Family_combined.csv", header=TRUE)

scale_fifty_family <- scale(Fifty_family)

Bray <- vegdist(scale_fifty_family,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-50,100), ylim=c(-10,50))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)


write.csv(all_data_zeros, "all_data_zeros_2.csv")

################# Volatiles produce at least 40% #######################

Forty <- read.csv("all_data_zeros_40.csv", header = TRUE)


Forty_no <- read.csv("all_data_zeros_40_no_factors.csv", header = TRUE)
str(Forty_no)
Forty_no$m111.00000_FLUX <- as.numeric(Forty_no$m111.00000_FLUX)

scale_forty <- scale(Forty_no)

Bray <- vegdist(scale_forty,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)

plot(nmdsBird)
treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-4,0), ylim=c(-1,2))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)

## Combining all replicates into single individuals

data <- aggregate(Forty, by= list(Forty$Sample.Name, Forty$Fam..), mean )
write.csv(data, "Family_40.csv")
Forty_clones_combined <- read.csv("Family_40_scaled.csv", header=TRUE)
Forty_clones <- read.csv("Family_40.csv", header=TRUE)
str(Forty_clones_combined)

Forty_clones_combined$m111.00000_FLUX <- as.numeric(Forty_clones_combined$m111.00000_FLUX)
Forty_clones_combined$m79.05478..benzene.H....Conc.2 <- as.numeric(Forty_clones_combined$m79.05478..benzene.H....Conc.2)


scale_Forty <- scale(Forty_clones_combined)

Bray <- vegdist(scale_Forty,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-20,200), ylim=c(-10,90))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
#orditorp(nmdsBird,display="species",col=labels$Fam.., air=0.01,cex=.75)

plot(nmdsBird)

## Aggregating by family

data <- aggregate(Forty_clones, by=list(Forty_clones$Fam.., Forty_clones$Fam..), FUN=mean)
write.csv(data, "Forty_Family_combined.csv")
Forty_family <- read.csv("Forty_Family_combined.csv", header=TRUE)

scale_forty_family <- scale(Forty_family)

Bray <- vegdist(scale_forty_family,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)

plot(nmdsBird)
treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-60,175), ylim=c(-20,100))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)



################## Volatiles with 30% of samples producing #######################


Thirty <- read.csv("all_data_zeros_30.csv", header = TRUE)


Thirty_no <- read.csv("all_data_zeros_30_no_factors.csv", header = TRUE) 
str(Thirty_no)
Thirty_no$m111.00000_FLUX <- as.numeric(Thirty_no$m111.00000_FLUX)

scale_Thirty <- scale(Thirty_no)

Bray <- vegdist(scale_Thirty,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)

plot(nmdsBird)
treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-4,2), ylim=c(-2,2))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)

## Combining all replicates into single individuals

data <- aggregate(Thirty, by= list(Thirty$Sample.Name, Thirty$Fam..), mean )
write.csv(data, "Family_30.csv")
Thirty_clones_combined <- read.csv("Family_30_scaled.csv", header=TRUE)
Thirty_clones <- read.csv("Family_30.csv", header=TRUE)
str(Thirty_clones_combined)

Thirty_clones_combined$m111.00000_FLUX <- as.numeric(Forty_clones_combined$m111.00000_FLUX)
Thirty_clones_combined$m79.05478..benzene.H....Conc.2 <- as.numeric(Forty_clones_combined$m79.05478..benzene.H....Conc.2)


scale_Thirty <- scale(Thirty_clones_combined)

Bray <- vegdist(scale_Thirty,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-10,200), ylim=c(-200,150))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
#orditorp(nmdsBird,display="species",col=labels$Fam.., air=0.01,cex=.75)

plot(nmdsBird)

## Aggregating by family

data <- aggregate(Thirty_clones, by=list(Thirty_clones$Fam, Thirty_clones$Fam), FUN=mean)
write.csv(data, "Thirty_Family_combined.csv")
Thirty_family <- read.csv("Thirty_Family_combined.csv", header=TRUE)

scale_thirty_family <- scale(Thirty_family)

Bray <- vegdist(scale_thirty_family,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)

plot(nmdsBird)
treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-50,175), ylim=c(-20,50))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)


######################### Volatiles produces more than 20% ######################

Twenty <- read.csv("all_data_zeros_20.csv", header = TRUE)


Twenty_no <- read.csv("all_data_zeros_20_no_factors.csv", header = TRUE) 
str(Twenty_no)
Twenty_no$m111.00000_FLUX <- as.numeric(Twenty_no$m111.00000_FLUX)

scale_Twenty <- scale(Twenty_no)

Bray <- vegdist(scale_Twenty,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)

plot(nmdsBird)
treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-4,10), ylim=c(-2,10))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)

## Combining all replicates into single individuals

data <- aggregate(Twenty, by= list(Twenty$Sample.Name, Twenty$Fam..), mean )
write.csv(data, "Family_20.csv")
Twenty_clones_combined <- read.csv("Family_20_scaled.csv", header=TRUE)
Twenty_clones <- read.csv("Family_20.csv", header=TRUE)
str(Twenty_clones_combined)

Twenty_clones_combined$m111.00000_FLUX <- as.numeric(Twenty_clones_combined$m111.00000_FLUX)
Twenty_clones_combined$m79.05478..benzene.H....Conc.2 <- as.numeric(Twenty_clones_combined$m79.05478..benzene.H....Conc.2)


scale_Twenty <- scale(Twenty_clones_combined)

Bray <- vegdist(scale_Twenty,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-50,410), ylim=c(-200,100))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
#orditorp(nmdsBird,display="species",col=labels$Fam.., air=0.01,cex=.75)

plot(nmdsBird)

## Aggregating by family

data <- aggregate(Twenty_clones, by=list(Twenty_clones$Fam, Twenty_clones$Fam), FUN=mean)
write.csv(data, "Twenty_Family_combined.csv")
Twenty_family <- read.csv("Twenty_Family_combined.csv", header=TRUE)

scale_twenty_family <- scale(Twenty_family)

Bray <- vegdist(scale_twenty_family,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)

plot(nmdsBird)
treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-50,200), ylim=c(-50,150))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)

######################### Volatiles produces more than 10% ######################

ten <- read.csv("all_data_zeros_10_NMDS_2_males.csv", header = TRUE)

str(ten)
ten$Fam.. <- as.factor(ten$Fam..)
ten$m111.00000_FLUX <- as.numeric(ten$m111.00000_FLUX)
ten$Length.leaf.C..mm.  <- as.numeric(ten$Length.leaf.C..mm. )

ten_no <- read.csv("all_data_zeros_10_no_factors.csv", header = TRUE) 
str(ten_no)
ten_no$m111.00000_FLUX <- as.numeric(ten_no$m111.00000_FLUX)

#scale_Ten <- scale(ten_no)

Bray <- vegdist(scale_Ten,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)

plot(nmdsBird)
treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-40,700), ylim=c(-2,100))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)

## Combining all replicates into single individuals

data <- aggregate(ten, by= list(ten$Sample.Name, ten$Fam..), mean )
write.csv(data, "Family_10_male_no_30.csv")
Ten_clones_combined <- read.csv("Ten_Family_combined_no_30.csv", header=TRUE)
Ten_clones <- read.csv("Family_10_female_no_30.csv", header=TRUE)
str(Ten_clones_combined)

Ten_clones_combined$m111.00000_FLUX <- as.numeric(Ten_clones_combined$m111.00000_FLUX)
Ten_clones_combined$m79.05478..benzene.H....Conc.2 <- as.numeric(Ten_clones_combined$m79.05478..benzene.H....Conc.2)


scale_Ten <- scale(Ten_clones_combined)

Bray <- vegdist(scale_Ten,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)


treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-50,500), ylim=c(-200,200))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)
#orditorp(nmdsBird,display="species",col=labels$Fam.., air=0.01,cex=.75)

plot(nmdsBird)

## Aggregating by family

data <- aggregate(Ten_clones_combined, by=list(Ten_clones_combined$Fam.., Ten_clones_combined$Fam..), FUN=mean)
write.csv(data, "Ten_Family_combined_no_30.csv")
Ten_family <- read.csv("Ten_Family_combined_2.csv", header=TRUE)

scale_ten_family <- scale(Ten_family)

Bray <- vegdist(scale_ten_family,"manhattan")

nmdsBird <- metaMDS(Bray,K=2,trace = T)

stressplot(nmdsBird)

plot(nmdsBird)
treat=as.matrix(NMDS_zdata)
ordiplot(nmdsBird,type = "n",xlim=c(-50,200), ylim=c(-200,200))
orditorp(nmdsBird,display="sites",col=labels$Fam.., air=0.01,cex=.75)

########### Correlation ################
########### Histograms #################
hist(Ten_family$m30.99783_FLUX)
hist(Eighty_family$m39.0326..cluster..H2O.H3O._.18O....Conc.)
