#!/usr/bin/env bash

# author: pirafrank
# date: 2024-03-22

# Get git info
info="$(git log --pretty=format:"%H;%aI;%an;%ae" | head -n1)"
branch="$(git rev-parse --abbrev-ref HEAD)"
tags="$(git tag --points-at HEAD | sed -e 's/^/"/g' -e 's/$/",/g' | tr -d '\n' | sed 's/,$//')"

# Split the info into an array
IFS=';' read -ra infoArray <<< "$info"

# Create the JSON object
json="{"
json+="\"commit_hash\":\"${infoArray[0]}\","
json+="\"commit_date\":\"${infoArray[1]}\","
json+="\"author_name\":\"${infoArray[2]}\","
json+="\"author_email\":\"${infoArray[3]}\","
json+="\"branch\":\"${branch}\","
json+="\"tags\":[${tags}]"
json+="}"

# Write the JSON object to the target file
printf "${json}"
