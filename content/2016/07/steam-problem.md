---
title: "Library problem with steam on arch linux (i965_dri.so)"
kind: article
created_at: 2016-07-07
author: fredrik
tags: steam, arch
---

Using a rolling distribution like Arch is good in many ways but when things you really 
need start to break it is not so fun. I have had some problems with steam - a thing
I really need in order to play games! (Yes - priorities are rightly ordered!) Apparently
steam comes with a couple of libraries that sooner or later will become older than the once
installed in the OS. My error looks like this:

```
Running Steam on arch rolling 64-bit
STEAM_RUNTIME is enabled automatically
Installing breakpad exception handler for appid(steam)/version(1467926999)
libGL error: unable to load driver: i965_dri.so
libGL error: driver pointer missing
libGL error: failed to load driver: i965
libGL error: unable to load driver: swrast_dri.so
libGL error: failed to load driver: swrast
```

After googling for quite a while and trying a couple of things I stumbled upon 
[this problem solver](http://wyldeplayground.net/steam-unable-to-load-driver-i965_dri-so-intel-graphics/).
It made sense to me directly. The post is essentially one line:

    LD_PRELOAD='/usr/lib32/libstdc++.so.6 /usr/lib32/libgcc_s.so.1 /usr/lib32/libxcb.so.1 /usr/lib32/libgpg-error.so' steam

LD_PRELOAD is a way to load some objects before others. In this case we tell steam to use these 4 libraries 
instead of its own. Problem solved and I can move on to more important things currently as the King of Finland
in the [Crusader Kings](http://www.crusaderkings.com/) year 987. I am about to turn this tribe into a merchant republic!

