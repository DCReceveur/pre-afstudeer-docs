# ADR001-Communicatie met de Productive API

## **Status:** Proposed

## **Context:**

Voor de development teams wordt Productive gebruikt voor het project beheer, het Project Management Portal biedt de klant en de PM inzicht in en communicatie met deze Productive omgeving. Voor de development teams dient het werkproces niet aangepast te worden.

## **Decision:**

### O5 Direct polling with cache

Er kan gebruik gemaakt worden van een cache met een tijd waarna records verlopen. Data over taken of projecten kan aan de hand van webhooks of direct polling opgehaald en weggeschreven worden waarna het PMP pas nieuwe data gaat ophalen zodra data voor een bepaalde tijd niet meer is ververst. Hiermee wordt het dubbel ophalen van data als er bijvoorbeeld van het dashboard naar een project wordt genavigeerd voorkomen.

```puml
title GET /tickets via /dependencies
autonumber
participant TicketController as ticket_ctrl
participant TicketRepository as ticket_repo
participant ProductiveApiClient as prod_api
database "PMP Database" as PMP_DB
database "Productive Database" as prod_db

[->ticket_ctrl : GET
ticket_ctrl -> ticket_repo : getTicketListForProject(project_id)
ticket_repo -> PMP_DB : tickets = getTicketsForProject(project_id)
loop foreach ticket in tickets
  alt now() - ticket.updated_at > 1 min
    ticket_repo -> ticket_repo : taskIds = List.add(ticket.getProductiveId)
  end
end
alt taskIds > 0
  ticket_repo -> prod_api : taskModels = getDependencies(taskIds)
  prod_api -> prod_db : "GET /dependencies&filter[task_id]=taskIds"
  ticket_repo -> PMP_DB : updateTickets(taskModels)
end
ticket_repo -> ticket_repo : response = tickets.toTicketRowItemModel()
ticket_repo -> ticket_ctrl : response
[<-ticket_ctrl : JSON
```

```puml
title GET /projects
autonumber
participant projectController as project_ctrl
'participant projectService as project_serv
participant projectRepository as project_repo
participant ProductiveApiClient as prod_api
database "PMP Database" as PMP_DB
database "Productive Database" as prod_db

[->project_ctrl : GET
project_ctrl -> project_repo : getProjects(customerId)
  alt now() - project.updated_at > 1 min
    project_repo -> prod_api : getProjects() // After date toevoegen?
    prod_api -> prod_db : GET /projects
  end

project_repo -> PMP_DB : update
project_repo -> project_ctrl : projects
```

Hier zijn nog een aantal keuzes in te maken:

- Verschillende procedures voor lezen en schrijven?

A: Vermoedelijk heeft schrijven voorrang over lezen zodat er binnen Productive zo min mogelijk met oude data gewerkt wordt.

- Een queue binnen de API client die in geval van te veel requests naar de Productive API requests later stuurt

ProductiveApiClient blijft dom* data naar Productive sturen tot er een antwoord terug komt die meldt dat de rate limits bereikt zijn. Hierna worden alle schrijf requests verzameld en later verstuurd. Read requests gooien een exception naar de FE?

*Schrijf operaties eerst?

- Hoe bepaal je de tijd na wanneer de data dirty is?

A: Dynamisch aan de hand van drukte? Standaard tijds limiet?

- Cache in het geheugen of in de database?

Geheugen kunnen dingen in verdwijnen in het geval dat het systeem uit valt. Een gebruiker zou dan kunnen denken een wijziging gemaakt te hebben die later niet meer terug te vinden is in het PMP.

Database is trager en er moet op gelet worden dat deze cache data die nog niet in Productive staat niet verward wordt met data die al wel naar Productive is verstuurd.

- Background sync procedure voor de cache?

Afhankelijk van de hoeveelheid projecten en taken zou er een background sync aangemaakt kunnen worden die de cache periodiek ververst.

```puml
title add task with error
autonumber
participant projectController as project_ctrl
'participant projectService as project_serv
participant projectRepository as project_repo
participant ProductiveApiClient as prod_api
database "PMP Database" as PMP_DB
database "Productive Database" as prod_db


```

## **Consequences:**

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

- Correctheid geschreven data

Als er taken worden aangemaakt binnen het PMP dienen dienen deze vastgelegd te worden in Productive. Afhankelijk van waar de aan de gebruiker getoonde informatie vandaan komt (Productive of lokale db) dient deze data direct gesynchroniseerd te worden of kan dit op een later moment gebeuren.

- Niet reageren webhook

Mocht de PMP back-end om wat voor reden niet dan ook geen OK status code terug sturen naar de webhook worden er door Productive nog 11 keer (over 12 uur) een poging gedaan de data te sturen. In het geval dat het PMP in deze tijd niet reageert zou er data in Productive staan die niet in het PMP aanwezig is en dus gesynchroniseerd moet worden.

- Initiële dataset

