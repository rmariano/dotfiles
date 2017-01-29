#!/bin/bash
set -euo pipefail

##############################################################################
#### start-branch.sh
####
#### Read $PROJECTS where the local projects reside,
#### defaulting to $HOME/projects
#### and for each one of them, create a new branch with the
#### name provided in $1, starting from the latest develop
##############################################################################

BRANCH_NAME=$1
PROJECTS_DIR=$PROJECTS
if [[ "$PROJECTS_DIR" == "" ]]; then
    PROJECTS_DIR=$HOME/projects;
fi

CURR_DIR=$(pwd);

for directory in $(ls -1 $PROJECTS_DIR); do

    cd $PROJECTS_DIR/$directory;
    git checkout develop
    git pull origin develop
    git checkout -b $BRANCH_NAME;
done

cd $CURR_DIR;
