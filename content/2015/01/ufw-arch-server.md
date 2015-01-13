---
title: "Setting up ufw for a web server"
kind: article
created_at: 2015-01-13
author: fredrik
tags: arch, server, security, linux, ufw
---

Once you have a secure server - as described in the [previous installment](/2015/01/securing-arch-server.html) - the next step is to set up a firewall so that only expected traffic is allowed. The high ceremony approach to this is to use `iptables`. I never learned this and once I found [`ufw`](https://wiki.archlinux.org/index.php/Uncomplicated_Firewall) (stands for *uncomplicated firewall*) there seem to be no need for trivial use cases like mine.

### Requirements

My needs are simple - I want to accept:

- ssh traffic on a port that is not 22
- http on port 80
- https on port 443

And that is all.

### ufw apps

ufw comes with a set of predefined *apps*. They are located in `/etc/ufw/applications.d/` and grouped into typcial uses. So the ssh rule is in the file `ufw-loginserver` along with other rules related to login. And web server rules are in `ufw-webserver`.

### Default

I start with adding a rule that denies everything

    > ufw default deny

on the command line. Almost everything happens on the command line....

### Web

The `WWW Full` rule in `ufw-webserver` is exactly what I want for http and https so:

    > ufw allow "WWW Full"

### SSH

There is a SSH rule in `ufw-loginserver` but it defaults to port 22. I can either change it or create a new rule. The latter seems better and will probably survive new versions of `ufw` better. So I add a file called `ufw-loginserver-custom` and copy the ssh rule with just a change to the port:

    [CUSTOMSSH]
    title=SSH server
    description=SSH server
    ports=12345/tcp

and allow it on the command line:

    > ufw allow CUSTOMSSH

### Enabling the firewall

Now all that is left is to enable the firewall:

    > ufw enable
    > systemctl enable ufw

and you have a secure server. Next is probably to get `nginx` up and running. I already posted about getting [unicorn and SSL to work with nginx](/2014/06/multiple-unicorn-servers-with-ssl-on-nginx.html) so I probably want add anything about that at this time.