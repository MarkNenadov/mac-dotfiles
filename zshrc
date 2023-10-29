# basic shell

alias mv='mv -i'
for c in cp rm chmod chown rename; do
  alias $c="$c -v"
done
alias p="ps -ef|grep "
alias f="find .|grep "
alias v="vim"
alias q="exit"
alias :q="exit"
alias c="clear"
alias ..="cd .."
alias h="history"
alias sus="su -s"
alias follow="tail -f"
alias ls="ls --color=auto"
alias duf="du -sh * | sort -hr"
alias f1="awk '{print \$1}'"
alias f2="awk '{print \$2}'"
alias f3="awk '{print \$3}'"

# ownership 

alias own="chown $USER:$USER"
alias a+x="chmod a+x"
alias a+r="chmod a+r"
alias a+w="chmod a+w"
alias a-x="chmod a-x"
alias a-r="chmod a-r"
alias a-w="chmod a-w"

# development

alias py="python3"
alias rb="ruby"
alias mvn-outdated="mvn versions:display-dependency-updates"
alias mvnci='mvn clean install'

# version control

alias g="git"
alias ga="git add"
alias gf="git fetch"
alias gp="git push"
alias gm="git mergeh"
alias gfm="git fetch; git merge;"
alias git-ls="git ls-tree -r master --name-only"

# javascript
alias y="yarn"
alias n="npm"

# compression

alias gz="gzip"
alias gu="gunzip"
alias z="zip"
alias zu="unzip"

# installation

alias upgrade="brew upgrade"

# typos

alias ccd="cd"
alias lls="ls"
alias cim="vim"
 
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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
