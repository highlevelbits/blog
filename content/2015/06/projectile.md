---
title: "Finding files in emacs and some bits about package mgmt"
kind: article
created_at: 2015-06-01
author: fredrik
tags: emacs, projectile, productivity, melpa, editor
---

Some more findings from my emacs journey. `C-x C-f` is not so fun when looking for files in any normal software projects. 
Proprietary IDEs and editors have nice support for quickly finding a file anywhere and of course it is there in 
emacs also. In IntelliJ I can go `C-N` to find files easily and in Sublime there is `C-P`. (Note that `C` in emacs
lingo is the same as `Ctrl` in many other lingos....) 

It seems that there are several ways to do this in emacs. I found a package called 
[projectile](https://github.com/bbatsov/projectile) that adds project
oriented features like this one. To add packages in emacs there is - since emacs 24 - `package.el` that can be
used to get packages from central repositories like [MELPA](http://melpa.org) 
(Milkypostman’s Emacs Lisp Package Archive). I put in some lines in my `.emacs` file for this:

    ;; MELPA
    (require 'package)
    (add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
    (package-initialize)

and this gives me access to remote packages via the `list-packages` command.

Now I have the nice `projectile-find-file` command available. To make it easily accesible I bind it to `M-p` with:

    (global-set-key (kbd "M-p") 'projectile-find-file)
    
also in `.emacs`.

There are loads of more stuff in projectile but you gotta start somewhere.

Also when investigating this I stumbled upon [helm](http://tuhdo.github.io/helm-intro.html) that supposedly is
an *incremental completion and selection narrowing framework*. The oceans of nice things in the emacs 
stratosphere....

UPDATE: also useful is to install `flx-ido` that gives you better fuzzy matching of file names. Available with MELPA. 
Next mission - automate package installs.
