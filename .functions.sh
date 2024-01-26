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
####
### Update ``main`` and delete old (merged) branches
####
gitclean() {
    BRANCH=${1:-main}

    git checkout $BRANCH \
        && git pull origin $BRANCH \
        && git branch --merged | egrep -v '(\*|main|mainline|master|develop)' | xargs -r git branch -d
}

,git-archive-branch() {
    BRANCH_NAME=${1}
    if [ -z ${BRANCH_NAME} ]; then
        echo "Error: Branch not specified";
        return 1;
    fi;
    git tag archive/${BRANCH_NAME};
    git branch -D ${BRANCH_NAME};
}

,git-backup-branch() {
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD);
    git checkout -b backup/${CURRENT_BRANCH} ${CURRENT_BRANCH}
    git checkout -
}

,git-prb() { # pull --rebase
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD);
    git pull --rebase origin ${CURRENT_BRANCH}
}


## Add a new file into a repo that works as a paste
# requires env bar PASTE_REPO_LOCATION
,paste() {
    current_dir=$(pwd)
    FILE_TO_ADD=${1}
    PASTE_LOCATION="${PASTE_REPO_LOCATION}/paste"
    cp -f ${FILE_TO_ADD} ${PASTE_LOCATION}
    cd ${PASTE_LOCATION}
    local_file=$(basename ${FILE_TO_ADD})
    git add ${local_file} && git commit -m "New paste"
    git push origin HEAD
    link_to_paste=$(gh browse -n ${local_file})
    cd ${current_dir}
    echo "New paste successfully created at: ${link_to_paste}"
}

########## Docker

## Stop all running Docker containers
,docker-stop-all() {
    docker stop $(docker ps -a -q)
}

,docker-shell-img() {
    IMAGE_NAME_OR_ID=${1}
    docker run --rm -it ${IMAGE_NAME_OR_ID} sh
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
