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

rectangle Browser{
component "React front-end" as PWA
}

component PMP{
component "PMP API" as API
component "PMP Database" as DB
component "PMP Services" as Service
}

rectangle "Notification system" as NS
database "Productive.io API" as PR_API

Klant --> PWA : HTTP(S)/JSON
Admin --> PWA : HTTP(S)/JSON
PWA --> API : HTTP(S)/JSON
Service --> DB : MS Entity framework
API-->Service
Service --> PR_API : HTTP(S)/JSON
PR_API -[norank]-> API : HTTP(S)/JSON via webhooks
Service --> NS : SMTP?

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
| **Generated API** | De generated API is de OpenAPI representatie van de back-end. Deze wordt [automatisch gegenereerd](https://openapi-generator.tech/) en is functioneel gelijk aan de [PMP API](#pmp-api) |

### PMP API

Het PMP API component is verantwoordelijk voor het beheer van de verschillende REST endpoints. De logica in dit component dient beperkt te worden tot configuratie van de endpoints, het afhandelen van role based autorisatie en model validatie.

```plantuml
rectangle "PMP API"{
    rectangle "Controllers"{
        rectangle "AccountController"
        rectangle "ProjectController"
        rectangle "TaskController"
        rectangle "CommentController"
        rectangle "ProductiveSyncController"
    }
    rectangle Models
}
    rectangle "Services"{
    }
    Controllers --> Services : uses
    Controllers --> Models : uses

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
| **Models**  | De Models zijn data objecten die worden gebruikt voor data transfer tussen verschillende componenten. Later in dit document wordt [per laag toelichting](#pmp-database--data-models) gegeven op de models.  |

TODO: Discussie over endpoints op maat voor bepaalde views of CRUD endpoints en sorteren en filteren op de frontend.

### PMP Services

De service laag is verantwoordelijk voor de business logica, [transformeren van input naar database models](#databasemodels) en het coördineren van "externe" verbindingen.

TODO: Je hebt sync service toegevoegd maar de rest van het hoofdstuk is nog niet bijgewerkt. Toch ook de repositories in de service laag toevoegen?

TODO: afhankelijk van de input van de webhooks zou de sync service gebruik kunnen maken van de productive services.

```plantuml
top to bottom direction
interface "IPersistence" as if1
interface "INotification" as if2
interface "IProductive" as if3
interface "ISync" as if4

rectangle "PMP Services"{
    rectangle "Persistence service" as pes
    rectangle "Notification service" as ns
    rectangle "Productive services" as prs{
        rectangle AccountService
        rectangle TaskService
        rectangle ProjectService
        rectangle CommentService
    }
    rectangle "Sync service" as sync
}

if1 --> pes
if2 --> ns
if3 --> prs
if4 --> sync
prs --> pes
sync --> pes

```

#### Toelichting Service componenten

| Component | Uitleg |
|---|---|
| Persistence service  | Verantwoordelijk voor logica betreft het opslaan en opvragen van data. Denk hierbij aan vertaling tussen input/output en database model, autorisatie en filtering. |
| Notification service  | Verantwoordelijk voor het inlichten van de gebruiker van het systeem bij bijvoorbeeld password resets of ingestelde notificaties TODO: rewrite na confirmatie notificatie ding in FO  |
| Productive services  | Deze service is verantwoordelijk voor het synchroniseren van de lokale database met productive en anders om.  |
| Sync service | Deze service is verantwoordelijk voor het opzetten van de Productive webhooks en het uitvoeren van de "clean sync" |

##### Regular sync

Eén belangrijke rol van de Productive service is het coördineren van de synchronisatie tussen het PMP en Productive. Zoals [hier](#productive-api-sync) toegelicht wordt er gebruik gemaakt van webhooks om op de hoogte gebracht te worden van wijzigingen binnen Productive. Normaliter komt hierdoor synchronisatie data binnen op de [hier boven genoemde 'ProductiveSyncController'](#toelichting-api-componenten). Deze webhooks dienen door de sync service opgezet te worden.

##### Clean sync

Ook is er een procedure nodig voor als de synchronisatie om wat voor reden dan ook mis loopt (denk langdurige uitval Productive/PMP, first time setup of 'corrupte' database data) waardoor het PMP zich zonder webhooks kan herstellen naar een werkende staat die overeen komt met de data die beschikbaar is op Productive. Aangezien deze actie veel data nodig heeft van productive zal deze procedure waarschijnlijk dermate veel tijd en requests kosten dat hij enkel als nood oplossing uitgevoerd dient te worden.

Als toelichting op dit punt is gekeken naar hoe "duur" het ophalen van alle taak data is. Op het moment van schrijven komen er 27060 resultaten binnen op het [tasks endpoint](https://developer.productive.io/tasks.html#tasks). Met een maximale [pagina grootte](https://developer.productive.io/index.html#header-pagination) van 200 items op een pagina zijn er 136 requests nodig alle taak data binnen te halen. Over één request (van maximale pagina grootte) doet Productive 2.82 seconden om reactie te geven met een response size van 499 KB. Met volledig gebruik van de rate limits zoals beschreven in [ADR001](./Decisions/ADR001-Communicatie_met_de_Productive_API.md) van 100 requests per 10 sec zou deze procedure met de huidige Productive data best case scenario op zijn minst 10 seconden en waarschijnlijk significant langer duren.

TODO: rename productive service?
TODO: Zou het beter zijn productive service op te splitten naar taakservice, projectservice ect? Hierdoor kunnen de services gebruikt worden om voor beiden de sync en "dagelijks gebruik".

### PMP Database & Data models

De database package is verantwoordelijk voor het low level beheer van de database verbinding en het database model. De verbinding en communicatie met de database wordt afgehandeld aan de hand van MS Entity Framework.

Aangezien er op verschillende plekken van dit document over "het model" gesproken wordt is een kleine toelichting van welke models welke rollen hebben binnen het systeem. In de software zullen binnen de API, Services en Database packages aparte models te vinden zijn:

```plantuml

rectangle API.Models{
        rectangle AddCustomerModel as cm1
        rectangle SearchProjectModel as sp1
        rectangle UpdateTaskListModel as ut1
        rectangle DeleteTaskModel as dt1
}

rectangle Services.Models{
        rectangle CustomerModel as cm2ß
        rectangle ProjectModel as sp2
        rectangle TasklistModel as ut2
        rectangle TaskModel as dt2
}

rectangle Database.Models{
        rectangle Customer as cm3
        rectangle Project as sp3
        rectangle Tasklist as ut3
        rectangle Task as dt3    
}

note "API input" as n1
note "API output" as n2
note "Database model" as n3

API.Models .right. n1
Services.Models .right. n2
Database.Models .right. n3

cm1-->cm2
cm2-->cm3

sp1-->sp2
sp2-->sp3

ut1-->ut2
ut2-->ut3


dt1-->dt2
dt2-->dt3

```

Gevraag:

Welke models heb je nodig?

Endpoint input models
Endpoint output models
Database model
Productive input model?

#### API.Models

De classes onder API.Models dienen als input [DTOs](https://en.wikipedia.org/wiki/Data_transfer_object) voor de verschillende REST controllers. Binnen deze models wordt aan de hand van [ASP.NET Validatie attributen](https://learn.microsoft.com/en-us/aspnet/core/mvc/models/validation?view=aspnetcore-8.0#validation-attributes) de back-end validatie gedaan om er zeker van te zijn dat er geen vreemde data naar de API wordt gestuurd.

#### Services.Models

De classes onder Services.Models dienen als output [DTOs](https://en.wikipedia.org/wiki/Data_transfer_object) voor de verschillende REST controllers.

TODO: De database models dienen ook als output?...

#### Database.Models

Binnen de classes van het database.Models package wordt aan de hand van annotaties de Entity Framework verbinding op gezet. Hierdoor worden wijzigingen in het datamodel meegenomen met het versiebeheer wat het potentieel terug vinden (of draaien) van problemen eenvoudiger maakt.

TODO: is niet smart

Navragen: in het template project hebben de controllers een dependency op database.models om de database classes te gebruiken als return type. Na gesprek met Niels is me verteld dat er doorgaans geen dependency is tussen de controller en de database models maar al deze communicatie via de services loopt. Zou het netter zijn deze dependency te verwijderen en enkel Services.Models te gebruiken als output?

### Notification system

### Productive API

## Code

### Productive API sync

Om te garanderen dat het PMP alle data weergeeft dat in productive aanwezig is dient er op een zeker moment data opgehaald te worden vanuit de Productive API. Binnen dit hoofdstuk worden een aantal opties voor deze synchronisatie gegeven met de voor en nadelen van de aanpakken.

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
