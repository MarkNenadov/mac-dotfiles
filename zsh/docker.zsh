#!/usr/bin/env zsh

silent_unalias docker_prune

# Completely clean up Docker system resources
# Removes all unused containers, networks, images, and volumes
# Usage: docker_prune
function docker_prune() {
    docker system prune --volumes -fa
}
