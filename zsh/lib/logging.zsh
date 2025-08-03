#!/usr/bin/env zsh

# Centralized logging functions for mac-dotfiles

log() {
	echo "[mac-dotfiles] $1"
}

log_dry_run() {
	echo "[mac-dotfiles] [DRY RUN] $1"
}