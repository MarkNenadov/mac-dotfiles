unalias whatison 2>/dev/null
unalias openports 2>/dev/null

whatison() {
    if [ -z "$1" ]; then
        echo "Usage: whatison <port_number>"
        return 1
    fi
    sudo lsof -i :$1
}

openports() {
    if [ -z "$1" ]; then
        echo "Usage: openports <search string>"
        return 1
    fi
    sudo lsof -i -n -P | grep TCP | grep $1
}
