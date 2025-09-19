#!/usr/bin/fish
#### functions.fish
## Extra functions available at the command line for the fish shell
####

#### Git
####
### Update `main` and delete old (merged) branches
####
function ,git-clean
    set branch $argv[1]
    if test -z $branch
        set branch main
    end
    set prefix $argv[2]

    git checkout $branch \
        && git pull origin $branch \
        && git branch --merged | egrep -v '(\*|main|mainline|master|develop)' | xargs -r git branch -d

    if test -n "$prefix"
        git branch | grep --color=none "$prefix" | xargs -r git branch -D
    end
end
