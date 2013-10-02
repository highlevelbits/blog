---
title: single point logging with go
kind: article
created_at: 2013-10-03 1:59:00
author: fredrik
tags: golang, coding, logging
---

I'll continue to spam you with [go](http://golang.org/) related posts. I am working on a rather small webapp built with go. Despite it being small we have still managed to code differently in different parts of the application. Logging is one such issue that we decided to do something about the other day. At the same time it was good to improve on the error handling which often goes hand in hand with logging. In the midst of this some external forces (operations....) tells us that we should use a **logging server** for logging. Not right away mayhaps but eventually. This led us to go for our own logging functions so that we can change the implementation in one place. So we needed to get some common things into the log. User name (or some way to keep track of one call to the system), a timestamp, the code line where the logging occurred and the message itself. A normal application log file more or less. 

To call our own logger we thought something like `LogInfo(user User, message string, args... interface{})` looked nice with corresponding functions for Error and Debug. The first implementation was easy enough:

    func LogInfo(message string, args ...interface{}) {
      log.Printf("INFO | " + message, args...)
    }

But wait? What happens with the code line number? It will point to our logger function and that is not what we intended. We would like the line nubmer to be where the call to LogInfo occurred. At this point in time it was very handy to have the source code available for the standard library. `Printf` does not care about line numbers and such - it just prints whatever line it is invoked on. Underneath the `Printf` function there are a `Logger` type that defines an `Output` function called by printf. So lets start with constructing a `Logger`:

    func Logger() *log.Logger {
      return log.New( os.Stderr, "", log.Lshortfile | log.Ldate | log.Ltime )
    }

The first argument to `New is a writer. For now we are happy to write to Stderr. The second is a prefix to use when logging - we don't care about it now - probably useful when you log from several things to the same file. Lastly we tell the standard library what we want to log - a short file description with line number and a timestamp. Find the available options under the *const* part in the log package documentation. Now all we need to do is to call the `Output` function on the logger.

    func LogInfo(message string, args ...interface{}) {
      calldepth := 3 // the distance to the actual call for logging
      Logger().Output(calldepth, "INFO | " + fmt.Sprintf(message, args...))
    }

and use it to log some stuff:

    LogInfo("%s %s", "some", "stuff")

The `calldepth` here is basically what part of the stack that makes it as a code line into the block. The standard library uses 2 so it made sense to add one to get to the right position for us. The standard library uses `runtime.Caller` to get to this information. There are other functions to get to the stack also in the `runtime` package.

In the real world we passed in info about our user, extracted log message creation to its own function and added functions for error and debug. We also had one set of functions accepting a user and one set not accepting a user. We also did [some thinking](http://stackoverflow.com/q/19115273/135673) about if it was possible to log something like a thread id and came to the conclusion that it isn't possible in go. I got a [nice answer](http://stackoverflow.com/a/19116962/135673) from [rog](http://stackoverflow.com/users/41344/rog) and here is the first part:

> Because of the high potential for abuse, there is no way to access an identifier for the current goroutine in Go. This may 
> seem draconian, but this actually preserves an important property of the Go package ecosystem: *it does not matter if you 
> start a new goroutine to do something*.

A good explanation and in line with the go way of doing things. I can find it a bit limiting at times but it is almost always for a good reason which makes it easier to accept.

As a side note - the go community is very helpful. Using the #golang tag on twitter for asking questions renders some nice answers and discussions. Very useful. And [stackoverflow](http://stackoverflow.com) is a good resource as always.
