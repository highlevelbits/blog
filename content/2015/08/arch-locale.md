---
title: "Making the locale stick"
kind: article
created_at: 2015-08-18
author: fredrik
tags: arch, linux, locale, keyboard
---

Setting up a new machine with arch linux and again have problems making my swedish locale stick. Since I have made 
several random changes I am not entirely sure anymore but it seems like a couple of things are needed.

To make the system believe it is on a swedish keyboard the file `/etc/vconsole.conf` needs to have `KEYMAP=sv-latin1`.
Note that this is not a locale - rather a keyboard mapping. I tried putting the locale `se-lat6` but it didn't work
(naturally). This can also be set with `localectl set-keymap --no-convert sv-latin1`.

To make X believe that it is on a swedish keyboard the x11-keymap needs to be set. It stays in a file in
`/etc/X11/xorg.conf.d/` called `00-keyboard.conf`. This can be set with the command `localectl set-x11-keymap se`. 

Also for the locale to behave correctly you need to have the `/etc/locale.conf` file set up correctly. I 
investigated this due to some problem with my previous setup and don't exactly remember the why's here. What I have
now is:

    LANG="sv_SE.UTF-8"
    LC_COLLATE="C"
    LC_MESSAGES="C"
    LC_NUMERIC="C"
    LC_TIME="C"
    LC_MONETARY="C"
    LC_NAME="C"
    LC_IDENTIFICATION="C"

If I remember correctly this means that I want swedish locale for input and such but for conversions and
localized messages I will rather stay with the default language. (Otherwise databases and whatnot tries 
to find error messages in swedish and that can be really annoying.)

![](https://farm2.staticflickr.com/1053/1223880092_090cde5430_b.jpg)

[Photo](https://www.flickr.com/photos/mdclxvi/1223880092) by Matus Kacmar
