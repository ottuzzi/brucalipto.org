---
date: '2004-10-21 18:40:37'
layout: post
slug: linux-su-ipaq
status: publish
comments: true
title: Linux su IPAQ
wordpress_id: '12'
categories:
- linux
tags:
- IPAQ
---

Questo articoletto serve come diario per la mia esperienza nell'installazione di Linux su un IPAQ 3875 recuperato di seconda mano.


## Introduzione


Mi è capitato di mettere le mani su un vecchio IPAQ 3875 e ho voluto sostituire il WinCE che vi si trova di default con un kernel linux e relative applicazioni. Era un bel po' di tempo che volevo fare questo esperimento e dopo alcune indagini ho scoperto che esiste proprio una distribuzione nata per questo scopo: [Familiar](http://familiar.handhelds.org/).
Familiar è nata nel seno di un [progetto](http://www.handhelds.org/) più ampio sponsorizzato nientemeno che dalla ormai defunta Compaq (acquistata dalla HP) ![IPAQ01](/images/2008/02/ipaq01.png)che voleva provare a portare linux sul suo palmare che all'epoca aveva ben pochi rivali: da tale progetto sono nati un bootloader, due ambienti grafici ([Opie](http://opie.handhelds.org/) e [GPE](http://gpe.handhelds.org/)) e due distribuzioni linux (la già citata Familiar e [Intimate](http://intimate.handhelds.org/)).


## Per cominciare


![IPAQ02](/images/2008/02/ipaq02.png)Per cominciare serve innanzitutto un palmare un po' vecchiotto (Familiar è "certificata" solo per alcuni IPAQ) che si è disposti a rischiare (in caso di problemi nell'installazione del bootloader ci si troverebbe con un "brick") un po' di pazienza e, per seguire meglio questi appunti, una macchina linux (io ho una Mandrake 10.0 CE).
Recuperiamo tutto l'occorrente:



	
  * [SynCE](http://synce.sourceforge.net/synce/tarballs.php)

	
  * [Familiar](http://familiar.handhelds.org/familiar/releases/v0.7.2/install/download.html)




## Installazione di SynCE


![IPAQ03](/images/2008/02/ipaq03.png)Come si può facilmente immaginare SynCE è la controparte linux di ActiveSync.
Come tutti i programmi UNIX è diviso in due parti: una parte core, e una con un frontend grafico per KDE e un frontend grafico per GNOME. A noi interessa per i nostri scopi solo la parte core e per far questo basta seguire fino al punto 7 le istruzioni che potete trovare [qui](http://synce.sourceforge.net/synce/tarballs.php). Una volta installato il tutto basta seguire [queste istruzioni](http://synce.sourceforge.net/synce/start.php) per vedere che il nostro IPAQ si connetta al PC.


## Installazione di Familiar


A questo punto dobbiamo installare Familiar e il processo si divide in due parti: l'installazione del bootloader (che permette ancora di utilizzare WinCE) e l'installazione della distribuzione vera e propria. Per l'installazione del bootloader (in assoluto l'operazione più delicata di tutta l'installazione) basta fare riferimento a [questo documento](http://familiar.handhelds.org/familiar/releases/v0.7.2/install/bootldr-synce.html).
Quando il bootloader sarà stato installato secondo le procedure sopra descritte possiamo procedere con l'installazione del nuovo sistema operativo come indicato a [questo indirizzo](http://familiar.handhelds.org/familiar/releases/v0.7.2/install/install-serial.html): per cronaca io ho utilizzato minicom e, a parte qualche problema per capire come si usa, il tutto ha funzionato egregiamente.


## Come far dialogare Familiar con il PC


![IPAQ04](/images/2008/02/ipaq04.png)Finalmente il nostro IPAQ è diventato un palmare Linux e ora vogliamo collegarci con lui per poter scambiare documenti etc. etc.
La cosa più bella del nostro "nuovo" palmare è che contiene un daemon SSH con cui possiamo interagire normalmente utilizzando i comandi ssh, scp e così via.
Ma procediamo con ordine (come utente root):



	
  * Collegare il palmare al PC via seriale

	
  * echo 1 > /proc/sys/net/ipv4/ip_forward
Così abilitiamo l'IPForwarding sul nostro PC e permettiamo ai pacchetti da e per l'IPAQ di passare attraverso il nostro PC (in qualche modo siamo il gateway dell'IPAQ).

	
  * /usr/sbin/pppd /dev/ttyS0 115200 192.168.0.1:192.168.0.2 nodetach \
local noauth nocrtscts lock user ppp proxyarp connect ms-dns 62.152.33.7 \
"/usr/sbin/chat -v -t3 ogin--ogin: ppp"
Questo comando indica che:

	
    * il palmare è collegato alla prima porta seriale (/dev/ttyS0)

	
    * bisogna dialogare a 115200 baud senza flow-control (nocrtscts)

	
    * che il proprio PC ha IP 192.168.0.1 e il palmare 192.168.0.2

	
    * che il palmare deve usare il DNS 62.152.33.7 per risolvere i nomi
Quando il nostro IPAQ sarà raggiungibile via SSH potremmo loggarci e creare così un opportuno /etc/resolv.conf.




	
  * Ecco cosa dovrebbe apparire se tutto è andato bene:
Serial connection established.
Using interface ppp0
Connect: ppp0 <--> /dev/ttyS0
Looking for secret in /etc/ppp/pap-secrets for client ppp server (null)
Looking for secret in /etc/ppp/chap-secrets for client ppp server (null)
Couldn't set pass-filter in kernel: Invalid argument
found interface eth0 for proxy arp
local  IP address 192.168.0.1
remote IP address 192.168.0.2


	
  * Apriamo una konsole sull'IPAQ (si, come tutti i LINUX anche sull'IPAQ abbiamo a disposizione una     console) e proviamo questi comandi:
ping 192.168.0.1(PING verso il proprio PC)
ping 195.210.91.83 (PING verso l'IP di www.libero.it)
ping www.libero.it (PING verso www.libero.it)




## Conclusioni


Ormai siamo arrivati alla conclusione di questo tutorial e si può continuare a sperimentare con il nostro IPAQ tenendo come punto di riferimento il sito istituzionale della distribuzione [Familiar](http://familiar.handhelds.org/) che abbiamo appena installato.

[![EmailOttuzziGoogle](/images/2008/02/ottuzzigoogle.png)](mailto:ottuzzi@gmail.com)
