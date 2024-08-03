# basic shell

source ~/.zsh/aliases.zsh

# helper functions

mkcd() {
  mkdir "$1"
  cd "$1" || return 1
}

docker_prune() {
	docker system prune --volumes -fa
}

randpass() {
  local len=${1:-32}
  openssl rand -base64 256 | tr -d '\n/+='| cut -c -$len
}

alias mkpasswd=randpass

last_commit() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    git log -1 --pretty=format:"%ar" | sed 's/\([0-9]*\) \(.\).*/\1\2/'
}

function 2heic() {
  for i in "$@"; do sips -s format heic -s formatOptions 80 "$i" --out "${i%.*}.heic"; done
}

function 2png() {
  for i in "$@"; do sips -s format png -s formatOptions 80 "$i" --out "${i%.*}.png"; done
}

function 2jpg() {
  for i in "$@"; do sips -s format jpg -s formatOptions 80 "$i" --out "${i%.*}.jpg"; done
}
123

trash() { mv $1 ~/.Trash }

f() {
    find . -name "$1"
}

whatison() {
    lsof -i :$1
}

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

alias e64=encode64

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# add temporal
export PATH=$PATH:/Users/markn/.temporalio/bin

# bun completions
[ -s "/Users/markn/.bun/_bun" ] && source "/Users/markn/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# py env
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
