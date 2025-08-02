function silent_unalias() {
  if [[ $# -eq 0 || -z "$1" ]]; then
    echo "Usage: silent_unalias <alias_name>" >&2
    return 1
  fi
  
  unalias "$1" 2>/dev/null
}

# This sources all .zsh files from the ~/.zsh/ directory for better organization
for module in ~/.zsh/*.zsh; do
	source "$module"
done

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Mise 
eval "$(mise activate zsh)"

# temporal
export PATH=$PATH:$HOME/.temporalio/bin

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
