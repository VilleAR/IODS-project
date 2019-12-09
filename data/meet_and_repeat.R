BPRS<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header=T)
RATS<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header=T)
write.csv(BPRS, "BPRS.csv")
write.csv(RATS, "RATS.csv")
library(dplyr)
library(tidyr)
summary(BPRS)
str(BPRS)
summary(RATS)
str(RATS)
#BPRS follows the development of a number of test subjects over 8 weeks of one of two treatments
#RATS appears to follow the progression of variable "WD" across different test groups
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID<-factor(RATS$ID)
RATS$Group<-factor(RATS$Group)
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5, 5)))
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3, 4)))
summary(BPRSL)
str(BPRSL)
summary(RATSL)
str(RATSL)
#The long form data has turned the data into a list of every single subject on every week/WD i.e. it has increased length but decreased width.
#The new weeks variable indicates which week the subject's bprs value is for, and time indicates when the weight of the rats was measured.
write.csv(BPRSL, "BPRSL.csv")
write.csv(RATSL, "RATSL.csv")

