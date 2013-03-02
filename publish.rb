#! /usr/bin/env ruby

require 'tmpdir'

`git checkout master`
`rm -rf output`
`nanoc`
Dir.mktmpdir { |dir|
  `cp -r output/* #{dir}`
  target_branch = 'gh-pages'
  `git checkout #{target_branch}`
  `cp -r #{dir}/* .`
  `git add .`
  `git commit -m "high level bits automatic deploy"`
  `git push git@github.com:highlevelbits/blog.git #{target_branch}`
  `git checkout master`
}
