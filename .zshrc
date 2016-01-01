# zsh configuration file

for file in ~/.{aliases,exports,sources}; do
    [ -r "$file" ] && source "$file";
done
unset file
