---
title: "Back in Javaland"
kind: article
created_at: 2014-03-05 07:00:00
author: fredrik
tags: java
---

So I am currently back coding Java. It is two months into the current assignment and about time to report some findings. The product I work on (yes - a real product that is **released**) is a desktop application written with [Swing](https://en.wikipedia.org/wiki/Swing_%28Java%29) - this GUI framework of Java that seems to be almost abandoned. But it is the choice you have when doing desktop with Java. (I have no idea whethere this is better or worse with other languages. Probably not for cross platform stuff. This [qt](http://qt-project.org/) thing might be a contender though.) It sure is possible to do good stuff with it. In this code base I have mostly been saved from interacting directly with Swing due to several abstractions (of varying quality) built on top of it. Some things have been really nice to use. Adding another menu item is done in no time at all. Sometimes it goes in the way. We tried to remove a tab from an editor window and it wasn't possible to even understand how to do it in a couple of hours. The code base is a bit old but still remarkable stable despite a clear lack of automated tests. (Yes - we are increasing the numbers.) So that is a little background to what I am doing at the moment. A couple of reflections on this:

- Java is the language I know best and it is really easy to just get going with it despite not having coding it for more than a year. Some skills seem to stick.
- inheritance sucks.
- interfaces may be handy if you use them consistently.
- the lack of enforced dependencies between packages in Java makes any code base a big soap.
- abstractions may make you go faster once you understand them.
- testing is hard. We tried to use [Fest](https://code.google.com/p/fest/) underneath the [JVM flavour of Cucumber](https://github.com/cucumber/cucumber-jvm). It looked promising but than we got weird problems with running tests on the build server so we abandoned it for a while in favor of automated tests under the hood instead. 
- the current code base is entangled so we always need to do a fair bit of mocking when setting up a test.
- since most of the code is uncovered by test we try to write unit tests for bigger units then classes so we cover as much as ground as possible with a single test. This has been working really fine. It is important to put the mocks in the right place for an interaction under test. 
- in a statically typed, compiled language even a system that has too few tests can have a some stability.

I will stay in Javaland for another 2 months. It is nicer than I expected. 

I also found out that there is a [german conference](http://www.javaland.eu/en/javaland-2014.html) called Javaland. Not for me but in case you want to go I give you a nice banner.

![](http://www.javaland.eu/typo3temp/pics/8e30c2bb4b.jpg)
