#!/usr/bin/zsh
#### functions.sh
## Extra functions available at the command line
####

########## Python-specific
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

####
## Function to create virtual environments
## Call format: $ mkvirtualenv <virtual-environment-name> [<python-version>]
## The first parameter is mandatory and it's the name of the new virtual
## environment to create.
## The second, optionally indicates the Python version to use (e.g. "python3.8")
## The new virtual environment will be created in $WORKON_HOME
####
mkvirtualenv() {
    VIRTUALENV_NAME=${1}
    if [ -z "$VIRTUALENV_NAME" ]; then
        echo "No name was provided for the new virtual envionment"
        return -1
    fi

    if [ -z "$2" ]; then
        PYTHON_VERSION=$(which python3);
    else
        PYTHON_VERSION=${2}
    fi
    echo "Creating environment '${VIRTUALENV_NAME}' with $(${PYTHON_VERSION} --version)"

    ${PYTHON_VERSION} -m venv "${WORKON_HOME}/${VIRTUALENV_NAME}"
}

########## Git
gitclean() {
    ####
    ### A git helper function
    ### Update ``master`` and delete old (merged) branches
    ####
    BRANCH=${1:-master}

    git checkout $BRANCH \
        && git pull origin $BRANCH \
        && git branch --merged | egrep -v '(\*|master|develop)' | xargs -r git branch -d
}


## Miscellaneous
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
