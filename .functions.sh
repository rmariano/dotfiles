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
    BRANCH=${1:-master}

    git checkout $BRANCH \
        && git pull origin $BRANCH \
        && git branch --merged | egrep -v '(\*|master|develop)' | xargs git branch -d
}


man() {
    ### Colors in man pages!
	env \
		LESS_TERMCAP_mb="$(printf '\e[1;31m')" \
		LESS_TERMCAP_md="$(printf '\e[1;31m')" \
		LESS_TERMCAP_me="$(printf '\e[0m')" \
		LESS_TERMCAP_se="$(printf '\e[0m')" \
		LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
		LESS_TERMCAP_ue="$(printf '\e[0m')" \
		LESS_TERMCAP_us="$(printf '\e[1;32m')" \
		man "$@"
}
