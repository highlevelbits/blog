#! /usr/bin/env bash

nanoc
cd output
git pull -f origin gh-pages
git add .
git commit -am "high level bits automatic deploy"
git push -f origin gh-pages
cd ..

