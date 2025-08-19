#!/usr/bin/zsh
#### functions.sh
## Extra functions available at the command line
####

#### Git
####
### Update ``main`` and delete old (merged) branches
####
,git-clean() {
    BRANCH=${1:-main}
    PREFIX=${2}

    git checkout $BRANCH \
        && git pull origin $BRANCH \
        && git branch --merged | egrep -v '(\*|main|mainline|master|develop)' | xargs -r git branch -d

    if [ -n "${PREFIX}" ]; then
        git branch | grep --color=none "${PREFIX}" | xargs -r git branch -D
    fi
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

,git-diff() {
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD);
  AGAINST=${1}
  git diff ${AGAINST} | diff2html -i stdin -t "Diff ${CURRENT_BRANCH}..${AGAINST}" --summary open
}


## Docker

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
