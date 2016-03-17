---
title: "Could not load OpenSSL"
kind: article
created_at: 2016-03-17
author: fredrik
tags: ruby, openssl, arch
---

Today suddenly I got a nasty error when trying to `bundle install` in a ruby repository I am working on:

    > bundle install   
    Error loading RubyGems plugin "/home/ruben/.rbenv/rbenv.d/exec/gem-rehash/rubygems_plugin.rb": /home/ruben/.rbenv/versions/2.0.0-p647/lib/ruby/2.0.0/x86_64-linux/openssl.so: undefined symbol: SSLv2_method - /home/ruben/.rbenv/versions/2.0.0-p647/lib/ruby/2.0.0/x86_64-linux/openssl.so (LoadError)
    
    Could not load OpenSSL.
    You must recompile Ruby with OpenSSL support or change the sources in your Gemfile from 'https' to 'http'.
    Instructions for compiling with OpenSSL using RVM are available at http://rvm.io/packages/openssl.
    >

As you can see this was with a pretty recent ruby 2.0 running on rbenv. I made a quick check and confirmed that I had the same
problem with ruby 2.2 so it likely had to do with the openssl library. Googling - however - was not of much help. Mostly older
issues talking about recompiling openssl with SSLv2. So after trying a few things I decided to downgrade openssl and it worked 
right away. The misbehaving version is `1.0.2.g` while `1.0.2.f` works as it should. (Or the ruby tooling is using something
in the latter that is shouldn't.....)

My conclusion is that SSLv2 is not included in the last package of openssl on arch linux. This is probably a good thing
as SSLv2 is regarded as broken. But since it breaks ruby it would be nice to have an intermediate solution while ruby
is being fixed. I sense this may take a while.....

