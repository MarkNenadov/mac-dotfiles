# mac-dotfiles

## Introduction

My mac dotfiles, with an environment bootstrap. 

Install via 

```
./install.sh
```

To skip homebrew bootstrap for isntall:

```
./install.sh --skip-brew
```

Update via 

```
./update.sh
```

## Requirements

* MacOS / zsh
* Homebrew


## Files of Note

* gitconfig (mostly aliases, some other settings)
* Brewfile (some software I want to have installed everywhere)
* python-requirements.txt (python packages I want to have installed everywhere)
* vimrc (a few vim settings)
* zshrc (some exports and functions)
  * .zsh/aliases.zsh (lots of aliases included into zshrc)
  * .zsh/*.zsh (utility functions separated by category)

## Sample Aliases

```
guessos 127.0.0.1    # use nmap to guess host os
ports                # show open ports on 127.0.0.1
ips                  # list bound ips
p xyz                # ps -ef|grep xyz
mvn-outdated         # list maven dependency updates
gz                   # gzip
gu                   # gunzip
gfm                  # git fetch; git merge
a+w                  # chmod a+w
f1                   # awk '{print \$1}'
```

## Sample Utility Functions

```
2png test.jpg   # convert test.jpg to test.png
last_commit     # how long ago was last commit on git repo
docker_prune    # prune docker volumnes
randpass        # generate a random password
```

## Thanks

...for inspiration and, at times, being on the receiving end of dotfile "theft"...

* Eric Farkas (https://github.com/speric)
* Carlos Alexandro Becker (https://github.com/caarlos0)
* Ian Langworth (https://github.com/statico)
* Wynn Netherland (https://github.com/pengwynn)
* Mathias Bynens (https://github.com/mathiasbynens)
* Wade Simmons (https://github.com/wadey)
* Roman Ožana (https://github.com/OzzyCzech)
