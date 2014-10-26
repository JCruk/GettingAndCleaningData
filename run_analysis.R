##########################################################################################################
# run_analysis.R File Description:

# This script will first set the working directory to its parent directory, which must also contain the 
# UCI HAR Dataset Directory in order to run. It will then check for installation of the the required
# reshape2 package, install it if necessary, and then load it.

# The script will then proceed through the five steps outlined in the course project description to clean the
# UCI HAR Dataset as follows:

# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Names the activities in the data set with descriptive activity names.
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################

# Package to check for required package, install it if necessary, and load it    
packages<-function(x){
        x<-as.character(match.call()[[2]])
        if (!require(x,character.only=TRUE)){
                install.packages(pkgs=x,repos="http://cran.r-project.org")
                require(x,character.only=TRUE)
        }
}
packages(reshape2)

# Set working directory to the directory containing this script (must also contain 'UCI HAR Dataset' directory)
script.dir <- dirname(parent.frame(2)$ofile)
setwd(script.dir)

# 1. Merge the training and the test sets to create one data set.
# Read in the data from files
features     = read.table('UCI HAR Dataset/features.txt',header=FALSE); #imports features.txt
ActivityType = read.table('UCI HAR Dataset/activity_labels.txt',header=FALSE); #imports activity_labels.txt
SubjectTrain = read.table('UCI HAR Dataset/train/subject_train.txt',header=FALSE); #imports subject_train.txt
xTrain       = read.table('UCI HAR Dataset/train/X_train.txt',header=FALSE); #imports x_train.txt
yTrain       = read.table('UCI HAR Dataset/train/y_train.txt',header=FALSE); #imports y_train.txt

# Assigin column names to the data imported above
colnames(ActivityType)  = c('ActivityId','ActivityType');
colnames(SubjectTrain)  = "SubjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "ActivityId";

# Create the final training set by merging yTrain, SubjectTrain, and xTrain
TrainingData = cbind(yTrain,SubjectTrain,xTrain);

# Read in the test data
SubjectTest = read.table('UCI HAR Dataset/test/subject_test.txt',header=FALSE); #imports subject_test.txt
xTest       = read.table('UCI HAR Dataset/test/X_test.txt',header=FALSE); #imports x_test.txt
yTest       = read.table('UCI HAR Dataset/test/y_test.txt',header=FALSE); #imports y_test.txt

# Assign column names to the test data imported above
colnames(SubjectTest) = "SubjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "ActivityId";

# Create the final test set by merging the xTest, yTest and SubjectTest data
TestData = cbind(yTest,SubjectTest,xTest);

# Combine training and test data to create a final data set
FullData = rbind(TrainingData,TestData);

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a vector for the column names from the finalData, which will be used
# to select the desired mean() & stddev() columns
colNames  = colnames(FullData); 

#SelectData <- SelectData[,grepl("mean|std|SubjectId|ActivityId", names(SelectData))] # Uncomment this line to include meanFreq variables
SelectData <- FullData[,grepl("mean|std|SubjectId|ActivityId", names(FullData)) & !grepl("meanFreq", names(FullData))] #Comment out this line to include meanFreq variable

# 3. Use descriptive activity names to name the activities in the data set

# Merge the finalData set with the acitivityType table to include descriptive activity names
FinalData = merge(SelectData,ActivityType,by='ActivityId',all.x=TRUE);

# Update the colNames vector to include the new column names after merge
colNames  = colnames(FinalData); 

# 4. Label the dataset with descriptive, human-readable activity names. 

# Clean up the variable names
 for (i in 1:length(colNames)) 
{
   colNames[i] = gsub("\\()","",colNames[i]) 
   colNames[i] = gsub(".X","X",colNames[i])
   colNames[i] = gsub(".Y","Y",colNames[i])
   colNames[i] = gsub(".Z","Z",colNames[i])
   colNames[i] = gsub("Acc","Accelerometer",colNames[i])
   colNames[i] = gsub(".std","StandardDeviation",colNames[i])
   colNames[i] = gsub(".mean","Mean",colNames[i])
   colNames[i] = gsub("^(t)","TimeDomain",colNames[i])
   colNames[i] = gsub("^(f)","FrequencyDomain",colNames[i])
   colNames[i] = gsub("Freq","Frequency",colNames[i])
   colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
   colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
   colNames[i] = gsub("[Gg]yro","Gyroscope",colNames[i])
   colNames[i] = gsub("Mag","Magnitude",colNames[i])
  };

# Reassign the new descriptive column names to the FinalData dataframe
colnames(FinalData) = colNames;

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Calculate the of each variable and create a new data frame containing the mean of each variable for each subject and activity type
MeanStdData<-melt(FinalData,id.vars=c("SubjectId","ActivityType","ActivityId"));

# Reverse the melt of the data to give a data frame mean of each variable in its own column for each subjectId and activity type
TidyData<-dcast(SubjectId + ActivityType ~ variable, data = MeanStdData, fun=mean)

# Write the tidyData data frame as a table 
write.table(TidyData, "./TidyData.txt",row.names=TRUE,sep='\t');
