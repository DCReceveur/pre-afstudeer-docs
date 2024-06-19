# FR3: Toevoegen aanvraag

Deze functional requirements hebben betrekking op het toevoegen, toelichten of wijzigen van aanvragen/taken op een lopend project.

## FR3.1: Toevoegen nieuwe aanvraag in een project

| FR3.1 | Toevoegen nieuwe aanvraag in een project |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | PM |
| Pre condities | De klant kan inloggen in het PMP. </br> De klant heeft op zijn minst één gepland of lopend project bij Bluenotion. |
| Post condities | Er is binnen Productive een nieuwe taak toegevoegd aan de aanvragen lijst. |
| Triggers | De klant geeft aan werk gedaan te willen hebben. |
| Exceptions | Het opgevraagde project bestaat niet. |
| Open issues | Maakt de PM/TL hier ook gebruik van of is dit specifiek voor de klant? </br> Kunnen projecten permanent gesloten/gearchiveerd zijn en dus niet meer bijgevuld worden? |

### FR3.1: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan een aanvraag te hebben voor een bestaand project |  |
| 2 |  | Presenteert de gebruiker met een aantal invoer velden om informatie te verzamelen op de taak. |
| 3 | Vult de gepresenteerde velden in met informatie over de taak. |  |
| 4 |   | Toont de ingevoerde informatie nogmaals en vraagt de gebruiker of de informatie correct is.  |
| 5 | Controleert de ingevulde informatie en geeft aan dat de informatie correct is. |  |
| 6 |  | Maakt op basis van de ingevulde gegevens een taak aan op de aanvragen lijst in Productive. </br> TODO: navragen, tonen verwachte reactie tijd/opvolg instructies? Dit zou afhankelijk zijn van het SLA dus deel van FR3.3? |

*Schatting van de door de actor aan te leveren informatie:

Titel, korte omschrijving, Screenshot (urgentie & impact zie FR3.3)

### FR3.1: Alternative flow - Hoge prioriteit taak

A: Doorgeven hoge prioriteit

B: Aanpassen naar lage prioriteit

|Stap | Actor | System |
|---|---|---|
| 4A |  | De taak heeft een prioriteit van 1 of 2 (zie [toelichting prioriteit taken](FunctioneelOntwerp.md#taak-impact-urgentie-en-prioriteit-levels)) |
| 5A   |   | Geeft aan dat de taak critical is en vraagt om critical taken telefonisch door te geven. |
| 6A | De klant geeft de taak telefonisch door | |
| 6B | De klant past de urgentie of impact aan zodat de taak een prioriteit boven de 3 krijgt |  |
| 7B |  | Resume main flow at 4 |

### FR3.1: Alternative flow - Incomplete invoer

A: Aanvullen missende informatie

|Stap | Actor | System |
|---|---|---|
| 3A  | Vult vereiste informatie niet in in de invoervelden  |   |
| 4A  |  | Geeft aan welke velden informatie missen  |
| 5A  | Vult de informatie aan |  |
| 6A  |   |  Resume main flow at 4 |

## FR3.2: Toelichting geven op aanvraag

| FR3.2 | Toelichting geven op aanvraag |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe klant  |
| Stakeholders | ACT2: Bluenotion admin |
| Pre condities | De actor heeft een aanvraag bij een project waar vraag naar feedback voor is gedaan. |
| Post condities | De feedback staat bij de aanvraag in productive. </br> De aanvraag staat niet meer geregistreerd als "waiting for feedback" |
| Triggers | De PM of TL heeft één of meer vragen gesteld bij een aanvraag |
| Exceptions |  |
| Open issues | Wat als de gebruiker de functionaliteit na nader bespreking niet meer hoeft? |

### FR3.2: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Navigeert naar de aanvraag details in het PMP  |   |
| 2 |   | Toont de vragen zoals gesteld door de PM/TL  |
| 3 | Vult de aanvraag waar nodig aan met de gevraagde informatie |   |
| 4 |   | Zet de nieuwe versie van de aanvraag in productive in de lijst met aanvragen.  |

### FR3.2: Alternative flow - Annulering aanvraag

A: Gebruiker annuleert de aanvraag.

|Stap | Actor | System |
|---|---|---|
| 3A | De gebruiker kiest er voor de aanvraag te annuleren |  |
| 3A |  | Registreer de aanvraag als closed in productive |

TODO: is het wel closed of een andere status? Moet ik hier iets zeggen over logging?


## FR3.3: Toevoegen taken past zich aan aan de klant zijn SLA

| FR3.3 | Toevoegen taken past zich aan aan de klant zijn SLA |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders |  |
| Pre condities | De klant heeft een project waarvan de SLA in het PMP systeem is ingeladen. |
| Post condities | Taak prioriteit, incident reactie en response tijd worden aan de hand van de SLA berekend. |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

### FR3.3: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 |   |   |
| 2 |   |   |

### FR3.3: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

## FR3.4: Toevoegen bijlagen bij taak

| FR3.4 | Toevoegen bijlagen bij taak |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders |  |
| Pre condities | De klant zit op de taak detail pagina of is een aanvraag aan het doen. |
| Post condities | Er zijn bijlages toegevoegd aan de aanvraag |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

### FR3.4: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | De actor kiest er voor een bijlage toe te voegen |  |
| 2 |  | Het systeem presenteert een manier om de bijlage te selecteren |
| 3 | De actor kiest één of meerdere bestanden om als bijlage toe te voegen. |  |
| 4 |  | Het systeem upload de bestanden en refereert bij de taak naar deze bestanden. |

### FR3.4: Alternative flow - Upload fails

|Stap | Actor | System |
|---|---|---|
| 4 |  | Het systeem geeft aan dat bestanden niet geüpload kunnen worden |
| 5 | Slaat de taak op zonder bijlage. |  |

## FR3.5: Aanpassen taak prioriteit

TODO: verder uitwerken.
Note: Na het aanpassen van de prio taak weer open zetten voor feedback Bluenotion

| FR3.5 | Aanpassen taak prioriteit |
|---|---|
| Prioriteit | ?  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | PM |
| Pre condities | Taak is een incident |
| Post condities | Escalatie naar het juiste niveau. |
| Triggers | De klant is het niet eens met de toegekende prioriteit (punt 9.3 SLA) |
| Exceptions |  |
| Open issues |  |

### FR3.5: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan het niet eens te zijn met de toegekende prioriteit |  |
| 2 |  | Geeft de optie de prioriteit aan te passen? |
| 3 | Past de impact of urgentie aan |  |
| 4 |  | Berekent de nieuwe prioriteit voor de taak, toont deze en slaat hem op bij de taak. |
| 2 |  | Geeft aan contact op te moeten nemen met de servicedesk? |
| 2 |  | ? |

### FR3.5: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
| 4A |  | Geeft aan dat de nieuwe prioriteit 1 of 2 is en daarmee direct contact op genomen dient te worden met Bluenotion. |
