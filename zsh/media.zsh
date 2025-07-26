#!/usr/bin/env zsh

silent_unalias 2heic
silent_unalias 2png
silent_unalias 2jpg

# Convert image files to HEIC format with 80% quality
# Uses macOS sips command for conversion, preserves original filename
# Usage: 2heic <file1> [file2 ...]
function 2heic() {
  if [ $# -eq 0 ]; then
    echo "Error: No files specified. Usage: 2heic <file1> [file2 ...]"
    return 1
  fi
  for i in "$@"; do sips -s format heic -s formatOptions 80 "$i" --out "${i%.*}.heic"; done
}

# Convert image files to PNG format with 80% quality
# Uses macOS sips command for conversion, preserves original filename
# Usage: 2png <file1> [file2 ...]
function 2png() {
  if [ $# -eq 0 ]; then
    echo "Error: No files specified. Usage: 2png <file1> [file2 ...]"
    return 1
  fi
  for i in "$@"; do sips -s format png -s formatOptions 80 "$i" --out "${i%.*}.png"; done
}

# Convert image files to JPG format with 80% quality
# Uses macOS sips command for conversion, preserves original filename
# Usage: 2jpg <file1> [file2 ...]
function 2jpg() {
  if [ $# -eq 0 ]; then
    echo "Error: No files specified. Usage: 2jpg <file1> [file2 ...]"
    return 1
  fi
  for i in "$@"; do sips -s format jpg -s formatOptions 80 "$i" --out "${i%.*}.jpg"; done
}
