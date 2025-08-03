#!/usr/bin/env zsh

silent_unalias get_os_info
silent_unalias is_macos
silent_unalias require_macos

# Detect and return operating system type and version
# Returns format: "os_type:version" (e.g., "macos:14.5" or "linux:22.04")
# Usage: get_os_info
function get_os_info() {
    local os_type
    local os_version
    
    case "$(uname -s)" in
        Darwin)
            os_type="macos"
            os_version=$(sw_vers -productVersion)
            ;;
        Linux)
            os_type="linux"
            if [[ -f /etc/os-release ]]; then
                os_version=$(awk -F= '/^VERSION=/{print $2}' /etc/os-release | tr -d '"')
            fi
            ;;
        *)
            os_type="unknown"
            os_version="unknown"
            ;;
    esac
    
    echo "$os_type:$os_version"
}

# Check if current system is macOS
# Returns true (0) if running on macOS, false (1) otherwise
# Usage: is_macos
function is_macos() {
    [[ "$(uname -s)" == "Darwin" ]]
}


# Ensure function is running on macOS, return error if not
# Prints error message and returns 1 if not on macOS
# Usage: require_macos || return 1
function require_macos() {
    if ! is_macos; then
        echo "Error: This function requires macOS"
        return 1
    fi
}

