# Getting-and-Cleaning-Data: 

Project with peer assesment

# Introduction 

This repository contains the R code and all the documentation files usefull in this project from the Coursera Data Science's track course "Getting and Cleaning data".

The project is based on data collected from the accelerometers embedded in the Samsung Galaxy S smartphone. A full description is available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data package can be downloaded at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Purpose of the project

Demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare TIDY data that can be used for later analysis.

A TIDY data set is characterized by the fact that each variable you measure should be in one column and Each different observation of that variable should be in a different row.

Create one R script called run_analysis.R that does the following: 

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Main files for the project

Caution: we assume that you have saved the R code in your working directory before using it!
Note: the code itself contains comments of the differents steps required.

`run_analysis.R`: Allows to proceed with the 5 steps defined above. In RStudio, you can launch the code with the R command `source ("run_analysis.R")`.

`CodeBook.md`: Contains the list of variables used but also describes the process permitting to clean up the data.

# The final output of the project

The file `Tidy_AveragesData.txt` presents the requested TIDY data set and is naturally included in this repository.

