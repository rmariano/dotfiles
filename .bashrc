#!/bin/bash
# Disable CTRL-S/Q
stty -ixon

export SHELL_LOADED="bash"

# Source global definitions
[[ -f /etc/bashrc ]] && source /etc/bashrc

# make 'less' more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Load git completion
[[ -r $HOME/.git-completion.bash && -f $HOME/.git-completion.bash ]] && source $HOME/.git-completion.bash

# Load the dot-files. Note: 'extra' must be at the end for extensibility
for file in ~/.{exports,aliases,bash_options,bash_prompt,functions.sh,extra}; do
    [[ -r "$file" &&  -f "$file" ]] && . "$file" ;
done
unset file

export HISTTIMEFORMAT="%Y-%m-%d %H:%M "
