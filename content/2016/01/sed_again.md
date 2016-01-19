---
title: "Sed to the rescue again"
kind: article
created_at: 2016-01-19
author: fredrik
tags: sed, bash
---

Just a `sed` reminder to my future self. I needed to rename a method in some ruby code. Really simple with sed if you 
don't have any name clashes:

    sed -i 's/old_method/new_method/g' **/*.rb

and done. It bothers me that I had to look it up....
