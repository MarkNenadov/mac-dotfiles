#!/usr/bin/env zsh

silent_unalias server

# Start HTTP server from current directory
# from https://github.com/cassiascheffer/dotfiles/blob/main/zsh/.zshrc

# Start a local HTTP server from the current directory
# Uses Python's built-in HTTP server, defaults to port 8000
# Automatically opens the URL in the default browser after 1 second
# Usage: server [port_number]
function server() {
    local port="${1:-8000}"
    echo "Starting HTTP server on port $port..."
    echo "Open http://localhost:$port in your browser"
    sleep 1 && open "http://localhost:$port/" &
    python3 -m http.server "$port"
}
