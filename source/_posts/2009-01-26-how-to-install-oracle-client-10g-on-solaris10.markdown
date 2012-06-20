---
date: '2009-01-26 17:03:07'
layout: post
slug: how-to-install-oracle-client-10g-on-solaris10
status: publish
title: How to install Oracle Client 10g on Solaris10
wordpress_id: '164'
categories:
- Solaris
tags:
- Tutorial
---

{% img left /images/2009/01/solaris.gif solaris logo %} Today I needed to install an Oracle Client on a new Solaris10 (x86 64bit) installation: I found a useful tutorial [here](http://ivan.kartik.sk/oracle/install_ora10gR2_solaris.html) but it helps you to install the whole database and not only the client. As you may guess the client installation is easier than the Oracle DB Server one.

The first thing to do is to check if you have installed the prerequisites packages:

{% codeblock Check for mandatory packages lang:sh %}
$ pkginfo -i SUNWbtool SUNWarc SUNWhea SUNWlibmr \
  SUNWlibm SUNWlibms SUNWsprot SUNWtoo SUNWi1of \
  SUNWi1cs SUNWi15cs SUNWxwfnt SUNWpoolr SUNWpool \
  SUNWuiu8
{% endcodeblock %}

If you see any error here you must install the missing packages: if you did the "full installation" you should have all packages already installed.

Now its time to create user, groups, directories and project: as root type

{% codeblock Preparing for installation lang:sh %}
//create user and groups
$ groupadd oinstall
$ groupadd dba
$ useradd -g oinstall -G dba -m -d /export/home/oracle -s /usr/bin/bash oracle
//create the project (this is optional)
$ projadd -U oracle oracle
//create the installation dir and give the right permissions
$ mkdir /opt/oracle
$ chown -R oracle:oinstall /opt/oracle
{% endcodeblock %}

OK... as root we have temporarily finished!

Now log in with the oracle user and [download the Oracle Client 10g for Solaris10 from Oracle website](http://www.oracle.com/technology/software/products/database/index.html): once there you need to select the right architecture (Solaris exists for SPARC and x86 both 32 and 64 bit) and get the right archive for the Oracle client installation. In my own situation (Solaris10 on a x86 64bit) I downloaded the file called [10201_client_solx86_64.zip](http://download.oracle.com/otn/solaris/oracle10g/10201/x8664/10201_client_solx86_64.zip) and I typed:

{% codeblock Installing oracle lang:sh %}
$ unzip 10201_client_solx86_64.zip
$ cd client/
$ ./runInstaller
{% endcodeblock %}

{% img /images/2009/01/01.png %} 

As you can see I used /opt/oracle/oraInventory and I leaved the group oinstall as the default group.

{% img /images/2009/01/03.png %} 

As ORACLE_HOME I used /opt/oracle/product/10.2.0/client_1.

{% img /images/2009/01/04.png %} 

Just before the installation finishes it prompts to you to execute two more commands as root: in my own installation I run

{% codeblock Finishing installation lang:sh %}
//execute the following commands as root
$ /opt/oracle/oraInventory/orainstRoot.sh
$ /opt/oracle/product/10.2.0/client_1/root.sh
{% endcodeblock %}

but, as you may guess, your path may be different from mine.

Now, if you want to use the just installed oracle binaries, you need to change the .profile of the user adding at the end:

{% codeblock Environment variables lang:sh %}
ORACLE_BASE=/opt/oracle
ORACLE_HOME=/opt/oracle/product/10.2.0/client_1
PATH=$PATH:/opt/oracle/product/10.2.0/client_1/bin/
export ORACLE_BASE
export ORACLE_HOME
export PATH
{% endcodeblock %}

I hope this tutorial can help you... if you find errors please report them to me and I will correct as soon as possible.
