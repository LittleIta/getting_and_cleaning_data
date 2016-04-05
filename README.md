# getting_and_cleaning_data
Getting and Cleaning Data Course Project

I wrote the script contained in the file "CodeBook.R" as part of the final assignment for the "Getting and Cleaning Data Course".

The script expected the following packages to be installed:
* tidyr
* dplyr

The script expects the required dataset to be either in the current directory of in the directory indicated by the variable "UCI_HAR_Dataset".
The source of the dataset is: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


This script does the following. 
	## 1.Merges the training and the test sets to create one data set.
	## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
	## 3.Uses descriptive activity names to name the activities in the data set
	## 4.Appropriately labels the data set with descriptive variable names. 
	## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	##

