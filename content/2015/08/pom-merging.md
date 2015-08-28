---
title: "Merging those pom files"
kind: article
created_at: 2015-08-28
author: fredrik
tags: maven, git, merge
---

Having release branches with lots of `pom.xml` files is not so fun when it comes to merging. 
A normal merge will detect conflicts in each and everyone of the pom files. (If you insist on 
having the version number in each pom file. This can be avoided by parameterizing the version number
in the parent pom.) Luckily git can help a bit to solve this. The default merge strategy (called `recursive`) 
will mark any conflicts and leave it up to you to resolve them. However if you pass in the `-X` flag you can 
configure the way a recursive merge works. One option is to decide to use ours or theirs changes when 
detecting conflicts. In the pom file example you would likely want to keep ours when merging to master. 
Call it with:

    git merge -X ours release-branch
    
or if you want to be specific

    git merge -s recursive -X ours release-branch
    
or even more specific

    git merge --strategy=recursive --strategy-option=ours release-branch

The problem with this is that if you have conflicts in the actual code you will have to deal with it separately.
In this case it is probably wise to set up a merge branch to do the merging on. First merge the code stuff and then
move on with pom files.

Other cool things I learned when playing with this:

- while `recursive` is default when merging a single head `octopus` is the default strategy when merging several
heads. I have a hard time coming up with a scenario where I would actually want to merge several heads into
one merge commit. But it is a cool feature.
- another strategy option for the `recursive` strategy is `patience` - this will give even better merge results
in some cases and should probably be used when there has been many changes between the merge subjects. Patience
is also an option to the `diff` command.

Another option is of course to not use `maven` at all.... :-)
