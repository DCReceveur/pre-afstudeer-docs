# Software Architecture Document

Binnen dit overzicht wordt aan de hand van het c4 model voor software architectuur documentatie een globaal overzicht gegeven van het geplande Project Management Portal.

## Context

```plantuml

actor Klant
actor Admin

rectangle "Project Management Portal" as PMP
rectangle "Productive API" as productive
rectangle "Back end database" as BE_DB
rectangle "Messaging system" as message
rectangle "React frontend" as FE

Klant --> FE : "Manages projects in                           "
Admin --> FE : "Validates tasks in           "

FE --> PMP : "Front-end for           "

PMP --> productive : "Retrieves project data from"
PMP --> BE_DB : "Caches project data in"
PMP --> message : "Informs customers using"

```

### React frontend

De front end wordt gemaakt aan de hand van React. De front-end dient enkel al

### Project Management Portal

### Productive API

### Back end database

### Messaging system

## Containers

## Components

## Code

## Architectural Relevant Decisions

### ADR1: Productive data caching
