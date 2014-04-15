---
title: "Building my own backup solution"
kind: article
created_at: 2014-04-15
author: hardy
tags: backup, crashplan, pi,
---

## Background

Not so long ago I witnessed complete disk crashes by some of my
 colleagues. Everything was lost and a full reinstall was at order.
Ironically, one of my colleagues was even running a backup software,
but it was so out of date, that once he had an updated version of the
OS installed, he could not find and install a suitable version of the
backup software to restore lost data.

Initially I smiled, but then I realized that I was in danger as well.
These guys where not technology savvy, but for me working with data
is my daily bread. Still, my disaster backup solution sucked, not to
say was non existent.

All I had was a USB drive attached to a
[Raspberry Pi](http://www.raspberrypi.org/) available as Samba drive
on my network.

## CrashPlan

As a first step I investigated cloud based backup services. I was
hoping that this could easily be setup without any new hardware. Of course having the backup off-site, sounded like a good idea as well. I
investigated several services and the choice is for sure huge our-days.
To get started start with one of comparisons sites out there (like
[this one](http://www.top10cloudstorage.com/review/justcloud/)).
They offer a good starting point, but if course their rankings have
to be taken with a grain of salt.

Another thing I noticed - it seems quite custom for these cloud
backup providers to hide their pricing information. Sometimes you have to click around for ages to find it, but other
times I was just unable to find any at all. Take
[justcloud.com](http://www.justcloud.com/) for example. Where the
heck is the pricing information? To me that's already a no go zone,
even if the service is good.

Anyways, I ended up with [CrashPlan](http://www.code42.com/crashplan/). Not because I think it is the best service, but more because it offered feature wise the minimum I expected for a reasonable price.

The strong points for me were:

* Price - 4 USD / month, if bound for 4 years
* Unlimited data - that was one of the determining features
* Free friend to friend backup - a very nice feature which comes in
handy as we'll [see later](#friend-to-friend).

On the weak side:

* Very basic Web UI which just allows you do download backed up
files. I was hoping for some more features, for example the ability to view and organize pictures on-line.
* The client to configure the backup is Java based and needs to run as a GUI
* Upload speed is not very high. My initial upload (~110 GB) took me
several weeks. The problem might be data
center location related or a
[problem of the software](http://networkrockstar.ca/2013/09/speeding-up-crashplan-backups/).
The verdict is still out on this one.

## CrashPlan on Raspberry Pi

Once I decided to use Crashplan it was at the time to install it on
my PI. For evaluation purposes I first installed CrashPlan on my
notebook, but in the long run my plan had always been to run Crashplan on the Pi.
Unfortunately, there is where the pain begun. Basically there three
hurdles you have to jump prior to running CrashPlan on a Pi:

<a name="arm-install"></a>

* [Install Java](#install-java)
* [Install and *patch* Crashplan](#install-crashplan)
* [Configure CrashPlan to run on a headless client](#headless-client)

Let's address these things, in this order.

<a name="install-java"></a>
### Install Java

Installing Java via the package manager is actually quite easy. You need some other libraries as well, but that's not hard.

    $ sudo apt-get install openjdk-7-jre-headless build-essential libjna-java

<a name="install-crashplan"></a>
### Install and patch CrashPlan

Now that you have Java installed it is time to download and install the
CrashPlan installer (check the website for the latest version):

    > curl -O http://download.crashplan.com/installs/linux/install/CrashPlan/CrashPlan_3.6.3_Linux.tgz
    > tar -zxvf CrashPlan_3.6.3_Linux.tgz
    > cd CrashPlan-install
    > sudo ./install.sh

You can choose the default installation options which will install
CrashPlan into _/usr/local/crashplan_.

Now it at the time to patch
the installation. The library _libjtux.so_, which get extracted
into the installation directory does not work on
[ARM processors](http://en.wikipedia.org/wiki/ARM_architecture). You
will need to replace it with an ARM compatible version. You can try
to compile a patched
[Jtux](http://www.basepath.com/aup/jtux) yourself as suggested
[here](https://0x539.se/crashplan-pa-din-raspberry-pi) or you can downloaded the pre-compiled binary from [here](http://goo.gl/kYqCLD).

    $ cd /usr/local/crashplan
    $ mv libjtux.so libjtux.so.orig
    $ cp <download-dir>/libjtux.so .

Now you are ready to run CrashPlan on your Pi.

     $ sudo service crashplan start

The first startup takes a long time, so be patient. You can check
whether the process is running via:

    $ sudo service crashplan status

Or if you want more details check the _/usr/local/crashplan/log_
directory which contains multiple log files.

<a name="headless-client"></a>
### Run CrashPlan on a headless client

Now that CrashPlan is running you need to configure it and setup the
backup sets. Provided your Pi runs headless (as in my case,)
you will have to solve now the last piece of the puzzle. Setting
up configuration via a headless client. To do so, you will have to
install CrashPlan on your computer as well and then follow the
instructions provided from the CrashPlan support pages on how to
[Configuring a Headless Client](http://support.code42.com/CrashPlan/Latest/Configuring/Configuring_A_Headless_Client).
Basically this is done via SSH tunneling and looks something like:

    > ssh -L 4200:localhost:4243 pi@my.pi.ip

(Don't forget to update the _ui.properties_ file as explained on
the help page).

**TIP**:

If you are like me and cannot remember all these options, add the
following to your _~/.ssh/config_ file:

    Host pi
        HostName <my.pi.ip>
        User pi
        IdentityFile ~/.ssh/id_rsa.pub
        LocalForward 4200 127.0.0.1:4243


## Crashplan on WD My Cloud

<a name="friend-to-friend"></a>
### Friend to friend backup

So, now I had a a backup on my USB disc attached to the PI and a
remote backup on the CrashPlan servers. But why stop there? It happened
that I also bought a [WD My Cloud](http://www.wdc.com/en/products/products.aspx?id=1140)
for my office. Given that it is running Linux and you can get root
access, it was not so far fetched to utilize it for CrashPlan as well.
CrashPlan allows friends to share their backup storage with each other
and the beauty is that this feature is free. All you have to do is to
sign up for another free CrashPlan account and use it to share you
backup device. How this works
in detail is described on the CrashPlan support site - [Backing Up To A Friends Computer](https://support.code42.com/CrashPlan/Latest/Backup/Backing_Up_To_A_Friends_Computer).

### Install and patch CrashPlan

However, to use friend to friend backup, I needed to install first
CrashPlan on the WD My Cloud. Luckily it is also an ARM based
processor, so the steps for installing CrashPlan are identical to
installing on the Pi. So back to [here](#arm-install).

### Monit

Almost there. A last thing I did was to installed
[Monit](http://mmonit.com/monit/).

    > apt-get install monit

The reason for installing it was
that I had several JRE crashes with CrashPlan not restarting. Adding
Monit with the following configuration (under _/etc/monit/conf.d/crashplan_)
fixed that problem. The crashes
still occur, but don't bother me too much at the moment:

    check process chrashplan with pidfile /usr/local/crashplan/CrashPlanEngine.pid
     start program = "/etc/init.d/crashplan start"
     stop  program = "/etc/init.d/crashplan stop"
     if 5 restarts within 5 cycles then timeout


### Summary

Overall I am happy with my new backup solution. From local USB
only, to two off-site backups, all fully automated, that's not too bad.
Price-wise I am also happy. For 4 USD per month, I get a unlimited
off-site storage at one of CrashPlan's servers, plus a free friend to
friend backup using the same technology and configuration.

I am still disappointed on what I can do with my backup data. I would
expect more from the CrashPlan web and tablet apps.

The biggest disappointment, however, is the Java client. It feels to
bulky and not flexible to fire up an UI to manage and configure
you backups. Maybe for recovery, but for simple configuration a
command line tool would be of great help. Maybe just as a supplementary
tool. On top of this, I need to keep CrashPlan around on my notebook,
just for running the GUI connecting to my PI.
That would be "ok", if I could just
use the GUI, but the installation of CrashPlan also installs some
services which I have not been able to turn off yet. Last, but not
least, the use of something like _libjtux_ is imo questionable. It's
poor to include something into your Linux distribution package which does then not even run on all installations. This whole fiddling with
the Java GUI became almost a deal breaker for me, but since I worked
it out in the end I'll stick to it for now. I would love
ChrashPlan to work on this part.

I hope this helps a few people trying to get CrashPlan to work on a
Raspberry Pi or a WD My Cloud. If you have problems with the
instructions or find other problems with my solution, leave a message.

Enjoy!