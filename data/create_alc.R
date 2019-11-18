#Ville Puurunen 18/11/2019 Week 3 of IODS
#Data from https://archive.ics.uci.edu/ml/datasets/Student+Performance
library(dplyr)
library(ggplot2)
math<-read.table("student-mat.csv", header=T, sep=";")
dim(math)
str(math)
por<-read.table("student-por.csv", header=T, sep=";")
dim(por)
str(por)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
mapo <- inner_join(math, por, by = join_by, suffix=c(".math", ".por"))
dim(mapo)
str(mapo)
alc <- select(mapo, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]
for(column_name in notjoined_columns) {
  two_columns<- select(mapo, starts_with(column_name))
  first_column<- select(two_columns, 1)[[1]]
  if (is.numeric(first_column)) {
    alc[column_name]<- round(rowMeans(two_columns))
  } else{
    alc[column_name]<- first_column
    
  }
}
glimpse(alc)
dim(alc) 
alc<-mutate(alc, alc_use=(Dalc+Walc)/2)
alc<-mutate(alc, high_use=alc_use>2) 
glimpse(alc)
dim(alc)
write.csv(alc, "alc.csv", row.names=F)

