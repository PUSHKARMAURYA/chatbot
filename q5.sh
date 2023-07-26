
    # Ask user to enter the name of a folder
read -p "Enter directory name: " dir

   # Check if the directory exists
if [ ! -d "$dir" ]; then
    echo "Error: folder '$dir' does not exist."
    exit 1
fi

    #  List all the files in the given direct
echo "Files in '$dir':"
files=$(ls "$dir")
echo "$files"

  # Sort the files
sorted=$(echo "$files" | sort)

 # Create a new directory named "sorted" 
sorted_dir="$dir/sorted"
mkdir -p "$sorted_dir"

    # Move each file from the original directory to the "sorted"
for file in $sorted; do
    mv "$dir/$file" "$sorted_dir/"
done

 # Display a success messg
num_files=$(echo "$sorted" | wc -w)
echo "Successfully moved $num_files files to '$sorted_dir'."
