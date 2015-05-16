---
title: "Tests running on commit"
kind: article
created_at: 2015-05-16
author: fredrik
tags: quality, testing, git
---

If you are like me you like to have fast running tests and you don't want failing tests in your repository.
Normally you ensure this with developer discipline and a CI server running stuff when repos get pushed
to the remote git server. 

The other day I played with the thought of actually stopping a commit if the specs isn't running. 
You need to have blindlingly fast tests for this to be practical. Tests hitting the database or being
involved in I/O in general are out of the question here. With git you can put hooks on almost everything.
One place is the `pre-commit` hook and it is suitable for this purpose. All the hooks are located in the 
`.git/hooks` folder of the repository. In a new repo there is a bunhc of samples here to give inspiration 
about what is possible to do. The principle is easy. Any hook that returns a non-zero result will 
interrupt the execution of the git command currently running. So for this purpose I just needed to add 
one line of code to the new `pre-commit` file.

    exec rspec spec

This command returns non-zero when a test is failing so it will stop the commit from proceeding if there
are failing tests.

Suppose you are running java and maven (like me at my current assignment)? Then you are out of luck. Just
waiting for maven to get started is the kind of times we don't have patience with when comitting code. 
Then we are lucky to have our build server doing it for us.
