#!/bin/bash
# Disable CTRL-S/Q
stty -ixon

# Source global definitions
[[ -f /etc/bashrc ]] && source /etc/bashrc

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
[[ -f "${HOME}/.bash_profile" ]] && source "${HOME}/.bash_profile"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=50000000;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
export HISTFILE=$HOME/.bash_history
export HISTTIMEFORMAT="[%Y-%m-%d %H:%M] "
