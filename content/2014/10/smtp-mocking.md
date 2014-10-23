---
title: "Mocking SMTP when testing a black box of software"
kind: article
created_at: 2014-10-23
author: fredrik
tags: smtp, testing, mocking, software development, integration testing, naming
---

So I wrote a micro service that gets a REST call and sends a mail or a SMS and I wanted to have some nice black box tests in place. 

### The test

So my test would `POST` to a web service, then wait for a little while and then check if a mail was sent. The test runs remotely from a build server so everything it needs needs to be accesible over HTTP. So I decided to have a *real* SMTP server running on the server writing files to a directory that a web server can pick up and show to the test. And a static web server serving the mail files in that directory. Pseudo code:

    random_id = UUID.generate()
    message = subject: random_id, message: 'long rant'
    server.post message
    wait 1000
    list_of_mails = staticServer.get
    assert list_of_mails =~ random_ud


### Dummy SMTP server

I looked around on the Internet for a while. I used a Java based graphical dummy server locally called [FakeSMTP](https://nilhcem.github.io/FakeSMTP/). It is really useful when doing stuff in a graphical environment. Now I needed something headless instead. My eyes fell on a [small Python script](https://github.com/maestrofjp/Dummy-SMTP) that did almost exactly what I wanted. The only thing missing was the naming of the files. In order to trace a mail through the server onto the SMTP server I needed something unique. I decided to put a UUID as the subject. The Python script needed [a little tweak](https://github.com/froderik/Dummy-SMTP) to get the subject (as well as the timestamp) onto the filename.

The script only works with Python 2 so make sure you have it..... I am sure it is easy to change for Python 3 for a pythonista.

### Simple file serving web server

Since the system **under test** lives in a tomcat I started out trying to make tomcat serve static files from the folder where the SMTP server stuffs mail files. It is supposed to work but I had some problems and gave up deciding to search for a simpler solution. And suddenly there it was. Look at [this](https://docs.python.org/2/library/simplehttpserver.html) beauty:

    python -m SimpleHTTPServer

Get yourself into a directory from where you want to serve static files - type the above into the terminal and you are up and running on port `8000`. 

### Closing rant about naming

Integration tests can mean many things. There seem to be no common vocabulary within the testing discipline. In Grails - the framework used in the micro service here - integration testing means talking directly to a controller and stubbing away third party dependencies. So the meaning here is to test the different parts and of a system together. (As opposite to unit testing.) For me integration testing normally means testing a couple of systems together and accessing it from the outside (normally with HTTP in some form). This confusion about names led me to use *black box testing* in this article. Using another name for this does not really help but when talking about black boxes it is obvious that we are not testing or knows about any internals - a good thing.
