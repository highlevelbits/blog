---
title: "Hero Driven Development - and what you can do about it"
kind: article
created_at: 2014-08-20
author: fredrik
tags: pattern, software development, agile, dragons, firefighting, management
---

It happens rather often that I found myself in a negative organizational pattern that I will call *hero driven development* in this post. It has several other names: I often call it *firefighting* and I have also seen *dragon slayer* and *cowboy shooting from the hip*. I am sure there are other names. Add yours in the comments!

![](https://farm1.staticflickr.com/117/384464432_e373fb5f2d_o.jpg)

Main characteristics of this pattern:

- a significant hoarded technical debt.
- a select few able to deal with that debt.
- *business as usual* is not normally premiered.
- the technical debt causes regular crises. A system goes down, some important functionality is broken or something like this.
- a hero puts his *ordinary* work aside for a while and gloriously solves the crises, slays the dragon and puts out the fire.
- everyone is happy until the next crises.
- a deficit in reflective exercises ensures that it happens again soon.

So what can we do about it? It is hard to change an organization that has settled on this pattern. The satisfaction of saving the organization whenever there is a crises is impossible to match with *business as usual*. It is also important to recognize that this kind of culture rarely is explicit. When asked, no one likes the cycle of crises and salvation. It is stuck on a subconscious level. Here are a number of things to focus on if you find yourself inside this pattern.

###Team solves crises
The main problem with hero driven development is that single individuals step in and solve crises when needed. They may even often come from outside the team that normally should be responsible for solving the crises. Decide that the responsibility for solving any crises is the entire team. Make these tasks visible in/on whatever tool you are using for task management. (Preferably a physical board.....)

###Pairing
This is a good strategy for the long term. If all work happens in pairs the knowledge needed for solving a crises will slowly spread throughout the team. It is also a good tactic for the short term. Decide that no hero solves a crises on his/her own but has to work with someone else so solve it. 

###Insist on retrospectives
When a pattern like this settles itself solidly it often proves hard to change it. Whenever a crises has been solved, everyone just moves forward, without reflecting on changes to avoid a similar crises in the future. To make the hero pattern visible, retrospectives can be a good tool. Focus on what to improve rather than the failure that caused the crises. Pick one or two things to improve in whatever time frame you are working in. Two weeks may be a good interval. Also, keep retrospectives short. An hour is enough if they are done regularly.

###Acknowledge hero skills
It is important to acknowledge that the heroes excellent skills is not a problem, it is an asset. Find a way to make sure that this skill set comes to good use when working to avoid future crises. Heroes may feel threatened by the disappearance of his/her natural arena. Try to create another arena for the hero to excel in his/her brilliancy.

### Workplace locations
Behavioral patterns like hero driven development can be inhibited by a conscious placement of workplaces. Put people that can benefit from each other together. Don't keep the same placement for long periods of time. Changes means that new constellations of people can start interact naturally. Where to put the hero? It probably depends a bit on how you want to solve crises further on. If the hero will be involved than he/she should be located in the midst of things. If not, located out of reach.

Also, never put several heroes together - spread them out as far away from each other as possible.

### Make the technical debt visible and start reducing it
The need for a hero is often caused by an unmanaged technical debt. Try to make this debt as visible as possible in the form of tasks that can be done. They should be as small as possible. This may be really hard but given some thought it is often possible to break the work into smaller bits. When a crises happens, try to think of what parts of the technical debt that caused it and try to prioritize those tasks.

If nothing else, a start can be to put automated tests on vital parts of the system. It is good for many things:
- it gives you feedback about how the system is feeling
- it makes it possible to refactor
- it increases the understanding, good tests can double as documentation

###Measure absence of crises
Finally - it is crises we want to avoid. Introduce metrics. It can be uptime, availability, number of crises a week, magnitude of a crises and so forth. Visibility of progress is very important. This is especially true in an organization that normally don't acknowledge *business as usual*.

<small>
Mighty [dragon photo](https://www.flickr.com/photos/mugley/384464432) by [Jes](https://www.flickr.com/photos/mugley/).
</small>