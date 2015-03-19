### If you have not yet install the package plyr:  ###
###  install.packages("plyr")

library(plyr)

###  Accessing the Data  ###
# CAUTION: We assume that you have saved "run_analysis.R" in your working dirctory !!!

# Download the data set at the following address
if (!file.exists("projectdata.zip")) {
        download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "projectdata.zip", method = "curl")
}

# Unzip the dataset
if (!file.exists("UCI HAR Dataset")) {
        unzip("projectdata.zip")
}

# STEP 1
# Merge the training and test sets to create one data set

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Creating the 'x' data set
x_data <- rbind(x_train, x_test)

# CreatING the 'y' data set
y_data <- rbind(y_train, y_test)

# CreatING the 'subject' data set
subject_data <- rbind(subject_train, subject_test)

## STEP 2
## Extract only the measurements on the mean and standard deviation for each measurement

Features <- read.table("UCI HAR Dataset/features.txt")

# We want only the columns including mean() or std() in their names
ColumnsWanted <- grep("-(mean|std)\\(\\)", Features[, 2])

# We subset these specific columns
x_data <- x_data[, ColumnsWanted]

# We correct the columns names
names(x_data) <- Features[ColumnsWanted, 2]

### STEP 3
### Use descriptive activity names to name the activities in the data set

Activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# We update all values with correct activity names
y_data[, 1] <- Activities[y_data[, 1], 2]

# We correct the column name
names(y_data) <- "activity"

#### STEP 4
#### Appropriately label the data set with descriptive variable names

# We correct the column name
names(subject_data) <- "subject"

# We merge all the data in a single data set
MergedData <- cbind(x_data, y_data, subject_data)

##### STEP 5
##### Create a second, independent tidy data set with the average of each variable
##### for each activity and each subject

AveragesData <- ddply(MergedData, .(subject, activity), function(x) colMeans(x[, 1:66]))

###   the requested Tidy data are given in the .txt file defined below  ###

write.table(AveragesData, "Tidy_AveragesData.txt", row.name=FALSE)

