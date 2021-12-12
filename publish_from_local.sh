#! /usr/bin/env bash

# I keep this for reference or when travis starts failing 
# for now publishing is done when pushing to master

rm -rf output/*
nanoc compile
cd output
echo highlevelbits.com > CNAME
git add .
git commit -am "high level bits automatic deploy"
git push -f origin gh-pages
cd ..

