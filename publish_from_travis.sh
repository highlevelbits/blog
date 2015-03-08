#! /usr/bin/env bash

git config user.email "highlevelbits@eldfluga.se"
git config user.name "high level bits automator"

bundle install
git clone https://github.com/highlevelbits/blog.git --branch gh-pages output
nanoc
cd output
echo highlevelbits.com > CNAME
git add .
git commit -am "high level bits automatic deploy"
git push --force --quiet "https://${GH_AUTH}@github.com/highlevelbits/blog.git" master:gh-pages 
