# You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.

## Download the file to load and unzip it

if (!file.exists("data")){
        dir.create("data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/UCIHARDataset.zip")

unzip(zipfile = "./data/UCIHARDataset.zip", exdir = "./data")

## Load packages

library(plyr)
library(dplyr)
library(data.table)
library(tidyr)

## Load and create Data

features <- read.csv('./data/UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

training.set.Data <- read.table('./data/UCI HAR Dataset/train/X_train.txt')
training.activity.Data <- read.csv('./data/UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
training.subject.Data <- read.csv('./data/UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

test.set.Data <- read.table('./data/UCI HAR Dataset/test/X_test.txt')
test.activity.Data <- read.csv('./data/UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
test.subject.Data <- read.csv('./data/UCI HAR Dataset/test/subject_test.txt',header = FALSE, sep = ' ')

## Combine X_train, y_train & subject_train / X_test, y_test & subject_test

training.data <-  data.frame(training.subject.Data, training.activity.Data, training.set.Data)
test.data <- data.frame(test.subject.Data, test.activity.Data, test.set.Data)

## Rename the colnames of the new data frame
names(training.data) <- c(c('subject', 'activity'), features)
names(test.data) <- c(c('subject', 'activity'), features)

## Merge the training and test set

MergedData = rbind(training.data, test.data)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

Mean.Std.Data <-MergedData[grepl("mean|std|subject|activity",colnames(MergedData))]


# 3. Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity_labels <- as.character(activity_labels[,2])
Mean.Std.Data$activity <- activity_labels[Mean.Std.Data$activity]
View(Mean.Std.Data$activity)

# 4. Appropriately labels the data set with descriptive variable names.

names(Mean.Std.Data)

names(Mean.Std.Data) <- gsub('\\(|\\)',"", names(Mean.Std.Data))
names(Mean.Std.Data) <- gsub("^t", "TimeDomain_", names(Mean.Std.Data))
names(Mean.Std.Data) <- gsub("^f", "FrequencyDomain_", names(Mean.Std.Data))
names(Mean.Std.Data) <- gsub("Acc", "Accelerometer", names(Mean.Std.Data))
names(Mean.Std.Data) <- gsub("Gyro", "Gyroscope", names(Mean.Std.Data))
names(Mean.Std.Data) <- gsub("Mag", "Magnitude", names(Mean.Std.Data))
names(Mean.Std.Data) <- gsub("-mean-", "_Mean_", names(Mean.Std.Data))
names(Mean.Std.Data) <- gsub("-std-", "_StandardDeviation_", names(Mean.Std.Data))
names(Mean.Std.Data) <- gsub("-", "_", names(Mean.Std.Data))

names(Mean.Std.Data)

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

Tidy.Data <- ddply(Mean.Std.Data, c("subject", "activity"), numcolwise(mean))
write.table(x = Tidy.Data, file = "Tidy.Data.txt", row.name=FALSE)

## Exporting the file to c:/
write.table(Tidy.Data, "c:/Tidy.Data.txt", row.name=FALSE)
