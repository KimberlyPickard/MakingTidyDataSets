##
## run_analysis.R
##
## author: Kimberly Pickard
## date:   12/24/2020
##
## Peer-graded Assignment: Getting and Cleaning Data Course Project
##
## ---------------------------------------------------------------------------------
##
## This R script does the following:
## 
## 1. Merges the training and the test sets to create one data set.
##
## 2. Extracts only the measurements on the mean and standard deviation 
##         for each measurement.
##
## 3. Uses descriptive activity names to name the activities in the data 
##         set.
##
## 4. Appropriately labels the data set with descriptive variable names. 
##
## 5. From the data set in step 4, creates a second, independent tidy 
##         data set with the average of each variable for each activity and 
##         each subject.
##
## The data set used for this project is located:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
###########################################################################
# 
#
#setwd("/users/kimberlypickard/Desktop/JohnHopkins/JohnHopkins R Projects/C3_Getting&CleaningData/MakingTidyData Orig")
print("Loading libraries..")
library(dplyr)
library(matrixStats)

###########################################################################
## Step 1: Load the 25 files from the UCI HAR Dataset.
##  
##
############################################################################
print("**Step 1: Loading the files from the UCI HAR Dataset**")

DATA_DIR = "./data/"

if (!file.exists("data")) {
    print("Creating data directory")
    dir.create("data")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zipfile = "./data/getdata_projectfiles_UCI HAR Dataset.zip"
    print("Downloading data files:")
    download.file(fileUrl, destfile = zipfile, method = "curl")
    print("Unzipping data files:")
    unzip(zipfile, exdir = "./data")
    print("Data ready...")
}



## BodyAccXTest DF consists of V1 to V128 with dim 2947x128
## BodyAccYTest DF consists of V1 to V128 with dim 2947x128
## BodyAccZTest DF consists of V1 to V128 with dim 2947x128
## BodyGyroXTest DF consists of V1 to V128 with dim 2947x128
## BodyGyroYTest DF consists of V1 to V128 with dim 2947x128
## BodyGyroZTest DF consists of V1 to V128 with dim 2947x128
## TotalAccXTest DF consists of V1 to V128 with dim 2947x128
## TotalAccYTest DF consists of V1 to V128 with dim 2947x128
## TotalAccZTest DF consists of V1 to V128 with dim 2947x128
BodyAccXTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt",sep = ""), 
                           header = FALSE, sep = "", dec = ".")
BodyAccYTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt",sep = ""), 
                           header = FALSE, sep = "", dec = ".")
BodyAccZTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt",sep = ""), 
                           header = FALSE, sep = "", dec = ".")
BodyGyroXTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt",sep = ""), 
                            header = FALSE, sep = "", dec = ".")
BodyGyroYTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt",sep = ""), 
                            header = FALSE, sep = "", dec = ".")
BodyGyroZTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt",sep = ""), 
                            header = FALSE, sep = "", dec = ".")
TotalAccXTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt",sep = ""), 
                           header = FALSE, sep = "", dec = ".")
TotalAccYTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt",sep = ""), 
                            header = FALSE, sep = "", dec = ".")
TotalAccZTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt",sep = ""), 
                            header = FALSE, sep = "", dec = ".")

## BodyAccXTrain DF consists of V1 to V128 with dim 7352x128
## BodyAccYTrain DF consists of V1 to V128 with dim 7352x128
## BodyAccZTrain DF consists of V1 to V128 with dim 7352x128
## BodyGyroXTrain DF consists of V1 to V128 with dim 7352x128
## BodyGyroYTrain DF consists of V1 to V128 with dim 7352x128
## BodyGyroZTrain DF consists of V1 to V128 with dim 7352x128
## TotalAccXTrain DF consists of V1 to V128 with dim 7352x128
## TotalAccYTrain DF consists of V1 to V128 with dim 7352x128
## TotalAccZTrain DF consists of V1 to V128 with dim 7352x128
BodyAccXTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt",sep = ""), 
                           header = FALSE, sep = "", dec = ".")
BodyAccYTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt",sep = ""), 
                           header = FALSE, sep = "", dec = ".")
BodyAccZTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt",sep = ""), 
                           header = FALSE, sep = "", dec = ".")
BodyGyroXTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt",sep = ""), 
                            header = FALSE, sep = "", dec = ".")
BodyGyroYTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt",sep = ""), 
                            header = FALSE, sep = "", dec = ".")
BodyGyroZTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt",sep = ""), 
                            header = FALSE, sep = "", dec = ".")
TotalAccXTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt",sep = ""), 
                            header = FALSE, sep = "", dec = ".")
TotalAccYTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt",sep = ""), 
                            header = FALSE, sep = "", dec = ".")
TotalAccZTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt",sep = ""), 
                            header = FALSE, sep = "", dec = ".")

##
## subjectTest DF consists of one array with dim 2947, identifying subjects
## 2 through 24.
subjectTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/subject_test.txt",sep = ""), 
                             header = FALSE, sep = "", dec = ".")

## XTest DF consists of V1 to V561 with dim 2947x561
XTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/X_test.txt",sep = ""), 
                             header = FALSE, sep = "", dec = ".")

## yTest DF consists of one array with dim 2947, with values from 1 to 6
## identifying  - 1 WALKING
##              - 2 WALKING_UPSTAIRS
##              - 3 WALKING_DOWNSTAIRS
##              - 4 SITTING
##              - 5 STANDING
##              - 6 LAYING

yTest <- read.table(paste(DATA_DIR,"UCI HAR Dataset/test/y_test.txt",sep = ""), 
                     header = FALSE, sep = "", dec = ".")

##
## subjectTrain DF consists of one array with dim 7352, identifying subjects
## 1 through 30.
subjectTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/subject_train.txt",sep = ""), 
                           header = FALSE, sep = "", dec = ".")

## XTrain DF consists of V1 to V561 with dim 7352x561(features)
XTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/X_train.txt",sep = ""), 
                     header = FALSE, sep = "", dec = ".")

## yTrain DF consists of one array with dim 7352, with values from 1 to 6
## identifying  - 1 WALKING
##              - 2 WALKING_UPSTAIRS
##              - 3 WALKING_DOWNSTAIRS
##              - 4 SITTING
##              - 5 STANDING
##              - 6 LAYING

yTrain <- read.table(paste(DATA_DIR,"UCI HAR Dataset/train/y_train.txt",sep = ""), 
                     header = FALSE, sep = "", dec = ".")


##
## featureLabels DF is 2-dim array with dim 561x2, so that
## we can identify the correct feature label by its index
## The first column consists of integers 1:561
## The second column is a character string.
##
## example: 530 is associated with "fBodyBodyGyroMag-std()"
##      and 532 is associated with "fBodyBodyGyroMag-max()"
##
featureLabels <- read.table(paste(DATA_DIR,"UCI HAR Dataset/features.txt",sep = ""), 
                           header = FALSE, sep = "", dec = ".")


###########################################################################
## Step 2: 
##
##  Define our column names for our new TidyData data frame.
##  We have 581 column names.
##
############################################################################
print("**Step 2: Creating the column names for the Tidy Data Set**")
goodColNames <- append( c("Subject",               #subjectTest and subjectTrain
                          "Activity",              #yTest and yTrain
                          "BodyAccXMean",  "BodyAccYMean",  "BodyAccZMean",   
                          "BodyGyroXMean", "BodyGyroYMean", "BodyGyroZMean",
                          "TotalAccXMean", "TotalAccYMean", "TotalAccZMean",
                          "BodyAccXSD",    "BodyAccYSD",    "BodyAccZSD",
                          "BodyGyroXSD",   "BodyGyroYSD",   "BodyGyroZSD",
                          "TotalAccXSD",   "TotalAccYSD",   "TotalAccZSD"),
                        paste(featureLabels[,1],featureLabels[,2]))         #XTest and XTrain

###########################################################################
## Step 3 (Test): 
##
##  Compute the mean and standard deviation for each line in [Body Total][Acc Gyro][Test Train] files to find:
##
##	BodyAccXTestMean    and  BodyAccXTestSD
##	BodyAccYTestMean    and  BodyAccYTestSD
##	BodyAccZTestMean    and  BodyAccZTestSD
##	BodyGyroXTestMean and  BodyGyroXTestSD
##	BodyGyroYTestMean and  BodyGyroYTestSD
##	BodyGyroZTestMean and  BodyGyroZTestSD
##	TotalAccXTestMean   and  TotalAccXTestSD
##	TotalAccYTestMean   and  TotalAccYTestSD
##	TotalAccZTestMean   and  TotalAccZTestSD
##
##  Each of these variables contain vector of length 2947.
##
############################################################################
print("**Step 3: Finding the mean and standard deviations for the test Inertial Signal data.**")


