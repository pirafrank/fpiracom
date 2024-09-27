#!/bin/bash

if [[ $JEKYLL_ENV == "production"  ]] ; then
  bundle exec jekyll build
else
  bundle exec jekyll build --future --drafts
fi
