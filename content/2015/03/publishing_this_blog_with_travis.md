---
title: "Publishing this blog with travis"
kind: article
created_at: 2015-03-08
author: fredrik
tags: continuous integration, nanoc, ruby, travis
---

![](http://blog.travis-ci.com/images/travis-mascot-200px.png)

So finally I got around setting up [travis](https://travis-ci.org/) to automatically post this blog upon pushes to master.
It was pretty straight forward. Travis picks up a file called `.travis.yml` where the build configuration is placed. 
It ended up looking like this:

    language: ruby

    install: bundle install
    script:  "./publish_from_travis.sh"

    # this is the encrypted api key from github setting 
    # the GH_AUTH env variable used in the install script
    env:
      global:
        secure: hrfBYK9YXs0rJJvr3zbIFFt7E11KdbtTzbSYgvULEhVgRwXscKRj.....

    # build only master - don't want to publish wip
    branches:
      only:
        - master

First the language of the build is stated. 

    language: ruby

Travis comes with two steps: `install` and `script` where the latter means 
*test tour stuff*. 

    install: bundle install
    script:  "./publish_from_travis.sh"

The normal build process is more about automated testing than automated publishing. 
Here I use the install stuff for the reasonable thing to do - installing them gems. Than in the script phase a
bash script is called. This is circa the same script as we have been using to publish from our local machines
but with some small changes about how the gh-pages branch is cloned and updated. Firstly https is used. Since this
is a public repo cloning is trivial. For pushing there needs to be some credentials though. Here is the publish script:

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
    git push --force --quiet "https://${GH_AUTH}@github.com/highlevelbits/blog.git" gh-pages> /dev/null 2>&1

Note the environment variable use in the push command. This is a reference to an encrypted variable stored in the 
end->global->secure key:

    # this is the encrypted api key from github setting 
    # the GH_AUTH env variable used in the install script
    env:
      global:
        secure: hrfBYK9YXs0rJJvr3zbIFFt7E11KdbtTzbSYgvULEhVgRwXscKRj....

This field is generated with the travis command line tool. Install it with:

    > gem install travis
    
and use it like so

    > echo GH_AUTH=<github api key> | travis encrypt --add
    
the -add flag adds it automatically to the `.travis.yml` in the current directory. Handy! 
Now it is encrypted so that only travis can decrypt.

Finally we tell travis to only build `master` so we can keep branches for work in progress without publishing them.

    # build only master - don't want to publish wip
    branches:
      only:
        - master

All the files used for publishing the blog are available for review in 
[the repository](https://github.com/highlevelbits/blog).

I had some excellent help from Gergely Nemeths post 
[about this](https://medium.com/@nthgergo/publishing-gh-pages-with-travis-ci-53a8270e87db) 
(just translated the node stuff into ruby)
and also from the excellent [travis docs](http://docs.travis-ci.com/).

So what will this give us? Hopefully more shorter posts since it now will be possible to publish directly
with a push inside github.
