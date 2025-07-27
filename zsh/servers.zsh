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
    
    if [[ ! "$port" =~ ^[0-9]+$ ]]; then
        echo "Error: Port must be numeric" >&2
        return 1
    fi
    
    if (( port < 1024 )); then
        echo "Error: Port $port is a privileged port (< 1024) and requires sudo" >&2
        return 1
    fi
    
    if (( port > 65535 )); then
        echo "Error: Port $port is out of valid range (1024-65535)" >&2
        return 1
    fi
    
    echo "Starting HTTP server on port $port..."
    echo "Open http://localhost:$port in your browser"
    sleep 1 && open "http://localhost:$port/" &
    python3 -m http.server "$port"
}

# Guess operating system of a remote host using nmap OS detection
# Uses nmap's -O flag to perform OS fingerprinting via TCP/IP stack analysis
# Requires sudo privileges for raw socket access
# Usage: guessos <ip_address>
function guessos() {
    if [ $# -eq 0 ]; then
        echo "Error: No ip address specified. Usage: guessos <ip_address>"
        return 1
    fi

    sudo nmap -O $1
}