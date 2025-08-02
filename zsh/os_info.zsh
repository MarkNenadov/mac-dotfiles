#!/usr/bin/env zsh

silent_unalias get_os_info
silent_unalias is_macos
silent_unalias require_macos

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

function is_macos() {
    [[ "$(uname -s)" == "Darwin" ]]
}


function require_macos() {
    if ! is_macos; then
        echo "Error: This function requires macOS"
        return 1
    fi
}

