#!/usr/bin/env zsh

set -ex

git pull --ff-only
./install.zsh --quiet
