# .bash_profile

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Load git completion
[[ -r $HOME/.git-completion.bash && -f $HOME/.git-completion.bash ]] && source $HOME/.git-completion.bash

# Load dotfiles
for file in ~/.{bash_prompt,aliases,exports,sources,bash_options}; do
    [[ -r "$file" &&  -f "$file" ]] && source "$file"
done
unset file

PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH
