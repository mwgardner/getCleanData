getCleanData
============
### run_analysis.R
The run_analysis.R script reads and processes the Human Activity Recognition (HAR) Using Smartphones Data Set, consisting of accelerometer and gyroscope sensor data collected from Samsung Galaxy S II smartphones, which is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The script is run using the command: `uciHarCleanData()`.  
`tidyData <- uciHarCleanData()`

#### Script Requirements
`library(data.table)`

### Script Details
The script specifically reads in the data, located in the folder "UCI HAR Dataset" within the working directory, and then:
* merges the training and test data sets into a single dataset
* extracts only the mean and standard deviation measurement variables
	* includes mean measurements and standard deviation measurements
	* does not include mean frequency measurements (weighted average of the frequency components to obtain a mean frequency) or mean measurements on the angle variable
	* write a comma-separated value file (`UCI_HAR_mean_stdev.csv`) of all data of mean and standard deviation measurements
* calculates the mean of the mean and standard deviation measurement variables (66 variables) for each subject and activity
    * writes a tab-separated text file (`tidyData.txt`) with these mean values in the working directory
    * output text file can be read into R using the following command:  
    `read.table("./tidyData.txt", header=TRUE, sep="\t")`