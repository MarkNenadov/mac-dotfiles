#!/usr/bin/env zsh

silent_unalias flushdns

# Clear DNS cache on macOS
# Flushes system DNS cache and reloads mDNSResponder service
# Usage: flushdns
function flushdns() {
    require_macos || return 1
    sudo dscacheutil -flushcache; 
    sudo killall -HUP mDNSResponder   
}
