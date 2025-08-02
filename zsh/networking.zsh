#!/usr/bin/env zsh

silent_unalias flushdns

function flushdns() {
    require_macos || return 1
    sudo dscacheutil -flushcache; 
    sudo killall -HUP mDNSResponder   
}
