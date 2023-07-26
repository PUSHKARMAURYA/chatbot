#!/bin/bash

log_directory="logs"
output_file="filtered_logs.txt"

# Task 1: Read all log files in the "logs" directory
for log_file in "$log_directory"/log_*.txt; do
  # Task 2: Extract timestamp and message from each log entry
  awk -F '[ :]' '{ printf "Timestamp: %s-%s-%s %s:%s:%s\nMessage: %s\n", $2, $3, $4, $5, $6, $7, $8 }' "$log_file"
done | 
# Task 3: Filter out log entries older than a given date (2022-01-02 in this case)
awk -v cutoff_date="2022-01-02" '$2 >= cutoff_date' |
# Task 4: Sort the remaining log entries based on timestamps in descending order
sort -r -k2,3 |
# Task 5: Write the sorted log entries to the "filtered_logs.txt" file
tee "$output_file" |
# Task 6: Calculate the average time difference between consecutive log entries for each log file
awk -F '[ :-]' '
  {
    current_time = mktime($2 " " $3 " " $4 " " $5 " " $6 " " $7);
    if (prev_time[$1] > 0) {
      time_diff[$1] += current_time - prev_time[$1];
      count[$1]++;
    }
    prev_time[$1] = current_time;
  }
  END {
    for (file in time_diff) {
      avg_time_diff = time_diff[file] / count[file];
      printf "Filename: %s\nMaximum Average Time Difference: %d seconds.\n", file, avg_time_diff;
    }
  }
' |
# Task 7: Find the log file with the maximum average time difference
sort -k4nr |
head -1 |
# Task 8: Print and save the output filename and corresponding maximum average time difference
tee -a "$output_file" |
# Task 9: Find the log file with the longest average message length
awk -F ': ' '
  {
    file = $2;
    getline;
    getline;
    avg_msg_length = 0;
    count = 0;
    while (getline > 0) {
      if ($1 == "Message") {
        avg_msg_length += length($2);
        count++;
      }
    }
    avg_msg_length /= count;
    printf "Filename: %s\nLongest Average Message Length: %d characters\n", file, avg_msg_length;
  }
' |
# Task 10: Print and save the output filename and corresponding longest average message length
tee -a "$output_file"

echo "Script executed successfully!"
