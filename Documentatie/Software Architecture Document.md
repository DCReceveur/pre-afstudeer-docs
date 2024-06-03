# Software Architecture Document

Binnen dit overzicht wordt aan de hand van het c4 model voor software architectuur documentatie een globaal overzicht gegeven van het geplande Project Management Portal.

## Context

```plantuml

actor Klant
actor Admin

rectangle "Productive API" as productive
rectangle "Messaging system" as message
rectangle "Project management portal" as PMP
' rectangle "PMP database" as BE_DB
Klant --> PMP : "Manages projects in                           "
Admin --> PMP : "Validates tasks in           "

PMP --> productive : "Retrieves project data from"
' PMP --> BE_DB : "Caches project data in"
PMP --> message : "Informs customers using"

```

### Project Management Portal

Levert op vraag informatie aan de gebruikers over de projecten en taken zoals beschikbaar op de productive.io API.

### Productive API

Houdt de huidige staat van binnen Bluenotion uitgevoerde projecten bij. Deze API en de achter liggende database dient als de single point of truth van het PMP systeem.

### Messaging system

Verantwoordelijk voor het op de hoogte stellen van gebruikers als er acties ondernomen moeten worden. Voorbeelden zijn:

- Een taak die gereviewd moet worden
- Een critical of blocking issue

### PMP Database

Omdat de Productive API rate limited is en er mogelijk data over projecten dient opgeslagen te worden die niet binnen productive beschikbaar is wordt gebruik gemaakt van een (voor de API) lokale database om opgevraagde data te cachen en overige data op te slaan.

## Containers

```plantuml

actor Klant
actor Admin

rectangle PMP{
rectangle "React front-end" as PWA
rectangle "PMP API" as API
rectangle "PMP DB" as DB
rectangle "PMP Services" as Service
}

rectangle "Notification system" as NS
rectangle "Productive.io API" as PR_API

Klant --> PWA : HTTP(S)/JSON
Admin --> PWA : HTTP(S)/JSON
PWA --> API : HTTP(S)/JSON
Service --> DB : MS Entity framework
API-->Service
Service --> PR_API : HTTP(S)/JSON
Service --> NS : SMPT?

```

## Components

### React front-end

TODO: Lijntjes fixen

TODO: De echte views hier in zetten.

```plantuml
top to bottom direction
skinparam linetype ortho

rectangle "React front-end"{
    rectangle "View" as view{
        rectangle "Admin" as Admin{
            rectangle "AdminProjectView"
            rectangle "AdminProjectDetailView"
            rectangle "AdminTaskDetailView"
            rectangle "AdminCommentsView"
        }
        rectangle "Customer" as Customer{
            rectangle "CustomerProjectView"
            rectangle "CustomerProjectDetailView"
            rectangle "CustomerTaskDetailView"
            rectangle "CustomerCommentsView"
        }
        rectangle "Partials" as Partials{
            rectangle "ProjectsPartial"
            rectangle "ProjectDetailsPartial"
            rectangle "TaskDetailPartial"
            rectangle "CommentsPartial"   
        }
    }

    rectangle "Generated API" as GeneratedAPI{
        rectangle "Generated Controllers"
        rectangle "Generated Models"
    }

    view-->GeneratedAPI
    Admin-->Partials : uses
    Customer-->Partials : uses
}
```

#### Toelichting FE componenten

