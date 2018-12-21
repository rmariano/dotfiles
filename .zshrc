# zsh configuration file

for file in ~/.{aliases,exports,sources,zsh_options,zsh_prompt}; do
    [ -r "$file" ] && source "$file";
done

alias history='history -f -t "[%Y-%m-%d %H:%M]" 0'
