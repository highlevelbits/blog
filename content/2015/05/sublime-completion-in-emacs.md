---
title: "Sublime completions in Emacs"
kind: article
created_at: 2015-05-24
author: fredrik
tags: sublime, emacs, coding, editor
---

I am on a serious quest to replace all my proprietary editors with emacs. So to start with I am using it instead of 
Sublime when coding Ruby. I also have started some preliminary investigations into using it for java development also.
More on that in later posts I hope.

One thing I like in Sublime is how you easily get completions from you current file. 
[Turns out](http://emacs.stackexchange.com/questions/12646/equivalent-of-sublimes-text-expansion) there is a
built in thing in emacs called `dabbrev` that does the same thing. It expands on `M-/` by default. `/` is not
the nicest character on a swedish keyboard so I bound `M-RET` (or Alt-Enter as it is called in IntelliJ) to
dabbrev by putting this line into my `.emacs` file.

    (global-set-key (kbd "M-RET") 'dabbrev-expand)
    
In general I find that it may be hard to find emacs documentation for what you are looking for. On the other
hand there is [emacs.stackexchange.com](http://emacs.stackexchange.com) so anything is solvable with 
the help of community.
