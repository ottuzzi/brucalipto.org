---
date: '2004-04-08 14:28:45'
layout: post
slug: p2p-e-firme-digitali
status: publish
comments: true
title: P2P e firme digitali
wordpress_id: '6'
categories:
- unclassified
tags:
- firma digitale
- P2P
---

                        Prima degli ultimi attacchi dei vari organismi di controllo sui copyright (SIAE, RIAA, MPAA)                         verso le reti P2P il problema maggiore era il conoscere il contenuto/valore di ciò                         che si stava scaricando prima di finire il download.


## Cosa si può fare?


Parlando con i miei colleghi è nata l'idea di introdurre le firme digitali                         nel mondo del P2P. La firma digitale non risolve alla radice il problema di sapere                         cosa e, soprattutto, la qualità di cosa si sta scaricando ma permette di                         crearsi una rete di fiducia (web of trust) di contenuti firmati da persone                         che condividono materiale di buona qualità.
Facciamo qualche esempio:




  * cerco l'ultimo album di Madonna;


  * ottengo tre risultati (R1, R2, R3) con tre firme digitali diverse (F1, F2, F3);


  * ne scelgo uno (R1) e lo scarico;


    * se mi va bene quello che ho scaricato dichiaro che i contenuti firmati allo stesso modo di R1 (la firma F1 in questo caso) sono tutti di buona qualità;


    * se NON mi va bene quello che ho scaricato dichiaro che i contenuti firmati allo stesso modo di R1 (la firma F1 in questo caso) sono tutti di scarsa qualità;





  * continuo ad usare emule come al solito valutando di volta in volta la qualità                         delle firme associate ai files che scarico preferendo di volta in volta le firme che avevo già                         considerato affidabili.


Dopo un po' di tentativi ci si costruirà una lista di firme certe di condividere contenuti di qualità.


## Una applicazione


Il programma di filesharing emule ha già in se un primitivo sistema di firma digitale (MD5 se non sbaglio): ogni file che circola sulla rete e-donkey ha un identificativo univoco (hash) ed addirittura i file stessi vengono spezzati in più parti ed ognuna di esse ha il suo hash.
A quanto si può notare già gran parte dell'infrastruttura necessaria è                         disponibile: basta sostituire gli hash dei files (e dei segmenti di files) con l'hash ricavato                         firmandoli digitalmente. Ognuno che si appresta a condividere qualcosa deve avere la propria                         coppia di chiavi (pubblica/privata) e firmare con la chiave privata il contenuto (e i singoli segmenti                         del contenuto stesso): il risultato della firma è il nuovo hash che circolerà sulla rete                         di P2P.


## Conclusioni


A questo punto risulta chiaro il quadro: nel momento che dobbiamo scegliere cosa scaricare                         ci possiamo affidare alle firme digitali che contraddistinguono files che offrono "a vista"                         lo stesso contenuto ma che in realtà potrebbero nascondere "sgradevoli" sorprese.

[![Ottuzzi Email](http://localhost/wordpress/wp-content/uploads/2008/02/ottuzziemail.png)](mailto:ottuzzi@gmail.com)
