#!/bin/bash

# Usage
# use 's' to deploy to stable, use 't' to deploy to test.


#
# Variables
#

MAIN_DIR="." # change this to the dir where the repo has been cloned to.
CURRENT_BRANCH=$( cd $MAIN_DIR && git branch | sed -n -e 's/^\* \(.*\)/\1/p')
STABLE_PATH="/var/www/fpira.com"
TEST_PATH="/var/www/test.fpira.com"
USER="francesco"
SERVER="lisa.fpira.com"
REMOTE_PATH=""

#
# Script
#

cd $MAIN_DIR

if [[ $# != 1 ]]; then
    echo "Error: wrong number of arguments"
    echo "Usage: ./deploy.sh <option>"
    echo "Options: 's' to deploy to stable, use 't' to deploy to test."
    exit 1
fi

if [ $1 == "s" ]; then
    if [ "$CURRENT_BRANCH" != "master" ]; then
        echo "You're not on branch 'master'"
        exit 1
    fi
    REMOTE_PATH=$STABLE_PATH
    STATUS="1"
elif [ $1 == "t" ]; then
    REMOTE_PATH=$TEST_PATH
    STATUS="1"
else
    echo "Invalid option!"
    echo "Usage: ./deploy.sh <option>"
    echo "Options: 's' to deploy to stable, use 't' to deploy to test."
    exit 1
fi

if [ ! -z "$REMOTE_PATH" ]; then
    echo "Cleaning up..."
    rm -rf _site
    jekyll b
    echo "Deploying to $REMOTE_PATH ..."
    rsync -avhz -c --delete _site/ $USER@$SERVER:"$REMOTE_PATH" # remote deploy
    # rsync -avhz -c --delete _site/ "$REMOTE_PATH" # local deploy
    echo "Deployed to $REMOTE_PATH !"
else
    echo "An error has occurred! Aborting..."
    exit 1
fi


