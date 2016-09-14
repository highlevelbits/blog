---
title: "How to extract part of a line with sed"
kind: article
created_at: 2016-09-14
author: fredrik
tags: bash, sed, grep
---

Say you have a file with lots of data but you really just want to find a couple of lines that matches something and then 
you want to extract another part of that line to a list. `grep` and `sed` can help you. So for example to match on
`the new paris` and extract the number 19 from `manif_id="19"` on the same line you could do:

    grep 'the new paris' china_books.xml | sed -n 's/.*manif_if=\"\([0-9]*\).*/\1/p'

The parentheses - `\([0-9]\)` - in the regexp part of the sed command captures what is inside and makes it available to the `\1`
parameter in the second part. Note that parentheses needs to be escaped!

Also about to finish a great book. 
[The last day of new paris](https://www.goodreads.com/book/show/26042254-the-last-days-of-new-paris) by China Mieville.
All about paris and surrealist manifestations. Recommended!
