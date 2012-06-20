---
date: '2008-03-28 14:38:57'
layout: post
slug: how-to-install-data-protector-60-on-red-hat-enterprise-linux-5
status: publish
title: How to install Data Protector 6.0 on Red Hat Enterprise Linux 5
wordpress_id: '64'
categories:
- Linux
tags:
- RHEL5
- CentOS
- Tutorial
---

{% img left /images/2008/03/redhat.jpg RedHat Logo%} Yesterday I finished the installation of a new Red Hat Enterprise Linux 5 (RHEL5) and I needed to install the Data Protector Disk Agent to backup its files. I have a Windows 2003 cell manager and a HP-UX install server that should help with the installation of the Data Protector software on UNIX/Linux/Solaris hosts... I'm quite a newbye on the topic but I was unable to install the disk agent using the HP-UX install server so here you will find instructions for the "always working" manual installation.

The first thing is to get the HP-UX PA-RISC install server CDs from HP website: if you do not have the original CDs you can get them as trial from [here](http://h20293.www2.hp.com/portal/swdepot/displayProductInfo.do?productNumber=DP60SWD1).

Now its time to install the Disk Agent on the server you need to backup; you need to install two packages that are not installed by default on the Red Hat Enterprise Linux 5: *ncompress* and *xinetd*. So, as root, execute the command:

{% codeblock Install prerequisites lang:sh %}
$ yum install ncompress xinetd
{% endcodeblock %}

to get the needed packages installed.

Insert the first CD of the HP-UX PA-RISC install server on the optical drive of the server and mount it:

{% codeblock Mount CD lang:sh %}
$ mount /dev/hda /mnt
{% endcodeblock %}

Now it is install time:

{% codeblock Install DP lang:sh %}
$ cd /mnt/LOCAL_INSTALL
$ ./omnisetup.sh
{% endcodeblock %}

Answer all the questions the installer asks to you and finish the installation. In my installation the Data Protector agent was not correctly added to the xinetd configuration... look if you find the omni file in /etc/xinetd.d... if you do not find it create it with the following content:

{% codeblock xinetd service installation %}
service omni
{
socket_type = stream
protocol = tcp
wait = no
user = root
server = /opt/omni/lbin/inet
server_args = inet -log /var/opt/omni/log/inet.log
disable = no
}
{% endcodeblock %}

and verify it is owned by *root* and with *644* permissions.

OK... we are at the end...


{% codeblock Restart xinetd lang:sh %}
$ /etc/init.d/xinetd restart
{% endcodeblock %}

As suggested by fluffy on comment #1 now you have to check if the firewall (iptables) is actually active: if the firewall is switched on you have to permit the traffic from and to port 5555 to flow regularly.


{% codeblock Check firewall rules lang:sh %}
$ chkconfig --list | grep iptables
iptables        0:off   1:off   2:off   3:off   4:off   5:off   6:off
{% endcodeblock %}

If you any `on` you need to modify the file `/etc/sysconfig/iptables` adding:


{% codeblock Proposed firewall rule %}
-A RH-Firewall-1-INPUT -m state –state NEW -m tcp -p tcp –dport 5555 -j ACCEPT
{% endcodeblock %}

Now everything should be ok... let's try if the Data Protector agent answers to port 5555:

{% codeblock Final check lang:sh %}
$ telnet localhost 5555
{% endcodeblock %}

That's all... if you encounter any problem leave a comment here... I'll try to help you.

Leave a comment even if you have a smarter method... I am very glad to learn.
