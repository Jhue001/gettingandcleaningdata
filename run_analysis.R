
library(dplyr)

if (!dir.exists('./data')) { dir.create('./data')}

##download zip and unzip
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUC
              I%20HAR%20Dataset.zip' , './data/data.zip')
unzip('./data/data.zip', exdir = './data')

##create list of data frames with names
features <- read.table("./data/UCI HAR Dataset/features.txt",
                       col.names = c("n","functions"))
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                        col.names = c("code", "activity"))
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subject")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", 
                     col.names = features$functions)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", 
                     col.names = "code")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",
                            col.names = "subject")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", 
                      col.names = features$functions)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", 
                      col.names = "code")

##merge training and test data
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)

#cbind all data 
Merged_Data <- cbind(Subject, Y, X)

#select only mean and std with subject and activity code
TidyData <- select(Merged_Data, subject, code, contains("mean"), contains('std'))

##sub code for activity name
TidyData$code <- activities[TidyData$code, 2]

##name description
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

##second, independent tidy data set with the average of each variable for 
##each activity and each subject.

resultData <- TidyData %>%
    group_by(subject, activity) %>%
    summarise_each(TidyData, funs(mean))