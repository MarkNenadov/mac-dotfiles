#!/usr/bin/env zsh

silent_unalias server

# Start HTTP server from current directory
# from https://github.com/cassiascheffer/dotfiles/blob/main/zsh/.zshrc

function server() {
    local port="${1:-8000}"
    echo "Starting HTTP server on port $port..."
    echo "Open http://localhost:$port in your browser"
    sleep 1 && open "http://localhost:$port/" &
    python3 -m http.server "$port"
}
