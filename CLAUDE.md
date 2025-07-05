# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository that provides configuration files and installation scripts for setting up a ZSH-based development environment with Homebrew package management.

## Key Commands

### Installation and Setup
- `./install.sh` - Full installation including Homebrew packages
- `./install.sh --skip-brew` - Install dotfiles without Homebrew packages
- `./install.sh --dry-run` - Preview changes without making them
- `./install.sh --dry-run --skip-brew` - Dry run without Homebrew
- `./update.sh` - Update dotfiles (pulls from git and reinstalls)

### No Build/Test Commands
This repository contains configuration files and shell scripts - there are no build, test, or lint commands to run.

## Architecture

### Core Structure
- `install.sh` - Main installation script with dry-run support
- `update.sh` - Simple update script that pulls and reinstalls
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