BodyAccXTestMean =  rowMeans(BodyAccXTest)
BodyAccYTestMean =  rowMeans(BodyAccYTest)
BodyAccZTestMean =  rowMeans(BodyAccZTest)
BodyGyroXTestMean = rowMeans(BodyGyroXTest)
BodyGyroYTestMean = rowMeans(BodyGyroYTest)
BodyGyroZTestMean = rowMeans(BodyGyroZTest)
TotalAccXTestMean = rowMeans(TotalAccXTest)
TotalAccYTestMean = rowMeans(TotalAccYTest)
TotalAccZTestMean = rowMeans(TotalAccZTest)

BodyAccXTestSD =  rowSds(as.matrix(BodyAccXTest),  na.rm=TRUE)
BodyAccYTestSD =  rowSds(as.matrix(BodyAccYTest),  na.rm=TRUE)
BodyAccZTestSD =  rowSds(as.matrix(BodyAccZTest),  na.rm=TRUE)
BodyGyroXTestSD = rowSds(as.matrix(BodyGyroXTest), na.rm=TRUE)
BodyGyroYTestSD = rowSds(as.matrix(BodyGyroYTest), na.rm=TRUE)
BodyGyroZTestSD = rowSds(as.matrix(BodyGyroZTest), na.rm=TRUE)
TotalAccXTestSD = rowSds(as.matrix(TotalAccXTest), na.rm=TRUE)
TotalAccYTestSD = rowSds(as.matrix(TotalAccYTest), na.rm=TRUE)
TotalAccZTestSD = rowSds(as.matrix(TotalAccZTest), na.rm=TRUE)

#########################################################################
## Step 4 (Train): 
##
##  Compute the mean and standard deviation for each line in [Body Total][Acc Gyro]Train files to find:
##
##	BodyAccXTrainMean    and  BodyAccXTrainSD
##	BodyAccYTrainMean    and  BodyAccYTrainSD
##	BodyAccZTrainMean    and  BodyAccZTrainSD
##	BodyGyroXTrainMean   and  BodyGyroXTrainSD
##	BodyGyroYTrainMean   and  BodyGyroYTrainSD
##	BodyGyroZTrainMean   and  BodyGyroZTrainSD
##	TotalAccXTrainMean   and  TotalAccXTrainSD
##	TotalAccYTrainMean   and  TotalAccYTrainSD
##	TotalAccZTrainMean   and  TotalAccZTrainSD
##
##  Each of these variables contain vector of length 7352.
##
############################################################################
print("**Step4: Finding the mean and standard deviations for the train Inertial Signal data.**")
BodyAccXTrainMean =  rowMeans(BodyAccXTrain)
BodyAccYTrainMean =  rowMeans(BodyAccYTrain)
BodyAccZTrainMean =  rowMeans(BodyAccZTrain)
BodyGyroXTrainMean = rowMeans(BodyGyroXTrain)
BodyGyroYTrainMean = rowMeans(BodyGyroYTrain)
BodyGyroZTrainMean = rowMeans(BodyGyroZTrain)
TotalAccXTrainMean = rowMeans(TotalAccXTrain)
TotalAccYTrainMean = rowMeans(TotalAccYTrain)
TotalAccZTrainMean = rowMeans(TotalAccZTrain)

BodyAccXTrainSD =  rowSds(as.matrix(BodyAccXTrain),  na.rm=TRUE)
BodyAccYTrainSD =  rowSds(as.matrix(BodyAccYTrain),  na.rm=TRUE)
BodyAccZTrainSD =  rowSds(as.matrix(BodyAccZTrain),  na.rm=TRUE)
BodyGyroXTrainSD = rowSds(as.matrix(BodyGyroXTrain), na.rm=TRUE)
BodyGyroYTrainSD = rowSds(as.matrix(BodyGyroYTrain), na.rm=TRUE)
BodyGyroZTrainSD = rowSds(as.matrix(BodyGyroZTrain), na.rm=TRUE)
TotalAccXTrainSD = rowSds(as.matrix(TotalAccXTrain), na.rm=TRUE)
TotalAccYTrainSD = rowSds(as.matrix(TotalAccYTrain), na.rm=TRUE)
TotalAccZTrainSD = rowSds(as.matrix(TotalAccZTrain), na.rm=TRUE)



###########################################################################
## Step 5 (Test): 
##
##
##  Now cbind all of the test vectors into a 2947x581 array, 
##  call it TestData.
##  
############################################################################
print("**Step5: Column binding all the test vectors into 2947x581 array.**")
TestData <- cbind(subjectTest,  ##(2947x1)
                  yTest,        ##(2947x1)
                  BodyAccXTestMean, BodyAccYTestMean, BodyAccZTestMean,
                  BodyGyroXTestMean,BodyGyroYTestMean,BodyGyroZTestMean,
                  TotalAccXTestMean,TotalAccYTestMean,TotalAccZTestMean,
                  BodyAccXTestSD,   BodyAccYTestSD,   BodyAccZTestSD,
                  BodyGyroXTestSD,  BodyGyroYTestSD,  BodyGyroZTestSD,
                  TotalAccXTestSD,  TotalAccYTestSD,  TotalAccZTestSD,
                  XTest)      ##(2947x561)

colnames(TestData) <- goodColNames

#dim(TestData) #expect [1] 2947   581

###########################################################################
## Step 6 (Train): 
##
##
##  Now cbind all of the train vectors into a 7352x581 array, 
##  call it TrainData.
##  
############################################################################
print("**Step6: Column binding all the train vectors into 7352x581 array.**")
TrainData <- cbind(subjectTrain,  ##(7352x1)
                  yTrain,        ##(7352x1)
                  BodyAccXTrainMean, BodyAccYTrainMean, BodyAccZTrainMean,
                  BodyGyroXTrainMean,BodyGyroYTrainMean,BodyGyroZTrainMean,
                  TotalAccXTrainMean,TotalAccYTrainMean,TotalAccZTrainMean,
                  BodyAccXTrainSD,   BodyAccYTrainSD,   BodyAccZTrainSD,
                  BodyGyroXTrainSD,  BodyGyroYTrainSD,  BodyGyroZTrainSD,
                  TotalAccXTrainSD,  TotalAccYTrainSD,  TotalAccZTrainSD,
                  XTrain)      ##(7352x561)

colnames(TrainData) <- goodColNames

#dim(TrainData) #expect [1] 7352   581



###########################################################################
## Step 7:
##
## Row bind TestData (2947x580) with TrainData (7352x580) to produce the 
## tidy data set: TidyData (10,299x580)
##
############################################################################
print("**Step7: Row binding all the test and train vectors into a tidy 10,299x581 array.**")
TidyData <- rbind(TestData, TrainData)


#dim(TidyData) # Expect [1] 10299   581
#head(names(TidyData),30)

###########################################################################
## Step 8:
##
## Using TidyData (10,299x581), find the average of each variable for each 
## activity (6) and each subject (30) to produce a new tidy set called 
## MeanTidyData (180 x 581).
##
############################################################################
print("**Step8: Averaging tidy data based on activity and subject to produce a smaller tidy set of size 180x581**")
## Filter out data frm TidyDataTable based on the activity and the subject
## identifying  - 1 WALKING
##              - 2 WALKING_UPSTAIRS
##              - 3 WALKING_DOWNSTAIRS
##              - 4 SITTING
##              - 5 STANDING
##              - 6 LAYING

TidyDataTable <- tbl_df(TidyData)

by_subjectActivity <- group_by(TidyDataTable, Subject, Activity)
NewTidySet <- summarize_all(by_subjectActivity, mean)

#summary(NewTidySet)
#dim(NewTidySet)       #Expect [1] 180 581
#names(NewTidySet)


###########################################################################
## Step 9:
##
## Write NewTidySet
##
############################################################################
print(paste("**Step9: Writing smaller data set to",DATA_DIR,"UCI HAR Dataset/NewTidySet.txt",sep = ""))
write.table(NewTidySet, paste(DATA_DIR,"UCI HAR Dataset/NewTidySet.txt",sep = ""))


#checkTidyData <- read.table(paste(DATA_DIR,"UCI HAR Dataset/NewTidySet.txt",sep = ""), 
#                            sep = "", dec = ".")


