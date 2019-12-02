hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

library(stringr)
library(tidyr)
library(dplyr)
summary(gii)
str(gii)
summary(hd)
str(hd)
names(gii)[3]="GII"
names(gii)[7]="edu2f"
names(gii)[8]="edu2m"
names(gii)[9]="labf"
names(gii)[10]="labm"
names(hd)[3]="HDI"
names(hd)[4]="LifeE"
names(hd)[7]="GNIpC"
names(hd)[8]="GNIpC-HDI"
names(hd)[6]="eduyearsmeans"
names(hd)[5] = "eduyearsexpect"
gii<-mutate(gii, eduratioFM = edu2f/edu2m)
gii<-mutate(gii, labratioFM=labf/labm)
human<-inner_join(hd, gii, by="Country", suffix=c("hd,", "gii"))         
write.csv(human, file="Human.csv")
str(human)
dim(human)
#human is a dataset that combines data from the Gender Inequality Index and Human Development Index.
#The variables include maternal mortality ratio, 2nd level education percentage(edu) and ratio, employment
#percentage(lab) and ratio, life expentacy, gender representation in parliament, GII Rank
#and Gross National Income per capita minus HDI rating(GNIpC-HDI)
human$GNIpC<-str_replace(human$GNIpC, pattern=",", replace="")%>%as.numeric()
keep<-c("Country", "LifeE", "eduyearsexpect", "GNIpC", "Maternal.Mortality.Ratio", "Adolescent.Birth.Rate", "Percent.Representation.in.Parliament", "eduratioFM", "labratioFM")
human<-dplyr::select(human, one_of(keep))
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human_ <- filter(human, complete.cases(human))
n<-dim(human_)[1]
human_<-human_[1:(n-7),]
#Using the exact same code as in the DataCamp exercises gave me a totally different result here so I had to use this method.
rownames(human_) <- human_$Country
human<-human_
human_ <- dplyr::select(human, -Country)
write.csv(human_, "Human.csv", rownames=T)
