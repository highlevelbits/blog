---
title: "No desktop nemo"
kind: article
created_at: 2015-11-08
author: fredrik
tags: arch, linux, nemo
---

I use the nemo file manager when I need to browse directories and double click and stuff like that. Maybe most
importantly - it knows how to find my camera over USB. This is the default file manager for the nice cinnamon 
desktop (default in Linux Mint). Now I am running Arch with Openbox so I don't have a desktop. Nemo defaults
to doing stuff to my desktop when it starts which is likely bevause it wants to put icons and stuff on it. 
I don't like it. There seem to be several ways to configure away this behavior. On my old box it works due to 
some configuration that I don't remember. Now on my new box I encountered the same behavior again and went for 
an alias: `alias nemo='nemo --no-desktop'` to solve it. Neat!

Now I am off to upload some photos......
