---
date: '2007-10-30 12:43:34'
layout: post
slug: how-to-install-truecrypt-on-ubuntu-edgy-610
status: publish
comments: true
title: How to install Truecrypt on Ubuntu Edgy 6.10
wordpress_id: '28'
categories:
- linux
tags:
- Tutorial
---

This is a mini-tutorial on how to install, and use, Truecrypt 4.3a on the now venerable Ubuntu Edgy 6.10.


## What is truecrypt?


As you can read in [Truecrypt homepage](http://www.truecrypt.org/):


Free open-source disk encryption software for Windows Vista/XP/2000 and Linux


So with Truecrypt you can encrypt you private files on a disk (on a real disk or on an encrypted file). This tutorial is needed because neither Truecrypt nor Scramdisk (the very useful GUI to use Truecrypt) were not already debianized in Ubuntu Edgy 6.10.


## Prerequisites


The first thing you need is the Linux kernel source you are running:



> sudo su #we are going to work as root
> cd /usr/src #change to the appropriate directory
> apt-get source linux-image-`uname -r` #get linux sources
> CTRL-D #We want to leave the root user as fast as possible ;)

Now you'll get you Linux sources in /usr/src.
Last dependency is dmsetup:


> sudo apt-get install dmsetup #get dmsetup package from Ubuntu archives





## Truecrypt


Now that we have all dependencies we can get, compile and install Truecrypt:



> cd /tmp #move in a working directory
#download the sources
> wget http://www.truecrypt.org/downloads/truecrypt-4.3a-source-code.tar.gz
#decompress the sources
> tar zxvf truecrypt-4.3a-source-code.tar.gz
#move in the Linux directory
> cd truecrypt-4.3a-source-code/Linux/
> sudo su #now we need to be root
> ./build.sh #answer the questions and compile
> ./install.sh #install everything
#We want to leave the root user as fast as possible ;)
> CTRL-D

OK... we are almost arrived :) Truecrypt now should be compiled and installed... let me know if something is not going as expected and I'll try to help you out.


## What is scramdisk?


As you can read in [Scramdisk homepage](http://sd4l.sourceforge.net/):


SD4L is a suite of Linux tools and a graphical user interface (GUI) which allow the creation of, and access to ScramDisk encrypted container files. In particular, SD4L provides a Linux driver which enables mounting ScramDisk containers. ScramDisk for Linux also encrypts partitions on a hard disk or storage media such as USB sticks or floppy disks entirely as devices. Version 1.0 and later versions, moreover, support TrueCrypt containers.


 Installing scramdisk is easy as using it: it is not packaged by Ubuntu but scramdisk developers debianized it even for the ancient Ubuntu Edgy 6.10:



> cd /tmp #move in a working directory
# for 32bit systems
> wget http://ovh.dl.sourceforge.net/sourceforge/sd4l/ScramDisk_1.2-0_Ubuntu-6.10_2.6.17_i386.deb
# for 64bit systems
> wget http://switch.dl.sourceforge.net/sourceforge/sd4l/ScramDisk_1.2-0_Ubuntu-6.10_2.6.17_x86_64.deb
> sudo dpkg -i ScramDisk_1.2-0_Ubuntu-6.10_2.6.17_*.deb #install it
> scramdisk #use it


## The end


OK... hopefully everything should have worked and know you have the latest Truecrypt and the latest scramdisk installed on you PC: put them at good use :)

Let me know if you encountered a problem... I'll try to help you. Please leave a note even if you find this tutorial vaguely useful and help me to improve it.

[![EmailOttuzziGoogle](/images/2008/02/ottuzzigoogle.png)](mailto:ottuzzi@gmail.com)
