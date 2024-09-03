# FDR004 Aanpassingen productive workflow

Is dit eigenlijk een ADR? Het is niet perse relevant voor de architectuur van het PMP maar heeft wel invloed op hoe gebruikers buiten het PMP werken in Productive.

## **Status:** Proposed

## **Context:**

Aangezien voor elk project variaties bestaan op de boven beschreven werkwijzes/procedures en lang niet alle informatie interessant is voor de klant van Bluenotion is er na overleg met de UX ontwerper en PM gekozen om de "ontwikkelstraat"** lost te koppelen van de status die de klant ziet. De hoop is door de klant een gesimplificeerde werkwijze te laten zien de onduidelijkheden over benaming van verschillende takenlijsten en statussen te beperken. Wel komt hier bij kijken dat er een eis is in [NFR8.4](#nonfunctional-requirements) die specificeert dat de werkwijze van developers zo min mogelijk aangetast dient te worden door de introductie van het PMP.

<!-- TODO2: **ontwikkelstraat toevoegen aan woordenlijst -->

Om tot een passende oplossing te komen over hoe binnen Productive flexibel gewerkt kan worden maar wel alle data beschikbaar is voor het PMP zijn voor [ACT1](../FunctioneelOntwerp.md#act1-externe-beheerder) en [ACT2](../FunctioneelOntwerp.md#act2-interne-beheerder) alle scenarios waarop ze zouden interacteren met de Productive omgeving op een rijtje gezet en opties vergeleken waarop de interactie gefaciliteerd zou kunnen en wat voor impact dit zou hebben op de workflow [ACT3](../FunctioneelOntwerp.md#act3-interne-medewerker).

<!-- TODO: is dit nou soort van [problem analysis](https://ictresearchmethods.nl/field/problem-analysis/)? -->

### ACT1: Externe beheerder

Wat vindt de klant interessant?

- Moet IK iets doen om werk aan een taak verder te laten gaan
- Wat moet ik doen om werk aan een taak verder te laten gaan
- Is Bluenotion aan de slag met mijn taak

Wanneer moet de klant wat doen om een taak verder te laten gaan?

1. De klant moet een initiële aanvraag doen voor functionaliteit (ticket indienen)
    </br> - Eerste actie, het PMP hoeft enkel de aanvraag te faciliteren.
2. De klant moet akkoord geven op de inschatting zoals gedaan door de PM/TL voordat er met de taken gestart wordt
    </br> - Het PMP moet de klant inlichten (e-mail+dashboard) en de klant de optie te geven akkoord te gaan, feedback te geven of de aanvraag te annuleren.
3. De klant moet feedback kunnen geven wanneer hier naar gevraagd wordt (op elk moment in het ontwikkel proces. Voorbeelden: klant heeft feedback op de gemaakte inschatting, review UX designs of een bugfix dat grenst op nieuwe functionaliteit)
    Het PMP moet de klant inlichten (e-mail+dashboard), de vraag om feedback (comments) tonen en de optie geven om hier op te reageren.
4. De klant moet akkoord geven op functionaliteit wanneer deze op de test omgeving staat voordat deze naar productie gaat
    </br> - Het PMP moet de klant inlichten (e-mail+dashboard), en per aangeleverde functionaliteit (kunnen er meer zijn) de optie krijgen deze goed te keuren, af te keuren en comments achter te laten.

Opties:

- Status geeft aan wie wanneer ingelicht moet worden

### ACT2: Interne beheerder

Wil de PM ook wat?

- Moet IK iets doen om werk aan een taak verder te laten gaan
- Wat moet ik doen om werk aan een taak verder te laten gaan

Wanneer moet een PM wat met een taak?

1. De klant heeft een initiële aanvraag gedaan voor functionaliteit
    </br> - PM moet terugkoppelen met een inschatting van hoe lang BN bezig gaat zijn met de taak en indien gewenst de taak opsplitsen in taken voor elk gerelateerd team.
2. De klant heeft akkoord gegeven op een taak.
    </br> - TODO: Vragen, zet het PMP de taak automatisch open en op de Todo lijst of doet de PM dit?
3. De klant heeft feedback gegeven op een taak (vorig lijstje optie 2, 3, 4)
    </br> - De PM moet met de klant overleggen of de juiste teams aansturen om de feedback te verwerken

## **Decision:**

O3: Afleiden wie wat moet doen op basis van custom fields.

## **Consequences:**

Door een single select dropdown field toe te voegen aan taken met "Waiting for feedback customer" en "Waiting for feedback Bluenotion" kan er beiden binnen het PMP en Productive gezien worden op welke taken feedback nodig is en kunnen developers zonder in het PMP te werken ook feedback vragen.

De custom fields zijn met een dropdown niet fout gevoelig en worden bij de meeste projecten nog niet gebruikt in de standaard developer workflow. Daar waar ze wel al gebruikt worden kunnen ze wegens aanschaf van een nieuw Productive abonnement toegevoegd worden naast al gebruikte custom fields.

## **Alternatives:**

### O1: Afleiden wie wat moet doen op basis van welke taaklijst een taak in staat

<!-- TODO: invullen of weghalen -->

<!-- Omschrijving:

Binnen Productive zouden projectborden aangemaakt kunnen worden waarna zodra iemand binnen Productive een taak in de aangegeven takenlijst zet er een bericht wordt gestuurd met de vraag aan de klant feedback te geven op de taak.

Pros:

- Snel te implementeren

Cons: -->

### O2: Afleiden wie wat moet doen op basis van takenlijst en tags

Omschrijving:

Er zou binnen het PMP een tag gebruikt kunnen worden als "waiting for review customer" en "waiting for review Bluenotion" waarna het PMP op basis van tag en het takenlijst waar een taak in staat afgeleid kan worden wie wat moet doen.

Pros

- Past binnen het basis Productive pakket.
- Er is geen limiet (gevonden) op de hoeveelheid tags die aangemaakt kunnen worden.
- Er bestaat binnen productive filtering op tags vanuit de API. (relevant voor [ADR001](../../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md))
- Heeft geen invloed op de huidige developer workflow

Cons

- Tags autocompleten in Productive pas zodra ze al een keer zijn gebruikt in het huidige Board*. = Foutgevoelig vanuit het PMP.

*Groepering aan task lists

### O3: Afleiden wie wat moet doen op basis van custom fields

Omschrijving:

Er zou binnen het PMP gebruik gemaakt kunnen worden van een custom field waarna vergelijkbaar met O2 het PMP op basis van takenlijst en het custom field af kan leiden wie wat moet doen.

Pros

- Er bestaat binnen productive filtering op custom fields vanuit de API. (relevant voor [ADR001](../../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md))
- Custom fields hebben verschillende invoer opties (plain text, number, date picker, single select dropdown, multi select dropdown en person) die invoer vanuit het PMP limiteren.
- Heeft geen invloed op de huidige developer workflow

Cons

- Binnen het huidige Productive pakket kunnen maximaal 3 custom fields gebruikt worden.

### O4: Afleiden wie wat moet doen op basis van taak status

Omschrijving:

Elke taak heeft een status waarvan op het moment voornamelijk alleen Open en Closed worden gebruikt, hier zouden statussen aan toegevoegd kunnen worden waarop het PMP kan afleiden wie wat moet doen.

Pros

- Past binnen het basis Productive pakket.
- Status kan enkel geselecteerd worden met een dropdown = lagere foutgevoeligheid in Productive
- Status wordt intern gestructureerd op "Not started", "Started" en "Closed". De review status zou "Not started" kunnen zijn waardoor de originele workflow bijna niet wordt aangetast

Cons

- Er wordt mogelijk binnen sommige projecten gebruik gemaakt van filters op "Open" taken die met aanpassing van deze structuur andere output gaan leveren.

#### Oud uit het FO

Door in de workflow twee statuses toe te voegen die aangeven dat één van de partijen feedback moet aanleveren voordat er verder gegaan kan worden met een taak is het mogelijk op elk moment in het ontwerp of ontwikkelproces een taak weer open te zetten voor feedback. Hiermee kan met een relatief kleine wijziging in het bestaande systeem door het PMP aan de combinatie van een taak zijn status en het bord waar hij op staat bepaald worden wat welke actor wat moet doen om weer aan de slag te kunnen met een taak.

<!-- Bluenotion werkt bij start van het project per taak met een status die aangeeft of een taak "Open", "Done", "Vakantie/Vrij" of "Closed" is. Het hele proces van aanvraag tm implementatie bevindt zich in de "Open" status. Door naast Open twee extra statuses toe te voegen voor wanneer een taak wacht op feedback van de klant of wacht op feedback van Bluenotion is het mogelijk binnen Productive zonder een taak van bord te wisselen een taak "open te zetten voor review". Zo kan er bijvoorbeeld een taak met onduidelijke beschrijving uit de aanvragen opengezet worden voor verduidelijking en een taak uit staging klaargezet voor review in de applicatie. -->

| Status  | Uitleg  | [Workflow stage](https://help.productive.io/en/articles/5813154-creating-and-managing-workflows)  |
|---|---|---|
| Waiting for review customer  | Geeft aan dat een taak aan het wachten is op feedback van de klant.  | Not started  |
| Waiting for review Bluenotion | Geeft aan dat een taak aan het wachten is op feedback van Bluenotion. | Not started |
| Open  | Geeft aan dat Bluenotion actief aan het werk is aan een taak.  | Started  |
| Done  | Geeft aan dat Bluenotion aan een taak heeft gewerkt en deze klaar is voor review.  | Started  |
| Closed  | Geeft aan dat de klant een afgeronde taak heeft gereviewd en goedgekeurd.  | Closed  |
<!-- | Not started | TODO: is deze status nodig? Hiermee zou een taak niet in progress zijn zonder dat er op een van de partijen op feedback wordt gewacht. Mogelijk relevant voor de wishlist? Extra statuses kunnen er wel voor zorgen dat het overzicht wordt verloren. | Not started | -->

Omdat niet elk project bij Bluenotion niet de zelfde Productive structuur volgt qua taak borden en statussen is voor een koppeling tussen het PMP en Productive de volgende informatie nodig:

Bord:

- Welk bord (mogen) aanvragen staan?
- Welk bord wordt gebruikt als backlog?
- Welk bord wordt gebruikt als laatste controle van de klant? (development/staging)
- *Welk bord wordt gebruikt als wishlist?

Status:

- Bij welke status moet de klant 'iets' met de taak? (Waiting for review customer)
- Bij welke status moet Bluenotion 'iets' met de taak? (Waiting for review Bluenotion)*
- status open
- status done
- status closed

*Status wordt op het moment gebruikt in sommige projecten, om tijdens de transitie van klanten in Productive naar het PMP geen functionaliteit kwijt te raken waar de klant gewend aan is, is het misschien beter om te kijken of tags gebruikt kunnen worden als notificatie flag.

*Is wishlist deel van V1?
Is done/closed nodig of wordt status gebruikt?

wishlist?

benodigde statussen:

Not started
Open
Done
Closed

Aan de hand van deze informatie kan het PMP de volgende beslissingen maken:

| Status | Bord | Betekenis | Actie |
|--|--|--|--|
| Waiting for review Bluenotion | Aanvragen | De aanvraag is ingediend en wacht op goedkeuring van Bluenotion | Informeer de PM aan de hand van PMP of e-mail. |
| Waiting for review customer | Aanvragen | De aanvraag heeft meer feedback nodig van de klant | Informeer de klant aan de hand van het PMP of e-mail. |
| Open | Aanvragen | De aanvraag is goedgekeurd, taken zijn aangemaakt en zijn in behandeling bij Bluenotion | nvt |
| Done | Aanvragen | Alle taken waarin de aanvraag was geresulteerd zijn klaar voor review voor de klant | Informeer de klant aan de hand van het PMP of e-mail. |
| Closed | Aanvragen | Alle taken waarin de aanvraag was geresulteerd zijn klaar voor review voor de klant | nvt |

| Status | Bord | Betekenis | Actie |
|--|--|--|--|
| Waiting for review customer | Backlog | Tijdens het ontwikkelen bleek meer informatie nodig te zijn. | Informeer de klant aan de hand van PMP of e-mail. |
| Waiting for review Bluenotion | Backlog | De klant heeft reactie gegeven op de informatievraag. | Informeer de PM (of dev?) aan de hand van PMP of e-mail. |
| Open | Backlog | De taak is in behandeling | nvt |
| Not started | Backlog | Er is iets mis? | nvt* |
| Done | Backlog | Er is iets mis? | nvt* |
| Closed | Backlog | Er is iets mis? | nvt* |

*Iets verzinnen voor deze "verloren" taken? Staan normaal op productive maar zouden mogelijk niet netjes in een PMP groepering gegooid worden.

| Status | Bord | Betekenis | Actie |
|--|--|--|--|
| Waiting for review customer  | Staging | De taak is afgerond en de klant kan de functionaliteit controleren. |  |
| Waiting for review Bluenotion  | Staging | De klant heeft reactie gegeven op de taak maar de taak niet goedgekeurd. |  |
| Open  | Staging |  |  |
| Done | Staging |  |  |
| Closed | Staging |  |  |

| Status | Bord | Betekenis | Actie |
|--|--|--|--|
| Waiting for review customer  | Live |  |  |
| Waiting for review Bluenotion  | Live |  |  |
| Open  | Live |  |  |
| Done | Live |  |  |
| Closed | Live |  |  |

Kun je een taak hebben in de aanvragen?
Maakt de PM taken aan op de backlog?

|  |  |  |  |
|--|--|--|--|
|  | backlog |  |  |
|  | staging |  |  |
|  | Aanvragen |  |  |
|  | Aanvragen |  |  |
|  | Aanvragen |  |  |
|  | Aanvragen |  |  |

### O5: Afleiden wie wat moet doen op basis van taak titel/beschrijven

Omschrijving:

Er zou binnen de titel of beschrijving van een taak iets over de feedback status vermeld kunnen worden waaruit het PMP en de gebruikers binnen Productive kunnen afleiden wie wat moet doen.

Pros

- Past binnen het huidige productive pakket

Cons

- Foutgevoelig vanuit het PMP wegens handmatige invoer
- Heeft invloed op de huidige developer workflow

### O6: Handmatig via het PMP

Omschrijving:

Strict gezien is het niet nodig de feedback status in Productive over te nemen, wel is het handig voor scenarios waar op een lopende taak feedback gegeven dient te worden.

Pros

- Heeft geen invloed op de huidige developer workflow

Cons

- Binnen productive is het niet direct zichtbaar of er op een taak feedback gevraagd/gegeven is.

## Log

| Optie | Status | Omschrijving | Datum |
|---|---|---|---|
| O4 | Proposed | Taak status+task list voorgesteld |  |
| O4 | Rejected | Productive pakket upgrade geeft O3 voorkeur |  |
| O3 | Proposed | Custom field + task list voorgesteld |  |
