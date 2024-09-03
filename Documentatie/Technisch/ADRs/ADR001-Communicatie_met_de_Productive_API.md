# ADR001-Communicatie met de Productive API

## **Status:** Proposed

## **Context:**

Voor de development teams wordt Productive gebruikt voor het project beheer, het Project Management Portal biedt de klant en de PM inzicht in en communicatie met deze Productive omgeving. Voor de development teams dient het werkproces niet aangepast te worden.

## **Decision:**

### O2-Continu synchroniserende backend database aan de hand van Webhooks

Om de meest recente data te tonen uit productive terwijl de schaalbaarheid wordt behouden is gekozen gebruik te maken van de [Productive.io webhooks](https://developer.productive.io/webhooks.html#webhooks). Hiermee zou data automatisch gesynchroniseerd kunnen worden naar de back-end database vanuit waar (zonder verdere rate limits) de data verspreid kan worden naar verschillende gebruikers van het PMP.

#### Data uitlezen

In dit geval zou het PMP bij bijvoorbeeld het opvragen van taken die bij een project horen enkel met zijn eigen database communiceren.

```puml
title getTasks 'local'
autonumber
participant TaskController as task
participant TaskService as task_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db

?-> task : UI request
task --> task_serv : getTasks(projectId)
task_serv --> pers_serv : getTasks(projectId)
pers_serv --> pmp_db : SELECT....

```

<!-- TODO: Zijn gets nodig om via een service te doen? Is het netter de controller direct met de repositories te laten praten of heeft de service laag hier toch een rol in?

TODO: Terminologie opzoeken transparant vs non-transparant layers of iets dergelijks -->

#### Data wijzigen binnen productive

Indien via het PMP een wijziging wordt doorgevoerd zoals het toevoegen van een taak of comment of het wijzigen van een status komt dit binnen bij het PMP en wordt de PMP database bijgewerkt.

```puml
title Add task via Productive
autonumber
participant ProductiveSyncController as prod_sync
participant SyncService as sync_serv
participant TaskService as task_serv
participant "PersistenceService" as pers_serv
database PMP_database as pmp_db

[-> prod_sync : webhook message
prod_sync -> sync_serv : processSyncRequest(message)
sync_serv -> task_serv : addTask(TaskInfo) 
task_serv -> pers_serv : addOrUpdate(TaskInfo)
pers_serv -> pmp_db : INSERT TaskInfo
note right 
    %autonumber%: Could be inserted/updated with "synced flag"
end note
```

#### Data wijzigen binnen het PMP

Als via het PMP een wijziging wordt doorgevoerd kan deze direct of op een rustig moment doorgestuurd worden naar Productive. Met het op het moment verwachtte gebruik van het PMP zou een directe synchronisatie waarschijnlijk* de betere optie zijn.

*Deze mening is puur gebaseerd op het redundant wegschrijven van data en [NFR2.1](../../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) en [NFR8.2](../../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) zonder verdere uitgebreide redenatie of onderzoek.

```puml
title Add task via PMP
autonumber
participant TaskController as task_ctrl
participant TaskService as task_serv
participant ProductiveService as prod_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db
database Productive_API as prod_api

[->task_ctrl : UI request(TaskInfo)
task_ctrl -> task_serv : addTask(TaskInfo)

task_serv -> prod_serv : syncTask(TaskInfo)
prod_serv -> prod_api: HTTP POST
alt http success

task_serv -> pers_serv : insertOrUpdateTask(TaskInfo)

pers_serv -> pmp_db : INSERT TaskInfo
note right 
    %autonumber%: Could be inserted/updated with "not synced flag"
end note
else http failure
prod_serv -> task_ctrl : throw SynchronizationException
end

```

<!-- TODO: Procedure voor retries bij error of direct error tonen aan gebruiker?

TODO: Change diagram exception

TODO: bovenstaande procedure is sequentieel, het is beter als het parallel kan. Toch eerst PMP commit en rollback procedure opzetten? -->

#### Synchronisatie bevestiging

Een resultaat van het ontkoppelen van de PMP database en de Productive database (alle opties hier besproken behalve [O1](#o1-directe-communicatie-met-productive) waar "direct" met Productive gecommuniceerd wordt) is dat de twee datasets mogelijk andere data bevatten. Eén punt waarop dit binnen de gemaakte sequence diagrammen is bij het [wijzigen van data binnen Productive](#data-wijzigen-binnen-productive) waar een periode bestaat waar data wel in Productive bestaat maar niet in de PMP database. Bij het wijzigen van data binnen het PMP zou een soort gelijke scenario voor kunnen komen als het toevoegen/wijzigen van data binnen Productive om wat voor reden dan ook (te veel requests, verbinding problemen of authenticatie problemen?) data niet door de Productive API geaccepteerd wordt. Een deel van de scenario's waar in data niet wordt gesynchroniseerd zou afgevangen kunnen worden door voor binnen het PMP aangemaakte wijzigingen bij te houden of de resulterende webhook (of http response code) ook weer is binnengekomen op de synchronisatie service. Hierdoor zouden problematische records in ieder geval gedetecteerd kunnen worden.

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

- Initiële dataset

Omdat er aan de hand van webhooks enkel nieuwe data wordt gesynchroniseerd tussen Productive en het PMP dient er voor een oplossing aan de hand van webhooks nagedacht te worden over een procedure van het binnenhalen van een initiële dataset.

## **Alternatives:**

### O1: Directe communicatie met productive

Technisch gezien is voor de data over projecten en taken geen back end database nodig als de data direct van Productive's API gehaald wordt. Hiermee is het PMP [gelimiteerd aan 100 requests per 10 seconden](https://developer.productive.io/index.html#header-rate-limits) en dit biedt weinig flexibiliteit in data transformatie of implementatie van niet productive gerelateerde functionaliteit als het toevoegen van documentatie ([FR7](../../Functioneel/Requirements/FR7_Inzien_project_documentatie.md)) of een service overview ([FR6](../../Functioneel/Requirements/FR6_Inzien_project_service_statuses.md) ) in een project.

<!-- TODO: Data altijd opvragen en toch wegschrijven in een lokale db zodat opgevraagde data wél altijd beschikbaar is zou een 'alternatief' kunnen zijn maar komt qua voor en nadelen redelijk overeen met O1. Zou dit een optie zijn voor wanneer Productive overbelast is? Vermoedelijk voegt het onnodige complexiteit toe zonder toevoeging van grote waarde. -->

```puml
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

```puml
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

```puml
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

prod_serv -> prod_api : HTTP GET 
prod_serv -> pers_serv : setToSynced(lc)**
pers_serv -> pmp_db : UPDATE/DELETE...
```

**Dit zou ook kunnen gebeuren als de gesynchroniseerde items terug komen via de webhook

<!-- TODO: verantwoording dat je in dit geval de "niet gesynchroniseerde" data gecombineerd moet worden met A. de productive API data of B. de lokale data verzameld aan de hand van webhooks of REST requests. -->

### O4: Change based polling

Productive biedt een "[Activities](https://developer.productive.io/activities.html#activities)" endpoint aan waar wijzigingen in het Model van productive opgevraagd kunnen worden op basis van taak, project of bedrijf met ingebouwde filters evenementen voor of na een bepaalde datum. Door wanneer data over een bepaald project nodig is zou in de lokale database gekeken kunnen worden wanneer hier de laatste activiteit in is geweest. Deze activiteit is weg te schrijven in de lokale database en kan getoond worden aan de gebruiker.

```puml

start
:get relevant project from local db;
if (Project found) then (no)
    :get project from productive;
    if(Productive contains project data)then (yes)
        :get all activities from productive*;
    else (no)
    :Show project not found;
    endif
else (yes) 
    :get Activities from productive since last local update;

    if(Activities>0) then (yes)
    :Write changes to local db;
    else (no)
    endif
endif

:show data to user;
stop

```

Aan de hand van deze procedure stuur je per pagina op zijn minst één request naar de productive Activities endpoint en één request naar de PMP database. Als aan de hand van de activities alle data ingeladen kan worden is met één request naar de PMP database en twee naar productive (met één enkel naar Activities zie je het verschil tussen geen activity en geen project niet) gegarandeerd worden dat je werkt met de meest recente versie van een project en de bijbehorende taken.

Uitdagingen:

- Het toevoegen van bijlages lijkt niet terug te komen in de activities maar wel de last activity van het project.
- Activities omzetten naar objecten als projecten en taken zou uitdagend kunnen zijn
- Het is mogelijk dat enkel de meest recent geüpdatet data in de activities lijst komen en dus alsnog naderhand data opgehaald moet worden van productive om alle informatie aan de gebruiker te kunnen tonen.

### O4: Hybrid/caching?

Er kan gebruik gemaakt worden van een cache met een tijd waarna records verlopen. Data over taken of projecten kan aan de hand van webhooks of direct polling opgehaald en weggeschreven worden waarna het PMP pas nieuwe data gaat ophalen zodra data voor een bepaalde tijd niet meer is ververst. Hiermee wordt het dubbel ophalen van data als er bijvoorbeeld van het dashboard naar een project wordt genavigeerd voorkomen.

```puml
title get by project id with cache
TicketController -> TicketService : GetTicketsByProjectId([id])
TicketService -> TicketRepository : GetByProjectId([id])
    alt "Project found && !Refresh needed"
            note right
                Refresh needed = last_synced-datetime.now>refresh_required_interval
            end note
        TicketService <- TicketRepository : Tickets
        TicketController <- TicketService : Tickets
    else "Project not found || Refresh needed"
        TicketService -> SyncService : SyncTicketsForProjects([id])
        SyncService -> TicketApiClient : GetTicketsByProjectId([id])
        SyncService -> TicketRepository : AddOrUpdateTickets(Tickets)
        TicketController <- SyncService : Tickets
end alt
```

<!-- ## Open vragen -->

<!-- [ ] De bulk requests zoals beschreven in [optie 4](#o4-change-based-polling) heb ik persoonlijk nooit gebruikt en in de [Productive FAQ](https://developer.productive.io/faq.html#faq) wordt gesproken over dat er geen bulk insert bestaat voor create budget/deals. Mij is het vooralsnog onduidelijk of dit inhoudt dat er enkel voor de budget en deals endpoints geen bulk inserts gedaan kunnen worden of dat er api breed enkel bulk update en deletes gedaan kunnen worden. -->

<!-- [ ] [O2:](#o2-continu-synchroniserende-backend-database-aan-de-hand-van-webhooks) Bij het toevoegen van data voor Productive binnen het PMP is er een periode dat de data wel in het PMP zou kunnen staan zonder dat er via de webhooks het toegevoegde item binnen zou komen. In de sequence diagram van het aangegeven hoofdstuk wordt bijgehouden of verschillende items gesynchroniseerd zijn aan de hand van verificatie na de webhook maar hier is geen strikte eis voor. Is er wens naar een dergelijke functionaliteit of is dit onnodige bij bedachte complexiteit? -->

<!-- [ ] Zoals bij de diagram voor [data wijzigen binnen het PMP](#data-wijzigen-binnen-het-pmp) besproken zou er nagedacht kunnen worden over een rollback procedure van incorrecte of niet verwerkte data in plaats van data sequentieel weg te schrijven. In de ideale situatie zouden alle stappen binnen TaskService.AddTask(TaskInfo) asynchroon uitvoerbaar zijn terwijl de transactie not atomair is. -->

## Toevoegingen

- De ProductiveApiClient die aanvragen verstuurd naar Productive als iets gewijzigd moet worden is gelimiteerd aan de 100 requests per 10 seconden waar de Productive API. Indien het PMP boven deze 100 requests uit komt dient het systeem hier netjes mee om te gaan. In de huidige setup zou dit de vorm aan nemen van een queue die berichten stuurt naar de Productive API die indien er door Productive het bericht wordt gegeven dat de rate limits bereikt zijn de wijzigingen bewaart en op een rustiger moment verwerkt.
