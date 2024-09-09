---

weight: 2

---

# FR2: Inzien taken

Deze functional requirements betreffen het inzien van informatie over en gerelateerd aan de taken die gekoppeld zijn aan het project van een klant.

## FR2.1: Inzien taken van project

User story: Als externe beheerder wil ik een overzicht van het geplande werk zodat ik zicht kan houden op de ontwikkeltijd en kosten.

| FR2.1 | Inzien taken van project |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe beheerder |
| Stakeholders | PM |
| Pre condities | De klant kan inloggen in het PMP. </br> De klant heeft op zijn minst één gepland, lopend of afgerond project bij Bluenotion. |
| Post condities | De klant heeft een overzicht van de taken die voor de software developers op de planning staan. [(planning van lifecycle taken)](../FunctioneelOntwerp.md#lifecycle-aanvragen) |
| Triggers | De klant vraagt de details voor een project op |
| Exceptions | Het opgevraagde project bestaat niet |
| Open issues |  |

### FR2.1: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Vraagt voor een project alle bijbehorende taken op |  |
| 2 |  | Presenteert een aantal lijsten met uit te voeren taken, geplande taken, taken waar de gebruiker feedback op moet geven en afgeronde taken. |

### FR2.1: Alternative flow - Project heeft geen taken

|Stap | Actor | System |
|---|---|---|
| 2A |  | Toont lege takenlijsten |

## FR2.2: Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed

User story: Als externe beheerder wil ik een overzicht van het geplande werk zodat ik zicht kan houden op de ontwikkeltijd en kosten.

| FR2.2 | Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe beheerder |
| Stakeholders | PM |
| Pre condities | De klant kan inloggen in het PMP. </br> De klant heeft op zijn minst één gepland, lopend of afgerond project bij Bluenotion. |
| Post condities | De klant heeft een gefilterd/gesorteerd overzicht van alle voor hem relevante taken. |
| Triggers | De klant vraagt de details voor een project op |
| Exceptions | Het opgevraagde project bestaat niet |
| Open issues |  |

### FR2.2: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Vraagt voor een project alle bijbehorende taken op |  |
| 2 |  | Presenteert een aantal lijsten met uit te voeren taken, geplande taken, taken waar de gebruiker feedback op moet geven en afgeronde taken. |

### FR2.2: Alternative flow - Project heeft geen taken

|Stap | Actor | System |
|---|---|---|
| 2A |  | Toont lege takenlijsten |

## FR2.3: Inzien taak details

User story: Als externe beheerder wil ik een overzicht van het geplande werk zodat ik zicht kan houden op de ontwikkeltijd en kosten.

| FR2.3 | Inzien taak details |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe beheerder |
| Stakeholders | PM |
| Pre condities | De klant kan inloggen in het PMP. </br> De klant heeft op zijn minst één gepland, lopend of afgerond project bij Bluenotion met op zijn minst één bijbehorende taak. |
| Post condities | De klant heeft een overzicht van de voor hem relevante informatie over een taak zoals de status, geplande uren/kosten, due date, priority en type. (heeft een klant toegang tot de comments van een taak?) |
| Triggers | De klant vraagt de details voor een taak |
| Exceptions | De opgevraagde taak bestaat niet |
| Open issues |  |

### FR2.3: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Vraagt voor een specifieke taak de taak details op |  |
| 2 |  | Toont de naam, status, geplande uren/kosten, due date, prioriteit en type van de geselecteerde taak. |

## FR2.4: Tonen taken in Gantt chart

User story: Als externe beheerder wil ik een overzicht van het geplande werk zodat ik zicht kan houden op de ontwikkeltijd en kosten.

| FR? | Tonen taken in Gantt chart |
|---|---|
| Prioriteit | Could have |
| Primaire Actor | ACT1: Externe beheerder  |
| Stakeholders |  |
| Pre condities | Er zijn taken ingepland voor een project van de klant |
| Post condities | De gebruiker krijgt een overzicht van wanneer welke taken gepland staan. |
| Triggers | De klant geeft aan een visueel overzicht te willen van wanneer welke taken af zijn. |
| Exceptions |  |
| Open issues | Timeline vs GANTT chart |

### FR2.4: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Aanvraag |  |
| 2 |  | Resultaat |

### FR2.4: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |
