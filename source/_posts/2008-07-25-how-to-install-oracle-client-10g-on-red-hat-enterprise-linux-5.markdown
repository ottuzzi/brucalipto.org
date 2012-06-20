---
date: '2008-07-25 13:56:18'
layout: post
slug: how-to-install-oracle-client-10g-on-red-hat-enterprise-linux-5
status: publish
title: How to install Oracle Client 10g on Red Hat Enterprise Linux 5
wordpress_id: '69'
categories:
- Linux
tags:
- RHEL5
- CentOS
- Tutorial
---

{% img left /images/2008/03/redhat.jpg RedHat Logo%} Today I needed to install the Oracle Client 10g on a Red Hat Enterprise Linux 5 32bit: all around the net you can find many useful tutorial on how to install the Oracle DB Server but I cannot find how to install only the client. As you may guess the client installation is easier than the Oracle DB Server one.

On the linux machine, as root, you have to run the following commands:


{% codeblock Create user and groups lang:sh %}
$ groupadd oinstall
$ groupadd dba
$ useradd -g oinstall -G dba oracle
$ passwd oracle
{% endcodeblock %}



{% codeblock Setup filesystem lang:sh %}
$ mkdir /opt/oracle
$ chown -R oracle:oinstall /opt/oracle
{% endcodeblock %}

{% codeblock Install some needed packages lang:sh %}
$ yum install libXp gcc make setarch libaio glibc-devel
{% endcodeblock %}

{% codeblock Change /etc/redhat-release as RHEL5 is not a supported platform lang:sh %}
$ cp /etc/redhat-release /etc/redhat-release.5
$ echo redhat-4 > /etc/redhat-release
{% endcodeblock %}

OK... as root we have now finished!

Now log in with the oracle user and [download the Oracle Client 10g from Oracle website](http://www.oracle.com/technology/software/products/database/oracle10g/htdocs/10201linuxsoft.html): once there get the file called [10201_client_linux32.zip](http://download.oracle.com/otn/linux/oracle10g/10201/10201_client_linux32.zip). Unzip and run the client:

{% codeblock Installing oracle lang:sh %}
$ unzip 10201_client_linux32.zip
$ cd client
$ ./runInstaller
{% endcodeblock %}

I pointed the oraInventory directory to `/opt/oracle` in the first screen; in the second one I choose to install the Oracle 10g Client in `/opt/oracle/product/10.2.0/client_1/`. Just before the installation finishes it prompts to you to execute two more commands as root: in my own installation I run

{% codeblock Execute the following commands as root lang:sh %}
$ /opt/oracle/orainstRoot.sh
$ /opt/oracle/product/10.2.0/client_1/root.sh
{% endcodeblock %}

but, as you may guess, your path may be different from mine.

Now the final step: we have to restore the /etc/redhat-release file we changed before:


{% codeblock The final touch lang:sh %}
$ mv /etc/redhat-release.5 /etc/redhat-release
{% endcodeblock %}

I hope this tutorial can help you... if you find errors please report them to me and I will correct as soon as possible.
