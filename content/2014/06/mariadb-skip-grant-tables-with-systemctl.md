---
title: "How to make systemctl on arch linux start mariadb (mysql) with the --skip-grant-tables flag"
kind: article
created_at: 2014-06-25
author: fredrik
tags: mysql, mariadb, arch, linux, systemctl
---

I have had the opportunity to familiarize myself with mariadb lately. Mariadb is an open source clone of the popular mysql relational database - now owned by oracle. It was very easy to get up and running on arch linux. Just a matter of:

    sudo pacman -S mariadb
    sudo systemctl enable mysqld

and it was up and running. However after a while I was unable to log on with the command line tool. I learned how to start the database with the `--skip-grant-tables` and found out that the `user` table mariadb uses for authentication was empty. Since my use of mariadb is only temporary I decided to not care so much about why this happen. Instead I decided to make sure that the database always starts with the mentioned flag. To do this you need to find the files `systemctl` uses for managing its tasks. They (some of them at least) are located in `/usr/lib/systemd/system`. There seems to be one file for each thing `systemctl` is managing. I found `mysqld.service` and added the `--skip-grant-tables` flag to the `ExecStart` key. Like this:

    ExecStart=/usr/bin/mysqld --pid-file=/run/mysqld/mysqld.pid --skip-grant-tables 

So now my database starts without wanting authentication for connections. This is practical in a local development environment but should of course never be used in production. 
