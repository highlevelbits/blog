---
title: what is tdd?
kind: article
created_at: 2013-04-14 12:12:12
author: fredrik
tags: tdd
---

I am doing a bit of coaching on Test Driven Development (TDD) this month and had to start
think about the topic a bit and thus this post. I have been doing TDD since the ages of
eXtreme Programming in the late 90's. It now is so natural to me so I never feel done
without having proper code coverage. Yet at times there are circumstances where I decide
not to do it and that has almost always to do with large code bases without existing test
infrastructure. The cost to get started can be so high sometimes. This piece will include
a definition of TDD and a collection of things to keep in mind when practicing it. In a
future post I will step you through a code example using the technique.

Many may think of TDD as something related to testing and quality - boooooring stuff. In
fact it turns out that it is truly a software development method. When applied consistently
it helps with many of the typical problems software projects encounter. I will end this post
with discussing the benefits of TDD.

The classic way to describe TDD is with the red-green-refactor mantra and I think it is
really good to have this _easy to understand_ description of the concept. Red -
write at test that fails, green - unfail the test, refactor - adapt the resulting code
with its surroundings. Lets examine these parts one by one.

### Red

In the red phase - __write a test__ that fails. This is the specification of what you are about
to do next. It defines the scope of the task. You may want to understand it as your _definition
of done_.

This test should test only one thing in order to keep changes small. If the test is small - it is
likely that the code fulfilling the test also will be small and you'll end up with a nice change
set to put in your repository.

It may help thinking about specifications rather than tests. What you really do when writing
the test upfront is designing the interface of the unit under test. It is the first usage of
the upcoming code and as such is a great way to understand what is really needed from the code.

