# FR8 Controleren aanvraag

Deze functional requirements hebben betrekking op het goed (of af) keuren van aanvragen gedaan door de externe klant en het maken van taken op basis van deze aanvragen.

## FR8.1: Controleren aanvraag

| FR8.1 | Controleren aanvraag|
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT2: Bluenotion admin |
| Stakeholders | ACT1: Externe klant, ACT3: Software developer |
| Pre condities | Er is een project waar een klant een aanvraag heeft gedaan.  |
| Post condities | De klant wordt op de hoogte gebracht dat er om feedback is gevraagd. </br> De taak staat op het "Awaiting customer" bord. |
| Triggers | Er staan taken in de "Aanvraag" lijst. |
| Exceptions | In de tijd dat de vraag wordt gecontroleerd is de taak door de klant verwijderd. |
| Open issues | Een klant kan meerdere reprosenatoren hebben. Wie moet op de hoogte gebracht worden van wanneer een taak open gezet is voor feedback? (Alleen de eigenaar van het project? Alle klanten die zijn toegevoegd aan het project? Op project of taak niveau een optie om te abonneren ) </br> Wat kan de klant aanpassen in een taak? Wat moet er gebeuren als een klant bijvoorbeeld de cost estimate van een taak voor nu te hoog vindt? Blijft een taak als dit op de aanvragen, wordt deze alsnog naar de backlog gehaald of wordt deze taak geannuleerd? |



### FR8.1: Main flow

| Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan een ingediende aanvraag te willen controleren |  |
| 2 |  | Toont alle in het PMP en Productive beschikbare informatie over de taak zoals naam, omschrijving, eventuele time estimate en comments. |
| 3 | Geeft aan dat de taak duidelijk is omschreven en geeft een schatting van hoe veel tijd Bluenotion kwijt is met het implementeren van de functionaliteit als beschreven in de taak. |  |
| 4 |  | Zet de aanvraag open voor feedback van de klant voor goedkeuring van de time estimate |

### FR8.1: Alternative flow - Taak is onduidelijk omschreven

| Stap | Actor | System |
|--|--|--|
| 3A | Geeft aan dat de aanvraag niet duidelijk genoeg is omschreven om een taak van te maken met een notitie voor de gebruiker wat er aangepast/verduidelijkt moet worden |  |
| 4A |  | Stelt "ACT1: Externe klant" op de hoogte van de vraag om verduidelijking voor het toelichting geven op de taak ([FR3.2](/Documentatie/Requirements/FR3_Toevoegen_aanvraag.md#fr32-toelichting-geven-op-taak)). |

### FR8.1 Alternative flow - Aanvraag bevat omschrijving voor meerdere taken

| Stap | Actor | System |
|--|--|--|
| 3B | Geeft aan dat de aanvraag eigenlijk over meer dan één taak gaat. |  |
| 4B |  |  |

<!-- | 1 | Geeft aan welke taak open gezet moet worden voor feedback  |   |
| 2 |   | Geeft de actor de mogelijkheid de taak zelf aan te passen.  |
| 3 | Geeft aan welke punten ontbreken of onduidelijk zijn.  |   |
| 4 |   | Zet de taak op "awaiting customer" met de bijbehorende feedback.  | -->

<!-- TODO: Waar komt feedback? Wordt dit bijgehouden in de comments van de taak? De omschrijving? Apart in het PMP?
A: feedback in de comments van productive. Aparte "chat" voor tenant level communicatie [FR9](#fr9-tenant-level-chat-voor-directe-communicatie) komt in het PMP -->

### FR8.1: Alternative flow - Taak is zelf aan te vullen

|Stap | Actor | System |
|---|---|---|
| 3A | Past de ontbrekende/onduidelijke punten zelf aan |  |
| 4A |  | Zet de nieuwe versie van de taak op "awaiting customer" zodat de klant goedkeuring kan geven voordat er aan begonnen wordt.  |

## FR8.2: Op splitten taak naar "team" taken

| FR? | Op splitten taak naar "team" taken  |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT2: Bluenotion admin  |
| Stakeholders |  |
| Pre condities | Een klant heeft een taak in de aanvragen toegevoegd. |
| Post condities | Er zijn verschillende taken aangemaakt voor elk team dat iets met de taak moet doen. |
| Triggers | De PM merkt op dat verschillende teams aan één taak moeten werken. |
| Exceptions |  |
| Open issues | Kunnen dependencies gebruikt worden? Hoofd en subtaken? TODO's? Wanneer is de controle voorbij?  |

### FR8.2: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | De actor geeft aan een aanvraag te willen splitten naar verschillende taken |  |
| 2 |  | Het systeem geeft een aantal opties (teams) waar binnen dat project taken voor aangemaakt kunnen worden |
| 3 | De actor geeft aan welke teams aan de taak gaan werken |  |
| 4 |  | Het systeem maakt verschillende taken aan voor de betreffende teams, zet ze op de "aanvraag" lijst en refereer in de originele taak naar de nieuwe (dependency/sub?) taken |
| 5 | De actor voert voor de nieuwe taken een estimate in per sub taak* |  |
| 6 |  | Het systeem zet de taken na goedkeuring externe klant op de backlog |

*Standaard wordt de tijd opgedeeld aan de hand van de standaard split met optie tot aanpassing.
TODO: navragen, stap 5 zou ook kunnen gebeuren aan de hand van de "standaard split"

### FR8.2: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |
