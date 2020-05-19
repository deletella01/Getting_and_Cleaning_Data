
library(plyr)

# Download the Project Dataset and save in a Folder 
if(!file.exists("./UntidyDataDownload")){dir.create("./UntidyDataDownload")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./UntidyDataDownload/WK4ProjectDataset.zip")

# Unzip and Extract the Dataset to the Folder
unzip(zipfile = "./UntidyDataDownload/WK4ProjectDataset.zip", exdir = "./UntidyDataDownload")

# Step 1:Merges the training and the test sets to create one data set.

 # 1.1:Read .txt files into R

  # 1.1.1:Reading training datasets
test_X <- read.table("./UntidyDataDownload/UCI HAR Dataset/test/X_test.txt")
test_Y <- read.table("./UntidyDataDownload/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UntidyDataDownload/UCI HAR Dataset/test/subject_test.txt")

  # 1.1.2:Reading test datasets
train_X <- read.table("./UntidyDataDownload/UCI HAR Dataset/train/X_train.txt")
train_Y <- read.table("./UntidyDataDownload/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UntidyDataDownload/UCI HAR Dataset/train/subject_train.txt")


  # 1.1.3:Reading feature vector
features <- read.table("./UntidyDataDownload/UCI HAR Dataset/features.txt")

  # 1.1.4:Reading activity labels
activity_labels <- read.table("./UntidyDataDownload/UCI HAR Dataset/activity_labels.txt")

 # 1.2:Assigning descriptive variable names to test and train datasets.

colnames(test_X) <- features[,2]
colnames(test_Y) <- "activityID"
colnames(subject_test) <- "subjectID"

colnames(train_X) <- features[,2]
colnames(train_Y) <- "activityID"
colnames(subject_train) <- "subjectID"

colnames(activity_labels) <- c("activityID", "activityType")

 # 1.3:Merging all test and train datasets into one set
train_merge <- cbind(train_Y, subject_train, train_X)
test_merge <- cbind(test_Y, subject_test, test_X)
merged_data <- rbind(train_merge, test_merge)

# Step 2:Extracts only the measurements on the mean and standard deviation for each measurement.

 # 2.1 Reading column names into a vector
colNames <- colnames(merged_data)

 # 2.2:Create another vector to define ID, mean, and standard deviation(sd)
mean_and_sd <- (grepl("activityID", colNames) |
                     grepl("subjectID", colNames) |
                     grepl("mean..", colNames) |
                     grepl("std...", colNames)
)

 # 2.3 Creating a new new dataset that contains only the mean and standard deviation of the variables
dataForMeanandSd <- merged_data[ , mean_and_sd == TRUE]

# Step 3: Uses descriptive activity names to name the activities in the data set
dataWithActivityNames <- merge(dataForMeanandSd, activity_labels,
                               by = "activityID",
                               all.x = TRUE)

# Step 4: Label the data set with descriptive variable names.
# In Step 1.2, it is shown that activity_labels contains different activities carried out by
 # different subjects. This activities are represented by a corresponding digit known as the 
 # activityID column merged in Step 2.3. This is changed to each respective decriptive name
 # in Step 5.2.


# Step 5: From the data set in step 4, creates a second, independent tidy data set with the 
 # average of each variable for each activity and each subject. 

 # 5.1: Making a second tidy data set with the average of each variable for each activity
  # and each subject.
tidyData <- aggregate(. ~subjectID + activityID, dataWithActivityNames, mean)
tidyData <- tidyData[order(tidyData$subjectID, tidyData$activityID), ]

# 5.2: Each respective descriptive name is allocated to each activity.

descriptiveNames<-activity_labels$activityType
tidyData$activityID<-descriptiveNames[tidyData$activityID]

 # 5.3: Writing second tidy data set into a txt file
write.table(tidyData, "TidyData.txt", row.names = FALSE)

