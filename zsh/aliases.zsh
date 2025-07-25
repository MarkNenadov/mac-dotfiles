alias mv='mv -i'
for c in cp rm chmod chown rename; do
  alias $c="$c -v"
done
alias ps="ps -ef"
alias p="ps -ef|grep "
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
alias du="du -h"
alias u="uptime"
alias f1="awk '{print \$1}'"
alias f2="awk '{print \$2}'"
alias f3="awk '{print \$3}'"
alias df="df -h"
alias cls="clear"
alias d="cd ~/Documents"
alias dl="cd ~/Documents"
alias p="cd ~/CodeProjects"
alias path='echo -e ${PATH//:/\\n}'
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

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
alias gc="git commit"
alias gs="git status"
alias gl="git log"
alias gl1="git log --pretty=oneline"
alias gss="git status -s"
alias clone="git clone"
alias gm="git merge"
alias gfm="git fetch; git merge;"
alias git-ls="git ls-tree -r master --name-only"
alias trigger-build="git commit --allow-empty -m "Trigger build" && git push"

# networking

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"
alias ports="netstat -p tcp -t -u -l -a -n"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias guessos="sudo nmap -O"

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

# various
alias e64=encode64
