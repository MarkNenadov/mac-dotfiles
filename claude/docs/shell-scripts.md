# shell-scripts.md

## Basic Principles

* Prefer zsh
* Use #!/usr/bin/env zsh at the top of each zsh file
* Use snake case
* Maximum line length is 80 characters.
* Pipelines should be split one per line if they don't all fit on one line.

## File Naming

* Use .sh for command-line exeuctabe scripts
* Use .zsh for libraries and other things intended to be sourced

## Variables

* Use local variables where possible
* local variables should never be capitlized
* Use readonly for constants

## Functions

* Check parameters and fail with error message if not provided
* Use function keyword to make a function (not just my_function() {})
* Use opening brace (on same line as function name)