Omdat er aan de hand van webhooks enkel nieuwe data wordt gesynchroniseerd tussen Productive en het PMP dient er voor een oplossing aan de hand van webhooks nagedacht te worden over een procedure van het binnenhalen van een initiële dataset.



## **Alternatives:**

### O1: Directe communicatie met productive

Technisch gezien is voor de data over projecten en taken geen back end database nodig als de data direct van Productive's API gehaald wordt. Hiermee is het PMP [gelimiteerd aan 100 requests per 10 seconden](https://developer.productive.io/index.html#header-rate-limits) en dit biedt weinig flexibiliteit in data transformatie of implementatie van niet productive gerelateerde functionaliteit als het toevoegen van documentatie ([FR7](../../Functioneel/Requirements/FR7_Inzien_project_documentatie.md)) of een service overview ([FR6](../../Functioneel/Requirements/FR6_Inzien_project_service_statuses.md) ) in een project.

### O2-Continu synchroniserende backend database aan de hand van Webhooks

Om de meest recente data te tonen uit productive terwijl de schaalbaarheid wordt behouden is gekozen gebruik te maken van de [Productive.io webhooks](https://developer.productive.io/webhooks.html#webhooks). Hiermee zou data automatisch gesynchroniseerd kunnen worden naar de back-end database vanuit waar (zonder verdere rate limits) de data verspreid kan worden naar verschillende gebruikers van het PMP.

#### Data uitlezen

In dit geval zou het PMP bij bijvoorbeeld het opvragen van taken die bij een project horen enkel met zijn eigen database communiceren.

{%
    include-markdown "../../UML/Technisch/Sequence/ADR001_gettasks_local.md"
%}

<!-- TODO: Zijn gets nodig om via een service te doen? Is het netter de controller direct met de repositories te laten praten of heeft de service laag hier toch een rol in?

Terminologie opzoeken transparant vs non-transparant layers of iets dergelijks 

redenering: Binnen BN worden voornamelijk open lagen gebruikt waar de controllers voor simpele lees acties direct met de repositories werken.
-->

#### Data wijzigen binnen productive

Indien via het PMP een wijziging wordt doorgevoerd zoals het toevoegen van een taak of comment of het wijzigen van een status komt dit binnen bij het PMP en wordt de PMP database bijgewerkt.

{%
    include-markdown "../../UML/Technisch/Sequence/ADR001_addtask_via_prod.md"
%}

#### Data wijzigen binnen het PMP

Als via het PMP een wijziging wordt doorgevoerd kan deze direct of op een rustig moment doorgestuurd worden naar Productive. Met het op het moment verwachtte gebruik van het PMP zou een directe synchronisatie waarschijnlijk* de betere optie zijn.

*Deze mening is puur gebaseerd op het redundant wegschrijven van data en [NFR2.1](../../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) en [NFR8.2](../../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) zonder verdere uitgebreide redenatie of onderzoek.

{%
    include-markdown "../../UML/Technisch/Sequence/ADR001_addtask_via_PMP_with_prod_insert.md"
%}

<!-- TODO: Procedure voor retries bij error of direct error tonen aan gebruiker?

TODO: Change diagram exception

TODO: bovenstaande procedure is sequentieel, het is beter als het parallel kan. Toch eerst PMP commit en rollback procedure opzetten? -->

#### Synchronisatie bevestiging

Een resultaat van het ontkoppelen van de PMP database en de Productive database (alle opties hier besproken behalve [O1](#o1-directe-communicatie-met-productive) waar "direct" met Productive gecommuniceerd wordt) is dat de twee datasets mogelijk andere data bevatten. Eén punt waarop dit binnen de gemaakte sequence diagrammen is bij het [wijzigen van data binnen Productive](#data-wijzigen-binnen-productive) waar een periode bestaat waar data wel in Productive bestaat maar niet in de PMP database. Bij het wijzigen van data binnen het PMP zou een soort gelijke scenario voor kunnen komen als het toevoegen/wijzigen van data binnen Productive om wat voor reden dan ook (te veel requests, verbinding problemen of authenticatie problemen?) data niet door de Productive API geaccepteerd wordt. Een deel van de scenario's waar in data niet wordt gesynchroniseerd zou afgevangen kunnen worden door voor binnen het PMP aangemaakte wijzigingen bij te houden of de resulterende webhook (of http response code) ook weer is binnengekomen op de synchronisatie service. Hierdoor zouden problematische records in ieder geval gedetecteerd kunnen worden.

### O3: Timed data synchronisatie

Productive biedt de mogelijkheid [bulk requests](https://developer.productive.io/index.html#header-content-negotiation) te doen. Dit zou gebruikt kunnen worden om op aanvraag de back-end database te synchroniseren met de informatie zoals beschikbaar op Productive.

{%
    include-markdown "../../UML/Technisch/Sequence/ADR001_addtask_via_PMP_without_prod_insert.md"
%}

{%
    include-markdown "../../UML/Technisch/Sequence/ADR001_bulk_sync_tasks.md"
%}

**Dit zou ook kunnen gebeuren als de gesynchroniseerde items terug komen via de webhook

<!-- TODO: verantwoording dat je in dit geval de "niet gesynchroniseerde" data gecombineerd moet worden met A. de productive API data of B. de lokale data verzameld aan de hand van webhooks of REST requests. -->

### O4: Change based polling

Productive biedt een "[Activities](https://developer.productive.io/activities.html#activities)" endpoint aan waar wijzigingen in het Model van productive opgevraagd kunnen worden op basis van taak, project of bedrijf met ingebouwde filters evenementen voor of na een bepaalde datum. Door wanneer data over een bepaald project nodig is zou in de lokale database gekeken kunnen worden wanneer hier de laatste activiteit in is geweest. Deze activiteit is weg te schrijven in de lokale database en kan getoond worden aan de gebruiker.

{%
    include-markdown "../../UML/Technisch/ADR001_Activity_change_based_polling.md"
%}

Aan de hand van deze procedure stuur je per pagina op zijn minst één request naar de productive Activities endpoint en één request naar de PMP database. Als aan de hand van de activities alle data ingeladen kan worden is met één request naar de PMP database en twee naar productive (met één enkel naar Activities zie je het verschil tussen geen activity en geen project niet) gegarandeerd worden dat je werkt met de meest recente versie van een project en de bijbehorende taken.

Uitdagingen:

- Het toevoegen van bijlages lijkt niet terug te komen in de activities maar wel de last activity van het project.
- Activities omzetten naar objecten als projecten en taken zou uitdagend kunnen zijn
- Het is mogelijk dat enkel de meest recent geüpdatet data in de activities lijst komen en dus alsnog naderhand data opgehaald moet worden van productive om alle informatie aan de gebruiker te kunnen tonen.

<!-- ### O5 Direct polling with cache

Er kan gebruik gemaakt worden van een cache met een tijd waarna records verlopen. Data over taken of projecten kan aan de hand van webhooks of direct polling opgehaald en weggeschreven worden waarna het PMP pas nieuwe data gaat ophalen zodra data voor een bepaalde tijd niet meer is ververst. Hiermee wordt het dubbel ophalen van data als er bijvoorbeeld van het dashboard naar een project wordt genavigeerd voorkomen.

{%
    include-markdown "../../UML/Technisch/Sequence/ADR001_gettasks_with_cache.md"
%} -->

<!-- ## Open vragen -->

<!-- [ ] De bulk requests zoals beschreven in [optie 4](#o4-change-based-polling) heb ik persoonlijk nooit gebruikt en in de [Productive FAQ](https://developer.productive.io/faq.html#faq) wordt gesproken over dat er geen bulk insert bestaat voor create budget/deals. Mij is het vooralsnog onduidelijk of dit inhoudt dat er enkel voor de budget en deals endpoints geen bulk inserts gedaan kunnen worden of dat er api breed enkel bulk update en deletes gedaan kunnen worden. -->

<!-- [ ] [O2:](#o2-continu-synchroniserende-backend-database-aan-de-hand-van-webhooks) Bij het toevoegen van data voor Productive binnen het PMP is er een periode dat de data wel in het PMP zou kunnen staan zonder dat er via de webhooks het toegevoegde item binnen zou komen. In de sequence diagram van het aangegeven hoofdstuk wordt bijgehouden of verschillende items gesynchroniseerd zijn aan de hand van verificatie na de webhook maar hier is geen strikte eis voor. Is er wens naar een dergelijke functionaliteit of is dit onnodige bij bedachte complexiteit? -->

<!-- [ ] Zoals bij de diagram voor [data wijzigen binnen het PMP](#data-wijzigen-binnen-het-pmp) besproken zou er nagedacht kunnen worden over een rollback procedure van incorrecte of niet verwerkte data in plaats van data sequentieel weg te schrijven. In de ideale situatie zouden alle stappen binnen TaskService.AddTask(TaskInfo) asynchroon uitvoerbaar zijn terwijl de transactie not atomair is. -->

## Toevoegingen

- De ProductiveApiClient die aanvragen verstuurd naar Productive als iets gewijzigd moet worden is gelimiteerd aan de 100 requests per 10 seconden waar de Productive API. Indien het PMP boven deze 100 requests uit komt dient het systeem hier netjes mee om te gaan. In de huidige setup zou dit de vorm aan nemen van een queue die berichten stuurt naar de Productive API die indien er door Productive het bericht wordt gegeven dat de rate limits bereikt zijn de wijzigingen bewaart en op een rustiger moment verwerkt.

## History

| Date | Status |
|---|---|
| 04-09-2024 | O2: Proposed |
| 05-09-2024 | O2: Rejected due to Productive plan limitations |
| 05-09-2024 | O5: Proposed |
