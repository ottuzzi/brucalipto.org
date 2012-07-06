---
date: '2003-11-14 13:44:02'
layout: post
slug: il-firewall-per-cellulare
status: publish
comments: true
title: Il firewall per cellulare
wordpress_id: '5'
categories:
- unclassified
tags:
- Cellulare
- firewall
---

Quante volte abbiamo desiderato che certe persone non ci disturbassero attraverso il nostro caro e amato telefono cellulare???


## L'idea


Ero in vacanza da qualche parte (non ricordo dove) e sono stato "disturbato" dal mio capo che voleva chiedermi qualcosa (era così importante che non ricordo cosa fosse). La richiesta non era così pressante ma la sola idea di poter essere rintracciato sul telefono personale per motivi non strettamente personali mi disturbava. Possibile che non ci sia una soluzione, che non prevede l'uso di 2 cellulari, per evitare tale scocciatura?
A questo punto sono rimasto folgorato da un'idea: il firewall per cellulare. Prendendo spunto dal noto dispositivo di sicurezza per reti di calcolatori ho pensato che lo stesso principio si può applicare al cellulare. Ovviamente andranno fatte delle modifche e il concetto andrà semplificato ma l'idea è quella.
Eccovi una prima idea di implementazione:



	
  * andranno definite delle aree (ES: 'verde', 'gialla', 'rossa');

	
  * la zona 'verde' conterrà i numeri per cui vogliamo sempre essere raggiungibili (moglie, mamma, etc);

	
  * la zona 'gialla' conterrà i numeri per cui a volte non vorremmo essere raggiungibili (amante, etc);

	
  * la zona 'rossa' conterrà i numeri per cui 'raramente' vorremo essere raggiungibili (vedi paragrafo iniziale);

	
  * se si accettano le telefonate della zona 'rossa' si accetteranno anche quelle della zona 'gialla';

	
  * se non si accettano le telefonate della zona 'gialla' non si accetteranno neppure quelle della zona 'rossa';

	
  * ogni volta che si riceve una telefonata che sarà bloccata dal firewall il cellulare ce lo farà sapere con un 'SMS fake' (cioè finto, creato ad hoc dal cellulare per il suo stesso sistema di gestione SMS).


Credo che questo sia sufficiente per dare l'idea di cosa intendo, ora rimane solo ai grandi costruttori implementare questa idea che sicuramente sarà gradita ai più.
