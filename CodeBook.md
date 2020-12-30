---
title: "CodeBook"
author: "Kimberly Pickard"
date: "12/29/2020"
output: html_document
---
This codebook describes how the script "Run_Analysis.R" reads in 25 data files detailing over 10,000 captured observations from 30 subjects engaging in six different activities. The data is then reduced and merged into one smaller tidy data set. The final step is to write out this tidy data set to a text file.


#### Step 1: Load the data:

The script **Run_Analysis.R** checks to see if the input data resides locally. If not,
then the data is downloaded from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##### For the “Test” group:
The body acceleration signal obtained by subtracting the gravity from the total acceleration: 

1.	**BodyAccXTest** DF consists of V1 to V128 with dim 2947x128
2.	**BodyAccYTest** DF consists of V1 to V128 with dim 2947x128
3.	**BodyAccZTest** DF consists of V1 to V128 with dim 2947x128

The angular velocity vector measured by the gyroscope:

4.	**BodyGyroXTest** DF consists of V1 to V128 with dim 2947x128
5.	**BodyGyroYTest** DF consists of V1 to V128 with dim 2947x128
6.	**BodyGyroZTest** DF consists of V1 to V128 with dim 2947x128

The acceleration signal from smartphone accelerometer [X,Y,Z] axis in standard gravity units ‘g’: 

7.	**TotalAccXTest** DF consists of V1 to V128 with dim 2947x128
8.	**TotalAccYTest** DF consists of V1 to V128 with dim 2947x128
9.	**TotalAccZTest** DF consists of V1 to V128 with dim 2947x128

##### For the “Train” group:
The body acceleration signal obtained by subtracting the gravity from the total acceleration: 

10.	**BodyAccXTrain** DF consists of V1 to V128 with dim 7352x128
11.	**BodyAccYTrain** DF consists of V1 to V128 with dim 7352x128
12.	**BodyAccZTrain** DF consists of V1 to V128 with dim 7352x128

The angular velocity vector measured by the gyroscope:

13.	**BodyGyroXTrain** DF consists of V1 to V128 with dim 7352x128
14.	**BodyGyroYTrain** DF consists of V1 to V128 with dim 7352x128
15.	**BodyGyroZTrain** DF consists of V1 to V128 with dim 7352x128

The acceleration signal from smartphone accelerometer [X,Y,Z] axis in standard gravity units ‘g’: 

16.	**TotalAccXTrain** DF consists of V1 to V128 with dim 7352x128
17.	**TotalAccYTrain** DF consists of V1 to V128 with dim 7352x128
18.	**TotalAccZTrain** DF consists of V1 to V128 with dim 7352x128

##### Remaining files:
19. **subjectTest** DF consists of one array with dim 2947, identifying subjects 2 through 24.

20. **XTest** DF consists of V1 to V561 with dim 2947x561

21. **yTest** DF consists of one array with dim 2947, with values from 1 to 6 identifying

    a.	1 WALKING
    b.	2 WALKING_UPSTAIRS
    c.	3 WALKING_DOWNSTAIRS
    d.	4 SITTING
    e.	5 STANDING
    f.	6 LAYING

22. **subjectTrain** DF consists of one array with dim 7352, identifying subjects 1 through 30.

23. **XTrain** DF consists of V1 to V561 with dim 7352x561(features)

24. **yTrain** DF consists of one array with dim 7352, with values from 1 to 6 identifying

    a.	1 WALKING
    b.	2 WALKING_UPSTAIRS
    c.	3 WALKING_DOWNSTAIRS
    d.	4 SITTING
    e.	5 STANDING
    f.	6 LAYING

25. **featureLabels** DF is 2-dim array with dim 561x2, so that we can identify the correct feature label by its index

    a.	The first column consists of integers 1:561
    b.	The second column is a character string.
    c.	Example: 530 is associated with "fBodyBodyGyroMag-std()"



#### Step 2: Define column names for the new TidyData data frame:

**goodColNames** : This variable contains the list of character strings used that will be used to label the columns of the tidy data set. These label names will be used for both the Test and Train data, which will allow us to merge both Test and Train data into one table.
 
The first two columns identify the subject (possible 1-30), and the activity (possible 1-6):
“Subject”,“Activity”,

The next 18 columns identify the mean and standard deviation values which we will compute from the data from the captured image files: 
    "BodyAccXMean",  	"BodyAccYMean",  	"BodyAccZMean",   
    "BodyGyroXMean",	"BodyGyroYMean",	"BodyGyroZMean",                          
    "TotalAccXMean",	"TotalAccYMean", 	"TotalAccZMean",
    "BodyAccXSD",   	"BodyAccYSD",   	"BodyAccZSD",
    "BodyGyroXSD",   	"BodyGyroYSD",  	"BodyGyroZSD",
 	"TotalAccXSD",   	"TotalAccYSD",   	"TotalAccZSD",
 
The remaining 561 features are indicated by column names which are created by pasting the first column value with the second column character string. Example column names:
	“1 tBodyAcc-mean()-X”
	“1 tBodyAcc-mean()-Y”


#### Step 3 (Test):
Compute the mean and standard deviation for each line in [Body Total][Acc Gyro]Test files to find:

1.	**BodyAccXTestMean**    and  **BodyAccXTestSD**
2.	**BodyAccYTestMean**    and  **BodyAccYTestSD**
3.	**BodyAccZTestMean**    and  **BodyAccZTestSD**
4.	**BodyGyroXTestMean** and  **BodyGyroXTestSD**
5.	**BodyGyroYTestMean** and  **BodyGyroYTestSD**
6.	**BodyGyroZTestMean** and  **BodyGyroZTestSD**
7.	**TotalAccXTestMean**   and  **TotalAccXTestSD**
8.	**TotalAccYTestMean**   and  **TotalAccYTestSD**
9.	**TotalAccZTestMean**   and  **TotalAccZTestSD**

Each of these variables contain vector of length 2947.

#### Step 4 (Train):
Compute the mean and standard deviation for each line in [Body Total][Acc Gyro]Train files to find:

1.	**BodyAccXTrainMean**    and  **BodyAccXTrainSD**
2.	**BodyAccYTrainMean**    and  **BodyAccYTrainSD**
3.	**BodyAccZTrainMean**    and  **BodyAccZTrainSD**
4.	**BodyGyroXTrainMean** and  **BodyGyroXTrainSD**
5.	**BodyGyroYTrainMean** and  **BodyGyroYTrainSD**
6.	**BodyGyroZTrainMean** and  **BodyGyroZTrainSD**
7.	**TotalAccXTrainMean**   and  **TotalAccXTrainSD**
8.	**TotalAccYTrainMean**   and  **TotalAccYTrainSD**
9.	**TotalAccZTrainMean**   and  **TotalAccZTrainSD**

Each of these variables contain a vector of length 7352.

#### Step 5 (Test):
**TestData**:	Now cbind all of the test vectors into a 2947x18 array, call it **TestData**, along with appropriate column labels.

#### Step 6 (Train):
**TrainData**:	Now cbind all of the test vectors into a 7352x18 array, call it **TestData**, along with appropriate column labels.


#### Step 7:
**TidyData**:	Row bind **TestData** (2947x580) with **TrainData** (7352x580) to produce the tidy data set: **TidyData** (10,299x580)

#### Step 8:
**NewTidySet**:  Using **TidyData** (10,299x580), find the average of each variable for each activity (6) and each subject (30) to produce a new tidy set called **NewTidySet** (180 x 580).

#### Step 9:
Write **NewTidySet** to the file "NewTidySet.txt"


