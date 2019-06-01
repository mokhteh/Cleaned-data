---
title: "R Notebook"
output: html_notebook
---

Codebook 
=================
  The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


For each record it is provided:
  ======================================
  
  - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
""
"These signals were used to estimate variables of the feature vector for each pattern:  "
"'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions."
""
"timeBodyAccelerometer-XYZ"
"timeGravityAccelerometer-XYZ"
"timeBodyAccelerometerJerk-XYZ"
"timeBodyGyroscope-XYZ"
"timeBodyGyroscopeJerk-XYZ"
"timeBodyAccelerometerMagnitude"
"timeGravityAccelerometerMagnitude"
"timeBodyAccelerometerJerkMagnitude"
"timeBodyGyroscopeMagnitude"
"timeBodyGyroscopeJerkMagnitude"
"frequencyBodyAccelerometer-XYZ"
"frequencyBodyAccelerometerJerk-XYZ"
"frequencyBodyGyroscope-XYZ"
"frequencyBodyAccelerometerMagnitude"
"frequencyBodyAccelerometerJerkMagnitude"
"frequencyBodyGyroscopeMagnitude"
"frequencyBodyGyroscopeJerkMagnitude"
""
"The set of variables that were estimated from these signals are: "
""
"mean(): Mean value"
"std(): Standard deviation"
"mad(): Median absolute deviation "
"max(): Largest value in array"
"min(): Smallest value in array"
"sma(): Signal magnitude area"
"energy(): Energy measure. Sum of the squares divided by the number of values. "
"iqr(): Interquartile range "
"entropy(): Signal entropy"
"arCoeff(): Autorregresion coefficients with Burg order equal to 4"
"correlation(): correlation coefficient between two signals"
"maxInds(): index of the frequency component with largest magnitude"
"meanFreq(): Weighted average of the frequency components to obtain a mean frequency"
"skewness(): skewness of the frequency domain signal "
"kurtosis(): kurtosis of the frequency domain signal "
"bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window."
"angle(): Angle between to vectors."

```{r}
library(dplyr)
# Downlaoding, unziping and monitor the files in the directory
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip")
unzip("data.zip")
setwd("UCI HAR Dataset")
dir()

```


```{r}
#Reading train and test data for activity, subject and features.
train <- read.table("./train/X_train.txt")
test <- read.table("./test/X_test.txt")

act_train <- read.table("./train/y_train.txt")
act_test <- read.table("./test/y_test.txt")

sub_train <- read.table("./train/subject_train.txt")
sub_test <- read.table("./test/subject_test.txt")
```


```{r}
#Cmbining test and train sets to get the whole data
dt<-rbind(test,train)
act_dt<-rbind(act_test,act_train)
sub_dt<-rbind(sub_test,sub_train)
```


```{r}

#Gettingthe actual features names and assign to attributes names.
feat_names <- read.table("features.txt")
head(feat_names)
names(dt) <- feat_names$V2

#Setting appropriate names to activity and subject attributes.
names(act_dt)<-"activity"
names(sub_dt)<-"subject"

```


```{r}
#Adding activity and subject columns to data
comb1<-cbind(dt, act_dt)
data_fin<-cbind(comb1, sub_dt)

#Finding features related to mean and std and make them as factors to be grouped later.
feat_codebook<-feat_names$V2[grep("mean\\(\\)|std\\(\\)", feat_names$V2)]
feat_need<-c(as.character(feat_codebook),"subject","activity")
data_fin$activity<-factor(data_fin$activity)
data_fin$subject<-factor(data_fin$subject)
```


```{r}
#Subseting the desired features related to mean and std
codebook <- subset(data_fin, select=feat_need)
dim(codebook)
str(codebook)
```


```{r}
#Reading activity labels and assigning to rows in activity column.
act_lab <- read.table("activity_labels.txt")
codebook$activity<-as.character(act_lab$V2[codebook$activity])

#Substitute feature names with complete names.
names(codebook)<-gsub("^t","time",names(codebook))
names(codebook)<-gsub("^f","frequency",names(codebook))
names(codebook)<-gsub("Acc","Accelerometer",names(codebook))
names(codebook)<-gsub("Gyro","Gyroscope",names(codebook))
names(codebook)<-gsub("Mag","Magnitude",names(codebook))
names(codebook)<-gsub("BodyBody", "Body",names(codebook))

#Check for the change
names(codebook)
```


```{r}
#Applying mean function to grouped subject and activity observations.
avg_data<-aggregate(.~subject+activity, codebook, mean)
#Ordering the whole table based on subject and activity.
avg_data<-avg_data[order(avg_data$subject,avg_data$activity),]
#Writing the tidy data to the directory.
write.table(avg_data, file = "tidy.txt",row.name=FALSE)

#Reading the data and check for proper format.
tidy <- read.table("tidy.txt", header = T)
tidy[1:4,1:4]
str(tidy)
```
