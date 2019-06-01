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

timeBodyAccelerometer-XYZ

timeGravityAccelerometer-XYZ

timeBodyAccelerometerJerk-XYZ

timeBodyGyroscope-XYZ

timeBodyGyroscopeJerk-XYZ

timeBodyAccelerometerMagnitude

timeGravityAccelerometerMagnitude

timeBodyAccelerometerJerkMagnitude

timeBodyGyroscopeMagnitude

timeBodyGyroscopeJerkMagnitude

frequencyBodyAccelerometer-XYZ

frequencyBodyAccelerometerJerk-XYZ

frequencyBodyGyroscope-XYZ

frequencyBodyAccelerometerMagnitude

frequencyBodyAccelerometerJerkMagnitude

frequencyBodyGyroscopeMagnitude

frequencyBodyGyroscopeJerkMagnitude

The set of variables that were estimated from these signals are:

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values.
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window
angle(): Angle between to vectors.


Units for "subject" and "activity" is factor and int for all the rest.
