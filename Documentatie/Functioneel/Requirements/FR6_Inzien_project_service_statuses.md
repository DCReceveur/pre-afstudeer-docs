# FR6: Inzien project service statuses

Deze functional requirements hebben betrekking tot het inzien van verschillende dependencies en services die geleverde projecten nodig hebben om te functioneren. Enkele voorbeelden van deze services en dependencies zijn een database, proxy, backup service, web/app server, virtuele machines.

## FR6.1: Inzien lijst van project dependencies

User story: Als externe beheerder wil ik alle informatie over mijn te bouwen/gebouwde systeem op één centrale plek bekijken.

Het zien van welke dependencies een project nodig heeft (databases, proxies, algemene infra)

| FR6.1 | Inzien lijst van project dependencies |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT1: Externe beheerder  |
| Stakeholders |  |
| Pre condities | Een klant heeft een project in het PMP|
| Post condities | De klant ziet het overzicht van de dependencies/infra |
| Triggers | Op aanvraag van Externe beheerder |
| Exceptions |  |
| Open issues | Hoe het overzicht van dependencies wordt weergegeven is nog niet vastgesteld. Voor de basis implementatie wordt gewerkt met een lijst van service namen (xyz database, xyz webserver, xyz proxy....) |

### FR6.1: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | De klant geeft aan de dependencies/services van een project te willen zien* |  |
| 2 |  | Toont een lijstje met de namen van verschillende services aan de gebruiker. |

TODO: *Afhankelijk van de hoeveelheid informatie die al op het scherm aanwezig is kan deze informatie mogelijk gewoon op de project detail pagina.

### FR6.1: Alternative flow - Er zijn geen services aan het project gekoppeld

|Stap | Actor | System |
|---|---|---|
| 2A |  | Toont een lege service lijst |

## FR6.2: Inzien huidige status (online/offline) project dependencies

User story: Als externe beheerder wil ik alle informatie over mijn te bouwen/gebouwde systeem op één centrale plek bekijken.

Het zien van welke dependencies een project nodig heeft (databases, proxies, algemene infra) met live status

| FR6.2 | Inzien huidige status (online/offline) project dependencies |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT1: Externe beheerder |
| Stakeholders |  |
| Pre condities | Een klant heeft een project in het PMP. </br>Aan het project is een overzicht van de dependencies/infra.</br>Het overzicht heeft voor elke service een hostname, ip adres of andere online identifier. |
| Post condities | De klant ziet het overzicht van dependencies/infra met een indicator of de service online is. |
| Triggers | Op aanvraag van Externe beheerder |
| Exceptions |  |
| Open issues | Zie [FR6.1](#fr61-inzien-lijst-van-project-dependencies) |

### FR6.2: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan de dependencies/services van een project te willen zien |  |
| 2 |  | Toont een lijstje met de namen van verschillende services aan de gebruiker |
| 3 |  | Vraagt aan de services of ze online zijn |
| 4 |  | Toont het resultaat van de 'vraag' aan de gebruiker |
| 5 |  |  |
