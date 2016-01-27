

#title: "run_analysis.R"
#author: Jo Stichbury
#date: 27th January 2016

  
# Code to address the project for Coursera's Getting and Cleaning Data course
# See https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project
# Instructions:
# You should create one R script called run_analysis.R that does the following. 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

run_analysis <- function(){

#Set working directory
setwd("~/Documents/R/getting and cleaning data/project")
#download data
library(httr) 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "datadownload.zip"
if(!file.exists(file))
  {
    download.file(url, file, method="curl")
  }

if(!file.exists("UCI HAR Dataset")) #To store downloaded data
  {
  unzip(file, list = FALSE, overwrite = TRUE)
  } 
if(!file.exists("tidydata")) #To store tidy data
  {
  dir.create("tidydata")
  } 

#Reading data and merging the test and training sets
#First the subjects
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
allsubjects <- rbind(subject_test, subject_train)
colnames(allsubjects) <- "SubjectID"

#Next the activities
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
activities <- rbind(y_test, y_train)
activities <- as.vector(activities$V1) #Convert to vector

#Get the activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels <- factor(activity_labels$V2)

#Replace the numbers in the activities vector with the correct label
activities <- data.frame(factor(activities, labels=activity_labels))
colnames(activities) <- "Activity"

#Now to read in the actual signals for test and training subjects
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
data <- rbind(X_test, X_train)

#Read in the descriptive names of the measurements
features<-read.table("./UCI HAR Dataset/features.txt") 

##We only want the data for mean and standard deviation values - anything with mean or std in the column name
meanCols<-grep("mean",features$V2,ignore.case=TRUE)
stdCols<-grep("std",features$V2,ignore.case=TRUE)
cols<-append(meanCols, stdCols)

#Use dplyr to select those columns
library(dplyr)
Xdata<-select(data, cols)
#Clean up data variable to keep things tiday
rm(data)

#Give correct column names by subsetting from features.txt
#These are as descriptive as any I could come up with, so I have not attempted to rewrite them into more 'meaningful' descriptions
colnames(Xdata) <-features$V2[cols] ## Use subset of features

#Join allsubjects, activities and Xdata columns together to make the tidy dataset 
tidydata <- cbind(allsubjects, activities, Xdata)
View(tidydata) #Take a quick peek to check it looks OK

## Print this to file
write.table(tidydata, file="./tidydata/tidyData.txt", row.names = FALSE)

#Now build a new tidy dataset of the mean values of each reading for subject/activity
groupeddata<-group_by(tidydata, SubjectID, Activity)
tidymeans<-summarise_each(groupeddata,funs(mean))

#Print the mean values dataset to file
write.table(tidymeans, file="./tidydata/tidydata_means.txt", row.names = FALSE)

##Print out when complete
print("All done")
}