---
title: "Sending mail on the (arch) command line"
kind: article
created_at: 2015-01-17
author: fredrik
tags: arch, server, linux, email
---

I [handwired my own backup solution](/2013/12/simple_backups.html) a while ago and apparently left out the important part of reporting. When the backup script is done a mail is sent to me depending on the result. It took some time for me to figure out how to do this but once I knew it was really easy. Install `ssmtp`:

    sudo pacman -S ssmtp

As root - edit `/etc/ssmtp/ssmtp.conf`:

    mailhub=<smtp.server>:<port>
    AuthUser=<username>
    AuthPass=<password>
    UseSTARTTLS=YES

I use sendgrid as outgoing SMTP server but there are several other options. Setting up your own shouldn't be to hard either.

Once you have this up and running you can send me an email like this:

    echo 'Really cool post about sending mails' | mail -s 'Cool post' fredrik@eldfluga.se

![mail boxes](https://farm7.staticflickr.com/6200/6118863684_32120222a4_b.jpg)

<small>
[Photo](https://www.flickr.com/photos/gregoryjordan/6118863684/) by [Gregory Jordan](https://www.flickr.com/photos/gregoryjordan/).
</small>
