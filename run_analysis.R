#------------------------------------------------------------------------------#
## Download and extract the data
#------------------------------------------------------------------------------#

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "archive.zip", mode = "wb")
unzip("archive.zip") 
file.remove("archive.zip")
#Now the data files are available in the repo "UCI HAR Dataset"


#------------------------------------------------------------------------------#
## Merge the training and the test sets to create one data set.
#------------------------------------------------------------------------------#

# Bind the two groups of observations
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
observation <- rbind(X_train, X_test)

# Bind the subject identifier of the two groups
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(subject_train,subject_test)

# Bind the labels of the two sets 
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
label <- rbind(y_train, y_test)

# Bind all the columns together and clear the rest
data <- cbind(subject, label, observation)
rm(X_train)
rm(X_test)
rm(subject_train)
rm(subject_test)
rm(y_train)
rm(y_test)
rm(subject)
rm(label)
rm(observation)

# Change the names of the variables with the description for "features.txt"
features <- read.table("UCI HAR Dataset/features.txt")
names(data) <- c("subject","label", as.character(features[,2]))
rm(features)


#------------------------------------------------------------------------------#
## Extract only the measurements on the mean and standard deviation 
#------------------------------------------------------------------------------#

extract1 <- data[,c(1:2)]
extract2 <- data[,grepl("mean()", colnames(data), fixed=TRUE)]
extract3 <- data[,grepl("std()", colnames(data), fixed=TRUE)]
# Overwrite the former 'data' which now contains only  the subject number, 
# the activity label and some means and standard deviations
data <- cbind(extract1, extract2,extract3)

# clear the rest of the environment
rm(extract1)
rm(extract2)
rm(extract3)


#------------------------------------------------------------------------------#
## Use descriptive activity names to name the activities in the data set
#------------------------------------------------------------------------------#

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("label","activity")

# Match the activity labels with the activity names and add a new column
data$label <- activity_labels$activity[match(data$label,activity_labels$label)]
names(data)[2] <- "activity"

# Clear the rest of the environment
rm(activity_labels)

#------------------------------------------------------------------------------#
## Appropriately label the data set with descriptive variable names. 
#------------------------------------------------------------------------------#

names(data) <- make.names(names(data))
# Can't really see how to make variable names more descriptive but not too long

#------------------------------------------------------------------------------#
## From the data set in step 4, create a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
#------------------------------------------------------------------------------#


library(dplyr)
data <- tbl_df(data)
data2 <- data %>% group_by(activity, subject) %>% summarise_each(funs(mean))

write.table(data2, "tidydata.txt")

### End of script

