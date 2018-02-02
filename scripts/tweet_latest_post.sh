#!/bin/bash

website_domain="$1"
if [ ! -z "$website_domain" ] && [ ! $(ls _posts/$(date '+%Y-%m-%d')-* > /dev/null 2>&1) ]; then
    post_filepath="$(ls _posts/"$(date '+%Y-%m-%d')"-* | head -n1)"
    post_title="$(cat $post_filepath | head -n6 | grep "title\:" | cut -d ' ' -f2- | sed 's/"//g')"
    post_url="https://""$website_domain/$(date '+%Y/%m')/$(echo $post_filepath | sed -e 's/\.md//g' -e 's/_posts\///g' | cut -d '-' -f4-)"
fi

source "$HOME/.config/secrets/pushbullet.sh"

MESSAGE="Blog update: \'$post_title.\n Check it out here $post_url\'"

curl --header "Access-Token: $PUSHBULLET_API_TOKEN" \
     --header 'Content-Type: application/json' \
     --data-binary "{\"body\":\"$MESSAGE\",\"title\":\"$website_domain auto-deploy (twitter)\",\"type\":\"note\"}" \
     --request POST \
     https://api.pushbullet.com/v2/pushes
