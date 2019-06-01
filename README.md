## README.md
===========================

The data divided to three major parts for test and train sets: features, activity and subject.
All these data are initially separated and we need to combine them together with proper approach.

After reading all the desired data, we combine test and train set for each type using rbind().
Then we add sunject and activity columns to feature date and make a whole table. We replace sunject column with the actual names of features.

The feature names could be changed to its complete form by reading features.txt and substituting any short form with the complet form.
Then we make activity and subject columns as factors in order to use any grouping finction to order and summarize data.

We subset the desired columns and apply mean function for any factor level in subject and activity. We order dataset based on subject and activity columns.
At the end, we write the tidy data to the directory.



