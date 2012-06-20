---
date: '2008-02-27 09:34:17'
layout: post
slug: guida-dinstallazione-di-un-server-ubuntu-804-hardy-heron
status: publish
comments: true
title: Guida d'installazione di un server Ubuntu 8.04 Hardy Heron
wordpress_id: '42'
categories:
- linux
tags:
- Hardy Heron
- Ubuntu
---

![Logo Ubuntu](/images/2008/02/ubuntulogo.png)Visto che siamo ormai prossimi al rilascio della Ubuntu 8.04 "Hardy Heron" ho pensato di proporvi una guida all'installazione di un server basato su questa versione della nota distribuzione. L'installazione illustrata sarà quella di un server e pertanto non ci sarà installato il server X e tantomeno GNOME o KDE: sarà installato un sistema base che poi provvederemo ad espandere con le prossime guide che saranno pubblicate nella serie dedicate alla Ubuntu 8.04.

[![Ubuntu Install 01](/images/2008/02/01.thumbnail.PNG)](/images/2008/02/01.PNG)Una volta scaricato il CD della Ubuntu 8.04 ([qui](http://cdimage.ubuntu.com/releases/hardy/alpha-5/) la ALPHA-5) e masterizzato lo andiamo ad inserire nel nostro futuro server e provvediamo al restart dello stesso. [![Ubuntu Install 025](/images/2008/02/025.thumbnail.png)](/images/2008/02/025.png)Subito dopo la partenza saremo accolti da una schermata che chiede di scegliere la lingua d'installazione: visto che si tratta di un server io preferisco sempre installare in inglese.[![Ubuntu Install 02](/images/2008/02/02.thumbnail.PNG)](/images/2008/02/02.PNG)Scelto l'inglese viene subito proposta la schermata iniziale con il logo Ubuntu e dove la prima voce è "Install Ubuntu"; prima di scegliere questa voce dando INVIO sarà necessario prima premere F4 per poter scegliere l'opzione "Install a command-line system". A questo punto potremo procedere con il premere INVIO e iniziamo così l'installazione.

Ora si può scegliere la lingua d'installazione (Inglese) e la localizzazione del nostro server. A questo punto è necessario indicare la tastiera a nostra disposizione: per determinare il layout corretto possiamo digitare alcuni dei caratteri proposti e alla fine del processo il programma di installazione dovrebbe identificare correttamente la tastiera (nel mio caso una tastiera italiana). Le immagini che seguono illustrano ad uno ad uno i passi appena elencati.

[![Ubuntu Install 03](/images/2008/02/03.thumbnail.PNG)](/images/2008/02/03.PNG) [![Ubuntu Install 04](/images/2008/02/04.thumbnail.PNG)](/images/2008/02/04.PNG) [![Ubuntu Install 05](/images/2008/02/05.thumbnail.PNG)](/images/2008/02/05.PNG) [![Ubuntu Install 06](/images/2008/02/06.thumbnail.PNG)](/images/2008/02/06.PNG) [![Ubuntu Install 07](/images/2008/02/07.thumbnail.PNG)](/images/2008/02/07.PNG)
(Cliccare su ogni immagine per vederla ingrandita)

Una volta identificata la tastiera è la volta di dare un nome al nostro server (nel mio caso ho lasciato ubuntu)e di partizionare il disco rigido: in questo caso lascio fare tutto al programma di installazione indicandogli di usare tutto lo spazio disco che trova e di impostare automaticamente l'LVM (Logical Volume Manager).
[![Ubuntu Install 08](/images/2008/02/08.thumbnail.png)](/images/2008/02/08.png) [![Ubuntu Install 09](/images/2008/02/09.thumbnail.png)](/images/2008/02/09.png) [![Ubuntu Install 10](/images/2008/02/10.thumbnail.png)](/images/2008/02/10.png) [![Ubuntu Install 11](/images/2008/02/11.thumbnail.png)](/images/2008/02/11.png) [![Ubuntu Install 12](/images/2008/02/12.thumbnail.png)](/images/2008/02/12.png)

Ora abbiamo preparato il nostro disco per accogliere il sistema operativo; il Logical Volume Manager è un'astrazione che si crea "al di sopra" delle partizioni dei dischi che offre la possibilità di ridimensionare "al volo" i volumi così gestiti. Per maggiori informazioni potete leggere l'[LVM-HOWTO](http://www.tldp.org/HOWTO/LVM-HOWTO/) (purtroppo in Inglese). 
Ora è il momento di inserire il nostro nome completo, il nome dell'utente che avrà i privilegi di amministratore del sistema e la sua password che andrà ripetuta per due volte per essere sicuri che sia stata digitata sempre correttamente. Nel mio caso specifico mi viene chiesto di inserire un proxy HTTP per poter verificare sui server Ubuntu la presenza di eventuali aggiornamenti rispeto a quanto installato da CD.
[![Ubuntu Install 14](/images/2008/02/14.thumbnail.png)](/images/2008/02/14.png) [![Ubuntu Install 15](/images/2008/02/15.thumbnail.png)](/images/2008/02/15.png) [![Ubuntu Install 17](/images/2008/02/17.thumbnail.png)](/images/2008/02/17.png)

[![Ubuntu Install 19](/images/2008/02/19.thumbnail.png)](/images/2008/02/19.png) Siamo ormai quasi alla fine del processo di installazione... ancora pochi particolari e il nostro nuovo server Ubuntu sarà pronto.  In questa schermata viene chiesto se l'orologio di sistema (quello del BIOS per intenderci) sia o meno in UTC: generalmente l'orologio di sistema andrebbe impostato su UTC (l'ora di Greenwich per intendersi) e poi spetta al sistema operativo correggere l'orologio del BIOS con le informazioni sul fuso orario di appartenenza fornite in fase di installazione. [![Ubuntu Install 20](/images/2008/02/20.thumbnail.png)](/images/2008/02/20.png)Fornita anche quest'ultima informazione il sistema completa l'installazione e ormai siamo pronti per riavviare il server e sfruttare le potenzialità della nuova Ubuntu 8.04 Hardy Heron.. Ora spazio alla fantasia e alla proprie necessità... da qui in avanti spetta a ciascuno di noi decidere cosa fare del proprio nuovo server.

[![EmailOttuzziGoogle](/images/2008/02/ottuzzigoogle.png)](mailto:ottuzzi@gmail.com)
