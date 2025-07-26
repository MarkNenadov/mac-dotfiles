function mkcd() {
    if [ -z "$1" ]; then
        echo "Usage: mkcd <directory_name>"
        return 1
    fi
    mkdir "$1"
    cd "$1" || return 1
}

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

function f() {
    find . -name "$1*"
}
