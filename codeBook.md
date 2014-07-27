run_analysis.R Code Book
============
### Data Set Information
The Human Activity Recognition (HAR) Using Smartphones Data Set, available from the UCI Machine Learning Repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), is processed to produce a tidy data set that consists of only the mean values of the mean ("Mean") and standard deviation ("StdDev") measurements of the training and test data merged together.

### To Run the Script and Read in the Output Data
The script is run using the command: `uciHarCleanData()`.  
        `tidyData <- uciHarCleanData()`

The script writes a tab-separated text file (tidyData.txt) in the working directory. The output text file can be read into R using the following command:  
`read.table("./tidyData.txt", header=TRUE, sep="\t")`

#### Script Requirements
library(data.table)

### run_analysis.R Code Description
The `uciHarCleanData()` function in `run_analysis.R` reads in the HAR data that is located in a directory named `UCI HAR Dataset`, which is located in the working directory. The function then reads the `features.txt` file to identify the variable measurement names and the `activity_labels.txt` file to identify the activity name labels. The X and Y training data located in the `train` subdirectory (`X_train.txt` and `y_train.txt`) is then read in along with the subject training data (`subject_train.txt`). Finally, the X test data (`X_test.txt`), Y test data (`y_test.txt`), and subject test data (`subject_test.txt`), located in the `test` subdirectory, are read into R.

The X, Y, and subject data from the training and test data sets are merged together. Only the mean and standard deviation measurements are extracted and retained for downstream processing (and these variables do not include mean frequency or angle measurement variables), yielding a total of 66 variables (from an original set of 561 variables).

Each observation (row) is appropriately labeled with the correct subject and activity being performed. The activity data labels are converted to factors. The variable names are cleaned up to be more descriptive and remove non-alphanumeric characters. This dataset of all data of the mean and standard deviation measurements are written to a comma-separated value (*.csv) file (`UCI_HAR_mean_stdev.csv`) in the working directory.

The mean values of the mean and standard deviation measurements are calculated for each activity and each subject. This tidy data set is written to a tab-delimited text (*.txt) file (`tidyData.txt`) in the working directory and is returned by the `uciHarCleanData()` function.


### Details on Original Measurements
(description below derived from features_info.txt in the data set)

The original data of the HAR UCI data set are measurements from 3-axis accelerometer ("Acceleration" variables) and 3-axis gyroscope ("Gyroscope" variables) sensors in Samsung Galaxy S II smartphones collected while individuals performed different activities. Measurements of each axis (xyz) are indicated with "X", "Y", and "Z" in the variable names. The raw time domain signals ("time" variables) were acquired at a sampling rate of 50 Hz. The data was post-processed using a media filter and 3rd-order low-pass Butterworth filter with a corner frequency of 20 Hz to remove noise. The accelerometer sensor data was separated into body and gravity acceleration signals using a low-pass Butterworth filter with a corner frequency of 0.3 Hz.

The body linear acceleration and angular velocity were derived in time to obtain the Jerk signals ("Jerk" variables). The magnitude of the 3-dimensional signals were calculated using the Euclidean norm ("Magnitude" variables). A fast Fourier transform (FFT) was applied to some of the measurements ("fft" variables). 

Data was collected from six individuals (Subjects 1 through 30).

#### Activities
    Walking  
    Walking Upstairs  
    Walking Downstairs  
    Sitting  
    Standing  
    Laying 

