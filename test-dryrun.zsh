#!/usr/bin/env zsh

# This script is used to test the dry run functionality of the install script 
# (it throws an error if it tries to change things)

/usr/bin/sandbox-exec -f ./test-dryrun.sb ./install.zsh --dry-run