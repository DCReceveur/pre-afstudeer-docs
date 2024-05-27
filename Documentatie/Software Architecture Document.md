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

## Architectural Relevant Decisions

### ADR1: Productive data caching