| Component | Uitleg |
|---|---|
| **View** | In de front-end zijn de views van MVC hetgeen dat data (uit de models) laat zien en interactie aanbiedt met de rest van het systeem (via de controllers) |
| **Admin** | Om meer zekerheid te bieden dat de klant niet "per ongeluk" in de admin omgeving terecht komt worden er aparte views aangemaakt met de functionaliteiten voor de Bluenotion Administrator (ACT2) |
| **Customer** | Binnen de Customer views worden de functionaliteiten voor de externe klant (ACT1) met betrekking tot het tonen van data geïmplementeerd. |
| **Partials** | Binnen de components worden generieke views gemaakt die onafhankelijk zijn van de gebruiker of die door de betreffende customer of admin views worden aangevuld. |
| **Generated API** | De generated API is de OpenAPI representatie van de back-end. Deze wordt automatisch gegenereerd en is functioneel gelijk aan de [PMP API](#pmp-api) |

### PMP API

TODO: lijntjes
TODO: is de productive sync controller een goed patroon? kan beter?

```plantuml
rectangle "PMP API"{
    rectangle "Controllers"{
        rectangle "AccountController"
        rectangle "ProjectController"
        rectangle "TaskController"
        rectangle "CommentController"
        rectangle "ProductiveSyncController"
    }
    rectangle "Models"{
        rectangle "InputModels"
    }
    Controllers --> Models : uses
}

```

#### Toelichting API componenten



| Component | Uitleg |
|---|---|
| **Controllers**  | De controllers zijn verantwoordelijk voor het beschikbaar stellen van de juiste RESTful endpoints en het op basis van deze endpoints aanspreken van de juiste services om een antwoord terug te kunnen geven.  |
| **AccountController**  | Verantwoordelijk voor endpoints met betrekking tot inloggen of account management  |
| **ProjectController**  | Verantwoordelijk voor endpoints met betrekking tot Projecten of project management  |
| **TaskController**  | Verantwoordelijk voor endpoints met betrekking tot Taken of taak management  |
| **CommentController**  | Verantwoordelijk voor endpoints met betrekking tot Comments op taken (bijlages?). |
| **ProductiveSyncController** | Verantwoordelijk voor endpoints met betrekking tot communicatie met de Productive API en de bijhorende webhooks. |
| **Models** | De Models zijn de objecten waar daadwerkelijk data voor de gebruiker in zit. |
| **InputModels**  | De InputModels zijn data objecten die worden gebruikt als input voor de REST controllers.  |

TODO: Discussie over endpoints op maat voor bepaalde views of CRUD endpoints en sorteren en filteren op de frontend.

TODO: Waarom in Api.Bluenotion.NL.Models alleen maar Input models?

### PMP Services

TODO: interface names?

```plantuml
top to bottom direction
interface "IPersistence" as if1
interface "INotification" as if2
interface "IProductive" as if3

rectangle "PMP Services"{
    rectangle "Persistence service" as pes
    rectangle "Notification service" as ns
    rectangle "Productive service" as prs
}

if1 --> pes
if2 --> ns
if3 --> prs
prs --> pes

```

#### Toelichting Service componenten

| Component | Uitleg |
|---|---|
| Persistence service  | Verantwoordelijk voor het afhandelen van database access, dit wordt een laag waarschijnlijk gebaseerd op entity framework TODO: ADR maken |
| Notification service  | Verantwoordelijk voor het inlichten van de gebruiker van het systeem bij bijvoorbeeld password resets of ingestelde notificaties TODO: rewrite na confirmatie notificatie ding in FO  |
| Productive service  | Deze service is verantwoordelijk voor het synchroniseren van de lokale database met productive en anders om.  |

TODO: rename productive service?
TODO: Zou het beter zijn productive service op te splitten naar taakservice, projectservice ect? Hierdoor kunnen de services gebruikt worden om voor beiden de sync en "dagelijks gebruik".

### PMP DB

Een database systeem gebaseerd op MySQL en ms Entity Framework waar data van productive wordt gecached zodat niet voor elke door de gebruiker van het PMP gemaakte request een request naar de Productive API gedaan hoeft te worden.

TODO: database model?

### Notification system

### Productive API

## Code

### Productive API sync

Om te garanderen dat het PMP alle data weergeeft dat in productive aanwezig is dient er op een zeker moment data opgehaald te worden vanuit de Productive API. Binnen dit hoofdstuk worden een aantal opties voor deze synchronisatie gegeven met de voor en nadelen van de aanpakken.

<table>
  <tr>
    <th>Reads</th>
    <th>Writes</th>
  </tr>
  <tr>
    <td>
    - Use local db only, db should be synced by way of webhooks

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
title Added task webhook sync
autonumber
participant ProductiveSyncController as prod_sync
' participant TaskController as task
participant ProductiveService as prod_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db
' database Productive_API as prod_api

?-> prod_sync : webhook message
prod_sync --> prod_serv: processSyncRequest(message)
prod_serv --> pers_serv : addTask(task)
pers_serv --> pmp_db : insert...

```

</td>
<td>
    
- Write to local db and send to Productive directly

```plantuml
title Add task from pmp
autonumber
participant TaskController as task
participant ProductiveService as prod_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db
database Productive_API as prod_api

?-> task : UI request
task -> prod_serv : addTask(TaskInfo)
prod_serv -> pers_serv : addTask(TaskInfo)
pers_serv -> pmp_db : INSERT...
prod_serv -> prod_api : HTTP POST*

```

*Zie [Productive API](https://developer.productive.io/tasks.html#tasks)
</td>
  </tr>
  <tr>
    <td>
    
- Use productive API call at time of request

```plantuml
title getTasks 'direct'
autonumber
participant TaskController as task
participant ProductiveService as prod_serv
database Productive_API as prod_api

?-> task : UI request
task --> prod_serv : getTasks(projectId)
prod_serv -->prod_api : http GET*

```

*Zie [Productive API](https://developer.productive.io/tasks.html#tasks)
</td>
    <td>
    - Write to local and sync on timer

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
' participant TaskController as task
participant PersistenceService as pers_serv
database PMP_database as pmp_db
database Productive_API as prod_api

?-> prod_sync : cron job sync
prod_sync -> prod_serv : syncLocalChanges
prod_serv -> pers_serv : lc = getLocalChanges
pers_serv -> pmp_db : select where synced=0

prod_serv -> prod_api : HTTP POST bulk*
prod_serv -> pers_serv : setToSynced(lc)**
pers_serv -> pmp_db : UPDATE/DELETE...
```

*[Bulk post](https://developer.productive.io/index.html#header-content-negotiation) nooit gedaan, moet getest worden of dit überhaupt een optie is
**Dit zou ook kunnen gebeuren als de gesynchroniseerde items terug komen via de webhook

TODO: verantwoording dat je in dit geval de "niet gesynchroniseerde" data gecombineerd moet worden met A. de productive API data of B. de lokale data verzameld aan de hand van webhooks of REST requests.
    </td>
  </tr>
  <tr>
  <td></td>
  <td>
  - Write to local staging/changes table, mark as synced at notice webhook

```plantuml
title Bulk sync tasks
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

  </td>

  </tr>
</table>

For reads:

#### 'Lokale' reads



#### 'Remote' reads


For writes:

#### Direct write


#### Timed bulk write





Can a bad sync happen, how would you notice and how would you solve it?

## Architectural Decision Records

```plantuml

rectangle "ADR001-O2-Continu synchroniserende backend database aan de hand van Webhooks" as ADR001o2 #Orange
rectangle "ADR002-O1-React native" as ADR002 #Green
rectangle "ADR003-O1-asp.net core" as ADR003 #Green
rectangle "ADR004-Database system-O1-SQL" as ADR004 #Orange

legend left
    | Color | Status |
    |<#Orange>| Proposed |
    |<#Green>| Accepted |
    |<#Red>| Rejected |
    | <#LightSlateGray> | Deprecated |
    | <#Maroon> | Superseded by |
endlegend

```

### ADR001-Communicatie met de Productive API

**Status:** Proposed

**Context:**

Voor de development teams wordt Productive gebruikt voor het project beheer, het Project Management Portal biedt de klant en de PM inzicht in en communicatie met deze Productive omgeving. Voor de development teams dient het werkproces niet aangepast te worden.

**Decision:** O2-Continu synchroniserende backend database aan de hand van Webhooks

Om de meest recente data te tonen uit productive terwijl de schaalbaarheid wordt behouden is gekozen gebruik te maken van de [Productive.io webhooks](https://developer.productive.io/webhooks.html#webhooks). Hiermee zou data automatisch gesynchroniseerd kunnen worden naar de back-end database vanuit waar (zonder verdere rate limits) de data verspreid kan worden naar verschillende gebruikers van het PMP.

**Consequences:**

- Door de back-end aan de hand van webhooks te synchroniseren ben je afhankelijk van de update rate van de webhooks. Dit is nog niet getest maar het zou kunnen dat hier een delay op zit die groter is dan een "handmatige" request bij een REST endpoint.

- Mocht de PMP back-end om wat voor reden niet dan ook geen OK status code terug sturen naar de webhook worden er door Productive nog 11 keer (over 12 uur) een poging gedaan de data te sturen. In het geval dat het PMP in deze tijd niet reageert zou er data in Productive staan die niet in het PMP aanwezig is en dus gesynchroniseerd moet worden.

- Webhooks zijn rate limited met 1000 requests per 5 min.

**Alternatives:**

- ADR001-O1: Continu synchroniserende backend database aan de hand van REST calls

Om de meest recente data te garanderen is het mogelijk bij elke aanvraag die gedaan wordt bij het PMP een synchronisatie request te sturen naar Productive.

- ADR001-O3: Data synchronisatie on request

Productive biedt de mogelijkheid [bulk requests](https://developer.productive.io/index.html#header-content-negotiation) te doen. Dit zou gebruikt kunnen worden om op aanvraag de back-end database te synchroniseren met de informatie zoals beschikbaar op Productive.

- ADR001-O4: Directe communicatie met productive zonder caching

Technisch gezien is voor de data over projecten en taken geen back end database nodig als de data direct van Productive's API gehaald wordt. Hiermee is het PMP [gelimiteerd aan 100 requests per 10 seconden](https://developer.productive.io/index.html#header-rate-limits) en dit biedt weinig flexibiliteit in data transformatie of implementatie van niet productive gerelateerde functionaliteit als het toevoegen van documentatie ([FR7](./FunctioneelOntwerp.md#fr71-openendownloaden-document)) of een service overview ([FR6](FunctioneelOntwerp.md#fr61-inzien-lijst-van-project-dependencies) ) in een project.

### ADR002-Front end framework

**Status:** Proposed

**Context:**

Voor het presenteren van de data aan de gebruiker is een front end nodig.

**Decision:** O1-React native

Om de ontwikkeling van de front end te vereenvoudigen is gekozen voor React Native.

**Consequences:**

Door React native te gebruiken wordt de applicatie gebouwd met standaarden en inhouse kennis van Bluenotion.

### ADR003-Back end framework

**Status:** Proposed

**Context:**
Om data aan te leveren aan de frontend dienen (REST?) API endpoints opgezet te worden.

**Decision:** O1-asp.net core

Binnen Bluenotion wordt hiervoor doorgaans een implementatie aan de hand van ASP.NET core voor aangeleverd.

**Consequences:**

Door de back end API te bouwen aan de hand van ASP.NET core wordt de applicatie gebouwd met standaarden en inhouse kennis van Bluenotion.

### ADR004-Database system

**Status:** Proposed

**Context:**

Er zijn verschillende database systemen beschikbaar om data voor het PMP op te slaan.

**Decision:** O1-SQL

**Consequences:**

Door een reguliere MySQL database te gebruiken kan eenvoudig gebruik gemaakt worden van Entity Framework als ORM.

**Alternatives:**

- O2-NoSQL
- O3-Graph

### ADR005-Database-ORM

<!-- Niet echt architectural significant -->

**Status:** Proposed

**Context:**

Om interacties met de database te vereenvoudigen kan een ORM gebruikt worden.

**Decision:**

**Consequences:**

### ADR006-Frontend backend Communicatie

<!-- Ook niet echt een ASR... -->

**Status:** Proposed

**Context:**
Om de communicatie tussen de front en backend te faciliteren wordt gebruik gemaakt van de OpenAPI client generators.

**Decision:**

**Consequences:**

### ADR007-MVC Design pattern

<!-- En deze is wel een ASR maar heeft een slechte reden om te bestaan. -->

**Status:** Proposed

**Context:**

Het PMP dient zo opgezet te worden dat de software onderhoudbaar is en zodat collega's er in de toekomst op verder kunnen bouwen. Hiervoor dient een standaard design pattern gebruikt te worden.

**Decision:**

Om de code onderhoudbaar te houden wordt gebruik gemaakt van het [MVC pattern](https://www.geeksforgeeks.org/mvc-design-pattern/).

**Consequences:**

- Code wordt gescheiden naar data, UI en logica (Separation of Concerns)
