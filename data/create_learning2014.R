#Ville Puurunen 18/11/2019
#File for 2nd week of IODS
library(dplyr)
library(GGally)
library(ggplot2)
data<-read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", header=TRUE, sep="\t")
dim(data) #183 rows and 60 columns
str(data) #Data seems to be about finding a correlation between attitude and points
dim(data)
data$age<-rowMeans(age_columns)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
deep_columns<-select(data, one_of(deep_questions))
data$deep<-rowMeans(deep_columns)
surface_columns<-select(data, one_of(surface_questions))
data$surf<-rowMeans(surface_columns)
strategic_columns<-select(data,one_of(strategic_questions))
data$stra<-rowMeans(strategic_columns)
analysis<-data.frame(data$stra, data$surf, data$deep, data$Points, data$Age, data$gender, data$Attitude)
colnames(analysis)[4]<-"points"
colnames(analysis)[5]<-"age"
colnames(analysis)[7]<-"attitude"
analysis<-filter(analysis, points>0)
dim(analysis)
setwd("D:/Small programs/RStudio/IODS/IODS-project/data")
write.csv(analysis, file="analysis.csv", row.names=F)
bb<-read.csv("analysis.csv") 
str(bb)
head(bb)


