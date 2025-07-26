silent_unalias 2heic
silent_unalias 2png
silent_unalias 2jpg

function 2heic() {
  if [ $# -eq 0 ]; then
    echo "Error: No files specified. Usage: 2heic <file1> [file2 ...]"
    return 1
  fi
  for i in "$@"; do sips -s format heic -s formatOptions 80 "$i" --out "${i%.*}.heic"; done
}

function 2png() {
  if [ $# -eq 0 ]; then
    echo "Error: No files specified. Usage: 2png <file1> [file2 ...]"
    return 1
  fi
  for i in "$@"; do sips -s format png -s formatOptions 80 "$i" --out "${i%.*}.png"; done
}

function 2jpg() {
  if [ $# -eq 0 ]; then
    echo "Error: No files specified. Usage: 2jpg <file1> [file2 ...]"
    return 1
  fi
  for i in "$@"; do sips -s format jpg -s formatOptions 80 "$i" --out "${i%.*}.jpg"; done
}
