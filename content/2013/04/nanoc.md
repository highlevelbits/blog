---
title: moving from drupal to nanoc
kind: article
created_at: 2013-04-13
author: fredrik
tags: nanoc, drupal, ruby
---

Time to move on to the bright (old) new world of static sites. We were not
entirely satisfied with drupal. Not knowing (or wanting to know) the platform
well enough made us unable to produce the awesome site we want high level bits to be.
In comes [nanoc](http://nanoc.ws/) - what you read here is generated by nanoc.

The source is now [all available at github](https://github.com/highlevelbits/blog) so if you want to
contribute a post just clone and pull request away.

We started by exporting our data from Drupal with [this little Ruby script](https://github.com/highlevelbits/blog/blob/master/import.rb)
that connects directly with the
drupal database and creates posts and appends old comments to the post. It also updates the
head section with title, timestamp and author. We decided to skip exporting of tags and do a retagging of all
the articles. Well worth the effort.

The natural choice for hosting is [github pages](http://pages.github.com/). It turned out to be rather easy to setup with nanoc.
There was no documentation for how to do it with nanoc so I added a
[section to the deploy guide](https://github.com/froderik/nanoc-site/blob/master/content/docs/guides/deploying-nanoc-sites.md#with-github-pages).
(Yet to make it into the main docs.) The instructions in the github docs are straightforward. A little script
automates the deploy procedure:

    #! /usr/bin/env bash

    nanoc prune compile --yes
    cd output
    git pull origin gh-pages
    git add .
    git commit -am "high level bits automatic deploy"
    git push origin gh-pages
    cd ..

To choose nanoc more or less just happened. I asked a bit on twitter and got nanoc is nice back and started
to play with it. It is nice and so here we are. Hardy had good experiences with awestruct but since he had
less time at the moment I just moved forward with nanoc to try it out.

All articles have been retagged so hopefully tags make more sense now. We don't have a tags page anymore. Instead
posts with similar tags are shown at the bottom of the page.

The [archive page](/archive.html) was fun to build. I decided to try to do foldable sections without using javascript using the checkbox
trick. Check the code to find out how it works.