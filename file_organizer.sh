#!/bin/bash

# Accept the target directory as a command-line argument
target_directory=$1

# Check if the target_directory is empty; default to the current directory if not provided
if [ -z "$target_directory" ]; then
    target_directory=.
fi

# List of file extensions for different categories
images=("jpg" "png")
text=("pdf" "txt")
video=("mp4" "avi")
production=("ai" "ps" "ae")

# Loop through the files in the target directory
files_list=($(find "$target_directory" -maxdepth 1 -type f))
for file in "${files_list[@]}"; do
    # Extract the file extension
    file_extension=$(echo "$file" | awk -F '.' '{print $NF}')
    
    # Check the file extension against the category lists
    if [[ " ${images[*]} " =~ " $file_extension " ]]; then
        images_dir="$target_directory/Images"
        if [ ! -d "$images_dir" ]; then
            mkdir "$images_dir"
        fi
        mv "$file" "$images_dir"
    
    elif [[ " ${text[*]} " =~ " $file_extension " ]]; then
        text_dir="$target_directory/Documents"
        if [ ! -d "$text_dir" ]; then
            mkdir "$text_dir"
        fi
        mv "$file" "$text_dir"
    
    elif [[ " ${video[*]} " =~ " $file_extension " ]]; then
        video_dir="$target_directory/Video"
        if [ ! -d "$video_dir" ]; then
            mkdir "$video_dir"
        fi
        mv "$file" "$video_dir"
    
    elif [[ " ${production[*]} " =~ " $file_extension " ]]; then
        production_dir="$target_directory/Production"
        if [ ! -d "$production_dir" ]; then
            mkdir "$production_dir"
        fi
        mv "$file" "$production_dir"
    fi
done
