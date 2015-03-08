#! /usr/bin/env bash

git config --global user.email "highlevelbits@eldfluga.se"
git config --global user.name "high level bits automator"

git clone https://github.com/highlevelbits/blog.git --branch gh-pages output
rm -rf output/*
nanoc
cd output
echo highlevelbits.com > CNAME
git add .
git commit -am "high level bits automatic deploy"
git push --force --quiet "https://${GH_AUTH}@github.com/highlevelbits/blog.git" gh-pages > /dev/null 2>&1
