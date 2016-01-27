--------------------
title: readme.md
output: html_document
author: Jo Stichbury
date: 27th January 2016

This readme explains how the scripts and data are connected for this project.

#### Overview of Data Sets
The data sets used for this course project are located at:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

They are associated with the following publication:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Overview of run_analysis.R
The script is heavily commented to explain the process. It is further described in the codebook that accompanies this project.

## Instructions for using run_analysis()
1)  Set your working directory in RStudio with `setwd()`.
2)  Download run_analysis.R into your working directory.
3) Open the script file in RStudio and source it into the console.
4) Call run_analysis()

## Output from run_analysis.R
The script will:
* unzip the raw datasets to a directory called "UCI HAR Dataset" within the working directory.
* create a folder called "tidydata", where it will save tidy datasets:
  - tidydata.txt - A merge of the training and the test sets provided by the raw data, which extracts only the mean and standard deviation for each measurement per subject and activity. Each measurement is found to be repeated 6 times. 
  - tidydata_means.txt -  Takes the tidy data set and calculated the mean of the 6 measurements for each variable for each activity and each subject.

Please see the Code Book (codeBook.md) for more information on the outputted tidy datasets.
To read the output back into R
read.table("./tidydata/tidydata.txt", header=TRUE)
read.table("./tidydata/tidydata_means.txt", header=TRUE)

## Sources

The raw data and more information about the study from which it originated, can be found at the *UCI Center for Machine Learning and Intelligent Systems* Machine Learning Repository: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The data set is associated with the following publication:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

