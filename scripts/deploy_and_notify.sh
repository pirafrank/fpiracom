#!/bin/bash

website_name='fpira.com'
source "$HOME/.config/secrets/pushbullet.sh"

bash deploy_fpiracom.sh s > "$HOME/deploy_fpiracom.log"

if [[ $? -eq 0 ]]; then
MESSAGE="SUCCESS, $website_name deployed!"
else
MESSAGE="ERROR, $website_name deploy script exited with code = $?"
fi

curl --header "Access-Token: $PUSHBULLET_API_TOKEN" \
     --header 'Content-Type: application/json' \
     --data-binary "{\"body\":\"$MESSAGE\",\"title\":\"fpira.com auto-deploy\",\"type\":\"note\"}" \
     --request POST \
     https://api.pushbullet.com/v2/pushes
