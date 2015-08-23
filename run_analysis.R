##******************************************************
## 
##
## Getting and Cleaning Data Course
## Course Project Assignment
## 
##
## Course Code: getdata-031
## Author: Nicolas Iguchi
##
##
## This script does the following steps:
## 
## 1. Reads and merges all sets, activity names and subject 
##    files into a single data Set
## 2. Merges both train and test data sets in a single one
## 3. Gets the activity name for all sets by joining the
##    ActivityLabel DataSet
## 4. Select only the needed variables, naming them
##    based on the features.txt file
## 5. calculates the average of each variable, by activity
##    name and subject
##******************************************************


#--------------------------------------------------------
# Load the used libraries
#--------------------------------------------------------
library("dplyr")
library("tidyr")

#--------------------------------------------------------
# Read the parameter files
#--------------------------------------------------------
activities <- read.table( file = "activity_labels.txt", 
                          header = FALSE, 
                          col.names = c( "activity_id", "activity_name" )
                          )

features <- read.table( file = "features.txt", 
                        header = FALSE, 
                        col.names = c( "feature_id", "feature_name" ), 
                        stringsAsFactors = FALSE)

#--------------------------------------------------------
# Read the entire Test Set file and take the mean and std variables
#--------------------------------------------------------

dataTest <- read.table(file = "test/X_test.txt", header = FALSE, col.names = features[, 2])
dataTest <- dataTest[, c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)]

#--------------------------------------------------------
# Add the subject to the dataSet
#--------------------------------------------------------
subjectTest <- read.table("test/subject_test.txt", header = FALSE, col.names = c("subject"))
dataTest <- cbind(subjectTest, dataTest)

#--------------------------------------------------------
# Add the Activity Code to the dataSet
#--------------------------------------------------------
activityTest <- read.table("test//y_test.txt", header = FALSE, col.names = c("activity_id"))
dataTest <- cbind(activityTest, dataTest)



#--------------------------------------------------------
# Read the entire Test Set file and take the mean and std variables
#--------------------------------------------------------
dataTrain <- read.table(file = "train/X_train.txt", header = FALSE, col.names = features[, 2])
dataTrain <- dataTrain[, c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)]

#--------------------------------------------------------
# Add the subject to the dataSet
#--------------------------------------------------------
subjectTrain <- read.table("train//subject_train.txt", header = FALSE, col.names = c("subject"))
dataTrain <- cbind(subjectTrain, dataTrain)

#--------------------------------------------------------
# Add the Activity Code to the dataSet
#--------------------------------------------------------
activityTrain <- read.table("train//y_train.txt", header = FALSE, col.names = c("activity_id"))
dataTrain <- cbind(activityTrain, dataTrain)


#--------------------------------------------------------
# Merges both train and test dataSets and add an id for each rows
#--------------------------------------------------------
dataFinal <- rbind(dataTest, dataTrain)
dataFinal$observation_id <- seq(1, nrow(dataFinal), by = 1)


#--------------------------------------------------------
# Join with  Activity DataSet to get the description
#--------------------------------------------------------
dataFinal <- inner_join(activities, dataFinal, by = "activity_id")
dataFinal <- select(dataFinal, activity_name:fBodyBodyGyroJerkMag.std..)


#--------------------------------------------------------
# Generate the output tidy data file
#--------------------------------------------------------
dataFinal <- group_by(dataFinal, subject, activity_name)

