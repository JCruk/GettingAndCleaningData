#CodeBook for `TidyData.txt`

##Data source
The oringal data used as input for generating 'TidyData.txt' was derived from the "Human Activity Recognition Using Smartphones Data Set" (HAR) and was provided as part of the John's Hopkins Coursera Getting and Cleaning Data course as a [download link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). A full description of the data used in this project is available at: [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The following files are available for the train and test data. Their descriptions are equivalent. 

##Data Manipulation
The data present in `TidyData.txt` was generated using an R script, `run_analysis.R`, which is available on this repository. The comments within the script describe each step taken to manipulate the input data, these Steps are also detailed in the file `README.md`, also available on this repository.

The goal of the `run_analysis.R` script is to generate a tidy dataset. This is accomplished through several sections of the script that correspond with the steps outlined in the assigned project: 

###Section 1. Merge the training and the test sets to create one data set.

After setting the source directory for the files, read into tables the data located in
- features.txt
- ActivityType.txt
- SubjectTrain.txt
- xTrain.txt
- yTrain.txt
- SubjectTest.txt
- xTest.txt
- yTest.txt

Assign column names and merge to create one data set.

###Section 2. Extract only the measurements on the mean and standard deviation for each measurement. 

Create a logcal vector that contains TRUE values for the SubjectId, mean and stdev columns and FALSE values for the others.
Subset this data to keep only the necessary columns.

###Section 3. Use descriptive activity names to name the activities in the data set

Merge data subset with the ActivityType table to append the descriptive activity names

###Section 4. Appropriately label the data set with descriptive activity names.

Use the gsub function to clean up data labels with consistent, human-readable names.

###Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
 
Per the project instructions, we need to produce only a data set with the average of each veriable for each activity and subjec

##Features 
 
A full description of the features contained the 'features_info.txt" files contained in the original dataset. As stated in that file:

> The features selected for this database come from the accelerometer and
> gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals
> (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then
> they were filtered using a median filter and a 3rd order low pass Butterworth
> filter with a corner frequency of 20 Hz to remove noise. Similarly, the
> acceleration signal was then separated into body and gravity acceleration
> signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth
> filter with a corner frequency of 0.3 Hz. 
> 
> Subsequently, the body linear acceleration and angular velocity were derived in
> time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the
> magnitude of these three-dimensional signals were calculated using the
> Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag,
> tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals
> producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag,
> fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain
> signals). 
> 
> These signals were used to estimate variables of the feature vector for each
> pattern:  '-XYZ' is used to denote 3-axial signals in the X, Y and Z
> directions.
> 
> tBodyAcc-XYZ
> tGravityAcc-XYZ
> tBodyAccJerk-XYZ
> tBodyGyro-XYZ
> tBodyGyroJerk-XYZ
> tBodyAccMag
> tGravityAccMag
> tBodyAccJerkMag
> tBodyGyroMag
> tBodyGyroJerkMag
> fBodyAcc-XYZ
> fBodyAccJerk-XYZ
> fBodyGyro-XYZ
> fBodyAccMag
> fBodyAccJerkMag
> fBodyGyroMag
> fBodyGyroJerkMag

##Format & variables in 'TidyData.txt'

The project instructions explicitly state "Extract only the measurements on the mean and standard deviation for each measurement."
For this reason, I included all variables pertaining to mean and standard deviation, with the exception of *meanFreq* variables 
as these are distinct measurements and not measurement means.

`tidydata.txt` is a comma-separated values file which can be read by R's
`read.table` function. The data contains the following identifier columns:

| Column Name | Description                                                    |
| ----------- | -------------------------------------------------------------- |
| SubjectId     | An integer identifying a single test subject. There are 30 subjects in total. |
| ActivityType    | A factor identify the type of activity the measurements were derived from. Possible values are: `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING` and `LAYING`. |

In addition, each row has 66 columns denoting measurements for each combination
of identifiers. The column names take the following format:

`````
<MeasurementDomain><ForceType><MeasurementSource><Jerk><Type><Axis>
``````

`MeasurementDomain` may be either `TimeDomain` or `FrequencyDomain`.

`ForceType` may be either `Body` or `Gravity`.
This indicates whether the measurment came from acceleration of the subjects' body or gravity

`MeasurementSource` generally includes either `Accelerometer` or `Gyroscope`.
This indicates the source of the measurements. In addition, some columns may
further include descriptions of the measurement, such as `Magnitude`.

`Jerk` indicates measurements where the body linear acceleration and angular velocity were derived in time along the given axis

`Type` may be either `Mean`, indicating an average, or `StandardDeviation`, indicating
standard deviation.

`Axis` may or may not be present and indicates the axis of movement in which the
measurements took place. This can be either `X`, `Y` or `Z`.


