
#change the work directory to UCI_HAR_Dataset and load the packaage dplyr

library(dplyr);library(reshape2)
#read the feature file into R an assign ti to feature variable
feature <- read.table("features.txt")
feature
dim(feature)

#read the subject_train for the subject label
Subject_Train <- read.table("./train/subject_train.txt")
Subject_Train

#read the y_train.txt file into R and assign it to TrainActivity 
TrainActivity <- read.table("./train/y_train.txt")
TrainActivity

#read the x_train.txt file into R and assign it to TrainSet
TrainSet <- read.table("./train/x_train.txt")

#name the variables properly for the TrainSet
names(TrainSet) <- feature[ ,2]
names(TrainSet)

#add two columns which label the Activity_Type and Subject_ID for each observation
TrainSet$Activity_Type <- TrainActivity[, 1]
TrainSet$Subject <- Subject_Train[, 1]


#read the y_test.txt file into R and assign it to TestActivity
TestActivity <- read.table("./test/y_test.txt")


#read the subject_test.txt file into R and assign it to Test_Subject
Subject_Test <- read.table("./test/subject_test.txt")


#read the x_test.txt file inoto R and assign it to TestSet
TestSet <- read.table("./test/X_test.txt")

#name the variables properly for the TrainSet
names(TestSet) <- feature[ ,2]
names(TestSet)


#add two columns which label the Acitvity_Type and Subject_ID respectively (same as for TrainSet)for each observation
TestSet$Activity_Type <- TestActivity[,1]
TestSet$Subject <- Subject_Test[, 1]


#merge TrainSet and TestSet using rbind and save it as DataSet
DataSet <- rbind(TrainSet, TestSet)
names(DataSet)

#subseting the columns which contains "mean" or "std" in variable names and merge data by column bind
DataSubset <- select(DataSet, contains("mean"), contains("std"), Activity_Type, Subject)


#Use descriptive activity names to name the activities in the data set

DataSubset$Activity_Type <- gsub("1", "WALKING", DataSubset$Activity_Type)
DataSubset$Activity_Type <- gsub("2", "WALKING_UPSTAIRs", DataSubset$Activity_Type)
DataSubset$Activity_Type <- gsub("3", "WALKING_DOWNSTAIRS", DataSubset$Activity_Type)
DataSubset$Activity_Type <- gsub("4", "SITTING", DataSubset$Activity_Type)
DataSubset$Activity_Type <- gsub("5", "STANDING", DataSubset$Activity_Type)
DataSubset$Activity_Type <- gsub("6", "LAYING", DataSubset$Activity_Type)

#Group the DataSubset using Subject and Activity_Type combination by group_by function
#and summarize the data by summarise_each function

names(DataSubset)
SubjectActivity <- group_by(DataSubset, Subject, Activity_Type)
Final <- summarise_each(SubjectActivity, funs(mean))
Final
write.table(Final, file = "Final.txt")

