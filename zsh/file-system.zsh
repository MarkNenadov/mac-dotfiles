mkcd() {
  mkdir "$1"
  cd "$1" || return 1
}

trash() { mv $1 ~/.Trash }

f() {
    find . -name "$1"
}
