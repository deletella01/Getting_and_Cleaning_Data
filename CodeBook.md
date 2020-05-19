# Getting and Cleaning Data CodeBook
This code book describes the variables, the data, and any transformations or work that was performed to clean up the data. 

## Variables

-test_X, test_Y, subject_test, train_X, train_Y, subject_train, features,and activity_labels: this are .txt files from the given dataset that was downloaded and read into R.
	
-train_merge: this is a vector that merges the columns of all train dataset.
 
-test_merge: this is a vector that merges the columns of the all test dataset.
 
-merged_data: this is a vector that joins the rows of the merged test dataset to the merged train dataset.

-colNames: the column names of the merged data is assigned to this vector.

-mean_and_sd: this vector is used to store column names of only the activity ID, subject ID, mean and standard deviation.

-dataForMeanandSd: the columns with the specific variables values named above, are assigned to this vector.

-dataWithActivityNames: this vector contains the merge of the dataset created to the different activities in activity label.

-tidyData: the final average of the mean and standard deviation value is computed and the result is ordered according to the different subjects and their different activities. This is stored in this vector as the final dataset.

-descriptiveNames: a vector used to store the various activities carried out by each subject.
 
## Steps to Clean Data
-Download the Project Dataset and save in a Folder.

-Unzip and Extract the Dataset to the Folder.

-Step 1: Merges the training and the test sets to create one data set.

 1.1: Read .txt files into R.
 
  1.1.1: Reading training datasets .
  
  1.1.2:Reading test datasets. 
  
  1.1.3:Reading feature vector. 
  
  1.1.4:Reading activity labels.
  
 1.2: Assigning descriptive variable names to test and train datasets.
 
 1.3:Merging all test and train datasets into one set.
 
-Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

  2.1 Reading column names into a vector.
  
  2.2:Create another vector to define ID, mean, and standard deviation(sd). 
  
  2.3 Creating a new new dataset that contains only the mean and standard deviation of the variables.
  
-Step 3: Uses descriptive activity names to name the activities in the data set.

-Step 4: Label the data set with descriptive variable names. In Step 1.2, it is shown that activity_labels contains different activities carried out by different subjects. This activities are represented by a corresponding digit known as the activityID column merged in Step 2.3. This is changed to each respective decriptive name in Step 5.2.

-Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

 5.1 Making a second tidy data set with the average of each variable for each activity and each subject.  

# 5.2: Each respective descriptive name is allocated to each activity.

 5.3 Writing second tidy data set into a txt file.
