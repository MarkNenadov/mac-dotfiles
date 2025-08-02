#!/usr/bin/env zsh

silent_unalias whatison
silent_unalias openports

# Show what process is listening on a specific port
# Uses lsof to display processes bound to the given port number
# Usage: whatison <port_number>
function whatison() {
    if [[ -z "$1" ]]; then
        echo "Usage: whatison <port_number>"
        return 1
    fi
    sudo lsof -i :$1
}

# Search for open TCP ports containing a specific string
# Filters lsof output to show only TCP connections matching search term
# Usage: openports <search_string>
function openports() {
    if [[ -z "$1" ]]; then
        echo "Usage: openports <search string>"
        return 1
    fi
    sudo lsof -i -n -P | grep TCP | grep $1
}
