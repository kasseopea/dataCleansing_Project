#Course Project : Mariah Azlan

library(plyr)

#1- Merges the training and the test sets to create one data set.
  #READ ALL FILES
  #First read the labels
  activity_labels <- read.table("./activity_labels.txt")
  colnames(activity_labels)[1] <- "id"
  colnames(activity_labels)[2] <- "Activity"
  data_labels <- read.table("./features.txt")
  
  #Read test samples
  test_data <- read.table("./test/X_test.txt")
  test_subject_data <- read.table("./test/subject_test.txt")
  test_activity_data <- read.table("./test/y_test.txt")
  
  #Read training samples
  train_data <- read.table("./train/X_train.txt")
  train_subject_data <- read.table("./train/subject_train.txt")
  train_activity_data <- read.table("./train/y_train.txt")
  
  #name the columns
  colnames(test_data) <- data_labels[,2]
  colnames(train_data) <- data_labels[,2]
  
  #Merge the data observations with test subject IDs and test activity IDs and rename the columns 
  test_data <- cbind(test_subject_data,test_activity_data,test_data)
  colnames(test_data)[1] <- "Subject"
  colnames(test_data)[2] <- "Activity"
  
  #Merge the data observations with test subject IDs and test activity IDs and rename the columns 
  train_data <- cbind(train_subject_data,train_activity_data,train_data)
  colnames(train_data)[1] <- "Subject"
  colnames(train_data)[2] <- "Activity"
  
  #now merge the two data sets
  master_data <- rbind(test_data,train_data)

  
#2- Extracts only the measurements on the mean and standard deviation for each measurement
  col_names <- names(master_data)
  std_cols <- grep( "mean\\(\\)", col_names) # extract the column numbers with mean()
  mean_cols <- grep ( "std\\(\\)", col_names) # extract the column numbers with std()
  valid_cols <- c(1,2,std_cols, mean_cols) # adding subject and activity as the first two columns in addition std and mean cols
  mean_std_data <- master_data[, valid_cols] 

#3 - Uses descriptive activity names to name the activities in the data set
  master_activity <- data.frame(master_data[,2]) #extract activity IDs in the second column
  names(master_activity)[1] <- "id"
  temp_str <- join(master_activity, activity_labels)
  master_data[,2] <- temp_str[,2]
  
# #4 Appropriately labels the data set with descriptive variable names
#   #variable subject had already been added earlier, now just rename
#   colnames(master_data)[1] <- "Subject"
#   colnames(master_data)[2] <- "Activity"
#   
# #5 From the data set in step 4, creates a second, independent tidy data set 
# #  with the average of each variable for each activity and each subject.
# 
#   