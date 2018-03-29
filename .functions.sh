#!/usr/bin/zsh
#### functions.sh
## Extra functions available at the command line
####

workon() {
    ###
    ## Activate the virtual environment
    ###
    export VENV_LOCATION="$WORKON_HOME/$1/bin/activate"
    if [[ ! -f $VENV_LOCATION ]]; then
        echo "Virtual environment '$1' doesn't exist";
    fi
    source $VENV_LOCATION
}


gitclean() {
    ####
    ### A git helper function
    ### Update ``master`` and delete old (merged) branches
    ####
    git checkout master \
        && git pull origin master \
        && git branch --merged | egrep -v '(\*|master)' | xargs git branch -d
}
