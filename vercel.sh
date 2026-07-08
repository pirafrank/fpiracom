#!/bin/bash

if [[ $VERCEL_ENV != "production"  ]] ; then
  bundle exec jekyll build --future --drafts
else
  bundle exec jekyll build
fi
