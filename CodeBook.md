# Getting and Cleaning Data Course Project
Getting and Cleaning Data Course Project

The script will read the files considering the structure present in the file

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The first step is to check if a folder called "merged" is present. If it is not present it will be created.

There is also a function called "merge_files" that read files using the read_table function into dataframes and merge than using the rbind function. We are suposing we are merging files that have the same structure.

After that, we merge all files from the dataset and put them into the "merge folder".

Hence, we read all merged files and start playing with them.

we create an empty dataframe called nX to be popuplated with the data we are interesting in. We load the features file and seach it for the columns that contains means and standard deviations. In the same loop we also rename the columns.

After that we merge (using cbind) tha activities dataframe and the subjects dataframe to the nX main dataframe. We arrange the columns to have better ordering of them. We write a table called results.txt with the results for step for in the intructions.

we algo group all the data, using the dplyr package, by subject and activity. Hence we summarize the data by its mean. We write a file called summary.txt with the results.

All the process is automatic and no manual intervention is necessary.

The submitted file contains 180 rows since there was 30 people that performed 6 different kinds of activities:

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

There are x columns in the file that are described below:

Subject : number of the people that performed the activities (from 1 to 30)
Activity : type of activity

and means and standard deviations for many different measures in 3 dimentions (x,y,z)

"tbodyaccmeanx"
"tbodyaccmeany"
"tbodyaccmeanz"
"tbodyaccstdx"
"tbodyaccstdy"
"tbodyaccstdz"
"tgravityaccmeanx"
"tgravityaccmeany"
"tgravityaccmeanz"
"tgravityaccstdx"
"tgravityaccstdy"
"tgravityaccstdz"
"tbodyaccjerkmeanx"
"tbodyaccjerkmeany"
"tbodyaccjerkmeanz"
"tbodyaccjerkstdx"
"tbodyaccjerkstdy"
"tbodyaccjerkstdz"
"tbodygyromeanx"
"tbodygyromeany"
"tbodygyromeanz"
"tbodygyrostdx"
"tbodygyrostdy"
"tbodygyrostdz"
"tbodygyrojerkmeanx"
"tbodygyrojerkmeany"
"tbodygyrojerkmeanz"
"tbodygyrojerkstdx"
"tbodygyrojerkstdy"
"tbodygyrojerkstdz"
"tbodyaccmagmean"
"tbodyaccmagstd"
"tgravityaccmagmean"
"tgravityaccmagstd"
"tbodyaccjerkmagmean"
"tbodyaccjerkmagstd"
"tbodygyromagmean"
"tbodygyromagstd"
"tbodygyrojerkmagmean"
"tbodygyrojerkmagstd"
"fbodyaccmeanx"
"fbodyaccmeany"
"fbodyaccmeanz"
"fbodyaccstdx"
"fbodyaccstdy"
"fbodyaccstdz" 
"fbodyaccjerkmeanx"
"fbodyaccjerkmeany"
"fbodyaccjerkmeanz"
"fbodyaccjerkstdx"
"fbodyaccjerkstdy"
"fbodyaccjerkstdz"
"fbodygyromeanx"
"fbodygyromeany"
"fbodygyromeanz"
"fbodygyrostdx"
"fbodygyrostdy"
"fbodygyrostdz"
"fbodyaccmagmean"
"fbodyaccmagstd"
"fbodybodyaccjerkmagmean"
"fbodybodyaccjerkmagstd"
"fbodybodygyromagmean"
"fbodybodygyromagstd"
"fbodybodygyrojerkmagmean"
"fbodybodygyrojerkmagstd"
