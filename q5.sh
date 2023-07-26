
  #Prompt the user to enter the name of a directory
  read -p "Enter directory name: "dir

     #Check if the directory exists
  if [! -d "$dir"]; then
    echo "Error: Directory '$dir' does not exist."
    exit 1
  fi

      #List all the files in the given directory
echo "Files in '$dir':"
  files=$(ls "$dir")
 echo "$files"

  # Sort the files alphabetically
   sorted=$(echo "$files" |sort)

  # Create a new directory named "sorted" inside the given directory
  sorted_dir="$dir/sorted"
  mkdir -p "$sorted_dir"

#Move each file from the original directory to the "sorted" directory
  for file in $sorted; do
    mv "$dir/$file" "$sorted_dir/"
  done

  #Display a success message with the total number of files moved
 num_files=$(echo "$sorted" |wc -w)
   echo "Successfully moved $num_files files to '$sorted_dir'."
