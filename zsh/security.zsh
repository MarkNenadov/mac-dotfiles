#!/usr/bin/env zsh

silent_unalias randpass

# Generate a secure random password using OpenSSL
# Creates base64-encoded password, removing problematic characters
# Default length is 32 characters, customizable via first argument
# Usage: randpass [length]
function randpass() {
  local len=${1:-32}
  openssl rand -base64 256 | tr -d '\n/+='| cut -c -$len
}

alias mkpasswd=randpass
