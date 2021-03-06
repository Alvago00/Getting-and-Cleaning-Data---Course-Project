# Getting-and-Cleaning-Data---Course-Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:

a tidy data set as described below;
a link to a Github repository with your script for performing the analysis; and
a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

Objectives

The run_analysis.R does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis.R

1. The code downloads the UCI HAR Dataset data set and unzips the file into the UCI HAR Dataset folder.
2. Loads the necessary packages.
3. Loads the train and test data sets and finallly merges the training and test set into one data frame.
4. Extracts only the measurements on the mean and standard deviation for each measurement.
5. Names the activities in the data set and replace the descriptive variable names
6. The mean of activities and subjects are created into a separate tidy data set which is exported as txt file.
