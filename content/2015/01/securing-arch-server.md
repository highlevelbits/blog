---
title: "Securing an arch linux server"
kind: article
created_at: 2015-01-11
author: fredrik
tags: arch, server, security, linux
---

I am setting up my own server for the second time. One year ago I got myself a virtual server at digital ocean running arch linux. Unfortunately they dropped support for arch early in 2014 so I needed to move elsewhere and I turned my eyes on linode. So in order to remember how this is done when I do it a third time I will write down some notes about it here. In this first post I will walk you through getting your server up to date and securing it on a shell level.

This guide will set up the server `gibson`  with a user called `william`.

### Getting in and updating

From your provider you have gotten a root password. Log in with it.

Set hostname:
    
    hostnamectl set-hostname gibson

I also add it to my local `/etc/hosts` so I don't have to remember the IP.

I prefer running my server in the UTC time zone. If you want something else you can take care of it now. Use `timedatectl` for this.

Before you can update the system, you need to create entropy, initiate pacman-key and populate the keyring.

To get arch package manager up and running you need to initiate it:

    haveged -w 1024
    pacman-key --init
    pkill haveged
    pacman-key --populate archlinux

Then run the update:

    pacman -Syu

I also install some stuff I will need pretty soon:

    pacman -S git zsh ufw

###Add sudo enable user

Then it is time to secure the login. It is considered harmful to have a password protected root login. Start with adding a normal user:

    useradd -m william
    passwd william

Give the new user root access:

    visudo

Here you have to know your way around `vi`. I can barely manage `vim` so....
Add this line somewhere in the file:

    ruben ALL=(ALL) ALL

Now log out from your root login and try your new user. You should be able to login with password.

### Secure the login

The next step is to use a public key for the ssh login instead of passwords. This will save you time when you need to get into your server and it is also more secure. 

If you don't have a ssh key you have to generate it now. You can find out how with the help of google. Copy the public key file to the server:

    scp ~/.ssh/id_rsa.pub william@gibson

Then login as `william` to `gibson`. The key file needs to be in `.ssh/authorized_keys`. If you are the only user on the machine you can move it like below. Otherwise append it to the file.

    mkdir .ssh
    mv id_rsa.pub .ssh/authorized_keys
    chown -R .ssh
    chmod 700 .ssh
    chmod 600 .ssh/authorized_keys

Finally we need to make some changes to the ssd configuration file.

    sudo vim /etc/ssh/sshd_config

In this file the following lines needs to be uncommented and altered.

    Port 66677
    PasswordAuthentication no          
    PermitRootLogin no

This changes the ssh port from the default 22 making it harder to start attacking the server. We also turn off password authentication and root login. Restart `sshd`.

    sudo systemctl restart sshd

Now the only user that can login is `william` with the ssh key that we entered and on the new port.

    ssh -p 66677 william@gibson

and you are fine to go.

Now you likely want to use the server to run some software that needs to be available. In the next post I will show you how to set up `ufw` - uncomplicated firewall.
