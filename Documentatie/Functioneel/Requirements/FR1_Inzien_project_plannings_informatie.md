# FR1: Inzien project plannings informatie

Deze functional requirements betreffen het inzien van de globale informatie over één of meerdere projecten voor ACT1: Externe beheerder.

## FR1.1: Inzien projecten

User story: Als Bluenotion admin wil ik een eenduidig overzicht van alle projecten die lopen binnen Bluenotion zodat ik snel de status met een klant kan bespreken.

| FR1.1 | Inzien projecten  |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe beheerder |
| Stakeholders | PM, TL, SD |
| Pre condities | De klant kan inloggen in het PMP. |
| Post condities | De klant heeft een lijst met de voor hem beschikbare projecten. |
| Triggers | De klant vraagt de lijst met voor hem beschikbare projecten op |
| Exceptions |  |
| Open issues | Data verzamelen: Wie is de klant, wat zijn zijn projecten? |

### FR1.1: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Vraagt de lijst met alle beschikbare projecten op |  |
| 2 |  | Toont alle voor de klant beschikbare projecten |

### <a id=FR1.1></a>FR1.1: Alternative flow - no projects for customer

|Stap| Actor | System |
|---|---|---|
| 2A |  | Toont geen projecten omdat er geen projecten aan de klant gekoppeld zijn. |

## FR1.2: Inzien totaal geplande uren+kosten

User story: Als externe beheerder wil ik een overzicht van het geplande werk zodat ik zicht kan houden op de ontwikkeltijd en kosten.

FR1.2 wordt niet geïmplementeerd na beslissing zoals vastgelegd in [FDR001](../FDRs/FDR001-Tijd-en-kosten-niet-tonen.md)

| FR1.2 | Inzien totaal geplande uren+kosten  |
|---|---|
| Prioriteit | Won't have [FDR002](../FDRs/FDR002-Tenant-level-chat.md)  |
| Primaire Actor | ACT1: Externe beheerder |
| Stakeholders |  |
| Pre condities | De klant is aangemeld in het PMP </br> De klant heeft op zijn minst één project in het PMP. |
| Post condities | De klant heeft een overzicht van de op het moment openstaande hoeveelheid uren en de kosten hiervan bij een project.  |
| Triggers | De klant opent het project overview |
| Exceptions |  |
| Open issues |  |

### FR1.2: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Opent de project overview van een van zijn projecten |  |
| 2 |  | Toont de actuele tijd en kosten planning |

### FR1.2: Alternative flow - Geen uren ingepland op het project

|Stap | Actor | System |
|---|---|---|
| 2 |  | Toont de actuele tijd en kosten planning als 0 |
