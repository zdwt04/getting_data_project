# Project Assignment
# set working directory to "../UCI HAR Dataset"

# read in activity labels
activties_labels <- read.table("./activity_labels.txt", stringsAsFactors = FALSE)

# read in xyx value labels
features_colnames <- read.table("features.txt", stringsAsFactors = FALSE)

# tidy the features column names such that they are more readable
tidycolnames <- gsub("^t", "time", features_colnames[,2])
tidycolnames <- gsub("^f", "frequency", tidycolnames)
tidycolnames <- gsub("Acc", "Acceleration", tidycolnames)
tidycolnames <- gsub("BodyBody", "Body", tidycolnames)
tidycolnames <- gsub("Gyro", "Gyroscope", tidycolnames)
tidycolnames <- gsub("Mag", "Magnitude", tidycolnames)
tidycolnames <- gsub("tBody", "timeBody", tidycolnames)
tidycolnames <- make.unique(tidycolnames, sep=".")

# read in test and training subject numbers or identifiers
test_subjects <- read.table("./test/subject_test.txt", col.names = "Subjects")
training_subjects <- read.table("./train/subject_train.txt", col.names = "Subjects")

# read in test and training xyz values and assign column names unaltered
test_values <- read.table("./test/X_test.txt", col.names = tidycolnames, check.names=FALSE)
training_values <- read.table("./train/X_train.txt", col.names = tidycolnames, check.names=FALSE)

# read in test and training Activity codes
test_activties <- read.table("./test/y_test.txt", col.names = "Activities")
training_activties <- read.table("./train/y_train.txt", col.names = "Activities")

# replace test and training activity codes with activity labels
test_activties$Activities <- sapply(test_activties, function(x) activties_labels[x,2])
training_activties$Activities <- sapply(training_activties, function(x) activties_labels[x,2])

# combine all test data sets into a data frame
df_test <- cbind(test_subjects, test_activties, test_values)
df_training <- cbind(training_subjects, training_activties, training_values)

# create test and training data tables
dt_test <- tbl_df(df_test)
dt_training <- tbl_df(df_training)

# select only mean() and std() columns from test data
test_mean_std <- select(dt_test, contains("subjects"), contains("Activities"), contains("mean()"), contains("std()"))
# select only mean() and std() columns from training data
training_mean_std <- select(dt_training, contains("subjects"), contains("Activities"), contains("mean()"), contains("std()"))

# remove "()" from test data column names
colnames(test_mean_std) <- gsub("()", "", colnames(test_mean_std), fixed=TRUE)
# remove "()" from training data column names
colnames(training_mean_std) <- gsub("()", "", colnames(training_mean_std), fixed=TRUE)

# Combine test and training dat sets
all_data <- rbind(as.data.frame(test_mean_std), as.data.frame(training_mean_std))

# Aggregate all data, grouped by Subjects and Activities
aggregated_means <- aggregate(. ~ Subjects + Activities, data = all_data, mean)
aggregated_means_sorted <- aggregated_means[order(aggregated_means$Subjects, aggregated_means$Activities),]
write.table(aggregated_means_sorted, "Samsung_Galaxy_S_Smartphone_data.txt", row.names=FALSE)
write.csv(aggregated_means_sorted, "Samsung_Galaxy_S_Smartphone_data.csv", row.names=FALSE)
