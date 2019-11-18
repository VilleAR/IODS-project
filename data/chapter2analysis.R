library(dplyr)
library(GGally)
library(ggplot2)

data<-read.csv("analysis.csv")
data <- data[c("data.gender", "age", "attitude", "data.deep", "data.stra", "data.surf", "points")]
dim(data)
str(data)
#This dataset is a list of exam results. Showed are average points from each category, points total, age, gender and attitude score
#Exploring relationships between variables
pairs(data[-6], col=data$data.gender)
p<-ggpairs(data, mapping=aes(col=data.gender), lower=list(combo = wrap("facethist", bins=20)))
p
p1<-ggplot(data, aes(x=data.gender, y=points, col=data.gender))
p2<-p1+geom_point()
p3<-p2+geom_smooth(method="lm")
p4<-p3+ggtitle("Attitude vs points")
p4
my_model<-lm(points ~ attitude+data.stra+data.surf, data=data)
ww<-c(1,2,5)
par(mfrow=c(2,2))
plot(my_model, which=ww)
