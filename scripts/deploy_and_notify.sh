#!/bin/bash

website_domain="fpira.com"
source "$HOME/.config/secrets/pushbullet.sh"

# assume we are in the root of pirafrank.github.io
bash scripts/deploy_fpiracom.sh s > "$HOME/deploy_fpiracom.log"

### notify via Pushbullet
if [[ $? -eq 0 ]]; then # check if deploy_fpiracom.sh exited with success
MESSAGE="SUCCESS, $website_domain deployed!"
else
MESSAGE="ERROR, $website_domain deploy script exited with code = $?"
fi

curl --header "Access-Token: $PUSHBULLET_API_TOKEN" \
     --header 'Content-Type: application/json' \
     --data-binary "{\"body\":\"$MESSAGE\",\"title\":\"$website_domain auto-deploy\",\"type\":\"note\"}" \
     --request POST \
     https://api.pushbullet.com/v2/pushes
