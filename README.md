The run_analysis.R script will generate the mean values for each observation type for each subject. This data has been collected and saved in a train and test data set.  Within each set of data, raw observations, subject numbers, and subject activities have been collected. These data will be combined within each set of data to create the respective data file. The train and test data sets will then be combined to form the comprehensive set of data.

Readable column names will be created from the values stored in the "features.txt" file and assigned to the appropriate data columns. Only the observations generated with the "mean()" or "std()" functions will be selected and saved in the final data set.

The output of this R script is written to a file named "Samsung_Galaxy_S_Smartphone_data.txt" and is a wide tidy data set with mean values for each activity or row for each subject.
