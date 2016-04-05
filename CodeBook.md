The dataset is loaded in the following variables:

**feautures**: List of all features.

**activity_labels**: Links the class labels with their activity name.

**subject_train**: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

**X_train**: Training set.

**y_train**: Training labels.

**subject_test**: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

**X_test**: Test set.

**y_test**: Test labels.

These data set is combined together using some temporary variables:

**Xy_train**: This dataframe contains de train measurement, with descriptive names, augumented with information about the activity and the subject

**Xy_test**: This dataframe contains de test measurement, with descriptive names, augumented with information about the activity and the subject

**Yx**: This dataframe is the combination of the test and the train datasets

**result**: The tidy data set as requested in step 5 of the assignment. 

The steps:
1. Add column names to X table. The column names are extracted from the "features.txt" file
 
2. Extract the columns containing the mean and the standard deviation from each measurements 
 
3. Add the subject to each row (y table)
 
4. Add the activity label to each row (y table)
 
5. Transform data frame to 

		- contain a descriptive value for the activity  (left_join() %>% select()
		
		- gather() all columns which are not variables
		
		- remember the source of this data befor combining the datasets mutate()

6. Create an independent tidy data set with the average of each variable for each activity and each subject.

7. Generate a CSV file from the result table (in current directory). 

The resulting dataset contains the following variables:
**activity**: One of the following six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) performed by persons wearing a smartphone (Samsung Galaxy S II) on the waist
**subject**: the subject who performed the activity for each window sample	
**feature**: the measurements on the mean and standard deviation for each feature measurement (see feature_info.txt included in de data set for a description of the features)
**mean(measurement)**: The mean of the mesured values, summarised by activity, subject and feature.

