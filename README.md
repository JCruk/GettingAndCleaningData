#Getting and Cleaning Data Course Project

This is the repo for the final project for Getting and Cleaning Data Course.

This repository contains the following files: 
`run_analysis.R` The r script processes the data and generated the required tidy dataset for submission. 
`CodeBook.md` A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data
`README.md` The README file for this repo. 

##Overview

The purpose of this project was to demonstrate the ability to collect, work with, and clean a data set. The goal was to prepare tidy data that can be used for later analysis. A full description of the data used in this project is available at the site where the data was obtained:  
[The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

##Running the Analysis Script

The data for this analysis must be in a directory named `UCI HAR Dataset`. The analysis script is named `run_analysis.R`; this script must be in the same directory as the `UCI HAR Dataset` in order for the script to run. Once this condition is met, the script can be run from R with the command 'source("path/to/script/file")'. The script will set its parent directory as the working directory. Upon completion the analysis script will generate a comma-separated values file called 'TidyData.txt'.

##Dependencies

This script requires use of the `reshape2` R package. The script will check to see if this package is currently installed, will install it if necessary, and then load it.

##Project Summary

The following is a summary description of the project instructions

You should create one R script called run_analysis.R that does the following: 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##Additional Information

You can find additional information about the variables, the data, and data manipulations in the CodeBook.md file.
