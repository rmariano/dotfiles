# zsh configuration file

for file in ~/.{aliases,exports,sources,zsh_options,zsh_prompt}; do
    [ -r "$file" ] && source "$file";
done
unset file
