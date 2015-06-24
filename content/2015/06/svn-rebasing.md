---
title: "Rebasing with Subversion"
kind: article
created_at: 2015-06-24
author: fredrik
tags: svn, version control
---

In git the rebase command is pretty useful when you want to get your own changes on top of whatever happened on `master` 
(or `trunk` as it is called in subversion land). But how do you do this in subversion? And safely? 
The closest I came to something similar is working on a *feature rebase* branch. So given trunk and a feature branch 
I'd do something like this:

    svn cp trunk feature-branch-rebase
    
    cd feature-branch-rebase
    svn merge feature-branch 
    # resolve all the conflicts, build the thing, run the tests and so on
    svn commit
    # let it run on the build server.... 
    
    cd trunk
    svn merge feature-branch-rebase
    svn commit
    
This last merge should then be trivial and not cause any headaches on trunk....
