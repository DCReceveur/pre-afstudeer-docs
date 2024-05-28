# Software Architecture Document

Binnen dit overzicht wordt aan de hand van het c4 model voor software architectuur documentatie een globaal overzicht gegeven van het geplande Project Management Portal.

## Context

```plantuml

actor Klant
actor Admin

rectangle "Productive API" as productive
rectangle "Messaging system" as message
rectangle "Project management portal" as PMP
rectangle "PMP database" as BE_DB
Klant --> PMP : "Manages projects in                           "
Admin --> PMP : "Validates tasks in           "

PMP --> productive : "Retrieves project data from"
PMP --> BE_DB : "Caches project data in"
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
}

rectangle "Notification system" as NS
rectangle "Productive.io API" as PR_API

Klant --> PWA : HTTP(S)
Admin --> PWA : HTTP(S)
PWA --> API : HTTP(S)
API --> DB : MS Entity framework
API --> PR_API : HTTP(S)
API --> NS

```

## Components

## Code

## Architectural Decision Records

```plantuml

rectangle "ADR001-O2-Continu synchroniserende backend database aan de hand van Webhooks" as ADR001o2 #Orange
rectangle "ADR002-O1-React native" as ADR002 #Orange
rectangle "ADR003-O1-asp.net core" as ADR003 #Orange
rectangle "ADR004-Database system-O1-SQL" as ADR004 #Orange

' ADR001o1 --> ADR001o2 : Alternative for
' ADR001o3 --> ADR001o2 : Alternative for
' ADR001o4 --> ADR001o2 : Alternative for

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

Door een reguliere SQL database te gebruiken kan eenvoudig gebruik gemaakt worden van Entity Framework als ORM.

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


