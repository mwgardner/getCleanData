uciHarCleanData <- function() {
    library(data.table)
        
    # reads in variable descriptions and activity descriptions
    # working directory should include the UCI HAR Dataset folder
    if(!file.exists("UCI HAR Dataset")) {
        stop("UCI Human Activity Recognition (HAR) data folder ('UCI HAR Dataset') not found.")
    }
    setwd("./UCI HAR Dataset")
    featureVariables <- read.table("features.txt")
    featureVariables <- as.character(featureVariables[,2])
    activities <- read.table("activity_labels.txt")
    activities <- as.character(activities[,2])
    
    # reads in training data sets (X, Y, and subject)
    setwd("./train")
    X_data <- read.table("X_train.txt")
    Y_data <- read.table("y_train.txt")
    subjects <- read.table("subject_train.txt")
    
    # merges training and test datasets together (separate X, Y, and subject)
    setwd("../test")
    X_data <- rbind(X_data,read.table("X_test.txt"))
    Y_data <- rbind(Y_data,read.table("y_test.txt"))
    Y_data <- Y_data[,1]
    subjects <- rbind(subjects,read.table("subject_test.txt"))
    subjects <- subjects[,1]
    setwd("../../")
    
    # appropriately labels the dataset with descriptive variable names
    names(X_data) <- featureVariables
    # finds the indices with variable names that contain "mean" or "std"
    meanStdIdx <- c(grep("mean", featureVariables, ignore.case=TRUE), 
                    grep("std", featureVariables, ignore.case=TRUE))
    meanStdIdx <- sort(meanStdIdx)
    # subsets X data for only the mean and standard deviation variables
    X.mean.std_data <- X_data[,meanStdIdx]
    
    # change the Y_data labels to match that of the descriptive activities
    f.Y_data <- factor(Y_data)
    levels(f.Y_data) <- activities
    
    # create complete dataset of X data, associated activity (Y data), and associated subject
    XY.meanStd.data <- cbind("subject" = subjects, "activity" = f.Y_data, X.mean.std_data)
    write.csv(XY.meanStd.data,"./UCI_HAR_mean_stdev.csv", row.names=FALSE)
    XY.data <- cbind("subject" = subjects, "activity" = f.Y_data, X_data)
    
    # splits XY.meanStd.data on activity and subject, and then calculates
    # the mean of only the mean and std variables (86)
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
    vars <- gsub("\\.","",sub("std","StdDev",sub("mean","Mean",
                sub("Mag","Magnitude",sub("Gyro","Gyroscope",
                sub("Acc","Acceleration",sub("^f","Fft",
                sub("^t","time",names(tidyData)))))))))
    names(tidyData) <- vars
    write.table(tidyData, "./tidyData.txt", sep="\t", row.names=FALSE)
    
    # splits XY.data on activity and subject, and then calculates
    # the mean of all variables (561)
    
    ##### not performed ######
    
    # sAll <- split(XY.data, list(XY.data$activity, XY.data$subject))
    # sAllidx <- names(XY.data)[3:563]
    # Mean.sAll <- data.frame(t(sapply(sAll, function(x) colMeans(x[,sAllidx]))))
    # tidyData2 <- cbind("subject" = subjectF, "activity" = activityF, Mean.sAll)
    
    #####
    
    # outputs a tab-delimited text file and returns the second tidy data set
    # write.table(tidyData2, "./tidyData2.txt", sep="\t", row.names=FALSE)
    return(tidyData)
}
    
    