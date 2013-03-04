#! /usr/bin/env bash

nanoc prune compile --yes
cd output
git add .
git commit -am "high level bits automatic deploy"
git push git@github.com:highlevelbits/blog.git gh-pages
cd ..

