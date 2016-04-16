---
title: "New openssl version breaks ruby"
kind: article
created_at: 2016-04-16
author: fredrik
tags: ruby, openssl, rbenv, arch
---

One of the finest things of arch linux is the package manager and the speed of updates whenever 
there is a new version of an important library. However sometime is can be a pain when some other 
things are moving a bit slower. 

Like now when the latest `openssl` version makes the ruby bundler go:

> You must recompile Ruby with OpenSSL support or change the sources in your Gemfile 
> from 'https' to 'http'. Instructions for compiling with OpenSSL using RVM are available
> at http://rvm.io/packages/openssl.

Although I don't use `rvm`. I use `rbenv` now - a more lightweight alternative.

Anyway - the **easy way out** that I used first was to just downgrade openssl to the version that worked.
First find it in `/var/cache/pacman/pkg`. 1.0.2.f is the last one to work with bundler and then downgrade:

    sudo pacman -U /var/cache/pacman/pkg/openssl-1.0.2.f-1-x86_64.pkg.tar.xz

Then in the future I'll have to ignore this package when updating all the others:

    sudo pacman -Syu --ignore openssl

So far for the **easiest way out**. The **harder way** must surely be to install ruby built with these libraries.
For me - an older ruby like `2.1.5` did not like to be reinstalled at all. There probably is a need for flags here.
Instead I tried to install `2.2.4` and it worked fine. So until I have a client that insists on an old version 
(like the one I did my last day for yesterday) I will be happy with this solution.
