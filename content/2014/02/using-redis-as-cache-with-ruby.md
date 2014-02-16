---
title: "Using redis as a cache with Ruby"
kind: article
created_at: 2014-02-16 07:00:00
author: fredrik
tags: redis, ruby, cache
---

For one sinatra based web site I am messing with I needed a cache for calls to third party APIs. I had used [redis](http://redis.io/) before together with [resque](http://resquework.org/) at a client gig so it was a natural choice for this task. Essentially I needed to use URLs as keys and the returned content for that URL as the value.


Installing redis is easy on arch: 

    pacman -S redis 

It hooks in nicely with `systemctl` so you can 

    systemctl start redis
    systemctl enable redis 

to have it up and running after reboots.

For integrating with Ruby there is a nice gem called `redis`. Install it with:

    gem install redis

or put it in your Gemfile for use with bundler.

Now we are ready to start using `redis`. My use case is the simplest possible with strings for both keys and values. To start interacting with redis you need a client instance:

    redis = Redis.new host: '127.0.0.1'

This creates a client with all the defaults trying to connect with redis on the default port `6379`. On my server I have a restrictive firewall running so I had to specify talking to an IP address rather than the default `localhost`. It is also possible to start redis listening to a socket instead of a port. This may be a bit faster.

Now we can put some stuff into the database:

    redis.set 'some_random_key', 'value'
    redis.expire 'some_random_key', 60 * 60 * 24

If I want to save the value forever only the first line is needed. But since this is a cache I had to add the second line to get a 24 hour expiry time on the item.

Now the key will be available for 24 hours and the be removed. To retrieve the value is just as easy:

    redis.get 'some_random_key'

I coded this up on the commute to work one day and installed it on the server the next. Really easy and useful. I certainly will consider redis as a database candidate for real work in the future. Using it as a cache is nice but it seems capable of being you main persistance store if you are into NoSQL stuff.

Also - it is really fast.
