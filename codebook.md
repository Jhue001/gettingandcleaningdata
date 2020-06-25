---
title: run_analysis.R
output: html_document
---

run_analysis.R script performs preparation for dataset and runs the 5 steps 
required by the course project.

1. Downloads the dataset
  * The dataset is downloaded and extracted under ./data

2. Each data is assigned under one variable
  * features <- features.txt
      The features selected for this database come from the accelerometer and gyroscope        3-axial raw signals tAcc-XYZ and tGyro-XYZ.
  * activities <- activity_labels.txt
      List of activities performed when the corresponding measurements were taken and its       codes (labels)
  * subject_test <- test/subject_test.txt : 2947 rows, 1 column
      contains test data of 9/30 volunteer test subjects being observed
  * x_test <- test/X_test.txt : 2947 rows, 561 columns
      contains recorded features test data
  * y_test <- test/y_test.txt : 2947 rows, 1 columns
      contains test data of activities’code labels
  * subject_train <- test/subject_train.txt : 7352 rows, 1 column
      contains train data of 21/30 volunteer subjects being observed
  * x_train <- test/X_train.txt : 7352 rows, 561 columns
      contains recorded features train data
  * y_train <- test/y_train.txt : 7352 rows, 1 columns
      contains train data of activities’code labels
      
3. Merges training and test data
  * X column is created by merging x_train and x_test
  * Y column is created by merging y_train and y_test
  * Subject column is created by merging subject_train and subject_test
  * Merged_data is created by column binding X, Y and Subject
  
4. Extract only the means and standard deviation for each measurement
  * TidyData is created by selecting only the columns containing means and std
    for each measurement

5. Uses descriptive activity names to name the activities in the data set
  * Values in code has been replaced by their respective activities
  
6. Using appropriate column names
  * column names have been replaced by clearer names
  
7. From the data set in step 4, creates a second, independent tidy data set with
  the average of each variable for each activity and each subject
  * resultData has been created with average of each variable.