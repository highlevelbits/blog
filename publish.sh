#! /usr/bin/env bash

nanoc prune compile --yes
cd output
git commit -m "high level bits automatic deploy"
git push git@github.com:highlevelbits/blog.git gh-pages
cd ..`

