#!/bin/zsh
export SHELL_LOADED="zsh"
# zsh configuration file
[[ -f /etc/zshrc ]] && source /etc/zshrc

# Load the dot-files. Note: 'extra' must be at the end for extensibility
for file in ~/.{exports,aliases,zsh_options,functions.sh,extra}; do
    [[ -r "$file" ]] && . "$file";
done
