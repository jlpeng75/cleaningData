#cleaningData
============
This dataset is extracted from the web, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The data description can be find in the web http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The Train_x.txt file was read into R, the variables were named properly using the feature.txt file. Then two columns were added for the corresponding Activity_Type and corresponding Subject ID for each observation using the x_train file and subject_train file respectively. Similarly, the test file was read into R and labled properly as did for Train dataset. The two files were combined by funciton rbind to form a final full dataset. The useful variables which contain "mean" or "std", together with "Activity_Type" and "Subject" were extracted using select function in ddply package. The resulting data were stored into DataSubset object for further analysis.

The DataSubset was grouped by combination of Subject and Activity_Type, then smmarized by calling the summarise_each function with mean funciton embeded. The final tidy data was exported as a .txt file using write.table function.
