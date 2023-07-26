#!/bin/bash

# Task 1: Prompt the user to enter the name of a directory
read -p "Enter the name of the directory: " input_directory

# Task 2: Check if the directory exists. If it doesn't, display an error message and exit the program.
if [ ! -d "$input_directory" ]; then
    echo "Oops! The directory doesn't exist."
    exit 1
fi

# Task 3: List all the files in the given directory and sort them alphabetically
files_list=$(ls "$input_directory" | sort)

# Task 4: Create a new directory named "sorted" inside the given directory
mkdir -p "$input_directory/sorted"

# Task 5: Move each file from the original directory to the "sorted" directory
for file in $files_list; do
    mv "$input_directory/$file" "$input_directory/sorted/"
done

# Task 6: Display a success message with the total number of files moved
count=$(ls "$input_directory/sorted" | wc -l)
echo "All done! Moved $count files to 'sorted' folder."
