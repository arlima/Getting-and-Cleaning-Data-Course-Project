require(readr)
require(dplyr)
#Download file from website

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip", method = "curl")
#zipF<- "data.zip"
#outDir<-"."
#unzip(zipF,exdir=outDir)

### Creating a folder for the merged files

Dir = "./merged"

ifelse(!dir.exists(file.path(Dir)), dir.create(file.path(Dir)), FALSE)

Dir2 = "Inertial Signals"

ifelse(!dir.exists(file.path(Dir,Dir2)), dir.create(file.path(Dir,Dir2)), FALSE)

### Creating a function to merge the files and save them

merge_files <- function(file1, file2, dest){
        df1 <- read.table(file1)
        df2 <- read.table(file2)
        df3 <- rbind(df1, df2)
        write.table(df3,dest, col.names = FALSE, row.names = FALSE)   
}

### Step1: Merging the files

merge_files("./UCI HAR Dataset/test/subject_test.txt", "./UCI HAR Dataset/train/subject_train.txt", "./merged/subject_merged.txt")
merge_files("./UCI HAR Dataset/test/X_test.txt",       "./UCI HAR Dataset/train/X_train.txt",       "./merged/X_merged.txt")
merge_files("./UCI HAR Dataset/test/y_test.txt",       "./UCI HAR Dataset/train/y_train.txt",       "./merged/y_merged.txt")
merge_files("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", "./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt","./merged/Inertial Signals/body_acc_x_merged.txt")
merge_files("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", "./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt","./merged/Inertial Signals/body_acc_y_merged.txt")
merge_files("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", "./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt","./merged/Inertial Signals/body_acc_z_merged.txt")
merge_files("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", "./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt","./merged/Inertial Signals/body_gyro_x_merged.txt")
merge_files("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", "./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt","./merged/Inertial Signals/body_gyro_y_merged.txt")
merge_files("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", "./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt","./merged/Inertial Signals/body_gyro_z_merged.txt")
merge_files("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", "./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt","./merged/Inertial Signals/total_acc_x_merged.txt")
merge_files("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", "./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt","./merged/Inertial Signals/total_acc_y_merged.txt")
merge_files("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", "./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt","./merged/Inertial Signals/total_acc_z_merged.txt")

### Step2: Reading all files

subject <- read.table("./merged/subject_merged.txt")
X <- read.table("./merged/X_merged.txt")
y <- read.table("./merged/y_merged.txt")
body_acc_x <- read.table("./merged/Inertial Signals/body_acc_x_merged.txt")
body_acc_y <- read.table("./merged/Inertial Signals/body_acc_y_merged.txt")
body_acc_z <- read.table("./merged/Inertial Signals/body_acc_z_merged.txt")
body_gyro_x <- read.table("./merged/Inertial Signals/body_gyro_x_merged.txt")
body_gyro_y <- read.table("./merged/Inertial Signals/body_gyro_y_merged.txt")
body_gyro_z <- read.table("./merged/Inertial Signals/body_gyro_z_merged.txt")
total_acc_x <- read.table("./merged/Inertial Signals/total_acc_x_merged.txt")
total_acc_y <- read.table("./merged/Inertial Signals/total_acc_y_merged.txt")
total_acc_z <- read.table("./merged/Inertial Signals/total_acc_z_merged.txt")

features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

### Step2.1-3: Extracting only the measurements on the mean and standard deviation for each measurement.

# Tranforming the features dataframe into a list
features_list <- features$V2

# Creating a new X dataframe - empty for a while

nX = data.frame(matrix(NA, nrow=length(X$V1), ncol=0))

# Now I will search for the columns that are mens os standard deviations and copy them from the X dataframe to the X dataframe
# I will also rename the columns

c <- 1
for (i in 1:length(features_list)) {
        #print(i)
        #print(features_list[[i]])
        #print(grep("std\\(\\)", features_list[[i]])==1)
        #print(grep("mean\\(\\)", features_list[[i]])==1)
        if (length(grep("std\\(\\)", features_list[[i]]))>0 || length(grep("mean\\(\\)", features_list[[i]])>0)) {
                nX <- cbind(nX, X[,i])
                coln = gsub("\\(\\)", "", features_list[[i]])
                coln = gsub("-", "", coln)
                coln = tolower(coln)
                colnames(nX)[c] <- coln
                c <- c + 1
        }
}

# Now I will merge the activities to the nX dataframe

nX <- cbind(nX, y$V1)
nX <- rename(nX, activity=`y$V1`)

# Now I will merge the subjects to the nX dataframe

nX <- cbind(nX, subject$V1)
nX <- rename(nX, subject=`subject$V1`)

nX <- merge (nX, activities, by.x="activity", by.y = "V1")

### Step5: Finishing renaming and reorganizing columns 

nX <- select(nX, -activity)
nX <- rename(nX, activity=V2)
nX <- select(nX, activity, everything())
nX <- select(nX, subject, everything())

write.table(nX,"./merged/results.txt", row.name=FALSE)

### Step5: Grouping and calculating averages from the step 4

nXa <- group_by(nX, subject, activity)
nXa <- summarise_each(nXa, funs(mean))

write.table(nX,"./merged/summary.txt", row.name=FALSE)