output <- summarize(dataFinal 
               , avg_tBodyAcc_meanX                    = mean(tBodyAcc.mean...X) 
               , avg_tBodyAcc_meanY                    = mean(tBodyAcc.mean...Y)
               , avg_tBodyAcc_meanZ                    = mean(tBodyAcc.mean...Z)
               , avg_tBodyAccMag_mean                  = mean(tBodyAccMag.mean..)
               
               , avg_tBodyAcc_stdX                     = mean( tBodyAcc.std...X)
               , avg_tBodyAcc_stdY                     = mean( tBodyAcc.std...Y)
               , avg_tBodyAcc_stdZ                     = mean( tBodyAcc.std...Z)
               , avg_tBodyAccMag_std                   = mean( tBodyAccMag.std..)
               
               , avg_tGravityAcc_meanX                 = mean(tGravityAcc.mean...X)
               , avg_tGravityAcc_meanY                 = mean(tGravityAcc.mean...Y)
               , avg_tGravityAcc_meanZ                 = mean(tGravityAcc.mean...Z)
               , avg_tGravityAccMag_mean               = mean(tGravityAccMag.mean..)
               
               , avg_tGravityAcc_stdX                  = mean(tGravityAcc.std...X)
               , avg_tGravityAcc_stdY                  = mean(tGravityAcc.std...Y)
               , avg_tGravityAcc_stdZ                  = mean(tGravityAcc.std...Z)
               , avg_tGravityAccMag_std                = mean(tGravityAccMag.std..)
               
               
               , avg_tBodyAccJerk_meanX                = mean(tBodyAccJerk.mean...X)
               , avg_tBodyAccJerk_meanY                = mean(tBodyAccJerk.mean...Y)
               , avg_tBodyAccJerk_meanZ                = mean(tBodyAccJerk.mean...Z)
               , avg_tBodyAccJerkMag_mean              = mean(tBodyAccJerkMag.mean..)
               
               , avg_tBodyAccJerk_stdX                 = mean(tBodyAccJerk.std...X)
               , avg_tBodyAccJerk_stdY                 = mean(tBodyAccJerk.std...Y)
               , avg_tBodyAccJerk_stdZ                 = mean(tBodyAccJerk.std...Z)
               , avg_tBodyAccJerkMag_std               = mean(tBodyAccJerkMag.std..)
               
               , avg_tBodyGyro_meanX                   = mean(tBodyGyro.mean...X)
               , avg_tBodyGyro_meanY                   = mean(tBodyGyro.mean...Y)
               , avg_tBodyGyro_meanZ                   = mean(tBodyGyro.mean...Z)
               , avg_tBodyGyroMag_mean                 = mean(tBodyGyroMag.mean..)
               
               , avg_tBodyGyro_stdX                    = mean(tBodyGyro.std...X)
               , avg_tBodyGyro_stdY                    = mean(tBodyGyro.std...Y)
               , avg_tBodyGyro_stdZ                    = mean(tBodyGyro.std...Z)
               , avg_tBodyGyroMag_std                  = mean(tBodyGyroMag.std..)
               
               , avg_tBodyGyroJerk_meanX               = mean(tBodyGyroJerk.mean...X)
               , avg_tBodyGyroJerk_meanY               = mean(tBodyGyroJerk.mean...Y)
               , avg_tBodyGyroJerk_meanZ               = mean(tBodyGyroJerk.mean...Z)
               , avg_tBodyGyroJerkMag_mean             = mean(tBodyGyroJerkMag.mean..)
               
               , avg_tBodyGyroJerk_stdX                = mean(tBodyGyroJerk.std...X)
               , avg_tBodyGyroJerk_stdY                = mean(tBodyGyroJerk.std...Y)
               , avg_tBodyGyroJerk_stdZ                = mean(tBodyGyroJerk.std...Z)
               , avg_tBodyGyroJerkMag_std              = mean(tBodyGyroJerkMag.std..)
               
               , avg_fBodyAcc_meanX                    = mean(fBodyAcc.mean...X)
               , avg_fBodyAcc_meanY                    = mean(fBodyAcc.mean...Y)
               , avg_fBodyAcc_meanZ                    = mean(fBodyAcc.mean...Z)
               , avg_fBodyAccMag_mean                  = mean(fBodyAccMag.mean..)
               
               , avg_fBodyAcc_stdX                     = mean(fBodyAcc.std...X)
               , avg_fBodyAcc_stdY                     = mean(fBodyAcc.std...Y)
               , avg_fBodyAcc_stdZ                     = mean(fBodyAcc.std...Z)
               , avg_fBodyAccMag_std                   = mean(fBodyAccMag.std..)
               
               , avg_fBodyAccJerk_meanX                = mean(fBodyAccJerk.mean...X)
               , avg_fBodyAccJerk_meanY                = mean(fBodyAccJerk.mean...Y)
               , avg_fBodyAccJerk_meanZ                = mean(fBodyAccJerk.mean...Z)
               , avg_fBodyAccJerkMag_mean              = mean(fBodyBodyAccJerkMag.mean..)
               
               , avg_fBodyAccJerk_stdX                 = mean(fBodyAccJerk.std...X)
               , avg_fBodyAccJerk_stdY                 = mean(fBodyAccJerk.std...Y)
               , avg_fBodyAccJerk_stdZ                 = mean(fBodyAccJerk.std...Z)
               , avg_fBodyAccJerkMag_std               = mean(fBodyBodyAccJerkMag.std..)
               
               , avg_fBodyGyro_meanX                   = mean(fBodyGyro.mean...X)
               , avg_fBodyGyro_meanY                   = mean(fBodyGyro.mean...Y)
               , avg_fBodyGyro_meanZ                   = mean(fBodyGyro.mean...Z)
               , avg_fBodyGyroMag_mean                 = mean(fBodyBodyGyroMag.mean..)
               
               , avg_fBodyGyro_stdX                    = mean(fBodyGyro.std...X)
               , avg_fBodyGyro_stdY                    = mean(fBodyGyro.std...Y)
               , avg_fBodyGyro_stdZ                    = mean(fBodyGyro.std...Z)
               , avg_fBodyGyroMag_std                  = mean(fBodyBodyGyroMag.std..)
               
               , avg_fBodyGyroJerkMag_mean             = mean(fBodyBodyGyroJerkMag.mean..)
               , avg_fBodyGyroJerkMag_std              = mean(fBodyBodyGyroJerkMag.std..)
)

#--------------------------------------------------------
# Creates the output file to be updated to Coursera Site
#--------------------------------------------------------
write.table(output, file = "output.txt" , row.names = FALSE)
