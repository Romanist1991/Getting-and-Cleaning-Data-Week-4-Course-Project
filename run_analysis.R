### 1. Merging the training and the test sets to create one data set.
#Set your working directory
setwd("C:/Users/vlady/OneDrive/Desktop/R Projects/Week4Assignment")

#Download the dataset
if(!file.exists("./cleandataset")){dir.create("./cleandataset")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./cleandataset/cleandataset.zip")

#Unzip the dataset
unzip(zipfile = "./cleandataset/cleandataset.zip", exdir = "./cleandataset")

#Reading training tables - xtrain / ytrain, subject train
xtrain <- read.table("./cleandataset/UCI HAR Dataset/train/X_train.txt", header=FALSE)
ytrain <- read.table("./cleandataset/UCI HAR Dataset/train/y_train.txt", header=FALSE)
subject_train <- read.table("./cleandataset/UCI HAR Dataset/train/subject_train.txt", header=FALSE)

#Reading the testing tables
xtest <- read.table("./cleandataset/UCI HAR Dataset/test/X_test.txt", header=FALSE)
ytest <- read.table("./cleandataset/UCI HAR Dataset/test/y_test.txt", header=FALSE)
subject_test <- read.table("./cleandataset/UCI HAR Dataset/test/subject_test.txt", header=FALSE)

#Reading the features data
features <- read.table("./cleandataset/UCI HAR Dataset/features.txt", header=FALSE)

#Reading the activity labels data
activity_labels = read.table("./cleandataset/UCI HAR Dataset/activity_labels.txt", header=FALSE)

#Assigning variable names
colnames(xtrain) <- features[,2]
colnames(ytrain) <- "activityID"
colnames(subject_train) <- "subjectID"
colnames(xtest) <- features[,2]
colnames(ytest) <- "activityID"
colnames(subject_test) <- "subjectID"
colnames(activity_labels) <- c('activityID','activityType')

#Merging the train and test datasets into one dataset
merged_train = cbind(ytrain, subject_train, xtrain)
merged_test = cbind(ytest, subject_test, xtest)
merged_dataset = rbind(merged_train, merged_test)

### 2.Extracting only the measurements on the mean and standard deviation for each measurement. 
#Reading column names
colNames = colnames(merged_dataset)
#Creating a vector for defining Activity ID, Mean and Standard deviation 
mean_and_std <- (grepl("activityID", colNames) |
                   grepl("subjectID", colNames) |
                   grepl("mean...", colNames) |
                   grepl("std...", colNames)
)
#Creating a subset to get the required dataset
mean_and_std_dataset <- merged_dataset[ ,mean_and_std == TRUE]

### 3.Using descriptive activity names to name the activities in the dataset.
#Adding descriptive activity names to mean_and_std_dataset from activity_labels
final_merged_dataset <- merge(mean_and_std_dataset,activity_labels,by="activityID",all.x=TRUE)
#Updating the activityID column
final_merged_dataset$activityID <-activity_labels[,2][match(final_merged_dataset$activityID, activity_labels[,1])] 
#Removing activityType column
final_merged_dataset <- final_merged_dataset[,names(final_merged_dataset) != 'activityType']

### 4.Labeling the dataset with descriptive variable names. 
names(final_merged_dataset)<-gsub("BodyBody", "Body", names(final_merged_dataset))
names(final_merged_dataset)<-gsub("Gyro", "Gyroscope", names(final_merged_dataset))
names(final_merged_dataset)<-gsub("Mag", "Magnitude", names(final_merged_dataset))
names(final_merged_dataset)<-gsub("Acc", "Accelerometer", names(final_merged_dataset))
names(final_merged_dataset) <- gsub("^t", "time", names(final_merged_dataset))
names(final_merged_dataset)<-gsub("^f", "frequency", names(final_merged_dataset))

### 5.Creating a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- aggregate(.~subjectID + activityID, final_merged_dataset,mean)
tidy_data <- tidy_data[order(tidy_data$subjectID, tidy_data$activityID)]
#Saving this tidy dataset to the local file
write.table(tidy_data, file = "tidydata.txt",row.name=FALSE)

