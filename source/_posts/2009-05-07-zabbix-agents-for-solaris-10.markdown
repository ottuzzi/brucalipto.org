---
date: '2009-05-07 11:38:46'
layout: post
slug: zabbix-agents-for-solaris-10
status: publish
title: Zabbix agents for Solaris 10
wordpress_id: '181'
categories:
- Solaris
---

{% img left /images/2009/05/zabbix.png %} [ZABBIX](http://www.zabbix.com) is an enterprise-class open source distributed monitoring solution. I use it at work and I like it very much. Today I needed the Zabbix Agent for Solaris10 for Intel and, as I still use version 1.4, I downloaded the precompiled agents binaries from [Zabbix site](http://www.zabbix.com/download.php). I'm writing this post because I found a problem!

The precompiled binaries fails to run with the following message:

{% codeblock Zabbix agent error on console lang:sh%}
ld.so.1: zabbix_agentd: fatal: libresolv.so.2: version `SUNW_2.3' not found (required by file zabbix_agentd)
ld.so.1: zabbix_agentd: fatal: libresolv.so.2: open failed: No such file or directory
Killed
{% endcodeblock %}

Running the ldd on the zabbix_agentd will reveal the problem:

{% codeblock ldd result lang:sh%}
ldd /export/home/zabbix/bin/zabbix_agentd
libkvm.so.1 =>   /usr/lib/libkvm.so.1
libm.so.2 =>     /lib/libm.so.2
libresolv.so.2 =>        /lib/libresolv.so.2
**libresolv.so.2 (SUNW_2.3) =>     (version not found)**
libnsl.so.1 =>   /lib/libnsl.so.1
libkstat.so.1 =>         /lib/libkstat.so.1
libsocket.so.1 =>        /lib/libsocket.so.1
libc.so.1 =>     /lib/libc.so.1
libelf.so.1 =>   /lib/libelf.so.1
libmp.so.2 =>    /lib/libmp.so.2
libmd.so.1 =>    /lib/libmd.so.1
libscf.so.1 =>   /lib/libscf.so.1
libdoor.so.1 =>  /lib/libdoor.so.1
libuutil.so.1 =>         /lib/libuutil.so.1
libgen.so.1 =>   /lib/libgen.so.1
{% endcodeblock %}

libresolv.so.2 (SUNW_2.3) is not bundled in Solaris10 but in Nevada (aka Solaris11): so the precompiled binaries were not built on Solaris10 but on Opensolaris. To overcome this problem I downloaded the Zabbix 1.4.6 sources and I compiled the agents with Sun Studio 12.

Here are my own binaries:
* [Zabbix 1.4.6 Agents for Solaris 10 i386 (32bit version)] (/images/2009/05/zabbix_agents_146solaris10i386tar.bz2)
* [Zabbix 1.4.6 Agents for Solaris 10 x64 (64bit version)] (/images/2009/05/zabbix_agents_146solaris10x64tar.bz2)

Use at your own risk and... enjoy!
