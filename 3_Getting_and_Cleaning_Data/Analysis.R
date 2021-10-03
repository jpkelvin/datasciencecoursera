# Project for Coursera Data Science Specialization  
# Peer Graded Assignment: Getting and Cleaning Data Course Project

library(dplyr)

# Read feature list and activity names
features_list <-  read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
y_test_label <- left_join(y_test, activity, by = "label")

tidy_test <- cbind(subject_test, y_test_label, x_test)
tidy_test <- select(tidy_test, -label)


subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
y_train_label <- left_join(y_train, activity, by = "label")

tidy_train <- cbind(subject_train, y_train_label, x_train)
tidy_train <- select(tidy_train, -label)

#Merges the training and the test sets to create one data set

tidy_set <- rbind(tidy_test, tidy_train)

#Extracts only the measurements on the mean and standard deviation for each measurement

tidy_mean_std <- select(tidy_set, contains("mean"), contains("std"))

# Averanging all variable by each subject each activity
tidy_mean_std$subject <- as.factor(tidy_set$subject)
tidy_mean_std$activity <- as.factor(tidy_set$activity)

#From the data set in last step, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.

FinalData <- tidy_mean_std %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)



