require(reshape2)
#functions: melt and dcast

######

#Read activity labels
readActivityLabels <- function(directory){
  activity_labels <- read.table(paste("./", directory, "/activity_labels.txt", sep=""))
  activity_labels
}

#Read features data set
readFeatures <- function(directory){
  df_features <- read.table(paste("./", directory, "/features.txt", sep=""))
  features<-as.vector(df_features[,2])
}

#1. Read all data train and test.
#2. Merge: subject + activity_id + activity (merge) + data
readData <- function(directory, type, activity_labels){
  x <- read.table(paste("./", directory, "/",type,"/X_",type,".txt", sep=""),header=FALSE)
  subject <- read.table(paste("./", directory,"/",type, "/subject_",type,".txt", sep=""),header=FALSE)
  y <- read.table(paste("./", directory, "/",type, "/y_",type,".txt", sep=""),header=FALSE)
  y_activity_labels <- merge(y,activity_labels,by="V1")
  data <- cbind(subject,y_activity_labels,x)
  data
}

#Save data frame (tidy data)
saveData <- function(file_data, file_name){
  write.table(file_data, file=file_name, sep="\t", row.names=FALSE)
}

######  MAIN

#Merges the training and the test sets to create one data set.
#Uses descriptive activity names to name the activities in the data set
activity_labels<-readActivityLabels("UCI HAR Dataset")
data_train<-readData("UCI HAR Dataset","train",activity_labels)
data_test<-readData("UCI HAR Dataset","test",activity_labels)

data<-rbind(data_train,data_test)

#Appropriately labels the data set
features<-readFeatures("UCI HAR Dataset")
colnames(data) <- c("Subject_ID","Activity_ID","Activity",features)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
col_extract<-c(1,2,3,grep("mean()", colnames(data), fixed=TRUE),grep("std()", colnames(data), fixed=TRUE))
data_extracted<-data[,sort(col_extract)]

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
data_melted<-melt(data_extracted, id=c("Subject_ID","Activity_ID","Activity"))
data_tidy <- dcast(data_melted, formula = Subject_ID + Activity_ID + Activity ~ variable, mean)

saveData(data_tidy,"analysis_result.txt")
