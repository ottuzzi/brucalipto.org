---
date: '2008-05-02 11:53:00'
layout: post
slug: how-to-install-data-protector-60-on-ubuntu-linux-704
status: publish
comments: true
title: How to install Data Protector 6.0 on Ubuntu Linux 7.04
wordpress_id: '66'
categories:
- linux
tags:
- Tutorial
- Ubuntu
---

{% img left /images/2008/02/ubuntulogo.png Logo Ubuntu %}Yesterday I finished the installation of a new Ubuntu Linux 7.04 Feisty Fawn 
and I needed to install the Data Protector Disk Agent to backup its files. I have a Windows 2003 cell manager and a HP-UX 
install server that should help with the installation of the Data Protector software on UNIX/Linux/Solaris hosts... I'm quite 
a newbye on the topic but I was unable to install the disk agent using the HP-UX install server so here you will find 
instructions for the "always working" manual installation.

The  first thing is to get the HP-UX PA-RISC install server CDs from HP website:if you do not have the original CDs 
you can get them as trial from [here](http://h20293.www2.hp.com/portal/swdepot/displayProductInfo.do?productNumber=DP60SWD1).

Now its time to install the Disk Agent on the server you need to backup; you need to install a package that is not installed 
by default on the Ubuntu Linux 7.04: inetd. So, as "administrator", execute the command:

{% codeblock lang:sh %}
$ sudo apt-get install netkit-inetd
{% endcodeblock %}

to get the needed package installed.

Insert the first CD of the HP-UX PA-RISC install server on the optical drive of the server and mount it:

{% codeblock lang:sh %}
$ mount /dev/hda /mnt
{% endcodeblock %}


Now it is install time:

{% codeblock lang:sh %}
$ cd /mnt/LOCAL_INSTALL
> ./omnisetup.sh
{% endcodeblock %}

Answer all the questions the installer asks to you and finish the installation. In my installation the Data Protector agent was correctly added to the inetd configuration:



{% codeblock lang:sh %}
$ cat /etc/inetd.conf
omni stream tcp nowait root /opt/omni/lbin/inet inet -log /var/opt/omni/log/inet.log
{% endcodeblock %}

OK... we are at the end...

{% codeblock lang:sh %}
$ /etc/init.d/inetd restart
{% endcodeblock %}

and now try if the Data Protector agent answers to port 5555:

{% codeblock lang:sh %}
$ telnet localhost 5555
{% endcodeblock %}


That's all... if you encounter any problem leave a comment here... I'll try to help you.

Leave a comment even if you have a smarter method... I am very glad to learn.
