function silent_unalias() {
  unalias $1 2>/dev/null
}

# This sources all .zsh files from the ~/.zsh/ directory for better organization
for module in ~/.zsh/*.zsh; do
	source "$module"
done

# Custom utility functions

function  encode64() {
  if [ -f "$1" ]; then

    local mime;
    mime=$(file -b --mime-type "$1")

    if [[ $mime == text/* ]]; then
        mime="${mime};charset=utf-8"
    fi

    printf "data:${mime};base64,%s" "$(base64 -i "$1")"
  else
    if [[ $# -eq 0 ]]; then
      cat | base64
    else
      printf '%s' "$1" | base64
    fi
  fi
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# temporal
export PATH=$PATH:$HOME/.temporalio/bin

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
