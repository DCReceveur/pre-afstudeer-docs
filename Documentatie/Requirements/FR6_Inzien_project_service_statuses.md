# FR6: Inzien project service statuses

Deze functional requirements hebben betrekking tot het inzien van verschillende dependencies en services die geleverde projecten nodig hebben om te functioneren. Enkele voorbeelden van deze services en dependencies zijn een database, proxy, backup service, web/app server, virtuele machines.

## FR6.1: Inzien lijst van project dependencies

Het zien van welke dependencies een project nodig heeft (databases, proxies, algemene infra)

| FR6.1 | Inzien lijst van project dependencies |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT1: Externe klant  |
| Stakeholders |  |
| Pre condities | Een klant heeft een project in het PMP|
| Post condities | De klant ziet het overzicht van de dependencies/infra |
| Triggers | Op aanvraag van Externe klant |
| Exceptions |  |
| Open issues | Hoe het overzicht van dependencies wordt weergegeven is nog niet vastgesteld. Voor de basis implementatie wordt gewerkt met een lijst van service namen (xyz database, xyz webserver, xyz proxy....) |

### FR6.1: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | De klant geeft aan de dependencies/services van een project te willen zien* |  |
| 2 |  | Toont een lijstje met de namen van verschillende services aan de gebruiker. |
| 3 |  |  |
| 4 |  |  |
| 5 |  |  |

*Afhankelijk van de hoeveelheid informatie die al op het scherm aanwezig is kan deze informatie mogelijk gewoon op de project detail pagina.

### FR6.1: Alternative flow - Er zijn geen services aan het project gekoppeld

|Stap | Actor | System |
|---|---|---|
| 2A |  | Toont een lege service lijst |

## FR6.2: Inzien huidige status (online/offline) project dependencies

Het zien van welke dependencies een project nodig heeft (databases, proxies, algemene infra) met live status

| FR6.2 | Inzien huidige status (online/offline) project dependencies |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders |  |
| Pre condities | Een klant heeft een project in het PMP. </br>Aan het project is een overzicht van de dependencies/infra.</br>Het overzicht heeft voor elke service een hostname, ip adres of andere online identifier. |
| Post condities | De klant ziet het overzicht van dependencies/infra met een indicator of de service online is. |
| Triggers | Op aanvraag van Externe klant |
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

## FR6.3: Beheren project services

TODO: fully dressed versie uitwerken.

De admin handelingen voor het beheer van de dependencies.

| FR6.3 | Beheren project services |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT2: Bluenotion admin |
| Stakeholders | ACT1: Externe klant |
| Pre condities | Er is een project toegevoegd aan het PMP |
| Post condities | Er is een service gekoppeld aan het project |
| Triggers | Op aanvraag van Bluenotion admin |
| Exceptions |  |
| Open issues | Zie [FR6.1](#fr61-inzien-lijst-van-project-dependencies) |

### FR6.3: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Kiest een project waar een wijziging moet gebeuren in de services |  |
| 2 |  | Toont de lijst met gekoppelde services als beschreven in [FR6.1](#fr61-inzien-lijst-van-project-dependencies) |
| 3 | Kiest een service geeft aan deze bij te willen werken |  |
| 4 |   | Toont een lijst aan gegevens die bij te werken zijn voor deze service (hostname/ip & servicenaam) |
| 5 | Past gegevens aan en geeft aan wijzigingen door te willen voeren  |   |
| 6 |  | Slaat de wijzigingen op in de lokale database |

### FR6.3: Alternative flow - service toevoegen

|Stap | Actor | System |
|---|---|---|
| 3A | Geeft aan een service toe te willen voegen |  |
| 4A |   | Toont een lijst aan gegevens nodig voor het toevoegen van een service (hostname/ip & servicenaam)  |
| 5A | Vult de gegevens in en geeft aan wijzigingen door te willen voeren  |   |
| 6  |  | Resume main flow stap 6 |

### FR6.3: Alternative flow - service verwijderen

|Stap | Actor | System |
|---|---|---|
| 3B | Kiest een service en geeft aan deze te willen verwijderen |  |
| 4B |  | Vraagt om bevestiging of de gebruiker de service "servicenaam" wilt verwijderen |
| 5B | Bevestigt het verwijderen van de service uit het project |  |
| 6 |  | Resume main flow stap 6 |
