setwd("~/Getting-and-Cleaning-Data")
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

######################  Reading the Training data (containing 561 variables initially) ####################################
Training <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE); 
Training[,562] <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE);
Training[,563] <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE);

######################   Reading the Testing data (containing 561 variables initially)  ####################################
Testing <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE);
Testing[,562] <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE);
Testing[,563] <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE);

######################   Reading the ActivityLabels (containing 2 variables)   ###################################
ActivityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE);

###################### Reading Features (containing 2 variables) #################################################
# We proceed with substitution of Features names better suited for R 
Features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE);
Features[,2] <- gsub('-mean', 'Mean', Features[,2]);
Features[,2] <- gsub('-std', 'Std', Features[,2]);

#####################                 STEP 1                          ###############################
#############   Merges the training and the test sets to create one data set   ######################
MergeData<- rbind(Training, Testing)

#####################                 STEP 2                            #############################
###    Extracts only the measurements on the mean and standard deviation for each measurement     ### 
Columns_Wanted<- grep(".*Mean.*|.*Std.*", Features[,2])
# First reduce the features table to what we want
Features<- Features[Columns_Wanted,]

####################       Adding the last two columns (subject and activity)    ####################
Columns_Wanted<- c(Columns_Wanted, 562, 563)

####################       Removing the unwanted columns from MergeData          #####################
MergeData<- MergeData[,Columns_Wanted]

#######################                STEP 3                                    ####################
##########      Uses descriptive activity names to name the activities in the data set    ###########
##########      Adding the column names (features) to MergeData                  ####################
colnames(MergeData)<- c(Features$V2, "Activity", "Subject")
colnames(MergeData)<- tolower(colnames(MergeData))

currentActivity = 1
for (currentActivityLabel in ActivityLabels$V2) {
        MergeData$activity <- gsub(currentActivity, currentActivityLabel, MergeData$activity)
        currentActivity <- currentActivity + 1
}

#######################                 STEP 4                                     ##################
###########      Appropriately labels the data set with descriptive variable names        ###########
MergeData$activity <- as.factor(MergeData$activity)
MergeData$subject <- as.factor(MergeData$subject)

#######################                 STEP 5                                 ######################
###        Creates a second, independent tidy data set with the average of each variable          ###
###                       for each activity and each subject                                      ###
TidyData = aggregate(MergeData, by=list(activity<- MergeData$activity, subject<- MergeData$subject), mean)

###     The means of the subject and activity columns provide no information: we remove them      ###
TidyData[,90] = NULL
TidyData[,89] = NULL

#######################          The table is saved in a .txt file       ############################
write.table(TidyData, "Tidy_Data.txt", sep="\t", row.name=FALSE)
