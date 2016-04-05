	library(dplyr)
	library(tidyr)
	## This script does the following. 
	## 1.Merges the training and the test sets to create one data set.
	## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
	## 3.Uses descriptive activity names to name the activities in the data set
	## 4.Appropriately labels the data set with descriptive variable names. 
	## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	##
	## The location of the dataset is contained in the variable UCI_HAR_Dataset
	## by default the dataset is expected in the current directory.
	if(!exists("UCI_HAR_Dataset")) UCI_HAR_Dataset <- "."

	## The tidy data set produced by step 5 is contained in the variable called "result"
	## and written to the "result.csv" file in the curren directory.


	## Load the data into maneagable tables
	## For each record it is provided:
	## ======================================

	## - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
	## - Triaxial Angular velocity from the gyroscope. 
	## - A 561-feature vector with time and frequency domain variables. 
	## - Its activity label. 
	## - An identifier of the subject who carried out the experiment.

	## The dataset includes the following files:
	## =========================================

	## - 'features.txt': List of all features.
	features 		<- tbl_df(read.table(file.path(UCI_HAR_Dataset, "features.txt"))) 

	## - 'activity_labels.txt': Links the class labels with their activity name.
	activity_labels	<- tbl_df(read.table(file.path(UCI_HAR_Dataset, "activity_labels.txt"))) 
	colnames(activity_labels) <- c("labels", "activity")

	## - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
	## - 'train/X_train.txt': Training set.
	## - 'train/y_train.txt': Training labels.
	subject_train 	<- tbl_df(read.table(file.path(UCI_HAR_Dataset, "train", "subject_train.txt"))) 
	X_train 		<- tbl_df(read.table(file.path(UCI_HAR_Dataset, "train", "X_train.txt"))) 
	y_train 		<- tbl_df(read.table(file.path(UCI_HAR_Dataset, "train", "y_train.txt"))) 

	## - 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
	## - 'test/X_test.txt': Test set.
	## - 'test/y_test.txt': Test labels.
	subject_test 	<- tbl_df(read.table(file.path(UCI_HAR_Dataset, "test", "subject_test.txt"))) 
	X_test 			<- tbl_df(read.table(file.path(UCI_HAR_Dataset, "test", "X_test.txt"))) 
	y_test 			<- tbl_df(read.table(file.path(UCI_HAR_Dataset, "test", "y_test.txt"))) 

	## The following files are available for the train and test data. Their descriptions are equivalent. 


	## - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
	## - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
	## - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


	## Make the test and the train datasets tidy:
	## 1. add column names to X table. The column names are extracted from the "features.txt" file
	## 2. Extract the columns containing the mean and the standard deviation from each measurements 
	## 3. Add the subject to each row (y table)
	## 4. Add the activity label to each row (y table)
	## 5. Transform data frame to 
	##		- contain a descriptive value for the activity  (left_join() %>% select()
	##		- gather() all columns which are not variables
	##		- remember the source of this data befor combining the datasets mutate()
	colnames(X_train) <- features$V2
	X_train <- X_train[grep("(mean|std)\\(\\)", names(X_train))]
	colnames(subject_train) <- c("subject")
	X_train_subj <- bind_cols(subject_train, X_train)
	colnames(y_train) <- c("labels")
	Xy_train <- bind_cols(y_train, X_train_subj)
	Xy_train <- left_join(Xy_train, activity_labels, by = "labels") %>% select(-labels) %>% gather(key = feature, value = measurement, -activity, -subject) %>% mutate(dataset = "train")

	colnames(X_test) <- features$V2
	X_test <- X_test[grep("(mean|std)\\(\\)", names(X_test))]
	colnames(subject_test) <- c("subject")
	X_test_subj <- bind_cols(subject_test, X_test)
	colnames(y_test) <- c("labels")
	Xy_test <- bind_cols(y_test, X_test_subj) 
	Xy_test <- left_join(Xy_test, activity_labels, by = "labels") %>% select(-labels) %>% gather(key = feature, value = measurement, -activity, -subject) %>% mutate(dataset = "test")

	# combine tidy datasets. The result is tidy
	Xy <- bind_rows(Xy_test, Xy_train)

	result <- summarise(group_by(Xy, activity, subject, feature), mean(measurement))
	write.csv(result, "result.csv", row.names=FALSE)

