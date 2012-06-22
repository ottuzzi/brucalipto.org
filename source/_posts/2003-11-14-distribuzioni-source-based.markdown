---
date: '2003-11-14 11:52:10'
layout: post
slug: distribuzioni-source-based
status: publish
comments: true
title: Distribuzioni source-based
wordpress_id: '3'
categories:
- linux
tags:
- Gentoo
- LFS
- Sorcerer Linux
---

In questo articolo introdurremo le distribuzioni source-based, specificheremo quali sono i loro punti di forza, le loro debolezze e soprattutto le differenze rispetto alle più blasonate distribuzioni classiche (RedHat , Mandrake, SuSE, etc.).


## Come funzionano le distribuzioni classiche


Quando parliamo di una distribuzione classica, generalmente insieme al nome, specifichiamo la versione della stessa (RedHat 7.3, Mandrake 8.2, etc.), indicando così non solo la società, ma anche il momento in cui tutti i pacchetti software che la compongono sono stati "congelati".
Questo modus operandi semplifica enormemente l'utilizzo per l'utente finale che si ritrova con un insieme di pacchetti software, certificati dal creatore della distribuzione, che lavorano e interagiscono tra loro senza problemi. E' frequente tra le distribuzioni maggiori, che un buon numero di programmi sia modificato secondo le esigenze del produttore stesso affinchè le varie componenti del sistema si integrino perfettamente.
Tutto questo ha perr un costo: ci si ritrova con un sistema sicuramente stabile, ma difficile da aggiornare e ottimizzato per una macchina standard che fa da comune denominatore tra il maggior numero di combinazioni hardware possibili.
Per concludere, la difficoltà di aggiornamento di tali sistemi è dato sia dalla personalizzazione di tanti software, come precedentemente spiegato, sia dalla possibilità di non poter installare eventuali tools di sviluppo.
A questo punto qualora si cerchi di aggiornare "manualmente" il sistema, ci si perderà in un mare di dipendenze, problema fondamentalmente a carico della società creatrice della distribuzione.


## Come funzionano le distribuzioni source-based


Quando si parla di distribuzioni source-based si parla di sistemi basati sulla compilazione diretta del codice sorgente di ogni pacchetto.
Come si potrà facilmente immaginare, a questo punto non si può più parlare di versione della distribuzione, in quanto essa stessa è un divenire che si evolve nel tempo.
Ovviamente questo approccio offre diversi svantaggi e alcune complicazioni rispetto all'approccio classico delle distribuzioni più famose: il sistema rischierà di non funzionare se si inserirà una versione di un software incompatibile con altre precedentemente installate e comunque tutto ciò è sicuramente più impegnativo dell'installazione di un sistema certificato.
Altrettanto evidenti sono comunque i vantaggi di questo approccio: un sistema così composto sarà ottimizzato per l'hardware su cui girerà, sfruttandone tutte le potenzialità (esempio: tutte le distribuzioni classiche sono al più compilate per processori Pentium quando sul mercato questi ultimi sono ormai scomparsi a favore dei più prestanti Athlon e Pentium III e IV).
Per finire, si può far notare come la manutenzione di un sistema così strutturato obblighi ad una profonda conoscenza del sistema operativo e di tutte le possibilità di configurazione dello stesso per poter sfruttare fino all'ultimo hertz il processore.
Passeremo ora in rassegna le più famose distribuzioni source-based e mettendo in evidenza le loro differenze e i loro punti di forza.


## LFS (Linux From Scratch)


Questa distribuzione è più che altro una guida alla costruzione della distribuzione stessa; non esiste infatti nessuna distribuzione liberamente scaricabile con questo nome, ma dopo una breve ricerca su google si trova un manuale, chiamato appunto LFS.
LFS non è una distribuzione utilizzabile su un sistema "pulito", in quanto per installarla è necessario un sistema Linux già funzionante.
Effettivamente lo scopo primario di LFS non è l'installazione e l'utilizzo del sistema operativo Linux, quanto l'insegnamento su come crearlo partendo da zero.
Oltre alla possibilità di scaricare il manuale, sul sito si trovano tutti i pacchetti necessari alla creazione del sistema (gcc, bash, glibc, etc).
Tra i lati negativi di questa distribuzione non possiamo non segnalare la difficoltà ad aggiornare tale sistema, capacità che va effettivamente oltre gli obiettivi di tale distribuzione.


