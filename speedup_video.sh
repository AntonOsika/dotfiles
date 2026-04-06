#!/bin/bash

input_file="$1"
filename=$(basename -- "$input_file")
extension="${filename##*.}"
filename="${filename%.*}"
output_file="${filename}_2x.${extension}"

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null
then
    osascript -e 'display notification "FFmpeg is not installed. Please install it first." with title "Error"'
    exit 1
fi

# Run FFmpeg command
ffmpeg -i "$input_file" -filter:v "setpts=0.5*PTS" -filter:a "atempo=2.0" "$output_file"

# Show completion message
osascript -e 'display notification "Video processing complete!" with title "Video Speed Up"'
