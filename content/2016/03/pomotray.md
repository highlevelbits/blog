---
title: "A pomodoro clock for the systray"
kind: article
created_at: 2016-03-20
author: fredrik
tags: ruby, qt, pomodoro, productivity
---

![](https://raw.githubusercontent.com/froderik/pomotray/master/tomato.png)

I have been using [pomodoro](http://pomodorotechnique.com/) to and from for several years and it works really good for me.
I haven't found a simple tool for linux though (apart from the one [outlined here](https://productivity.stackexchange.com/questions/717/which-computer-based-pomodoro-timers-exist-and-what-are-their-features/1672#1672).)
I'll be perfectly happy with a system tray tomato that can tell me when the time is up. So this weekend I went ahead and built 
one. I have done some fiddling with Qt before and decided to try it again. Since I know Ruby well I decided to use the
[ruby bindings](https://github.com/ryanmelt/qtbindings/) for Qt. Qt comes with a 
[class for creating systray icons](https://doc.qt.io/qt-4.8/qsystemtrayicon.html) that is really easy to use.

The code and instructions about how to use it is [available at github](https://github.com/froderik/pomotray).

My next challenge is to create an arch linux package out of this. I haven't done it before but I suspect that it will
not be that hard. The only thing I am curious about is the need to build ruby with the `--enable-shared` flag. How will
this work with precompiled things? It would be nice to depend on archs standard ruby package.

![](https://raw.githubusercontent.com/froderik/pomotray/master/tomato.png)
