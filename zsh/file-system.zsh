#!/usr/bin/env zsh

silent_unalias mkcd
silent_unalias trash
silent_unalias f

# Create a directory and immediately change into it
# Combines mkdir and cd into a single command
# Usage: mkcd <directory_name>
function mkcd() {
    if [ -z "$1" ]; then
        echo "Usage: mkcd <directory_name>"
        return 1
    fi
    mkdir "$1"
    cd "$1" || return 1
}

# Safely move files/directories to macOS Trash folder
# Includes safety checks to prevent trashing system directories
# Validates file existence before attempting to move
# Usage: trash <file_or_directory>
function trash() {
    if [ -z "$1" ]; then
        echo "Usage: trash <file_or_directory>"
        return 1
    fi
    
    # Prevent trashing critical directories
    case "$1" in
        / | /bin | /usr | /etc | /var | /System | /Library | ~ | $HOME)
            echo "Error: Cannot trash system directory '$1'"
            return 1
            ;;
    esac
    
    if [ ! -e "$1" ]; then
        echo "Error: '$1' does not exist"
        return 1
    fi
    
    mv "$1" ~/.Trash
}

# Quick file finder using partial name matching
# Searches current directory and subdirectories for files starting with given
# pattern
# Usage: f <partial_filename>
function f() {
    find . -name "$1*"
}
