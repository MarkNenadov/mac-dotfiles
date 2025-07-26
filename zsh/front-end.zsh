#!/usr/bin/env zsh

# bun completions
[ -s "/Users/markn/.bun/_bun" ] && source "/Users/markn/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
