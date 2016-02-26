# Getting and Cleaning Data - Course Project
  # by MindMui

# load test data set
  subject_test = read.table("data/test/subject_test.txt")
  X_test = read.table("data/test/X_test.txt")
  Y_test = read.table("data/test/Y_test.txt")

# load training data set
  subject_train = read.table("data/train/subject_train.txt")
  X_train = read.table("data/train/X_train.txt")
  Y_train = read.table("data/train/Y_train.txt")
  
# load lookup information
  features <- read.table("data/features.txt", col.names=c("FeatureId", "FeatureLabel"))
  activities <- read.table("data/activity_labels.txt", col.names=c("ActivityId", "ActivityLabel"))
  IncludedFeatures <- grep("-mean\\(\\)|-std\\(\\)", features$FeatureLabel) # Task 2: extracts only mean and std are selected
    # get the index using grep()
  
# Task 1: merge the test and training data
  subject <- rbind(subject_test, subject_train)
  names(subject) <- "SubjectID"
  
  X <- rbind(X_test, X_train)
  X <- X[, IncludedFeatures] # only the info with mean and std
  # remove brackets ()
  names(X) <- gsub("\\(|\\)", "", features$FeatureLabel[IncludedFeatures])

  Y <- rbind(Y_test, Y_train)
  names(Y) = "activityId"
  allactivity <- merge(Y, activities, by.x ="activityId",by.y="ActivityId")
  # activity list without the id:
  Activity <- allactivity$ActivityLabel
  
# merge data frames of different columns to form one data table
  data <- cbind(subject, X, Activity)
  write.table(data, "merged_tidy_data.txt") # output
  
# Task 5: creates an independent tidy data set 
  # with the average of each variable for each activity and each subject.
  library(data.table)
  dat <- data.table(data)
  calculatedData<- dat[, lapply(.SD, mean), by=c("SubjectID", "Activity")]
  write.table(calculatedData, "calculated_tidy_data.txt", row.names = FALSE) # output
  


  
  