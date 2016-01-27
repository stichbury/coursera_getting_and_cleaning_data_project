---
title: "codebook.md"
output: html_document
author: Jo Stichbury
date: 27th January 2016
---

# Project Description
This project is for Coursera's Getting and Cleaning Data course. See https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project for further information.

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

In this project, I am delivering:  
1) a tidy data set (comprising of 2 files) as described below  
2) a script (run_analysis.R) for performing the analysis  
3) a code book (this document) that describes the variables, the data, and any transformations or work to clean up the data  
4) A readme.md that explains how to use the script.   

##Study design and data processing

We are asked to create one R script called run_analysis.R that does the following, after downloading the raw data.   
1) Merges the training and the test sets to create one data set.   
2) Extracts only the measurements on the mean and standard deviation for each measurement.    
3) Uses descriptive activity names to name the activities in the data set   
4) Appropriately labels the data set with descriptive variable names.    
5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.    


###Collection of the raw data
The data is downloaded from the link posted on the course website.   
The zip is named "datadownload.zip" and it is extracted to a directory called "UCI HAR Dataset" within the working directory.

###Notes on the original (raw) data 
Files used:   
The individual performing the activity (one of 30): "./UCI HAR Dataset/test/subject_test.txt" - dimensions: 2947 x 1   
The recorded data: "./UCI HAR Dataset/test/X_test.txt" - dimensions: 2947 x 561   
The activity (one of 6): "./UCI HAR Dataset/test/y_test.txt" - dimensions: 2947 x 1   
The individual performing the activity (one of 30): "./UCI HAR Dataset/train/subject_train.txt" - dimensions: 7352 x 1   
The recorded data: "./UCI HAR Dataset/train/X_train.txt" - dimensions: 7352 x 561   
The activity (one of 6): "./UCI HAR Dataset/train/y_train.txt" - dimensions: 7352 x 1   
The activities: "./UCI HAR Dataset/activity_labels.txt" - dimensions: 6 x 2   
The signals: "./UCI HAR Dataset/features.txt" - dimensions: 561 x 2   

Note that the Inertial Signals folders are not used.

##Creating the tidy datafile
* I create a folder called "tidydata", where it will save the datasets required to complete the project:
  - tidydata.txt   
  -- dimensions: 10299 x 88
  --- Merges the training and the test sets provided by the raw data  
  --- Extracts only the mean and standard deviation for each measurement per subject and activity. (Each measurement is found to be repeated 6 times). To do this, I used grep to extract all columns that contain the word "mean", anywhere in the description of the measurement. So tBodyAcc-mean()-X is included, but also measurements like angle(tBodyAccMean, gravity). I'm not a subject expert so cannot determine if this is correct, but at least data is not lost if I include it all. Because I'm not an expert in what the columns all mean, I have also not attempted to change the descriptions further from what is listed. I have taken them straight from the features.txt file of measurement names.  
  
  - tidydata_means.txt 
  -- dimensions: 180 x 88
  ---  Takes the tidydata.txt dataset and calculates the mean of the 6 measurements for each variable for each activity and each subject. The file contains a tidy data set as per my ReadMe.md that can be read into R with read.table(header=TRUE). The data can be considered tidy as it is aligned with the principles in Hadley Wickham's paper from the Journal of Statistical Software (http://vita.had.co.nz/papers/tidy-data.pdf).   

###Cleaning of the data

(1) Reads in subject IDs for test and training, combines into a single set with a SubjectID header  
(2) Reads activity records for test and training, combines into a single set and converts to the appropriate textual representation (e.g. WALKING) with a Activity header  
(3) Reads and combines all measurements for test and training data and combines into a single set. Extracts the measurements that contain "mean" or "std" in the column name (case insensitive search) and creates a subset thereof  
(4) Combines (1-3) above and writes to file tidydata.txt  
(5) In the dataframe created in (4), each measurement is recorded 6 times per activity and subject. The mean value of each is calculated and a new dataframe created, written to file in tidydatameans.txt  

##Description of the variables in the tiny_data.txt file

###Variables descriptions 
There follows a short description of what the variable describes. However, as I'm not a subject expert, I've been brief in my explanation, as they may be complete rubbish. It's just my interpretation of the readme file provided with the data.  

SubjectID: integer value that identifies the person being observed. The participants are described in the data's readme as "...30 volunteers within an age bracket of 19-48 years...".   
Activity: factor that describes the action they were performing. The data's readme says "Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)".  

The rest of the data is harder to interpret. The data's readme says that the participants were "wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz".  

I would suggest that the values are thus broken down as having a number of componenents:  
- coming either from the accelerometer or the gyroscope  
- measured along X, Y or Z axis  
- from gravitational or body motion   

Beyond that, I've no idea, I'm afraid, as I don't understand the subject sufficiently, but would hope that the data is sufficiently tidy that someone who can, can take it and work more efficiently with it. Which is, as I understand it, the object of this project.

##Sources

The data set is associated with the following publication:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

