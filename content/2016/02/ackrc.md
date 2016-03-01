---
title: "Configuring ack to ignore certain directories"
kind: article
created_at: 2016-02-27
author: fredrik
tags: ack, bash, grep
---

`grep` is a wonderful command line tool that can be used for many things. While many developers rely on their IDE for search 
capabilities I have increasingly come to value the command line for finding stuff in source files. This tooling works regardless
of what language you are currently using so it will probably be useful for the rest of my career. 

When `git` appeared I started using `git grep`. It is really handy since it only find files that are added to version control. 
This is also a disadvantage at times.

Then some years ago I worked with a guy that introduced a series of grep tools to me. The final one was `ack` and I have stucked 
with it since then. It got good defaults for what you may want to ignore and also gives a nice colorized output. I haven't 
really tried to tweak it until the other day when I got disturbed by the appearance of content in the `coverage` folder of 
a ruby side project I am working on. It is easy to add the `--ignore-directory` flag on the command line but not so convenient 
the second time around. In comes the `.ackrc` file where you can put custom settings. You can have one in your home 
folder but also in any folder you are working with. So I added one to my working directory with the content:

    # ignore the coverage directory
    --ignore-directory=coverage

Nice! I will explore this tool more future on. It seems to have some really good things for log file analysis also.
