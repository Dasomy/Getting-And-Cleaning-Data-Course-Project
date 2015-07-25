## 0. Loads plyr package.

## Check if plyr package is installed. If not installed, install first.
if ("plyr" %in% rownames(installed.packages()) == FALSE) {
  install.packages("plyr")
}
library(plyr)
###############################################################################################
###############################################################################################


## 1.
## Merge the training and the test sets to create one data set.

## 1.1 Load resources from train and test folders
xTest <- read.table("test/X_test.txt")
yTest <- read.table("test/y_test.txt")
subjectTest <- read.table("test/subject_test.txt")

xTrain <- read.table("train/X_train.txt")
yTrain <- read.table("train/y_train.txt")
subjectTrain <- read.table("train/subject_train.txt")

## 1.2 Create 'x', 'y' and 'subject' data sets by merging them
x <- rbind(xTest, xTrain)
y <- rbind(yTest, yTrain)
subject <- rbind(subjectTest, subjectTrain)
###############################################################################################
###############################################################################################


## 2. 
## Extracts only the measurements on the mean and standard deviation for each measurement. 

## 2.1 Load features
features <- read.table("features.txt")

## 2.2 Get rows with mean and std in their names from features.txt
meanStd <- grep("mean|std", features[, 2])

## 2.3. Subset data with mean and std from 'x'
x <- x[, meanStd]

## 2.4 Update names of 'x' with their corresponding mean/std names
names(x) <- features[meanStd, 2]
###############################################################################################
###############################################################################################


## 3. 
## Uses descriptive activity names to name the activities in the data set

## 3.1 Load activity labels
activityLabels <- read.table("activity_labels.txt")

## 3.2 Update 'y' data values with their corresponding names
y[, 1] <- activityLabels[y[, 1], 2]

## 3.3 Update name of 'y'
names(y) <- "activity"
###############################################################################################
###############################################################################################

## 4. 
## Appropriately labels the data set with descriptive variable names.

## 4.1 Update name of 'subject'
names(subject) <- "subject"

## 4.2 Bind all data into one dataset 
fullData <- cbind(x, y, subject)
###############################################################################################
###############################################################################################

## 5. 
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## 5.1 Get average data
avgData <- ddply(fullData, .(subject, activity), function(X) colMeans(X[, 1:66])) ## Using uppercase 'X' to distinguish from 'x'

## 5.2 Write the average data to the file "average_data.txt"
write.table(avgData, "average_data.txt", row.names = FALSE)