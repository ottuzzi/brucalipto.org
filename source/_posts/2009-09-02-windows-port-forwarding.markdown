---
date: '2009-09-02 16:19:38'
layout: post
slug: windows-port-forwarding
status: publish
title: Windows port forwarding
wordpress_id: '197'
categories:
- Windows
tags:
- Tutorial
---

{% img left /images/2009/09/Windows_XP_Logo_small.jpg Windows XP Logo %} In Linux world port forwarding is a common feature: if you need to forward traffic from port XX to port YY you simply use the integrated Linux firewall called iptables. In Microsoft Windows the integrated firewall is not so sophisticated as the Linux one and I needed to found a solution. A friend of mine was asked about this question and answered: "You cannot find anything working... if you find something let me know!".

The smartest solution I found was to use [stunnel](http://www.stunnel.org/): maybe an overkill software for this simple task but it is
1. well known and opensource;
2. stable;
3. works as a windows service.

My own problem was to forward SMTP traffic from port 65025 to the well known port 25: this way if I telnet to port 65025 I can speak directly with the SMTP server listening on port 25.

The first thing was to download [stunnel for windows](http://www.stunnel.org/download/stunnel/win32/stunnel-4.27-installer.exe) and install it.

Now all the magic is to write the appropriate stunnel.conf file that, in my case, was something like this:

{% codeblock stunnel configuration file %}
; Certificate/key is needed in server mode and optional in client mode
; The default certificate is provided only for testing and should not
; be used in a production environment
cert = stunnel.pem
; Some performance tunings
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
[in65025smtp]
accept = 10.145.2.88:65025
connect = 10.145.2.88:65024
protocol = smtp
client = yes
[out25smtp]
accept = 10.145.2.88:65024
connect = 10.145.2.88:25
protocol = smtp
{% endcodeblock %}

Looking at the stunnel.conf file provided you can see the trick: stunnel accept SMTP connections on port 65025 and encrypts them forwarding the traffic to port 65024; then it gets encrypted SMTP traffic from port 65024 and forwards it decrypted to port 25.

Last but not least is to register stunnel as service: in Windows this is as easy as 1, 2, 3

{% img /images/2009/09/stunnel_as_service.png Stunnel as a service %}

Please remember also to start the service ;)

I hope this is clear... if you find something wrong here please let me know and I will correct it!
