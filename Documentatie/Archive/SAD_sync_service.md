##### Sync service

De sync service is verantwoordelijk voor het opzetten en verwerken van de productive synchronisatie data. Synchronisatie gebeurt aan de hand van twee verschillende methodes:

###### Regular sync

Eén belangrijke rol van de Productive service is het coördineren van de synchronisatie tussen het PMP en Productive. Zoals [hier](#productive-api-sync) toegelicht wordt er gebruik gemaakt van webhooks om op de hoogte gebracht te worden van wijzigingen binnen Productive. Normaliter komt hierdoor synchronisatie data binnen op de [hier boven genoemde 'ProductiveSyncController'](#toelichting-api-componenten). Deze webhooks dienen door de sync service opgezet te worden.

<!-- TODO: setup webhooks toevoegen! -->

###### Clean sync

Ook is er een procedure nodig voor als de synchronisatie om wat voor reden dan ook mis loopt (denk langdurige uitval Productive/PMP, first time setup of 'corrupte' database data) waardoor het PMP zich zonder webhooks kan herstellen naar een werkende staat die overeen komt met de data die beschikbaar is op Productive. Aangezien deze actie veel data nodig heeft van productive zal deze procedure waarschijnlijk dermate veel tijd en requests kosten dat hij enkel als nood oplossing uitgevoerd dient te worden.

Als toelichting op dit punt is gekeken naar hoe "duur" het ophalen van alle taak data is. Op het moment van schrijven komen er 27060 resultaten binnen op het [tasks endpoint](https://developer.productive.io/tasks.html#tasks). Met een maximale [pagina grootte](https://developer.productive.io/index.html#header-pagination) van 200 items op een pagina zijn er 136 requests nodig alle taak data binnen te halen. Over één request (van maximale pagina grootte) doet Productive 2.82 seconden om reactie te geven met een response size van 499 KB. Met volledig gebruik van de rate limits zoals beschreven in [ADR001](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md) van 100 requests per 10 sec zou deze procedure met de huidige Productive data best case scenario op zijn minst 10 seconden en waarschijnlijk significant langer duren.

<!-- TODO: rename productive service? -->

<!-- TODO: Zou het beter zijn productive service op te splitten naar taakservice, projectservice ect? Hierdoor kunnen de services gebruikt worden om voor beiden de sync en "dagelijks gebruik". -->