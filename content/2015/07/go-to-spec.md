---
title: "Go to test in emacs"
kind: article
created_at: 2015-07-04
author: fredrik
tags: emacs, testing, editor
---

So my emacs journey continues slowly but steadily. At the moment my customer is mostly about Java and I haven't
dared trying that in emacs yet. I am pretty sure it will be great once I get there though. My next gig will be more
Ruby so then emacs will be my main daily tool. Great!

A month ago I [told you about projectile](/2015/06/projectile.html) and how I use it to find files in my project.
In IDEA there is the nice `Ctrl-Shift-T` that takes you to test classes and I wanted to find something similar in
emacs. I [turned to](https://emacs.stackexchange.com/questions/13548/find-corresponding-test-file the nice 
emacs stackexchange community and they had an answer soon enough. And - as you may already have guessed - projectile 
has support for this out of box. `C-c p t` navigates between source and test nicely. I think I will bind this to 
something shorter further on but it is good to start with the defaults.

Also I decided to turn on projectile globally and thus put `(projectile-global-mode)` into my `.emacs` file.

