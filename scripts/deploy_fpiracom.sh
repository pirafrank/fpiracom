#!/bin/bash

# Usage
# use 's' to deploy to stable, use 't' to deploy to test.

# Global Variables
REPO_DIR="/home/francesco/Repositories/pirafrank.github.io" # change this to the dir where the repo has been cloned to.
STABLE_PATH="/var/www/fpira.com"
TEST_PATH="/var/www/test.fpira.com"
website_domain="fpira.com"
website_testdomain="test.fpira.com"

# Script Variables
WEB_ROOT=""
MASTER="master"
DEVELOP="develop"
TODAY="$(date '+%Y-%m-%d %H:%M:%S')"
SECONDS=0

# functions
function print_usage {
    echo "Error: wrong number of arguments"
    echo "Usage: ./deploy_fpiracom.sh <option>"
    echo "Options: 's' to deploy to stable, use 't' [branch] to deploy given branch to $website_testdomain"
}

#
# Script
#

if [[ $# != 1 ]] && [[ $# != 2 ]]; then
    print_usage
    exit 1
fi

cd $REPO_DIR

echo "
Hi $(whoami)!
uptime: $(uptime)
date  : $(date '+%Y-%m-%d %H:%M:%S')
"

if [ $1 == "s" ]; then
    git checkout -f $MASTER
    sleep 1
    git reset --hard HEAD
    git pull origin $MASTER
    WEB_ROOT=$STABLE_PATH
elif [[ $1 == "t" ]] && [[ ! -z $2 ]]; then
    # git checkout -f $DEVELOP
    git checkout -f $2
    sleep 1
    git reset --hard HEAD
    # git pull origin $DEVELOP
    git pull origin $2
    WEB_ROOT=$TEST_PATH
else
    print_usage
    exit 1
fi

if [ ! -z "$WEB_ROOT" ]; then
    echo "Cleaning up..."
    rm -rf _site
    if [ $1 == "s" ]; then
        JEKYLL_ENV="production" jekyll build
        # generating service-worker.js with list of files to keep offline
        sw-precache --config sw-config.js # 'npm install --global sw-precache' needed
    else
        JEKYLL_ENV="development" jekyll build --drafts --future
    fi
    echo "Deploying to $WEB_ROOT ..."
    # rsync -avhz -c --delete _site/ $USER@$SERVER:"$WEB_ROOT" # remote deploy
    rsync -avhz -c --delete _site/ "$WEB_ROOT" # local deploy
    if [ $1 == "s" ]; then cp service-worker.js "$WEB_ROOT/"; fi
    CURRENT_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
    printf "Deployed at: %s<br>branch: %s<br>commit: %s" "$TODAY" "$CURRENT_BRANCH" "$(git rev-parse HEAD)" > "$WEB_ROOT"/release.html
    echo "Deployed to $WEB_ROOT !"
else
    echo "An error has occurred: WEB_ROOT is null. Aborting..."
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
    bash /home/francesco/utils/ftp_mirror/fpira.com_static_backup_from_ftp.sh
else
    echo "No post-run scripts to run after deploying test version. Bye!"
fi

DURATION=$SECONDS

# Greetings
echo "
All done! Bye $(whoami)...
date: $(date '+%Y-%m-%d %H:%M:%S')
script run in $(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds.
"
exit 0

