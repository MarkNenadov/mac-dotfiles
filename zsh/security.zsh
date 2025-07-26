silent_unalias randpass

function randpass() {
  local len=${1:-32}
  openssl rand -base64 256 | tr -d '\n/+='| cut -c -$len
}

alias mkpasswd=randpass
