## run_analysis.R
##
## This script does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis <- function() {
    
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
    
    # Read in training data
    train_subject = read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", header = FALSE, na.strings = "Not Available", stringsAsFactors = FALSE)
    train_y = read.table(".\\UCI HAR Dataset\\train\\y_train.txt", header = FALSE, na.strings = "Not Available", stringsAsFactors = FALSE)
    train_X = read.table(".\\UCI HAR Dataset\\train\\X_train.txt", header = FALSE, na.strings = "Not Available", stringsAsFactors = FALSE)
    
    # Read in testing data
    test_subject = read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", header = FALSE, na.strings = "Not Available", stringsAsFactors = FALSE)
    test_y = read.table(".\\UCI HAR Dataset\\test\\y_test.txt", header = FALSE, na.strings = "Not Available", stringsAsFactors = FALSE)
    test_X = read.table(".\\UCI HAR Dataset\\test\\X_test.txt", header = FALSE, na.strings = "Not Available", stringsAsFactors = FALSE)
    
    # Merge training data
    train_set <- cbind(train_subject, train_y, train_X)
    
    # Merge testing data
    test_set <- cbind(test_subject, test_y, test_X)
    
    # Merge data sets
    merge_set <- rbind(train_set, test_set)
    
## requirement 2: extract mean and sd measurements

    ## extracted data set will still contain the volunteer and activity columns
    ## the only other columns will be the mean and standard deviation columns for each measurement
    ## these columns are identified in features.txt as those ending in -mean() and -std()

    ## identify the colums that we need from features.txt
    cols <- read.table(".\\UCI HAR Dataset\\features.txt", stringsAsFactors=FALSE)
    mycols <- grepl("-mean\\(\\)|-std\\(\\)", cols$V2)
    ## want to keep first two columns for volunteer and activity
    mycols2 <- c(TRUE, TRUE, mycols)
    ## subset the merged set to extract only the columns we need
    mean_sd_set <- subset(merge_set, select = mycols2)

## requirement 3: Uses descriptive activity names to name the activities in the data set
    ## we want to change the values in column 2 from numbers to activity name
    
    ## read in activity names and name the columns
    anames <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")
    anames <- rename(anames, ACTNUM = V1, ACTIVITY = V2)
    ## merge the data sets; remove the non-descriptive activity column
    named <- merge(anames, mean_sd_set, by.x = "ACTNUM", by.y = "V1.1", all.y = TRUE)
    named <- subset(named, select = -ACTNUM )

## requirement 4: Appropriately labels the data set with descriptive variable names.
    ## get column names from the features file
    cols <- subset(cols, select = V2)
    cnames <- subset(cols, subset = mycols)
    ## add VOLUNTEER and ACTIVITY and assign column names
    cnames2 <- rbind("ACTIVITY", "VOLUNTEER", cnames)
    colnames(named) <- cnames2[,1]
    
## requirement 5: creates a second, independent tidy data set with the average of each variable for each activity and each subject
    ## group the data set by both activity and volunteer and calculate mean of variables for each grouping 
    final <- named %>% group_by(ACTIVITY, VOLUNTEER) %>% summarise_each(funs(mean))
    write.table(final, file = "output.txt", row.name=FALSE)
}