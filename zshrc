# basic shell

for module in ~/.zsh/*.zsh; do
	source "$module"
done


# helper functions

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

function versions() {
	bun_version=$(bun --version)
	echo "Bun: $bun_version"

	node_version="$(node --version)"
	echo "Node: $node_version"

	npm_version="$(npm --version)"
	echo "Npm: $npm_version" 
	
	python_version="$(python --version)"
	echo "Python: $python_version"

	ruby_version="$(ruby --version)"
	echo "Ruby: $ruby_version"
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# add temporal
export PATH=$PATH:$HOME/.temporalio/bin

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# py env
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
