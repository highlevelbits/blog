---
title: "Bash magic"
kind: article
created_at: 2015-08-05
author: fredrik
tags: bash, command line
---

Recently I found myself with the task of writing a database script to update some stuff in production. 
Since I have no power over the machine in question I decided to do it in bash. While doing it I picked
up a couple of new spells that needed to be documented somehwere. Like here!

![](https://farm5.staticflickr.com/4116/4814208649_a9ce8c8e72_b.jpg)

### Redirection in general

I normally use mostly the fist one to get stuff into a file but got into some problems. It turned out that 
a single `>` overwrites the argument file while `>>` appends to it. Since I was looping over values and 
appending them to a result file the second option worked this time. I also cut and pasted a usage of `<<<` when
sending the result of a command to a `read` command. I am still not entirely sure about what this is.
Lots of information about [redirection](http://wiki.bash-hackers.org/syntax/redirection) can be found
in the [Bash Hackers Wiki](http://wiki.bash-hackers.org) (an overall good resource on bash - 
stackoverflow does not rule everywhere yet).

### Redirecting a file into a while loop using read for iterations

It is possible to send a file into a while loop like this:

    while read X Y Z 
    do
        # do stuff with X, Y and Z
    end < datafile.csv

This will read a 3 column tab separated file one line at a time into the X, Y and Z variables.
The read command default to tab separation. It is possible to set another separator with the 
`IFS` env variable. I had some problem running this on older versions of bash (production....) so
I abandoned it and converted data to tab sepearated files again. With bash 4.3 on Mint the IFS 
way of doig it works fine.

### Splitting data

The `read` command is generally cool. It can split any data into parts. Above it is used to get values from
a tab separated file inside a while loop criteria. I also used it for splitting
the result of a `grep` command:

    read -r X Y <<< `grep ^value, file`
    
Of course - in this case you need to be sure that there will be only one hit from the grep command.

### Tab characters....

...can be hard to work with. When greping on something with a tab character it is useful to use the 
perl style regexp:

    grep -P "stuff\tfluff" file
    
And outputting tab files also needs some special treatment:

    echo -e "stuff\tfluff"

### SQL variables

I learned that it is possible to select into a variable. For example the last insert id could be useful to 
have around for other queries.
    
    BEGIN;
    INSERT INTO stuff VALUES(null, 1, 2, 3);
    SELECT last_insert_id() INTO @id;
    INSERT INTO FLUFF VALUES(@id, 5, 6, 7);
    COMMIT;
    SELECT @id;

and as you see you can also select it directly. When called in a bash script you can then save it into a variable
to use for logging or further processing.

Well that is about it for now. Happy bashing bashers!

Photo credit to [jm3 of flickr](https://www.flickr.com/photos/jm3/4814208649).
