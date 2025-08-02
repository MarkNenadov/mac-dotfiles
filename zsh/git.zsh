#!/usr/bin/env zsh

silent_unalias last_commit
silent_unalias clean_branches

# Display abbreviated time since last commit on current branch
# Shows format like "2h" for "2 hours ago" or "3d" for "3 days ago"
# Usage: last_commit
function last_commit() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    git log -1 --pretty=format:"%ar" | sed 's/\([0-9]*\) \(.\).*/\1\2/'
}

# Clean up local branches that no longer exist on remote
# First prunes remote tracking references, then deletes local branches
# whose upstream branches have been deleted on origin
# Usage: clean_branches
function clean_branches() {
  git remote prune origin
  git branch -vv | \
    grep "origin/.*: gone]" | \
    awk '{print $1}' | \
    xargs git branch -D
}
