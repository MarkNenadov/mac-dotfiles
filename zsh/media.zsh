function 2heic() {
  for i in "$@"; do sips -s format heic -s formatOptions 80 "$i" --out "${i%.*}.heic"; done
}

function 2png() {
  for i in "$@"; do sips -s format png -s formatOptions 80 "$i" --out "${i%.*}.png"; done
}

function 2jpg() {
  for i in "$@"; do sips -s format jpg -s formatOptions 80 "$i" --out "${i%.*}.jpg"; done
}
