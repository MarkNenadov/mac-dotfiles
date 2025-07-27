# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository that provides configuration files and installation scripts for setting up a ZSH-based development environment with Homebrew package management.

## Key Commands

### Installation and Setup

- `./install.zsh` - Full installation including Homebrew packages
- `./install.sh --skip-brew` - Install dotfiles without Homebrew packages
- `./install.sh --dry-run` - Preview changes without making them
- `./install.sh --quiet` - Quiet installation (reduces Homebrew noise)
- `./install.sh --dry-run --skip-brew` - Dry run without Homebrew
- `./install.sh --inject-aliases <file>` - Inject aliases from zsh/aliases.zsh to specified file (exits after injection). Skips comments/blank lines, detects conflicts, avoids duplicates. Logic extracted to `lib/inject-aliases.zsh`
- `./update.zsh` - Update dotfiles (pulls from git and reinstalls with quiet mode)

### No Build/Test Commands

This repository contains configuration files and shell scripts - there are no build, test, or lint commands to run.

## Architecture

### Core Structure

- `install.zsh` - Main installation script with dry-run support
- `update.zsh` - Simple update script that pulls and reinstalls
- `Brewfile` - Homebrew package definitions
- `python-requirements.txt` - Python dependencies

### Configuration Files

- `gitconfig` - Git configuration with aliases
- `zshrc` - Main ZSH configuration
- `vimrc` - Vim editor configuration
- `zsh/` - Directory containing modular ZSH extensions:
  - `aliases.zsh` - Core shell aliases
  - `git.zsh` - Git utility functions (`last_commit`, `clean_branches`)
  - `docker.zsh`, `file-system.zsh`, `front-end.zsh`, `media.zsh`, `ports.zsh`, `security.zsh` - Category-specific utilities

### Installation Process

1. Installs Homebrew if not present (unless --skip-brew)
2. Installs packages from Brewfile via `brew bundle`
3. Backs up existing dotfiles (adds "OLD" suffix)
4. Creates symlinks to repository files
5. Installs zshlilly (ZSH enhancement framework)
6. Installs latest Python via pyenv
7. Installs Python packages from requirements file

### Key Features

- Dry-run capability for all operations
- Backup of existing configuration files
- Modular ZSH configuration system
- Comprehensive alias and function library
- Development tool installation via Homebrew

## Development Conventions

### General Principles

- Single-command setup
- Non-destructive updates
- Attempt to attain to modularity
- Attempt to default to safety -- validate parameters where possible

### Functions and Aliases

- Functions are preferred over aliases (especially when command can be made safer/clearer)
- Always use `function` keyword in function definitions (hence use of silent_unalias to ensure functions are not blocked by aliases)

### Documentation

- Always give credit in `README.md` for dotfile repositories borrowed from