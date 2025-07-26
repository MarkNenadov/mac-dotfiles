# mac-dotfiles

My dotfiles and configuration scripts for macOS, optimized for ZSH and Homebrew environments.

I've shared some thoughts on this subject over at my blog: https://wondering.willow.camp/the-joys-of-dotfiles

## Features

- 🚀 Quick setup with a single command
- 🛠️ Homebrew package management
- 🐍 Python environment configuration
- 🎨 Custom ZSH configuration with useful aliases and functions
- 🔧 Git configuration with helpful aliases
- 📝 Vim configuration

## Quick Start

```bash
# Full installation (including Homebrew packages)
./install.sh

# Installation without Homebrew packages
./install.sh --skip-brew

# Preview changes without making them (dry run)
./install.sh --dry-run

# Quiet installation (reduces Homebrew noise)
./install.sh --quiet

# Combine options (e.g., dry run without Homebrew)
./install.sh --dry-run --skip-brew

# Update your dotfiles (uses quiet mode)
./update.sh
```

## Requirements

- macOS
- ZSH shell
- Homebrew (optional, can be installed during setup)

## Configuration Files

### Core Configuration
- `gitconfig` - Git configuration with aliases and settings
- `zshrc` - Main ZSH configuration file
- `vimrc` - Vim editor configuration

### Package Management
- `Brewfile` - Homebrew package definitions
- `python-requirements.txt` - Python package dependencies

### ZSH Extensions
- `.zsh/aliases.zsh` - Shell aliases
- `.zsh/*.zsh` - Utility functions organized by category

## Useful Aliases

```bash
# Network
guessos 127.0.0.1    # Use nmap to guess host OS
ports                # Show open ports on 127.0.0.1
ips                  # List bound IPs

# Process Management
p xyz                # ps -ef|grep xyz

# Development
mvn-outdated         # List Maven dependency updates
gfm                  # git fetch; git merge

# File Operations
gz                   # gzip
gu                   # gunzip
a+w                  # chmod a+w
f1                   # awk '{print $1}'
```

## Utility Functions

```bash
2png test.jpg   # Convert test.jpg to test.png
last_commit     # Show time since last commit in git repo
docker_prune    # Clean up Docker volumes
randpass        # Generate a random password
```

## Contributing

Feel free to fork this repository and customize it for your needs. Pull requests are welcome!

## Acknowledgments

Thanks to the following developers for inspiration and ideas:

* Eric Farkas (https://github.com/speric)
* Carlos Alexandro Becker (https://github.com/caarlos0)
* Ian Langworth (https://github.com/statico)
* Wynn Netherland (https://github.com/pengwynn)
* Mathias Bynens (https://github.com/mathiasbynens)
* Wade Simmons (https://github.com/wadey)
* Roman Ožana (https://github.com/OzzyCzech)
* Cassia Scheffer (https://github.com/cassiascheffer)
