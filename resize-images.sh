#!/bin/bash

input_file="$1"
width=$(identify -format '%w' "$input_file")
height=$(identify -format '%h' "$input_file")

new_width_medium=$((width / 2))
new_height_medium=$((height / 2))

new_width_thumbnail=$((width / 4))
new_height_thumbnail=$((height / 4))

file_ext="${input_file##*.}"
filename_no_ext="${input_file%.*}"

output_file_medium="${filename_no_ext}_medium.${file_ext}"
output_file_thumbnail="${filename_no_ext}_thumbnail.${file_ext}"

# Function to get file size
get_file_size() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    stat -f%z "$1"
  else
    stat -c%s "$1"
  fi
}

# Resize and compress medium image
convert "$input_file" -resize "${new_width_medium}x${new_height_medium}" "$output_file_medium"
medium_file_size=$(get_file_size "$output_file_medium")

max_medium_file_size=$((800 * 1024))
while [ $medium_file_size -gt $max_medium_file_size ]; do
  new_width_medium=$((new_width_medium - 50))
  new_height_medium=$((new_height_medium - 50))
  convert "$input_file" -resize "${new_width_medium}x${new_height_medium}" -quality 80 "$output_file_medium"
  medium_file_size=$(get_file_size "$output_file_medium")
done

# Resize and compress thumbnail image
convert "$input_file" -resize "${new_width_thumbnail}x${new_height_thumbnail}" "$output_file_thumbnail"
thumbnail_file_size=$(get_file_size "$output_file_thumbnail")

max_thumbnail_file_size=$((400 * 1024))
while [ $thumbnail_file_size -gt $max_thumbnail_file_size ]; do
  new_width_thumbnail=$((new_width_thumbnail - 25))
  new_height_thumbnail=$((new_height_thumbnail - 25))
  convert "$input_file" -resize "${new_width_thumbnail}x${new_height_thumbnail}" -quality 80 "$output_file_thumbnail"
  thumbnail_file_size=$(get_file_size "$output_file_thumbnail")
done

echo "Resized $input_file to medium: $output_file_medium and thumbnail: $output_file_thumbnail"
