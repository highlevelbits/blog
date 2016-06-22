---
title: "Synchronize tmux panes"
kind: article
created_at: 2016-06-22
author: fredrik
tags: tmux
---

So we have clustered servers which is a pain when you want to look at some log files. [tmux](https://tmux.github.io/) and 
[stackoverflow](https://stackoverflow.com/questions/16325449/how-to-send-a-command-to-all-panes-in-tmux) 
to the rescue. I set up [tmuxinator](https://github.com/tmuxinator/tmuxinator/) to open up panes on all the 
servers and then once inside tmux I go:

    C-B :
    setw synchronize-panes yes

...and then I can tail and search all the logs at the same time. (This obviously only works when servers are set up
in the same way...).

