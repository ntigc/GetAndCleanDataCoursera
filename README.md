# GetCleanDataCoursera

Repo Created as Part of Coursera's "Getting and Cleaning Data" project. It includes the following files:

- run_analysis.R: script that processes the input files to generate the output
- CodeBook.md: code book of the tidy data Set
- read_output_file.R: script to read and view the final tidy DataSet

The tidy data Set get by this script was uploaded to Coursera Web Site, following the instructions provided in the Course Project Assignment.

## run_analysis.R Script Steps
The script performs the following steps to tidy the data set:

1. Reads and merges all sets, activity names and subject 
   files into a single data Set
2. Merges both train and test data sets in a single one
3. Gets the activity name for all sets by joining the
   ActivityLabel DataSet
4. Select only the needed variables, naming them
   based on the features.txt file
5. calculates the average of each variable, by activity
   name and subject

## Input Files Information
The input files are part of an experiment performed to determine if it is possible to recognize human activity by the information generated
by their smartphones' accelerometer and gyroscope. For more details please refer to the following link:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Remarks and Observations

- For "mean value for each measurement", only the variables in which name the string: "mean()" was found were considered in this script
- For "standard deviation value for each measurement", only the variables in which name the string: "std()" was found were considered in this script
- Despite the output file is a wide DataSet, no normalization or denormalization was done in mean and std variables, as they already meet the principles of tidy data principles
