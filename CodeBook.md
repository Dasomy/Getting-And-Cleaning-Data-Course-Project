# Codebook

## Overview
The `run_analysis.R` script performs the following steps as defined by the project's requirements.  
1. The script checks if `plyr` package is installed. If it isn't, it is first installed and then loaded. In the first step, all relevant data are merged together with `rbind()`.  
2. From the merged data, only the columns with the mean and standard deviation information are extracted. These column names are updated with their corresponding names from `features.txt`.  
3. Activity names are updated with their corresponding labels from `activity_labels.txt`.  
4. All column names are assigned with human understandable names. After binding the data, activity labels, and the subject list, you get the full data.  
5. From the full data, a tidy data set containing average measures for each activity for each subject. The results are saved to `average_data.txt`.

## Variables
Variables `xTest`, `yTest`, `subjectTest`, `xTrain`, `yTrain`, `subjectTrain` are objects holding the data from the downloaded resources.
* `xTest` : values of the test data
* `yTest` : labels of the test data
* `subjectTest` : list of subjects who performed the activity for each window sample
* `xTrain` : values of the train data
* `yTrain` : labels of the train data
* `subjectTrain` : list of subjects who performed the activity for each window sample

`x`, `y`, and `subject` are merged from the above data for further processing.
* `x` : `xTest` and `xTrain`
* `y` : `yTest` and `yTrain`
* `subject` : `subjectTest` and `subjectTrain`

`features` is loaded from `features.txt` and has all the features of the dataset.
`meanStd` contains the rows with mean and std extracted from `features`.
`activityLabels` contains the list of labels (1 ~ 6) and their corresponding activities.

`fullData` is the complete data set merged from `x`, `y`, and `subject`.
`avgData` is the data set with the average of each variable and each subject. `ddply()` in the `plyr` package was used to implement this. It applies the `colMeans()` function. This is later written to `average_data.txt`.
