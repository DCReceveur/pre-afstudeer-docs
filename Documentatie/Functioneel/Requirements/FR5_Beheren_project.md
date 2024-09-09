---

weight: 5

---

# FR5: Beheren project

Deze functional requirement betreft het voorbereidend werk dat wordt gedaan voordat een project wordt gestart. Voorbeelden zijn onderhandelen van de initiële scope, afstemmen van het budget/SLA. Deze requirement is nog niet helemaal afgestemd.

## FR5.1: Afhandelen project setup

User story: Als Bluenotion admin wil ik alle project management en project gerelateerde klantcontact via het zelfde kanaal afhandelen

| FR5.1 | Afhandelen project setup |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT2: Bluenotion admin |
| Stakeholders |  |
| Pre condities | Beiden actoren hebben inlog gegevens voor het PMP |
| Post condities | Een project is gestart met initiële scope |
| Triggers | Op aanvraag van Externe beheerder |
| Exceptions |  |
| Open issues | Procedure vast leggen |

### FR5.1: Main flow

|Stap | Actor | System |
|---|---|---|
|  |  |  |
|  |  |  |

### FR5.1: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

## FR5.2 Instellen productive boards en taak status

User story: Als Bluenotion admin wil ik per project aan kunnen passen welke productive borden voor het PMP betekenis hebben zodat het PMP kan werken met projecten die op verschillende manieren zijn opgezet.

| FR5.1 | Afhandelen project setup |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT2: Bluenotion admin |
| Stakeholders |  |
| Pre condities | Beiden actoren hebben inlog gegevens voor het PMP |
| Post condities | Een project is gestart met initiële scope |
| Triggers | Op aanvraag van Externe beheerder |
| Exceptions |  |
| Open issues |  |

<!-- TODO: cleanup -->

Benodigde borden:
aanvragen
backlog
development?
staging

wishlist?

TODO: statussen checken. Als over verschillende projecten de zelfde status id gebruikt wordt hoeft deze mogelijk niet ingesteld te worden. Field toewijzen aan een project of ticket doe je aan de hand van een update op project of ticket <https://developer.productive.io/working_with_custom_fields.html#working_with_custom_fields>

benodigde statussen:

Not started
Open
Done
Closed
Waiting for review customer
Waiting for review Bluenotion

Voorstel van handmatige configuratie van status in relatie tot bord:

| PMP status | Productive bord  |
|---|---|
| Open  | [-] Backlog</br>[-] Wishlist</br>[-] Aanvragen</br>[+] Bord toevoegen |
| Bezig  | [-] In progress</br>[-] In review</br>[-] Development</br>[-] Testing</br>[+] Bord toevoegen |
| Klaar  | [-] Staging</br>[+] Bord toevoegen |

Voordeel:

Door PM de borden te laten instellen (Opzetten project aan de hand van een template zou de borden zelf in kunnen vullen) is het mogelijk oude projecten in het PMP te laden.

Nadeel:

Het kan voorkomen dat deze lijst niet compleet is. Er moet dan een keuze gemaakt worden of voor taken op een onbekend bord een "unknown" status wordt gemaakt of de vorige status wordt aangehouden tot de taak op een bord terecht komt die aanduid dat de status is veranderd.

Note: PMP status hoeft wat mij betreft niet vast te staan. Je zou hier ook een extra status kunnen registreren voor tickets voor latere versies oid.

### FR5.2: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Vraagt de instellingen van een project op. |  |
| 2 |  | Toont de lijst van borden en statussen (zie boven) |
| 3 | Geeft aan een van de borden of statussen te willen wijzigen |  |
| 4 |  | Toont een lijst van borden of statussen gekoppeld aan het project in Productive |
| 5 | Geeft aan welke optie uit de lijst gebruikt moet worden en geeft aan wijzigingen te willen opslaan |  |
| 6 |  | Slaat de wijziging op in de PMP database. |
| 7 |  |  |

### FR5.2: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

