uciCleanData <- function() {
    library(data.table)
    library(tools)
    library(plyr)
    
    # reads in variable descriptions and activity descriptions
    setwd("~/Education/Coursera_DataScience/UCI HAR Dataset")
    featureVariables <- read.table("features.txt")
    featureVariables <- as.character(featureVariables[,2])
    activities <- read.table("activity_labels.txt")
    activities <- as.character(activities[,2])
    
    # reads in training data sets (X, Y, and subject)
    setwd("~/Education/Coursera_DataScience/UCI HAR Dataset/train")
    X_data <- read.table("X_train.txt")
    Y_data <- read.table("y_train.txt")
    subjects <- read.table("subject_train.txt")
    
    # merges training and test datasets together (separate X, Y, and subject)
    setwd("~/Education/Coursera_DataScience/UCI HAR Dataset/test")
    X_data <- rbind(X_data,read.table("X_test.txt"))
    Y_data <- rbind(Y_data,read.table("y_test.txt"))
    Y_data <- Y_data[,1]
    subjects <- rbind(subjects,read.table("subject_test.txt"))
    subjects <- subjects[,1]
    
    # appropriately labels the dataset with descriptive variable names
    names(X_data) <- featureVariables
    meanStdIdx <- c(grep("mean", featureVariables, ignore.case=TRUE), 
                    grep("std", featureVariables, ignore.case=TRUE))
    meanStdIdx <- sort(meanStdIdx)
    X.mean.std_data <- X_data[,meanStdIdx]
    
    # change the Y_data labels to match that of the descriptive activities
    f.Y_data <- factor(Y_data)
    levels(f.Y_data) <- activities
    
    # create complete dataset of X data, associated activity (Y data), and associated subject
    # XY.meanStd.data <- cbind(X.mean.std_data, "activity" = Y_data, "subject" = subjects)
    # XY.data <- cbind(X_data, "activity" = Y_data, "subject" = subjects)
    XY.meanStd.data <- cbind("subject" = subjects, "activity" = f.Y_data, X.mean.std_data)
    write.csv(XY.meanStd.data,"../UCI_HAR_mean_stdev.csv", row.names=FALSE)
    XY.data <- cbind(X_data, "activity" = f.Y_data, "subject" = subjects)
    
    # split and get means of variables for each activity and each subject
    # (assumes interaction of activity and subject = 180 elements in list)
    
    # produces the mean for only the mean and std variables (86)
    sMeanStd <- split(XY.meanStd.data, list(XY.meanStd.data$activity, XY.meanStd.data$subject))
    sMeanStdidx <- sort(c(grep("mean", names(XY.meanStd.data), ignore.case=TRUE), 
                           grep("std", names(XY.meanStd.data), ignore.case=TRUE)))
    Mean.sMeanStd <- data.frame(t(sapply(sMeanStd, function(x) colMeans(x[,sMeanStdidx]))))
    # applies descriptive names of rows and columns
    rownames <- row.names(Mean.sMeanStd)
    activity.subject <- t(sapply((strsplit(rownames, ".", fixed=TRUE)),c))
    activityF <- activity.subject[,1]
    subjectF <- as.numeric(activity.subject[,2])
    tidyData <- cbind("subject" = subjectF, "activity" = activityF, Mean.sMeanStd)
    write.csv(tidyData, "../tidyData.csv", row.names=FALSE)
    
    # produces the mean for all variables (561)
    sAll <- split(XY.data, list(XY.data$activity, XY.data$subject))
    sAllidx <- names(XY.data)[1:561]
    Mean.sAll <- data.frame(t(sapply(sAll, function(x) colMeans(x[,sAllidx]))))
    tidyData2 <- cbind("subject" = subjectF, "activity" = activityF, Mean.sAll)
    write.csv(tidyData2, "../tidyData2.csv", row.names=FALSE)
    
    return(tidyData2)
}
    
    