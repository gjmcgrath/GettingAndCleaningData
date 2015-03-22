##Load all files into data frames
###Variable descriptions
xTrain: dataframe of X_Train.txt
yTrain: dataframe of Y_train.txt
subjTrain: dataframe of subject_train.txt
xTest: dataframe of X_test.txt
yTest: dataframe of Y_test.txt
subjTest: dataframe of subject_test.txt
activityTable: dataframe of activity_labels.txt
features: dataframe of features.txt

##Bind the 3 files in the "test" folder by column
###Variable description
test: dataframe for all 3 test files 

##Bind the 3 files in the "train" folder by column
###Variable description
train: dataframe for all 3 train files 

##Now merge the "test" and "train" sets together by row
###Variable description
mergeTestTrain: full data contained in test and train files

##Rename the columns that relate to the activity so they are descriptive and unique

##Merge in the activity description
###Variable description
mergeActivity: full data contained in test and train files plus a new column for descriptive activity name

##Rename the measurement columns so they are the descriptions

##Separate out the columns of interest into separate dataframes
###Variable descriptions
tidyDescription: the second and third columns of mergeActivity
tidyMean: all columns of mergeActivity that contain the string "mean"
tidyStd: all columns of mergeActivity that contain the string "std"

##Now remerge the columns of interest into one dataframe that is the final unsummarized tidy dataset
###Variable descriptions
tidyFinal: dataset that has all mean and std data

#Set subject as a factor variable

##Create the summary dataset with the mean of each variable per subject and activity
##Change the order so it's grouped by subject
tidySummary: dataset that has means of variables for each activity ordered by subject and

##Write out the summary to a text file

