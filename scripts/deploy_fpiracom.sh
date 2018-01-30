#!/bin/bash

# Usage
# use 's' to deploy to stable, use 't' to deploy to test.


#
# Variables
#

REPO_DIR="/home/francesco/Repositories/pirafrank.github.io" # change this to the dir where the repo has been cloned to.
STABLE_PATH="/var/www/fpira.com"
TEST_PATH="/var/www/test.fpira.com"
WEB_ROOT=""
MASTER="master"
DEVELOP="develop"

#
# Script
#

cd $REPO_DIR
CURRENT_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

if [[ $# != 1 ]] && [[ $# != 2 ]]; then
    echo "Error: wrong number of arguments"
    echo "Usage: ./deploy.sh <option>"
    echo "Options: 's' to deploy to stable, use 't' [branch] to deploy given branch to test.fpira.com."
    exit 1
fi

echo "
Hi $(whoami)!
uptime: $(uptime)
date  : $(date)
"

SECONDS=0

if [ $1 == "s" ]; then
    git checkout -f $MASTER
    sleep 1
    git reset --hard HEAD
    git pull origin $MASTER
    WEB_ROOT=$STABLE_PATH
    STATUS="1"
elif [[ $1 == "t" ]] && [[ ! -z $2 ]]; then
    # git checkout -f $DEVELOP
    git checkout -f $2
    sleep 1
    git reset --hard HEAD
    # git pull origin $DEVELOP
    git pull origin $2
    WEB_ROOT=$TEST_PATH
    STATUS="1"
else
    echo "Error: branch to deploy missing!"
    echo "Usage: ./deploy.sh -t <branch>"
    echo "Options: 's' to deploy to stable, use 't' [branch] to deploy to given branch to test.fpira.com."
    exit 1
fi

if [ ! -z "$WEB_ROOT" ]; then
    echo "Cleaning up..."
    rm -rf _site
    if [ $1 == "s" ]; then
        JEKYLL_ENV="production" jekyll build
        sw-precache --config sw-config.js # 'npm install --global sw-precache' needed
    else
        JEKYLL_ENV="development" jekyll build --drafts --future
    fi
    echo "Deploying to $WEB_ROOT ..."
    # rsync -avhz -c --delete _site/ $USER@$SERVER:"$WEB_ROOT" # remote deploy
    rsync -avhz -c --delete _site/ "$WEB_ROOT" # local deploy
    if [ $1 == "s" ]; then cp service-worker.js "$WEB_ROOT/"; fi
    echo "Deployed to $WEB_ROOT !"
else
    echo "An error has occurred! Aborting..."
    exit 1
fi

### Post-run scripts go here (if any) ###
echo "
 # # # # # # # # # # # # #
 Running post-run scripts
 # # # # # # # # # # # # #
"

if [ $1 == "s" ]; then
    # these scripts will run after deploying production
    #/home/francesco/fpira.com_static_backup_and_deploy.sh
    /home/francesco/utils/ftp_mirror/fpira.com_static_backup_from_ftp.sh
else
    echo "No post-run scripts to run after deploying test version. Bye!"
fi

DURATION=$SECONDS

# Greetings
echo "
All done! Bye $(whoami)...
date: $(date)
script run in $(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds.
"
exit 0

