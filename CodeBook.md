# From the raw data to the final Tidy data

The code presented in `run_analysis.R` follows 5 steps defined in the ReadMe file.

Practically, the process involves:

1. Merging similar data (i.e. referring to the same entities and having the same number of columns) using the `rbind()` function.
2. In this complete data set, we are in fact interested only with columns presenting the mean and standard deviation measures. We extract these specific columns and we correct their names using the file `features.txt`.
3. Activity data correspond to values ranging from 1:6, we use the activity names and IDs from the file `activity_labels.txt` and perform the substitution in the data set.
4. On the whole data set, those columns with vague column names are corrected.
5. The last operation in order to build our tidy data consists in generating a new datas set with all the average measures related to each subject and activity type (i.e. a final data set of 30 subjects * 6 activities = 180 rows). 

The output file is called `Tidy_AveragesData.txt`, you will find it uploaded in this repository.

# List of Variables used in this project

## `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` are extracted from the downloaded files.
##  `x_data`, `y_data` and `subject_data` are merged and used in  further analysis.
## `features` is a text file containing the correct names for the `x_data` data set, which are applied to the column names stored in `ColumnsWanted` (i.e. mean and standard deviation measures), a numeric vector used to extract the desired data.
##  We proceed using the same logic with activity names, through the `activities` variable.
## `MergedData` regroup `x_data`, `y_data` and `subject_data` in a big dataset (using the 'cbind()' function.
## the last variable `AveragesData` contains the relevant averages ultimately stored in a the 'Tidy_AveragesData.txt` file. Please note that we have used the `ddply()` function from the plyr package in order to apply the `colMeans()` function easily.
