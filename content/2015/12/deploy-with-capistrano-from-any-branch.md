---
title: "Capistrano deploy from any branch"
kind: article
created_at: 2015-12-04
author: fredrik
tags: git, capistrano, ruby, devops
---

When using [capistrano](http://capistranorb.com/) for rails deployment you typically end up with a configuration file per 
environement in the `config/deploy` folder. In this file you state what branch you want to deploy from:

    set :branch, 'staging'

This may be a good thing if you always want to deploy from a certain branch to a certain environment. At my current gig
we always deploy to production from a `production` branch. Another common approach is to keep `master` in sync with
the production environment. However for test environemnts it may be convenient to be able to deploy from any branch.
Luckily config files in Ruby are often written in Ruby (not in XML or something similar unprogammable). So making this
little thing happen is as easy as:

    set :branch, `git symbolic-ref -q HEAD`.split('/').last.strip

and the current branch will be used when running the deploy. One may think that `git branch` should have an option for
just getting the current branch and nothing else but no luck there..... The `symbolic-ref` command give us the full name
of the branch. E.g. `refs/heads/development` so we need to the stripping part ourselves.

The way capistrano is normally setup it is possible to deploy the production branch from another branch. This makes it
impossible to keep track of what deploy configuration that actually was used for a certain deploy. Dangerous stuff indeed.
