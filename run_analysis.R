#Load all files into data frames
xTrain <- read.table("C:/Users/Garth/Documents/R/GettingDataProject/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_Train.txt")
yTrain <- read.table("C:/Users/Garth/Documents/R/GettingDataProject/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
subjTrain <- read.table("C:/Users/Garth/Documents/R/GettingDataProject/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
xTest <- read.table("C:/Users/Garth/Documents/R/GettingDataProject/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("C:/Users/Garth/Documents/R/GettingDataProject/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
subjTest <- read.table("C:/Users/Garth/Documents/R/GettingDataProject/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
activityTable <- read.table("C:/Users/Garth/Documents/R/GettingDataProject/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
features <- read.table("C:/Users/Garth/Documents/R/GettingDataProject/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

#Bind the 3 files in the "test" folder by column
test <- cbind(subjTest, yTest, xTest)

#Bind the 3 files in the "train" folder by column
train <- cbind(subjTrain, yTrain, xTrain)

#Now merge the "test" and "train" sets together by row
mergeTestTrain <- rbind(test, train)

#Rename the columns that relate to the activity so they are descriptive and unique
names(mergeTestTrain)[1:2]<- c("subject","activityNum")
names(activityTable)[1:2]<-c("activityNum","activityName")

#Merge in the activity description
mergeActivity <- merge(activityTable, mergeTestTrain, by="activityNum")

#Rename the measurement columns so they are the descriptions
names(mergeActivity)[4:564] <- t(features[2])

#Separate out the columns of interest into separate dataframes
tidyDescription <- mergeActivity[,2:3]
tidyMean <- mergeActivity[ , grepl( "mean", names(mergeActivity) ) ]
tidyStd <- mergeActivity[ , grepl( "std", names(mergeActivity) ) ]

#Now remerge the columns of interest into one dataframe that is the final unsummarized tidy dataset
tidyFinal <- cbind(tidyDescription, tidyMean, tidyStd)

#Set subject as a factor variable
tidyFinal$subject <- as.factor(tidyFinal$subject)

#Create the summary dataset with the mean of each variable per subject and activity
tidySummary <- aggregate(. ~subject + activityName, tidyFinal, mean)

#Change the order so it's grouped by subject
tidySummary <- tidySummary[order(tidySummary$subject,tidySummary$activityName),]

#Write out the summary to a text file
setwd("C:/Users/Garth/Documents/R/GettingDataProject/")
write.table(tidySummary, file = "TidyDataSet.txt",row.names = FALSE)
