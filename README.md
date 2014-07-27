getCleanData
============
## run_analysis.R
The run_analysis.R script reads and processes the Human Activity Recognition (HAR) Using Smartphones Data Set, consisting of accelerometer and gyroscope sensor data collected from Samsung Galaxy S II smartphones, which is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The script is run using the command: uciHarCleanData().

### Script Requirements
library(data.table)

### Script Details
The script specifically reads in the data, located in the folder "UCI HAR Dataset" within the working directory, and then:
* merges the training and test data sets into a single dataset
* extracts only the mean and standard deviation measurement variables
* calculates the mean of the mean and standard deviation measurement variables for each subject and activity
    * writes a comma-separated value file (tidyData.csv) with these mean values in the working directory
* calculates the mean of all variables (from the merged training and test HAR data sets) for each subject and activity
    * writes a comma-separated value file (tidyData2.csv) with these mean values in the working directory
    * returns this tidy data set as a data.frame