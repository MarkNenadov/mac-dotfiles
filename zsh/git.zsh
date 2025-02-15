last_commit() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    git log -1 --pretty=format:"%ar" | sed 's/\([0-9]*\) \(.\).*/\1\2/'
}

clean_branches() {
  git remote prune origin
  git branch -vv | grep "origin/.*: gone]" | awk '{print $1}' | xargs git branch -D
}
