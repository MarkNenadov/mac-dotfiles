# basic shell

alias rm="rm -v"
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

# version control

alias g="git"
alias git-ls="git ls-tree -r master --name-only"

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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
