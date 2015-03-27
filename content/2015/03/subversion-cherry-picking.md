---
title: "Cherry Picking with Subversion"
kind: article
created_at: 2015-03-27
author: fredrik
tags: svn, version control, cherry pick
---

So I am back in subversion after two years with git only development. I feel insecure.... 
Merge is not working so well as in git. Today I needed to merge changes from a single commit on a release branch
to our main branch. Cherry picking..... Turned out it was possible with subversion:

    svn merge -c <revision> <source_branch>

The -c merges only the commit and nothing else. Useful!
