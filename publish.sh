#! /usr/bin/env bash

nanoc prune compile --yes
cd output
git pull origin gh-pages
git add .
git commit -am "high level bits automatic deploy"
git push origin gh-pages
cd ..
