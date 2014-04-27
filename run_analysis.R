setwd("C:/Users/Hidetoshi/Documents/MY Learning/Data Science/Getting and Cleaning Data/project")
##
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep="")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", sep="")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep="")
X_train$activity <- as.factor(y_train[,1])
X_train$subject <- as.factor(subject_train[,1])
##
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep="")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", sep="")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep="")
X_test$activity <- as.factor(y_test[,1])
X_test$subject <- as.factor(subject_test[,1])
##
features <- read.table("./UCI HAR Dataset/features.txt", sep="")
names(X_train)[1:561] <- as.character(features[, 2])
names(X_test)[1:561] <- as.character(features[, 2])
## merge
dataset <-rbind(X_train, X_test) 
## extract
a <- grep("mean", features[,2])
b <- grep("std", features[,2])
meanstdData <- dataset[,c(a,b,562,563)]
##labels activity name
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep="")
levels(meanstdData$activity) <- activity_labels[,2]
##create a tidy data. (Not sure if this is it.)
index <- list(a=meanstdData$activity, b=meanstdData$subject) ## index by activity by subject
dataList <- split(meanstdData[,-(80:81)], index)
meanDataList <- lapply(dataList, colMeans)
tidyData <- t(data.frame(meanDataList))
save(tidyData, file="./tidyData") 
## save for upload
write.table(tidyData, file="./tidyData.txt", sep=" ")
