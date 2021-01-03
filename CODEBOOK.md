# CODEBOOK Description
This document is a codebook that contain information about the variables, the data, and all transformations that have been performed in order to tidy up the given data.

# The Data Source

Source of the data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
A full description is available at the website where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, 
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial 
linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap 
(128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body 
acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

# The Dataset

The dataset includes the information from the following files:

'features.txt': List of all features.
'train/X_train.txt': Training set.
'train/y_train.txt': Training labels.
'train/subject_train.txt': Training subjects set.
'test/X_test.txt': Test set.
'test/y_test.txt': Test labels.
'test/subject_test.txt': Test subjects set.
'activity_labels.txt': Links the numeric activity labels with their names.

# Transformation of the data for completion of the run_analysis.R file in order to meet the requirements of the project course.

1. The training and the test sets are loaded from the downloaded and unzipped zip file, and are then merged to create one dataset.  
For this the column names in the loaded datasets are changed accordingly: column names for the dataset loaded from the files "X_train.txt" and "X_test.txt" are taken from
the second column of the dataset loaded from the file 'features.txt'; columns in the dataset loaded from the file 'activity_labels.txt' are named as 'activityID' and 
'activityType'; column for the datasets loaded from the files 'y_train.txt' and 'y_test.txt' is named "activityID"; column for the datasets loaded from the files
'subject_train.txt' and 'subject_test.txt' is named "subjectID".


2. Only the measurements on the mean and standard deviation for each measurement are left in the dataset by applying grepl function on the column names and creating the 
respective logical vector used to filter the main dataset.

3. Descriptive activity names are used to name the activities in the dataset. The naming from the point 1 allows us to merge the train and test datasets with the actibity 
labels dataset in one dataset (by using the values in the common column "activityID".

4. The variables (columns) in the dataset are labelled with descriptive variable names by using the function gsub.

5. From the dataset in step 4, a second, independent tidy data is created, which is set with the average of each variable for each activity and each subject by using 
the aggregate function. Then the output is written to a local text file named "tidydata.txt""
