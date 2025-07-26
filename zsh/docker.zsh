#!/usr/bin/env zsh

silent_unalias docker_prune

function docker_prune() {
    docker system prune --volumes -fa
}
