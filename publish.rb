#! /usr/bin/env ruby

require 'tmpdir'

`git checkout master`
`nanoc prune compile`
`git push git@github.com:highlevelbits/blog.git gh-pages`
