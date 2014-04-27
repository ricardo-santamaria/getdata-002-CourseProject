## CodeBook

### Functions

* ``readActivityLabels(directory)``: 
* ``readFeatures(directory)``: 
* ``readData(directory, type, activity_labels)``:
* ``saveData(file_data, file_name)``: 

### Variables

* ``activity_labels``: activity_labels.txt
* ``features``: features.txt (second column)

* ``data_train``: subject + activity_id + activity (merge) + data
* ``data_test``: subject + activity_id + activity (merge) + data
* ``data``: rbind(data_train,data_test)

* ``data_extracted``: ``data`` only column with measurements on the mean and standard deviation
* ``data_melted``:   "Subject_ID", "Activity_ID", "Activity", "Variable" and "Value"
* ``data_tidy``: ``dcast data_melted``  One column for each "Variable" with value ``mean`` 

*  col_extract (aux)