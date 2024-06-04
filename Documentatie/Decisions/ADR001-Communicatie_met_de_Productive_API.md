# ADR001-Communicatie met de Productive API

## **Status:** Proposed

## **Context:**

Voor de development teams wordt Productive gebruikt voor het project beheer, het Project Management Portal biedt de klant en de PM inzicht in en communicatie met deze Productive omgeving. Voor de development teams dient het werkproces niet aangepast te worden.

## **Decision:**

### O2-Continu synchroniserende backend database aan de hand van Webhooks

Om de meest recente data te tonen uit productive terwijl de schaalbaarheid wordt behouden is gekozen gebruik te maken van de [Productive.io webhooks](https://developer.productive.io/webhooks.html#webhooks). Hiermee zou data automatisch gesynchroniseerd kunnen worden naar de back-end database vanuit waar (zonder verdere rate limits) de data verspreid kan worden naar verschillende gebruikers van het PMP.

```plantuml
title getTasks 'local'
autonumber
participant TaskController as task
participant PersistenceService as pers_serv
' participant ProductiveService as prod_serv
database PMP_database as pmp_db
' database Productive_API as prod_api

?-> task : UI request
task --> pers_serv : getTasks(projectId)
pers_serv --> pmp_db : SELECT....

```

```plantuml
title Sync tasks via webhook
autonumber
participant ProductiveSyncController as prod_sync
participant TaskController as task
participant ProductiveService as prod_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db
database Productive_API as prod_api

' ?-> prod_sync : cron job sync
' prod_sync -> prod_serv : syncLocalChanges
[->task : UI request(TaskInfo)
task -> prod_serv : addTask(TaskInfo)
prod_serv -> pers_serv : addTask(TaskInfo)
pers_serv -> pmp_db : insert into NotSynced
prod_serv -> prod_api: HTTP POST

[-> prod_sync : webhook message
prod_sync -> prod_serv : processSyncRequest(message)
prod_serv -> pers_serv : addTask(TaskInfo) 
pers_serv -> pmp_db : update Synced
```


## **Consequences:**

Belangrijke aspecten om rekening mee te houden tijdens de synchronisatie:

- Productive rate limits

| **Type**  | REST API calls | REST API calls 'reports' endpoint | Webhook |
|---|---|---|---|
| **Limiet**  | [100 requests per 10 sec](https://developer.productive.io/webhooks.html#webhooks) | [10 requests per 30 sec](https://developer.productive.io/webhooks.html#webhooks) | [1000 per 5 minutes](https://developer.productive.io/webhooks.html#header-rate-limits) |
| **Fout resultaat** | HTTP response 429 Too Many Requests | HTTP response 429 Too Many Requests | email notificatie |

Er wordt binnen de Productive API documentatie gesproken over bulk requests. De documentatie is niet heel duidelijk hoe deze bulk requests gebruikt kunnen worden maar voor acties die veel data nodig hebben zoals een eventuele state check (zie correctheid en actualiteit van de gelezen data) of de initiële database populatie zouden bulk requests gebruikt kunnen worden.

- Reactietijd

Het ophalen, filteren en transformeren van data van externe APIs is iets dat (relatief) veel tijd kan kosten. Door op de achtergrond de database te synchroniseren en "tijdens het gebruik van het PMP" data enkel uit de PMP database op te halen kan de hoeveelheid round trips tijdens gebruik verminderen.

- Correctheid en actualiteit van de gelezen data

Afhankelijk van waar de data die aan de gebruiker geleverd wordt vandaan komt zou het kunnen dat (in het geval van een lokale database) de data verouderd is of incorrect/niet overeenkomend met productive is weggeschreven.

NAVRAGEN: Er dient een procedure opgezet te worden waarin wordt gekeken naar de productive database en deze state A. wordt vergeleken met de huidige db state of B. de huidige db state wordt overschreven.

- Correctheid geschreven data

Als er taken worden aangemaakt binnen het PMP dienen dienen deze vastgelegd te worden in Productive. Afhankelijk van waar de aan de gebruiker getoonde informatie vandaan komt (Productive of lokale db) dient deze data direct gesynchroniseerd te worden of kan dit op een later moment gebeuren.

- Niet reageren webhook

Mocht de PMP back-end om wat voor reden niet dan ook geen OK status code terug sturen naar de webhook worden er door Productive nog 11 keer (over 12 uur) een poging gedaan de data te sturen. In het geval dat het PMP in deze tijd niet reageert zou er data in Productive staan die niet in het PMP aanwezig is en dus gesynchroniseerd moet worden.

## **Alternatives:**

### O1: Directe communicatie met productive zonder caching

Technisch gezien is voor de data over projecten en taken geen back end database nodig als de data direct van Productive's API gehaald wordt. Hiermee is het PMP [gelimiteerd aan 100 requests per 10 seconden](https://developer.productive.io/index.html#header-rate-limits) en dit biedt weinig flexibiliteit in data transformatie of implementatie van niet productive gerelateerde functionaliteit als het toevoegen van documentatie ([FR7](./FunctioneelOntwerp.md#fr71-openendownloaden-document)) of een service overview ([FR6](FunctioneelOntwerp.md#fr61-inzien-lijst-van-project-dependencies) ) in een project.

```plantuml
title getTasks 'direct'
autonumber
participant TaskController as task
participant ProductiveService as prod_serv
database Productive_API as prod_api

?-> task : UI request
task --> prod_serv : getTasks(projectId)
prod_serv -->prod_api : http GET

```

### O3: Timed data synchronisatie

Productive biedt de mogelijkheid [bulk requests](https://developer.productive.io/index.html#header-content-negotiation) te doen. Dit zou gebruikt kunnen worden om op aanvraag de back-end database te synchroniseren met de informatie zoals beschikbaar op Productive.

```plantuml
title Add task from pmp
autonumber
participant TaskController as task
participant ProductiveService as prod_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db


?-> task : UI request
task -> prod_serv : addTask(TaskInfo)
prod_serv -> pers_serv : addTask(TaskInfo)
pers_serv -> pmp_db : INSERT...
```

```plantuml
title Bulk sync tasks
autonumber
participant ProductiveSyncController as prod_sync
participant ProductiveService as prod_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db
database Productive_API as prod_api

?-> prod_sync : cron job sync
prod_sync -> prod_serv : syncLocalChanges
prod_serv -> pers_serv : lc = getLocalChanges
pers_serv -> pmp_db : select where synced=0

prod_serv -> prod_api : HTTP GET bulk*
prod_serv -> pers_serv : setToSynced(lc)**
pers_serv -> pmp_db : UPDATE/DELETE...
```

*[Bulk post](https://developer.productive.io/index.html#header-content-negotiation) nooit gedaan, moet getest worden of dit überhaupt een optie is
**Dit zou ook kunnen gebeuren als de gesynchroniseerde items terug komen via de webhook

TODO: verantwoording dat je in dit geval de "niet gesynchroniseerde" data gecombineerd moet worden met A. de productive API data of B. de lokale data verzameld aan de hand van webhooks of REST requests.