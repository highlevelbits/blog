---
title: "simple backups"
kind: article
created_at: 2013-12-15 21:01:00
author: fredrik
tags: arch, linux, backup, gpg, dropbox
---

![backups](http://farm7.staticflickr.com/6054/6261970884_ea884ea79f_b.jpg)

([Photo by gagam13](http://www.flickr.com/photos/40133358@N05/6261970884))

I just finished moving a rails thing from [heroku](https://heroku.com) to my own [arch linux server](https://www.archlinux.org/) at [digital ocean](https://www.digitalocean.com/). This has involved learning lots about server management. Setting up the server with decent security (ufw - uncomplicated firewall to the rescue) and a nginx web service talking to the unicorn-powered rails application. All rather easy and with lots of resources available on the interwebz. I didn't find much about backing up a postgres database though so I figured something out on my own. And here it is! My requirements:

- nightly backups is enough (for now - users may lose latest updates)
- backups must be stored on another server
- backups on that other server should be encrypted

This leaves me with 4 tasks:

- create a backup file
- encrypt the backup file
- upload the encrypted file to another server
- schedule a nightly task to initiate the backup

### Create a backup file

Postgres comes with the easy to use `pg_dump` command. Name your database and the file you want to export to:

    pg_dump -f <filename> <database>

If you want to export all databases in your postgres server you can use the `pg_dumpall` command instead and omit the database name. I created a filename with a timestamp so that there will be no file name conflict:

    date +%Y.%m.%d.%H.%M.%S

plus a suffix.

### Encrypt the backup file

`gnupg` provides with encryption. Easily installed with

    pacman -S gnupg

I settled for symmetric encryption with a hard password. 

    gpg --symmetric --batch --passphrase <password> --force-mdc <backupfile>

The `--symmetric` flag says to encrypt symmetrically. This means that we can decrypt with the same password. `--batch` makes it possible to pass in the passphrase on the command line rather than getting a prompt to enter it. `--force-mdc` makes sure that a warning about mdc is avoided when decrypting. I am not sure what this means. The command creates a file in parallell to the backup file with the added `.gpg` extension.

### Upload the encrypted file to another server

This can be done in many ways. I settled for dropbox mostly because it is free and rather easy to do. Even easier would be something like `sftp` if you have the luxury of having another server for backup storing. To communicate with dropbox I use the [Core API](https://www.dropbox.com/developers/core) with Ruby. 

    gem install dropbox-sdk

To use it you need to register an app with dropbox. Then you will get the key and secret needed to initiate communication and get an access token. To get the access token you will need to run the following once:

    require 'dropbox_sdk'

    flow = DropboxOAuth2FlowNoRedirect.new(APP_KEY, APP_SECRET)
    url = flow.start
    puts url

Go to the outputted url logged in as the user you want for dropbox and grab the code. Pass it in to the method below:

    code = gets.strip
    access_token, user_id = flow.finish code 

This access token can then be reused for all subsequent calls.

Then do the actual file transfer with:

    client = DropboxClient.new access_token
    file = open gpgfilename
    response = client.put_file(gpgfilename, file)

and the file ends up in the `Apps/<yourappname>` folder.

I use Ruby here but there are several other options depending on your setup.

### Schedule a nightly task

Finally I put all the above in to one huge ruby file (that I won't share because it is kinda messy). Then I added it to crontab with 

    export EDITOR=vim
    crontab -e

I always fail with vi.... The line to add for a nightly run at 01:37 is:

    37 1 * * * /path/to/backup.sh

Keep in mind that cron executes with `/bin/sh` so make sure to test your command under those circumstances. Cron is supposed to send mails when it fails. That remains to set up. I will probably rather hook the job up with nagios once I get that up and running for monitoring.

Thats it for now. I will come back with more server side tips further on.
