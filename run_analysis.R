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
    
    # appropriately labels the dataset with descriptive variable names,
    # but odd characters are still included
    names(X_data) <- featureVariables
    # finds the indices with mean and std. dev. variable measurements
    meanStdIdx <- c(grep("mean\\(\\)", featureVariables, ignore.case=TRUE,value=TRUE), 
                    grep("std\\(\\)", featureVariables, ignore.case=TRUE,value=TRUE))
    meanStdIdx <- sort(meanStdIdx)
    
    # subsets X data for only the mean and standard deviation variables
    X.mean.std_data <- X_data[,meanStdIdx]
    
    # change the Y_data labels to match that of the descriptive activities
    f.Y_data <- factor(Y_data)
    levels(f.Y_data) <- activities
    
    # create complete dataset of X data, associated activity (Y data), and associated subject
    XY.meanStd.data <- cbind("subject" = subjects, "activity" = f.Y_data, X.mean.std_data)
    
    # cleanup variable names and make more descriptive
    vars <- gsub("\\(\\)","",
                gsub("-","",
                sub("std","StdDev",
                sub("mean","Mean",
                sub("BodyBody","Body",
                sub("Mag","Magnitude",
                sub("Gyro","Gyroscope",
                sub("Acc","Acceleration",
                sub("^f","fft",
                sub("^t","time",names(XY.meanStd.data)))))))))))
    names(XY.meanStd.data) <- vars
    
    # write all measurements on mean and std. dev. variables to a *.csv file
    write.csv(XY.meanStd.data,"./UCI_HAR_mean_stdev.csv", row.names=FALSE)
        
    # splits XY.meanStd.data on activity and subject, and then calculates
    # the mean of only the mean and std variables (66)
    sMeanStd <- split(XY.meanStd.data, list(XY.meanStd.data$activity, XY.meanStd.data$subject))
    
    sMeanStdidx <- seq(3,length(names(XY.meanStd.data)),by=1)
    Mean.sMeanStd <- data.frame(t(sapply(sMeanStd, function(x) colMeans(x[,sMeanStdidx]))))
    
    # applies descriptive names of rows and columns
    rownames <- row.names(Mean.sMeanStd)
    activity.subject <- t(sapply((strsplit(rownames, ".", fixed=TRUE)),c))
    activityF <- activity.subject[,1]
    subjectF <- as.numeric(activity.subject[,2])
    tidyData <- cbind("subject" = subjectF, "activity" = activityF, Mean.sMeanStd)
    
    # writes tidyData as a tab-delimited text file and returns tidyData
    write.table(tidyData, "./tidyData.txt", sep="\t", row.names=FALSE)
    return(tidyData)
}
    
    