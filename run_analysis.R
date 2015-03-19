library(plyr)

######################            Accessing the Data               ##################################

# Download the data set at the following address
if (!file.exists("projectdata.zip")) {
        download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "projectdata.zip", method = "curl")
}

# Unzip the dataget
if (!file.exists("UCI HAR Dataset")) {
        unzip("projectdata.zip")
}

####################################################################################################

# Step 1
# Merge the training and test sets to create one data set
###############################################################################

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set
y_data <- rbind(y_train, y_test)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)

# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################

Features <- read.table("UCI HAR Dataset/features.txt")

# get only columns with mean() or std() in their names
ColumnsWanted <- grep("-(mean|std)\\(\\)", Features[, 2])

# subset the desired columns
x_data <- x_data[, ColumnsWanted]

# correct the column names
names(x_data) <- Features[ColumnsWanted, 2]

# Step 3
# Use descriptive activity names to name the activities in the data set
###############################################################################

Activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- Activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

# Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################

# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
MergedData <- cbind(x_data, y_data, subject_data)

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

# 66 <- 68 columns but last two (activity & subject)
AveragesData <- ddply(MergedData, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(AveragesData, "Tidy_AveragesData.txt", row.name=FALSE)

