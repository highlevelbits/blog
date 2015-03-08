#! /usr/bin/env bash

bundle install
git clone git@github.com:highlevelbits/blog.git --branch gh-pages output
nanoc
cd output
echo highlevelbits.com > CNAME
git add .
git commit -am "high level bits automatic deploy"
git push -f origin gh-pages
