#!/usr/bin/env zsh

silent_unalias whatison
silent_unalias openports

function whatison() {
    if [ -z "$1" ]; then
        echo "Usage: whatison <port_number>"
        return 1
    fi
    sudo lsof -i :$1
}

function openports() {
    if [ -z "$1" ]; then
        echo "Usage: openports <search string>"
        return 1
    fi
    sudo lsof -i -n -P | grep TCP | grep $1
}
