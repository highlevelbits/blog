#! /usr/bin/env bash

rm -rf output/*
nanoc
cd output
echo highlevelbits.com > CNAME
git add .
git commit -am "high level bits automatic deploy"
git push -f origin gh-pages
cd ..