## Gentoo Linux


Nato come progetto di uno degli sviluppatori di Stampede Linux (distribuzione incentrata sulla compilazione ottimizzata per Pentium ma ormai defunta), Gentoo è ormai nella classifica delle dieci distribuzioni Linux più famose secondo le statistiche di DistroWatch.
Questa distribuzione offre una delle ISO più piccole in assoluto da scaricare via Internet (circa una quindicina di MB), in accordo con lo spirito di tutte queste distribuzioni secondo cui bisogna scaricare i pacchetti che si vogliono installare solo quando necessario.
Alla base del sistema di gestione dei pacchetti di Gentoo, si trova Portage un sistema che registra l'anagrafica di tutto ciò che è installato o che si può installare, le relative versioni e ciò che conta di più le dipendenze.
Arma vincente di Portage è l'essere stato scritto in un linguaggio di script (python) che ne ha reso facile lo sviluppo e il mantenimento mano a mano che la base di utenza e di pacchetti si è allargata. Per ogni pacchetto che si vuole installare esistono le opportune istruzioni (ebuild) che interpretate da Portage installano, disinstallano e aggiornano il pacchetto desiderato.


## Sorcerer Linux


Sorcerer Linux è nato come il progetto di un sistemista che aveva bisogno di un metodo efficente ed efficace per tenere aggiornati i sistemi che doveva amministrare.
Per questo motivo si è scritto un sistema di gestione dei programmi installati, ovviamente compilati ogni volta dal loro sorgente, in bash, la celeberrima shell di linux.
Per migliorare il tutto ha dato un connotato magico alla sua soluzione dove il sistemista era il mago (Wizard), per installare un programma bisognava lanciare un'incantesimo (cast) etc etc.
Purtroppo l'inventore di questa distribuzione non è mai stato molto abile in pubbliche relazioni e, schiacciato dalla popolarità che stava assumendo la sua "creatura", ha pensato bene di distruggerla: appena venuto a conoscenza di un fork della stessa (Lunar Linux) ha cancellato tutte le copie delle ISO presenti sui server pubblici.
Per fortuna la GPL, la licenza sotto cui era nata la distribuzione Sorcerer Linux, permetteva un fork e per questo motivo si è formata un'altra distribuzione del nome SourceMage GNU Linux.
Per quanto riguarda Sorcerer Linux è rinata ma sotto un'altra licenza che esplicitamente vieta la nascita di progetti dalla sua stessa base ma il danno fatto dalla divisione in tre di questa idea ha compromesso le sue possibilità di diffusione.
Per quanto riguarda Lunar Linux e SourceMage non c'è molto da dire se non che partendo dalla stessa base di codice hanno molte delle caratteristiche in comune con Sorcerer che vista la sua semplicità di gestione è sicuramente (insieme ai suoi fork) una distribuzione da consigliare.


## Pro e contro delle distribuzioni Source-Based


Dire se le distribuzioni source-based siano il miglior approccio possibile o meno al mondo Linux è veramente difficile e come in tutte le cose bisogna fare dei distinguo.
C'è comunque da sottolineare come questa nuova idea abbia cambiato le carte in tavola rispetto al mondo fossilizzato delle distribuzione dove il mercato è ormai diviso tra i soliti grandi nomi: l'idea è sicuramente interessante ma ci sembra alquanto difficile costruire un modello di business profittevole vendendo una distribuzione sempre automaticamente aggiornata.
Tutti i progetti che abbiamo elencato sono basati esclusivamente sul lavoro di volontari che non hanno alla spalle una società che deve avere dei profitti e per questo motivo forse sono un pr più instabili delle distribuzioni più famose. Basti vedere il caso di Debian, anche lei costruita sul lavoro di migliaia di volontari, che non riesce a produrre una release stabile della sua distribuzione da diversi anni.

Passiamo ora ad elencare alcuni punti che possono aiutare a scegliere quale distribuzione installare:


## Distribuzioni classiche:

* poca esperienza del mondo Linux;
* fretta di avere un sistema funzionante;
* provare Linux;
* un connessione ad Internet lenta.

## Distribuzioni Source-based:

* sistemista esperto;
* voglia di avere un sistema sempre aggiornato ed ottimizzato;
* connessione ad Internet a banda larga;
* voglia di essere sempre "al limite".