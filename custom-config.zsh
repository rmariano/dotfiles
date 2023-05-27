#!/bin/zsh
export SHELL_LOADED="zsh"
# Load the dot-files. Note: 'extra' must be at the end for extensibility
for file in ~/.{aliases,exports,zsh_options,functions.sh,extra}; do
    [[ -r "$file" ]] && . "$file";
done
