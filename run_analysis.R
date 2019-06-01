library(dplyr)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip")
unzip("data.zip")
setwd("UCI HAR Dataset")
dir()

train <- read.table("./train/X_train.txt")
test <- read.table("./test/X_test.txt")

act_train <- read.table("./train/y_train.txt")
act_test <- read.table("./test/y_test.txt")

sub_train <- read.table("./train/subject_train.txt")
sub_test <- read.table("./test/subject_test.txt")

dt<-rbind(test,train)
act_dt<-rbind(act_test,act_train)
sub_dt<-rbind(sub_test,sub_train)

feat_names <- read.table("features.txt")
head(feat_names)

names(dt) <- feat_names$V2
names(act_dt)<-"activity"
names(sub_dt)<-"subject"

comb1<-cbind(dt, act_dt)
data_fin<-cbind(comb1, sub_dt)

feat_codebook<-feat_names$V2[grep("mean\\(\\)|std\\(\\)", feat_names$V2)]
feat_need<-c(as.character(feat_codebook),"subject","activity")
data_fin$activity<-factor(data_fin$activity)
data_fin$subject<-factor(data_fin$subject)

codebook <- subset(data_fin, select=feat_need)
dim(codebook)
str(codebook)

act_lab <- read.table("activity_labels.txt")
codebook$activity<-as.character(act_lab$V2[codebook$activity])

names(codebook)<-gsub("^t","time",names(codebook))
names(codebook)<-gsub("^f","frequency",names(codebook))
names(codebook)<-gsub("Acc","Accelerometer",names(codebook))
names(codebook)<-gsub("Gyro","Gyroscope",names(codebook))
names(codebook)<-gsub("Mag","Magnitude",names(codebook))
names(codebook)<-gsub("BodyBody", "Body",names(codebook))
names(codebook)


avg_data<-aggregate(.~subject+activity, codebook, mean)
avg_data<-avg_data[order(avg_data$subject,avg_data$activity),]
write.table(avg_data, file = "tidy.txt",row.name=FALSE)

tidy <- read.table("tidy.txt", header = T)
tidy[1:4,1:4]
