---
date: '2008-03-03 10:05:54'
layout: post
slug: fsck-di-un-filesystem-senza-reboot
status: publish
comments: true
title: fsck di un filesystem senza reboot
wordpress_id: '62'
categories:
- linux
tags:
- Ubuntu
---

{% img left /images/2008/03/linuxpenguin.gif Linux Penguin %} Stamattina, nella mia casella di posta, ho trovato un messaggio che diceva che il mio server di monitoraggio basato su Zabbix e installato su una Ubuntu 7.04 aveva tirato le cuoia stanotte alle 02:00: il messaggio riportava una laconico "ZABBIX database is down."!

Ovviamente il primo controllo è stato fatto sul DB (MySQL) e non ho trovato alcun messaggio d'errore... il problema è che in realtà il file /var/log/syslog era fermo da parecchie ore. Spinto da una irrazionale speranza ho provato un

{% codeblock lang:sh %}
$ /etc/init.d/mysql restart
{% endcodeblock %}

per scoprire che era inutile... il DB non risaliva. Bene... ho i backup... ranzo tutto e rimetto su i backup: no... nemmeno questo era possibile... la directory dei backup non era più una directory e al posto dei familiari drwxr-xr-x aveva degli spaventosi punti di domanda.

Riassumendo avevo il DB che non riusciva a risalire e i backup persi!

A questo punto l'unica cosa da fare era provare a verificare l'integrità del file system (ext3) e ho seguito i seguenti passi:

{% codeblock lang:sh %}
$ init 1 #vai in single-user-mode
$ mount #dammi la lista dei filesystem montati
/dev/sda1 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw,noexec,nosuid,nodev)
/sys on /sys type sysfs (rw,noexec,nosuid,nodev)
varrun on /var/run type tmpfs (rw,noexec,nosuid,nodev,mode=0755)
varlock on /var/lock type tmpfs (rw,noexec,nosuid,nodev,mode=1777)
udev on /dev type tmpfs (rw,mode=0755)
devshm on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
$ mount -o remount,ro / #rimonta in read-only il filesystem di /
$ e2fsck -f -v /dev/sda1 #controlla il filesystem anche se sembra corretto (-f) e sii prolisso nei log (-v)
$ mount -o remount,rw / #rimonta in read-write il filesystem di / una volta terminato il controllo
$ init 2 #ritorna al runlevel precedente e alla piena operatività del sistema
{% endcodeblock %}

Per fortuna dopo questa cura il DB è risalito correttamente e ho addirittura recuperato i miei backup!