## FR5.3: Beheren project services

TODO: fully dressed versie uitwerken.

De admin handelingen voor het beheer van de dependencies.

| FR5.3 | Beheren project services |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT2: Bluenotion admin |
| Stakeholders | ACT1: Externe beheerder |
| Pre condities | Er is een project toegevoegd aan het PMP |
| Post condities | Er is een service gekoppeld aan het project |
| Triggers | Op aanvraag van Bluenotion admin |
| Exceptions |  |
| Open issues | Zie [FR6.1](./FR6_Inzien_project_service_statuses.md#fr61-inzien-lijst-van-project-dependencies) |

### FR5.3: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Kiest een project waar een wijziging moet gebeuren in de services |  |
| 2 |  | Toont de lijst met gekoppelde services als beschreven in [FR6.1](./FR6_Inzien_project_service_statuses.md#fr61-inzien-lijst-van-project-dependencies) |
| 3 | Kiest een service geeft aan deze bij te willen werken |  |
| 4 |   | Toont een lijst aan gegevens die bij te werken zijn voor deze service (hostname/ip & servicenaam) |
| 5 | Past gegevens aan en geeft aan wijzigingen door te willen voeren  |   |
| 6 |  | Slaat de wijzigingen op in de lokale database |

### FR5.3: Alternative flow - service toevoegen

|Stap | Actor | System |
|---|---|---|
| 3A | Geeft aan een service toe te willen voegen |  |
| 4A |   | Toont een lijst aan gegevens nodig voor het toevoegen van een service (hostname/ip & servicenaam)  |
| 5A | Vult de gegevens in en geeft aan wijzigingen door te willen voeren  |   |
| 6  |  | Resume main flow stap 6 |

### FR5.3: Alternative flow - service verwijderen

|Stap | Actor | System |
|---|---|---|
| 3B | Kiest een service en geeft aan deze te willen verwijderen |  |
| 4B |  | Vraagt om bevestiging of de gebruiker de service "servicenaam" wilt verwijderen |
| 5B | Bevestigt het verwijderen van de service uit het project |  |
| 6 |  | Resume main flow stap 6 |

## FR5.4: Beheren project documentatie

User story: Als interne beheerder wil ik documentatie kunnen uploaden zodat het open gezet kan worden voor klanten om te lezen.
User story: Als interne beheerder wil ik verschillende documenten open kunnen zetten voor verschillende projecten zodat de klant enkel toegang heeft tot de documenten die voor hem/haar relevant zijn.

TODO: fully dressed versie uitwerken.

| FR7.3 | Beheren project documentatie (CRUD) |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT2: Bluenotion admin |
| Stakeholders | ACT1: Externe beheerder |
| Pre condities | Er is een project toegevoegd in het PMP |
| Post condities | Een document is toegevoegd, vervangen of verwijderd|
| Triggers | Op aanvraag Bluenotion admin |
| Exceptions |  |
| Open issues |  |

Notes:

Documentatie wordt geupload aan de hand van FR7.4, aan de hand van FR7.3 wordt de (al bestaande) documentatie gekoppeld aan een project.

TODO: Het voordeel aan deze opmerking is dat bij het uploaden van een nieuwe versie van bestaande documentatie er één nieuwe versie geüpload kan worden en deze met een handeling voor alle projecten vervangen kan worden. Je zou ook een nieuwe versie van een bestaand document kunnen uploaden en deze moeten koppelen aan elk project die je wilt updaten.

### FR5.4: Main flow

|Stap | Actor | System |
|---|---|---|

### FR5.4: Alternative flow - Geen uren ingepland op het project

|Stap | Actor | System |
|---|---|---|


## FR5.5: Documentatie op de to-do lijst zetten

User story: Als interne beheerder wil ik de externe beheerder op de hoogte brengen van aangeleverde instructies zodat dingen als deployment stappen door de klant zelf gevolgd kunnen worden en ik kan zien wanneer dit is gedaan.
