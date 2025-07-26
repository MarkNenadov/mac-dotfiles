whatison() {
    if [ -z "$1" ]; then
        echo "Usage: whatison <port_number>"
        return 1
    fi
    sudo lsof -i :$1
}
