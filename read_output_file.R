##******************************************************
## 
##
## Getting and Cleaning Data Course
## Course Project Assignment
##
## Course Code: getdata-031
##
##
## This script was added to view the output file generated
## by the run_analysis.R script in an R environment
## 
## The script was get from David Hood, community TA of 
## the course. See the following link for details:
## https://class.coursera.org/getdata-031/forum/thread?thread_id=28
##
## Prerrequisite: 
## the output file should be named:  "output.txt"
## and be located in the current working folder
##******************************************************


data <- read.table("output.txt", header = TRUE) 
View(data)