#### Variables in Output Data

    fftBodyAccelerationMeanX  
        mean measurements of fast Fourier transform of body acceleration along X-axis  
        
    fftBodyAccelerationMeanY
        mean measurements of fast Fourier transform of body acceleration along Y-axis
        
    fftBodyAccelerationMeanZ  
        mean measurements of fast Fourier transform of body acceleration along Z-axis
        
    fftBodyAccelerationStdDevX  
        standard deviation measurements of fast Fourier transform of body acceleration along X-axis
        
    fftBodyAccelerationStdDevY  
        standard deviation measurements of fast Fourier transform of body acceleration along Y-axis
        
    fftBodyAccelerationStdDevZ  
        standard deviation measurements of fast Fourier transform of body acceleration along Z-axis
        
    fftBodyAccelerationJerkMeanX  
        mean measurements of fast Fourier transform of jerk signals from body acceleration along X-axis
        
    fftBodyAccelerationJerkMeanY  
        mean measurements of fast Fourier transform of jerk signals from body acceleration along Y-axis
        
    fftBodyAccelerationJerkMeanZ  
        mean measurements of fast Fourier transform of jerk signals from body acceleration along Z-axis
        
    fftBodyAccelerationJerkStdDevX  
        standard deviation measurements of fast Fourier transform of jerk signals from body acceleration along X-axis
        
    fftBodyAccelerationJerkStdDevY  
        standard deviation measurements of fast Fourier transform of jerk signals from body acceleration along Y-axis
        
    fftBodyAccelerationJerkStdDevZ  
        standard deviation measurements of fast Fourier transform of jerk signals from body acceleration along Z-axis
        
    fftBodyAccelerationMagnitudeMean  
        mean measurements of fast Fourier transform of magnitude of body acceleration
        
    fftBodyAccelerationMagnitudeStdDev  
        standard deviation measurements of fast Fourier transform of magnitude of body acceleration
        
    fftBodyAccelerationJerkMagnitudeMean  
        mean measurements of fast Fourier transform of jerk magnitude of body acceleration
        
    fftBodyAccelerationJerkMagnitudeStdDev  
        standard deviation measurements of fast Fourier transform of jerk magnitude of body acceleration
        
    fftBodyGyroscopeJerkMagnitudeMean  
        mean measurements of fast Fourier transform of jerk magnitude of body gyroscope motion
        
    fftBodyGyroscopeJerkMagnitudeStdDev  
        standard deviation measurements of fast Fourier transform of jerk magnitude of body gyroscope motion
        
    fftBodyGyroscopeMagnitudeMean  
        mean measurements of fast Fourier transform of magnitude of body gyroscope motion
        
    fftBodyGyroscopeMagnitudeStdDev  
        standard deviation measurements of fast Fourier transform of magnitude of body gyroscope motion
        
    fftBodyGyroscopeMeanX  
        mean measurements of fast Fourier transform of body gyroscope motion along X-axis
        
    fftBodyGyroscopeMeanY  
        mean measurements of fast Fourier transform of body gyroscope motion along Y-axis
        
    fftBodyGyroscopeMeanZ  
        mean measurements of fast Fourier transform of body gyroscope motion along Z-axis
        
    fftBodyGyroscopeStdDevX  
        standard deviation measurements of fast Fourier transform of body gyroscope motion along X-axis
    
    fftBodyGyroscopeStdDevY  
    standard deviation measurements of fast Fourier transform of body gyroscope motion along Y-axis
    
    fftBodyGyroscopeStdDevZ  
    standard deviation measurements of fast Fourier transform of body gyroscope motion along Z-axis
    
    timeBodyAccelerationMeanX  
        mean measurements of body acceleration along X-axis
    
    timeBodyAccelerationMeanY  
        mean measurements of body acceleration along Y-axis
    
    timeBodyAccelerationMeanZ  
        mean measurements of body acceleration along Z-axis
    
    timeBodyAccelerationStdDevX  
        standard deviation measurements of body acceleration along X-axis
    
    timeBodyAccelerationStdDevY  
        standard deviation measurements of body acceleration along Y-axis
    
    timeBodyAccelerationStdDevZ  
        standard deviation measurements of body acceleration along Z-axis
    
    timeBodyAccelerationJerkMeanX  
        mean measurements of jerk body acceleration along X-axis
    
    timeBodyAccelerationJerkMeanY  
        mean measurements of jerk body acceleration along Y-axis
            
    timeBodyAccelerationJerkMeanZ  
        mean measurements of jerk body acceleration along Z-axis
    
    timeBodyAccelerationJerkStdDevX  
        standard deviation measurements of jerk body acceleration along X-axis
    
    timeBodyAccelerationJerkStdDevY  
        standard deviation measurements of jerk body acceleration along Y-axis
    
    timeBodyAccelerationJerkStdDevZ  
        standard deviation measurements of jerk body acceleration along Z-axis
    
    timeBodyAccelerationJerkMagnitudeMean  
        mean measurements of magnitude of jerk body acceleration
    
    timeBodyAccelerationJerkMagnitudeStdDev  
        standard deviation measurements of magnitude of jerk body acceleration
    
    timeBodyAccelerationMagnitudeMean  
        mean measurements of magnitude of body acceleration
    
    timeBodyAccelerationMagnitudeStdDev  
        standard deviation measurements of magnitude of body acceleration
    
    timeBodyGyroscopeMeanX  
        mean measurements of body gyroscope motion along the X-axis
    
    timeBodyGyroscopeMeanY  
        mean measurements of body gyroscope motion along the Y-axis
    
    timeBodyGyroscopeMeanZ  
        mean measurements of body gyroscope motion along the Z-axis
    
    timeBodyGyroscopeStdDevX  
        standard deviation measurements of body gyroscope motion along the X-axis
    
    timeBodyGyroscopeStdDevY  
        standard deviation measurements of body gyroscope motion along the Y-axis
    
    timeBodyGyroscopeStdDevZ  
        standard deviation measurements of body gyroscope motion along the Z-axis
    
    timeBodyGyroscopeJerkMeanX  
        mean measurements of jerk body gyroscope motion along the X-axis
    
    timeBodyGyroscopeJerkMeanY  
        mean measurements of jerk body gyroscope motion along the Y-axis
    
    timeBodyGyroscopeJerkMeanZ  
        mean measurements of jerk body gyroscope motion along the Z-axis
    
    timeBodyGyroscopeJerkStdDevX  
        standard deviation measurements of jerk body gyroscope motion along the X-axis
    
    timeBodyGyroscopeJerkStdDevY  
        standard deviation measurements of jerk body gyroscope motion along the Y-axis
    
    timeBodyGyroscopeJerkStdDevZ  
        standard deviation measurements of jerk body gyroscope motion along the Z-axis
    
    timeBodyGyroscopeJerkMagnitudeMean  
        mean measurements of magnitude of jerk body gyroscope motion
        
    timeBodyGyroscopeJerkMagnitudeStdDev  
        standard deviation measurements of magnitude of jerk body gyroscope motion
    
    timeBodyGyroscopeMagnitudeMean  
        mean measurements of magnitude of body gyroscope motion
    
    timeBodyGyroscopeMagnitudeStdDev  
        standard deviation measurements of magnitude of body gyroscope motion
    
    timeGravityAccelerationMeanX  
        mean measurements of gravity acceleration along the X-axis
    
    timeGravityAccelerationMeanY  
        mean measurements of gravity acceleration along the Y-axis
    
    timeGravityAccelerationMeanZ  
        mean measurements of gravity acceleration along the Z-axis
    
    timeGravityAccelerationStdDevX  
        standard deviation measurements of gravity acceleration along the X-axis
    
    timeGravityAccelerationStdDevY  
        standard deviation measurements of gravity acceleration along the Y-axis
    
    timeGravityAccelerationStdDevZ  
        standard deviation measurements of gravity acceleration along the Z-axis
        
    timeGravityAccelerationMagnitudeMean  
        mean measurements of magnitude of gravity acceleration
    
    timeGravityAccelerationMagnitudeStdDev
        standard deviation measurements of magnitude of gravity acceleration

#### Subjects
      1     Subject 1  
      2     Subject 2  
      3     Subject 3 
      4     Subject 4  
      5     Subject 5  
      6     Subject 6  
      7     Subject 7  
      8     Subject 8  
      9     Subject 9  
     10     Subject 10  
     11     Subject 11  
     12     Subject 12 
     13     Subject 13  
     14     Subject 14  
     15     Subject 15  
     16     Subject 16  
     17     Subject 17  
     18     Subject 18  
     19     Subject 19  
     20     Subject 20  
     21     Subject 21 
     22     Subject 22  
     23     Subject 23  
     24     Subject 24  
     25     Subject 25  
     26     Subject 26  
     27     Subject 27  
     28     Subject 28  
     29     Subject 29  
     30     Subject 30 