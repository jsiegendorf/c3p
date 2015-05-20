# c3p
Getting and Cleaning Data project repository

OS: Windows 7
R version: 3.1.3
Package Dependencies: dplyr

## run_analysis.R
##
## This script does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## requirement 1: read and combine data sets
    
    ## Volunteers 1-30 are separated into train and test groups. 
    ## The volunteer number is captured in the subject_train and subject_test files.
    ## The activity number is captured in the y_train and y_test files.
    ## The data set will be created as follows:
    ##      - The first column will be the volunteer number from the subject files
    ##      - The second column will be the activity number from the y files
    ##      - The rest of the columns will data from the x files
    ##
    ## Train and test data are read in separately. Columns will be merged within each set.
    ## Then the two sets will have rows merged.
    

## requirement 2: extract mean and sd measurements

    ## extracted data set will still contain the volunteer and activity columns
    ## the only other columns will be the mean and standard deviation columns for each measurement
    ## these columns are identified in features.txt as those ending in -mean() and -std()


## requirement 3: Uses descriptive activity names to name the activities in the data set
    ## we want to change the values in column 2 from numbers to activity name
    ## activity names are sourced from the activity_labels.txt file
    

## requirement 4: Appropriately labels the data set with descriptive variable names.
    ## get column names from the features file
    ## add VOLUNTEER and ACTIVITY and assign column names
    
    
## requirement 5: creates a second, independent tidy data set with the average of each variable for each activity and each subject
    ## group the data set by both activity and volunteer and calculate mean of variables for each grouping 

