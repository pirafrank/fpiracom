#!/bin/bash

# crontab entry
# 0 0 * * * /bin/bash /home/francesco/fpiracom_static_backup_from_ftp.sh > /dev/null 2>&1

# Warning: make sure that the target directory exists, otherwise the cd command will FAIL,
# so operation INCLUDING DELETING trees of files WILL TAKE PLACE at WRONG directory (root)!

#
# variables
#

LOCAL_STATIC="/var/www/fpira.com_static"
TEST_FOLDER="test_rDYZkm2w"


# avoid running in root or home dir
if [[ ./ -ef / ]]; then
    echo "Cannot run from root ('/')"
    exit 1
fi

if [[ ./ -ef ~ ]]; then
    echo "Cannot run from user's root ($pwd)"
    echo "Creating a dedicated folder..."
    mkdir ~/$TEST_FOLDER
    cd $TEST_FOLDER
fi

# checking target dir to exist
if [ ! -d "$LOCAL_STATIC/static" ]; then
    echo "Error: target directory ($LOCAL_STATIC) doesn't exists!"
    echo "Exiting..."
    exit 1
fi

# syncing remote to local static folder
lftp -c "set file:charset ASCII;
set ftp:ssl-allow no;
open ftp://fpiracom:PASSWORD_HERE@149.255.58.6;
lcd /var/www/fpira.com_static/static;
cd cdn.fpira.com/static;
mirror --only-newer --use-cache --verbose --allow-chown 
--allow-suid --no-umask --parallel=2 --exclude-glob .svn"

# committing to repo configured with git lfs

cd "$LOCAL_STATIC"

echo "pulling from static files repo..."
git pull origin master
sleep 1
echo "backing up all the static files to the repo..."
git add .
sleep 1
git commit -m 'commit'
sleep 1
git push origin --all