[<img style="float:right" src="http://farm1.staticflickr.com/64/159577406_f681497ca1.jpg" />](http://www.flickr.com/photos/martinlabar/159577406)

### Green

In the green phase - __unfail the test__ - write the code that makes the test pass. May it be with
shortcuts, magic numbers and whatnots. It should make the test pass - nothing more, nothing less.
Most of the thinking has already been done in the red phase so this may turn out to be rather easy.
Actually - if it turns out to be hard it may well be that the test written is a bit too large.

### Refactor

In the refactor phase - __rewrite the code__ written in the green phase. I like to think of this
as adapting the new code into the surrounding code base. Another way to put it is: remove duplication.
The most important thing to keep in mind during this phase is to NOT ADD ANY FUNCTIONALITY. The code
should behave exactly the same but now be written in a way that is readable and maintainable. How exactly
this is may differ between languages, organisations and teams. To make sure that the code really conforms
to the standards set you could choose between _pair programming_ and _code review_. It may also be
helpful to have som static code analyzers in place to detect common mistakes.

### Understand

When thinking about processes and methods I sometimes fall back to this kentbeckism:

> Listening, Testing, Coding, Refactoring.
> That's all there is to software.
> Anyone who tells you different is selling something.

As you can see red-green-refactor maps nicely to testing-coding-refactoring and then we have the added
_listening_. What this means - of course - is to make sure that you build the right stuff. You have
to listen to the user of the system, you have to listen to (understand) the domain you work in. Only
then can you make sure that the spec you will be writing in the red phase is the right spec. If the
spec is not what is needed the whole cycle will be waste.

With that said the basics has been covered. Lets take a look at some issues and possibilities.

### Coding guidelines?

Way back I often regarded test code as something that could be treated without care - a possibility to
do some cowboy hacking. This is a dangerous stand. Nowadays I think that the test code may be the most
important code to keep in shape. If well written it will serve as documentation for the system. In any
living system it is also the place where any new developer starts off when making changes. It should
be easy to add and alter tests. Generally it is wise to have the same coding guidelines for test code
as for the system as a whole. The only thing that may differ is the degree of DRY (don't repeat yourself).
Readable test code may sometime benefit from duplication. Setup code that calls generic methods makes
the test hard to follow - better to hardwire setup data that is relevant for the test and hide any setup
that is just boiler plate. Readability is more important than DRY-ness when it comes to test code.

### Test to code mapping

A common practice is to have one test class per class and often you also see one test method per method.
This may or may not be a good idea. The class-to-class mapping is good most of the time since it is
really easy to find relevant tests. If test files are growing out of control it is probably an indication
that the unit under test is in need of refactoring. The same goes for methods. A test method should test
one thing and if the method under test can be tested with only one test method this is good. But in many
cases this makes for bad test design so it really depends. Which leads us to....

### Test design

While a good design may emerge from TDD it may be easy to forget the design of the test code itself.
The common principles of designing software should be applied equally to this code but with readability
as the most important aspect.

### Coverage

Ideally - every code line is covered when running all tests. This is almost never the case. Some languages
makes it hard to get full coverage (think about javas checked exceptions that never occur). Legacy code
bases may have areas where intermingling dependencies makes it impossible to add any unit tests at all.
Black box acceptance like tests are likely the best approach to these cases. That said, it is never a bad
thing to strive for 100% code coverage. One way to make this possible is to stay small. If a method under
test does one thing it may be tested with one scenario but if it does several different things the number of
needed scenarios will multiply and increase the test code size exponentially.

[<img style="float:left" src="http://farm1.staticflickr.com/204/447845750_87dd3c1a48.jpg"/>](http://www.flickr.com/photos/mike9alive/447845750)

### No coverage
Sadly enough - there are code bases with next to no code coverage. This may make it hard to get started.
In these cases it is often best to do some integration tests on the whole first before starting to mess
around. Then - if possible - add unit tests whenever new code is written. Some parts may be next to
impossible to unit test without a non-estimable refactoring. Depending on your budget you'll have to decide
whether to attempt a refactoring or not. When using static languages it may often be safe to do refactorings
like _extract something_ and _inline something_. It may be enough to get some part of the code into
testable shape.

Also note that the refactor phase may result in small TDD loops on other parts of the system
in order to do a refactoring safely. This is because you may want to integrate your changes into some part
of the system that currently lack tests. In these cases it may be better to finish the task at hand in a decent
shape before moving on to tackle the needed refactoring in a new red-green-refactor cycle.

### What about user interfaces?

Yes! Test them also. That a user interface looks good can never be tested automatically. At least not until
we get sentient AIs that can understand the feelings of humans... But the code inside the user interface
can be tested. Any code that is complex can be extracted into testable units. The actual composition of a
user interface may not be possible to test (depending on the technique used) but the code needed to compose
it sure may. This will also lead to a good separation of concerns in the UI code base. That the whole thing
sits together nicely is best tested with integration/acceptance tests. Most common user interface technologies
have some kind of framework for this and if you lack this there are user interface robots for the common
platforms that knows how to enter characters in fields and click buttons. For the web there are several good
options that also tests dynamic content on a web page. I have good experiences with
[capybara](https://github.com/jnicklas/capybara) using the webkit driver. In Java land there is
[selenium](http://docs.seleniumhq.org/projects/webdriver/) that makes it easy to write javascript-aware tests.
For static sites it is even easier.

### What language to write tests in?

Most of the time it makes sense to write tests in the same language as the units under test. As a developer you
don't need to switch in another syntax cartridge. But for some languages (Java comes to mind) the amount of
code needed to write anything may make it worthwhile looking at a dynamic languages for tests. Groovy is probably
most handy for testing Java although any dynamic languages that runs on the JVM will do fine.

### Continuous integration

I have written extensively about [this elsewhere](http://highlevelbits.com/2010/11/continuous-integration-essentials.html)
so at the moment I will just take it down to: TDD without continuous integration is wasteful.

### So what are the benefits of working this way?

There are benefits at several levels. On the personal level TDD gives a sense of accomplishment and a secureness that the
code delivered actually works and adds value to the whole. But this may differ from person to person. The more obvious benefits
are on the organizational level:

* stability - the code base will be stable over time. New features won't break old ones.
* predictability - it will be easier to predict the outcome of a project since the code base will be in a known state. Estimates
may actually turn out to be correct!
* readability - the code produced will be readable which in turn will make the system maintainable.

So the benefits are huge - there are no known disadvantages. If you are not doing TDD today I hope this article sparked
some inspiration. If you feel you need guidance to get going I or one of many other TDD coaches will be happy to help you out.

While researching images for my TDD presentation I stumbled upon this guy. Kind of not related but awesome nevertheless.

[<img src="http://farm3.staticflickr.com/2201/2043747282_eaa5239696_b.jpg" />](http://www.flickr.com/photos/photochiel/2043747282)

Photo credits to flickr users [martinlabar](http://www.flickr.com/photos/martinlabar),
[mike9alive](http://www.flickr.com/photos/mike9alive) and [photochiel](http://www.flickr.com/photos/photochiel).