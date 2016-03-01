---
title: "Sorting CSV on the command line"
kind: article
created_at: 2016-03-01
author: fredrik
tags: bash, sort, csv
---

If you know your spreadsheet tool you probably think this post is rather useless. I like doing things on the command
line and so I felt it important to find out how a CSV file can be sorted thereon.(In my case I got a CSV file containing
a memory report of a redis instance.)

So - as expected - `sort` can help us with this. With no arguments it just sorts its input alphabetically. But it can also
work on *-separated files. With the `--field-separator` flag you can tell sort what to separate on. I suspect <tab> is 
the default here as I [found out last year](http://highlevelbits.com/2015/08/bash.html) for the `read` command. Also you often want to do 
a numeric sort and for the you can use the `-n` flag. Finally you may want to sort on a column in the middle of things.
The `--key` flag helps with that. It actually accepts a range so passing in a 3 sorts on everything from the third column to 
the end of line. To limit it to a single column `3,3` is needed. Also note that columns start on `1` which probably is 
good for nondeveloper users but left me puzzled for a while. An example call:

    sort --field-separator=',' --key=2,2 -n some-file.csv | less

To get larger numbers first - add `-r` for reverse.
