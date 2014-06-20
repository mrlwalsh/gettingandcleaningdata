# Peer Assessments /Getting and Cleaning Data Course Project  
# 
# The purpose of this project is to demonstrate your ability 
# to collect, work with, and clean a data set. The goal is 
# to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no 
# questions related to the project. You will be required to submit:  
#   
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis, and 
# 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
# 
# One of the most exciting areas in all of data science right now 
# is wearable computing - see for example this article . 
# Companies like Fitbit, Nike, and Jawbone Up are racing to 
# develop the most advanced algorithms to attract new users. 
# The data linked to from the course website represent data 
# collected from the accelerometers from the Samsung Galaxy S 
# smartphone. A full description is available at the site where the data was obtained:  
#   
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
# 
# Here are the data for the project:  
#   
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
# 
# You should create one R script called run_analysis.R that does the following.  
# 
# * Merges the training and the test sets to create one data set.
# * Extracts only the measurements on the mean and standard deviation for each measurement.  
# * Uses descriptive activity names to name the activities in the data set  
# * Appropriately labels the data set with descriptive variable names. 
# * Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
# 
# 
#   Setup  
 library(dplyr)
 setwd("C:/Users/Michael/Google Drive/Coursera/Getting and Cleaning Data/Project")
 
 if (!file.exists("data")) {
   dir.create("data")
 }
# read raw data
 
# #Train data
 
traindf <- read.table("./data/X_train.txt")
dim(traindf)
 
# Add Descriptive variable names
 
# variablenames <- read.table("./data/features.txt")
# variablenames
 
names(traindf) <- variablenames[,2]
# names(traindf)
 
subjecttrain <- read.table("./data/subject_train.txt")
dim(subjecttrain)

 activitytrain <- read.table("./data/y_train.txt")
 table(activitytrain$V1)
 nrow(activitytrain)
 
# Add descriptive names to activity values
 
activitylabels <- read.table("./data/activity_labels.txt")
# activitylabels
 
 activitytrain$activitylabel <- "nothing_yet"
activitytrain$activitylabel[activitytrain$V1 == 1] <- "WALKING"
activitytrain$activitylabel[activitytrain$V1 == 2] <- "WALKING_UPSTAIRS"
activitytrain$activitylabel[activitytrain$V1 == 3] <- "WALKING_DOWNSTAIRS"
activitytrain$activitylabel[activitytrain$V1 == 4] <- "SITTING"
activitytrain$activitylabel[activitytrain$V1 == 5] <- "STANDING"
activitytrain$activitylabel[activitytrain$V1 == 6] <- "LAYING"
 
activitytrain$activitylabel
names(activitytrain)
 
traindf[,562] <- subjecttrain[,1]
length(traindf)
 
traindf[,563] <- activitytrain[,2]
length (traindf)
 
# names(traindf)
 
table(traindf$V562,traindf$V563)
 
#Test data
# 
# testdf <- read.table("./data/X_test.txt")
# head(testdf)
# length(testdf)
# nrow(testdf)
# 
# # Add Descriptive variable names
# 
# names(testdf)
# names(testdf) <- variablenames[,2]
# names(testdf)
# 
# subjecttest <- read.table("./data/subject_test.txt")
# table(subjecttest$V1)
# nrow(subjecttest)
# 
# activitytest <- read.table("./data/y_test.txt")
# table(activitytest$V1)
# nrow(activitytest)
# 
# # Add descriptive names to activity values
# 
# activitylabels <- read.table("./data/activity_labels.txt")
# 
# activitytest$activitylabel <- "nothing_yet"
# activitytest$activitylabel[activitytest$V1 == 1] <- "WALKING"
# activitytest$activitylabel[activitytest$V1 == 2] <- "WALKING_UPSTAIRS"
# activitytest$activitylabel[activitytest$V1 == 3] <- "WALKING_DOWNSTAIRS"
# activitytest$activitylabel[activitytest$V1 == 4] <- "SITTING"
# activitytest$activitylabel[activitytest$V1 == 5] <- "STANDING"
# activitytest$activitylabel[activitytest$V1 == 6] <- "LAYING"
# 
# activitytest$activitylabel
# names(activitytest)
# 
# testdf[,562] <- subjecttest[,1]
# length(testdf)
# 
# testdf[,563] <- activitytest[,2]
# length (testdf)
# 
# names(testdf)
# 
# table(testdf$V562,testdf$V563)
# 
# #combine train and test data
# 
# alldata <- rbind(traindf,testdf)
# names(alldata)[562] <- "volunteer"
# names(alldata)[563] <- "activity"
# head(alldata)
# dim(alldata)
# 
# #Find only mean measure variables
# 
# meanindex <- grep("mean|std",variablenames$V2)
# meanindex
# length(meanindex)
# meanindex[80] <- 562
# meanindex[81] <- 563
# 
# # get reduced set of mean and std data
# 
# tidyextract <- alldata[,meanindex]
# dim(tidyextract)
# head(tidyextract)
# 
# # write the extracted data to a csv file
# 
# if (!file.exists("./data/tada.csv")) {
#   write.csv(tidyextract, file = "./data/tada.csv")
# }
# 
# # create file of data grouped by volunteer, activity
# 
# tesummary <- tidyextract
# 
# 
# 
# dg <- group_by(tidyextract, volunteer, activity)
# # the names of the columns you want to summarize
# cols <- names(tidyextract)[1:79]
# cols
# # the dots component of your call to summarise
# dots <- sapply(cols ,function(x) substitute(mean(x), list(x=as.name(x))))
# tesum <- do.call(summarise, c(list(.data=dg), dots))
# tesum[,1:3]
# dim(tesum)
# 
# # write the extracted summary data to a csv file
# 
# if (!file.exists("./data/tada2.csv")) {
#   write.csv(tesum, file = "./data/tada2.csv")
# }
# 
# 
# ```
# 
# Please upload a tidy data set according to the instructions in the project description. Please upload your data set as a separate file (do not cut and paste a dataset directly into the text box, as this may cause errors saving your submission).  
# 
# Please submit a link to a Github repo with the code for performing your analysis. The code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory. The output should be the tidy data set you submitted for part 1. You should include a README.md in the repo describing how the script works.  
# 
# Please submit a code book that modifies and updates the codebooks available to you with the data to indicate all the variables and summaries you calculated, along with units, and any other relevant information.  
# 
# In accordance with the Honor Code, I certify that my answers here are my own work, and that I have appropriately acknowledged all external sources (if any) that were used in this work.