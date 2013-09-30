---
title: thoughts about error handling with go
kind: article
created_at: 2013-09-30 21:02:00
author: fredrik
tags: golang, coding, readability
---

I find myself with this code line lots of time:

    if err != nil { return err }

Sometimes with an extra return value - sometimes not. However - the go formatter likes it to be:

    if err != nil {
        return err
    }

which is my preferred way to write it normally. Now I have started to use the one-liner approach to make my code more readable. In a simple database sequence you may need to check the error 3 or more times (getting the database, executing the query and scanning the response for data) so the error handling *noise* will be 3 or 9 lines of such a function. In my mind there is a conflict between explicit code and readable code. Go seems to drive me towards explicit code forcing me to leave some of my coding practices behind.

Please contribute your thoughts about this in the comments section below.
