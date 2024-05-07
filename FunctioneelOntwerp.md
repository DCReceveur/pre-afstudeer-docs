# Functioneel ontwerp Project Management Portal

Dit document dient als toelichting op de functionele eisen van het Product Management Portal. Na het doornemen van dit document dienen alle betrokken partijen een duidelijk beeld te hebben van precies wat het opgeleverde Project Management Portal functioneel kan.

## Aannames en afhankelijkheden

Technische aspecten van het systeem zijn vastgelegd in het Technisch ontwerp. Voor het schrijven van dit document zijn wel de volgende technische aannames gedaan:

- De API van Productive.io Kan alle door de klant gewenste informatie aanleveren.
- Het aantal naar de Productive API gestuurde requests blijft onder 100 per 30 sec.
<!-- TODO: link naar TO zodra deze bestaat. -->

## Actors

De actors zijn de mensen/rollen die gebruik maken van het systeem. Voor elke actor wordt toegelicht wat zijn/haar rol is, hoe de actor in de situatie voor het PMP werkt en wat de actor uit het PMP kan verwachten.

<!-- Een andere optie voor actors is: gebruiker & admin -->

### ACT1: Externe klant

Omschrijving: Een externe klant die een project wilt laten uitvoeren door Bluenotion.

Huidig proces: Een klant heeft een contract afgesloten bij Bluenotion voor een project. Op basis van gesprekken met de PM worden voor het project taken aangemaakt in Productive die door het development team worden opgepakt tot uiteindelijke realisatie van het product. Als de klant over de loop van het project wijzigingen wilt doen in de planning van het project loopt dit via de PM of een guest account met een apart bord in Productive.*

*Sommige klanten hebben direct toegang tot een voor hun aangemaakte productive omgeving om inzicht te kunnen krijgen in het project en al zelf taken in te schieten.

Doelen nieuwe project management portal:

- Inzicht krijgen in het door Bluenotion te verrichten werk. 
- Inzicht krijgen in het door mij verrichten werk.
- toevoegen van nieuwe taken.
- Prioriteren van bestaande taken?
- Aanpassen onduidelijke/incomplete taken

Aanspreekpunt: Jesse Bekke

### ACT2: Product manager

Omschrijving: De product manager is een medewerker van Bluenotion die projecten op functioneel en organisatorisch niveau beheert.

Huidig proces: Aan het eind van elke sprint wordt door de PM een demo gegeven aan de klant met de in die sprint geboekte vooruitgang en de planning voor de volgende sprint. Bevindingen in deze review worden door de PM verwerkt in de interne Productive omgeving. Indien een klant directe toegang heeft tot de productive omgeving heeft de PM de taak van het controleren en goedkeuren van de door de klant ingeschoten taken. Mochten er onduidelijkheden zijn in een taak of velden verkeerd ingevuld zijn (vaker voorkomend bij priority) is het aan de PM verdere verduidelijking te vragen aan de klant.

Doelen nieuwe project management portal:

- Taken goed of afkeuren voor de backlog op Productive.
- Taken handmatig aanpassen.
- Doorgeven aan de klant dat een taak incompleet of onduidelijk is.

Aanspreekpunt: Jesse Bekke

### ACT3: Software developer

<!-- of SD is geen stakeholder -->
- Software developer
  - Als Software developer wil ik niet mijn werkwijze aanpassen omdat een klant een nieuw portaal krijgt.
Bluenotion is voorlopig geen stakeholder in dit project.

Aanspreekpunt: NVT

### ACT4: Tech Lead

Is de tech lead een actor van did systeem of valt hij in dit geval onder de rol product manager?


<!-- ## User stories

  - Als product manager wil ik dat taken waar mogelijk herleidbaar zijn
    naar de oorspronkelijke wens/feedback om de facturatie te
    verantwoorden.

  - Als product manager wil ik dat taken en feedback met juiste
    prioritering (op basis van SLA) in productive terecht komen.

  - Als product manager wil ik af kunnen tekenen op door de klant
    voorgestelde taken met een time en cost estimate.

  - Als klant wil ik inzicht krijgen in de status van taken gerelateerd
    aan mijn project om wel geïnformeerde beslissingen te kunnen maken.

  - Als klant wil ik feedback kunnen geven op het gedane werk om het
    product te krijgen dat ik wil.

  - Als klant wil ik een consistente plek waar ik alle voor mij
    relevante gegevens terug kan vinden (iets met huis steil/wisselen
    van projectmanagement software)
 -->


## Domein

In dit hoofdstuk wordt toelichting gegeven op het domein waarin het systeem zich bevind.

```plantuml

'abstract placeholder

entity Klant
entity Project
entity Planning
entity Taak
entity Prioriteit
entity Type
entity Wishlist

note "1. Blocker \n2. Critical \n3. Major \n4. Minor \n5. Trivial \n6. Reminder" as TaakPrioriteiten
note "1. Bug\n2. Story\n3. Task\n4. Improvement\n5. New feature" as TaakTypes

TaakPrioriteiten .. Prioriteit
TaakTypes .. Taak

Klant -down- Project : > Eigenaar van
Planning -- Project: > Voor 
Taak -- Planning: > Opgenomen in
Prioriteit -- Taak: > Voor
Taak -- Type : > Ingediend als
(Klant, Taak) .. Wishlist : Aangevraagde taken
Wishlist -- Project :> Voor

Wishlist--Planning:> Gewenst voor

```

Domein definities

| Term | Uitleg | Oorsprong |
|---|---|---|
| Project | Een stuk software dat een **Klant** wilt laten ontwikkelen door Bluenotion. | |
| Taak | Een wens die een **Klant** heeft bij een **Project**. Dit kunnen nieuwe functionaliteiten en bugfixes zijn. Toelichting over de lifecycle van taken is [hier onder](#lifecycle-taken) te vinden. |  |
| Klant (verander naar tennant?) | Een individu of organisatie die bij Bluenotion een of meer projecten heeft lopen bij Bluenotion |  |
| Wishlist | Een lijst met wensen van de klant die nog niet zijn goedgekeurd voor ontwikkeling door een [PM](#act2-product-manager) of [TL](#act4-tech-lead) |  |
| Planning | Een lijst met alle taken die goedgekeurd zijn voor ontwikkeling. |  |
| Type | Het soort taak . |  |
| Prioriteit | De prioriteit van de taak, afhankelijk van of mensen nog kunnen werken en de wensen van de opdrachtgever. |  |
|  |  |  |

### Lifecycle taken

Aangezien het beheren van de workflow van taken een groot aspect zijn van het PMP is een korte toelichting gemaakt op de levensloop van een typische taak. Dit proces kan per project verschillen met details als of klanten zelf toegang hebben tot Productive of toevoeging/weglaten van sommige task lists maar het blijft in grove lijnen over de meeste projecten het zelfde.

Als een klant een bug of doorontwikkeling meld wordt hier een taak voor aangemaakt. Over de levensloop van een taak worden van verschillende actors verschillende acties verwacht. Om dit te organiseren worden op het moment binnen een project verschillende "Task lists" gebruikt. De levensloop van een taak ziet er bij de meeste projecten als volgt uit:

- **Wishlist**</br>Taken die door de klant zijn ingeschoten maar nog niet geaccepteerd door de PM en/of TL komen op de wishlist terecht.
  - **Waiting for reply PM/TL** </br> Een taak die binnen is gekomen via de klant waar nog geen goedkeuring op is gegeven door een PM/TL.
  - **Waiting for feedback Customer**</br> Een taak die gecontroleerd is door een PM/TL maar waar meer informatie nodig is van de klant. Denk hierbij aan extra informatie in de taak omschrijving of een akkoord met de time/cost estimate.

- **Planning**</br>Taken die opgenomen zijn in de planning hebben een akkoord van beiden de klant en Bluenotion (via PM/TL). Deze taken zijn compleet met time/cost estimates en een juiste prioriteit.
  - **Backlog**</br>De backlog is waar taken terecht komen na de wishlist. Vanaf de backlog pakken de aangewezen teams de taken op.
  - **In progress**</br>Zodra een developer een taak op pakt wordt deze als In progress geregistreerd.
  - **In review**</br>Nadat een developer aan een taak heeft gewerkt wordt deze klaar gezet voor review.
  - **Development**</br>Alle afgeronde taken die draaien in de dev omgeving?
  - **Testing**</br>Alle afgeronde taken die draaien in de test omgeving?
  - **Staging**</br>???
  - **Live**</br>Alle afgeronde taken die draaien op de klant omgeving.

## Requirements



### Functioneel

```plantuml

:ACT1 Externe klant: as klant
:ACT4 Tech lead: as TL
:ACT2 Product manager: as PM

(FR1: Inzien projecten) as FR1
(FR2: Inzien uit te voeren taken in een project) as FR2
(FR3: Toevoegen nieuwe taak in een project) as FR3
(FR4: Taak open zetten voor feedback klant) as FR4
(FR5: Goedkeuren extern toegevoegde taken) as FR5

klant --> FR1
klant --> FR2
klant --> FR3
klant -->FR4

TL-->FR5
PM-->FR5

```

- FR1: Inzien projecten
  - Als PM wil ik een eenduidig overzicht van alle projecten die lopen binnen Bluenotion zodat ik snel de status met een klant kan bespreken. (ACT1)
  - Als externe klant wil ik een eenduidig overzicht van alle voor mij relevante projecten zodat ik snel kan zien welke projecten actief aan gewerkt worden. (ACT2)

- FR2: Inzien uit te voeren taken in een project
  - Als externe klant wil ik een overzicht van het geplande werk zodat ik zicht kan houden op de ontwikkeltijd en kosten. (ACT2)
  - Als PM wil ik de zelfde informatie kunnen zien als een externe klant zodat ik bij vragen de klant kan ondersteunen. (ACT1)
  - Als software developer wil ik niet mijn werkwijze aanpassen om een externe klant inzicht te geven in mijn werk. (ACT3)

- FR3: Toevoegen nieuwe taak in een project
  - Als externe klant wil ik bij mijn projecten de optie om nieuwe taken toe te voegen zodat ik issues en door ontwikkelingen kan doorgeven.

- FR4: Taak open zetten voor feedback klant
  - Als PM wil ik bij taken die onduidelijk of incorrect ingevuld zijn de klant de optie geven deze onduidelijkheid te verhelderen. (ACT2)
  - Als TL wil ik bij taken die onduidelijk of incorrect ingevuld zijn de klant de optie geven deze onduidelijkheid te verhelderen. (ACT4)
  - Als externe klant wil ik bij taken die extra toelichting nodig hebben feedback kunnen geven op deze taken zodat ze goedgekeurd kunnen worden voor de backlog. (ACT1)
  - Als externe klant wil ik een eenduidig overzicht van taken die wachten op mijn input voordat er aan gewerkt wordt zodat deze taken niet onnodig lang blijven liggen. (ACT1)

- FR5: Goedkeuren extern toegevoegde taken
  - Als PM wil ik bij taken die toegevoegd zijn door een externe klant taken goedkeuren voor ze op de backlog terecht komen.

<!-- Is dit een fr of valt dit onder fr aanmaken/feedback geven? -->
- FR?: Toevoegen screenshots aan een taak
- FR?: Mention screenshots in taak description
- FR?: Aanpassen geaccepteerde taken? Kunnen taken die al op de backlog (of verder) nog aangepast worden door de klant? idee: naam en beschrijving niet, comments kunnen wel toegevoegd worden?
- FR?: Priority afleiden van de SLA
- FR?: Verkopen extra uren indien deze binnen Bluenotion beschikbaar zijn.
- FR?: Pre-project proces vastleggen in PMP
- FR?: Authenticatie en Autorisatie gebeurt binnen het PMP
- FR?: Klanten kunnen enkel data zien en aanpassen voor de projecten waar ze beheerder van zijn.
- FR?: Acties die effect hebben op de staat van een project (bijvoorbeeld FR3, FR4, FR5) dienen gelogd te worden.
- FR?: klanten kunnen tickets voor verschillende omgevingen aanmaken.
- FR?: Bij het accepteren van een taak aanvinken voor welke teams dat de taak is en subtaken aanmaken voor UX, FE, BE.... (Niet besproken)

<!-- 
Old:
- Inzien project status (PM & Extern)
  - Beschikbare projecten voor meerdere projecten bij 1 klant?
  - Uren/kosten verbruikt en totaal?
  - Quicklist van huidige taken?
  - Timeline?
  - PM contact info/eind sprint/volgend contact moment?

- Inzien taken (PM & Extern)
  - Uit te voeren taken?
  - “In progress” taken?
  - Voltooide taken?
  - per taak: status, time/cost, due date?, task changelog + ability to
    add comment?

- Toevoegen taak (PM & Extern)
  - Toevoegen problem omschrijving & screenshots
  - Task priority aan de hand van een vragenlijstje en SLA
  - Na terugkoppeling van PM met time/cost estimates een
    bevestiging/annulering optie?

- Toevoegen/aanpassen SLA? (PM) -->

### Non-functioneel

#### Usability

- NFR1: Werkt op alle Windows en MacOS versies van de afgelopen 2 jaar?
- PWA/site/app

#### Reliability

- NFR?: database back-ups?
- NFR?: Het systeem maakt gebruik van het al draaiende Productive.io systeem als Single Source of Truth.

#### Performance

- NFR?: Het systeem mag met N aantal gebruikers niet boven de 100 requests per 10 seconde rate limit van de productive.io mogen komen.
- NFR?: Het systeem mag met N aantal gebruikers niet boven de 10 rapport generating per 30 seconde requests rate limit van productive.io mogen komen.

#### Supportability

- NFR?: Het systeem dient beschikbaar te zijn in Nederlands en Engels, met optie tot uitbreiding.

<!-- ### Plus

#### Design constraints

#### Implementation requirements

#### Interface requirements

#### Physical requirements -->

- Het systeem zou moeten werken binnen het huidige productive abonnement


- Voor de back-end wordt gebruik gemaakt van .NET <span class="mark">framework</span> om bedrijf standaarden te hanteren.
- Voor het front-end wordt gebruik gemaakt van React Native om bedrijf standaarden te hanteren.

### Fully dressed Use Cases

#### FR1: Inzien projecten

| |  |
|---|---|
| Naam | FR1: Inzien projecten |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | PM, TL, SD |
| Pre condities | De klant kan inloggen in het PMP. |
| Post condities | De klant heeft een lijst met de voor hem beschikbare projecten. |
| Triggers | De klant vraagt de lijst met voor hem beschikbare projecten op |
| Exceptions |  |
| Open issues | Data verzamelen: Wie is de klant, wat zijn zijn projecten? |

##### FR1: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Opent de PWA |  |
| 2 | Toont alle voor de klant beschikbare projecten | |

##### FR1: Alternative flow - no projects for customer

|Stap| Actor | System |
|---|---|---|
| 2A |  | Toont geen projecten omdat er geen projecten aan de klant gekoppeld zijn. |


#### FR2: Inzien uit te voeren taken in een project

| |  |
|---|---|
| Naam | FR2: Inzien uit te voeren taken in een project |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | PM |
| Pre condities | DDe klant kan inloggen in het PMP. </br> De klant heeft op zijn minst één gepland, lopend of afgerond project bij Bluenotion. |
| Post condities | De klant heeft een overzicht van de taken die voor de software developers op de planning staan. [(planning van lifecycle taken)](#lifecycle-taken) |
| Triggers | De klant vraagt de details voor een project op |
| Exceptions | Het opgevraagde project bestaat niet |
| Open issues |  |

<!-- TODO: Exception staat ook bij preconditie -->

##### FR2: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Vraagt voor een project alle bijbehorende taken op |  |
| 2 |  | Presenteert een aantal lijsten met uit te voeren taken, geplande taken, taken waar de gebruiker feedback op moet geven en afgeronde taken. |

##### FR2: Alternative flow - Project heeft geen taken

|Stap | Actor | System |
|---|---|---|
| 2A |  | Toont lege takenlijsten |

#### FR3: Toevoegen nieuwe taak in een project

| |  |
|---|---|
| Naam | FR3: Toevoegen nieuwe taak in een project |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | PM |
| Pre condities | De klant kan inloggen in het PMP. </br> De klant heeft op zijn minst één gepland, lopend of afgerond project bij Bluenotion. |
| Post condities | Er is binnen Productive een nieuwe taak toegevoegd aan de wishlist. |
| Triggers | De klant geeft aan werk gedaan te willen hebben. |
| Exceptions | Het opgevraagde project bestaat niet. |
| Open issues | Maakt de PM/TL hier ook gebruik van of is dit specifiek voor de klant? </br> Kunnen projecten permanent gesloten/gearchiveerd zijn en dus niet meer bijgevuld worden? |

##### FR3: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan een wens te hebben voor een bestaand project |  |
| 2 |  | Stelt de gebruiker een aantal vragen om de wens van de klant duidelijk te krijgen. |
| 3 | Controleert de ingevulde vragen, past ze aan waar nodig en stuurt ze op voor verdere verwerking |  |
| 4 |  | Maakt op basis van de ingevulde gegevens een taak aan op de wishlist in Productive. |

##### FR3: Alternative flow - blocking issue

|Stap | Actor | System |
|---|---|---|
| 4A |  | Taak is een blocker met hoge priority dus wordt direct in de backlog gezet? |

#### FR4: Taak open zetten voor feedback klant

| |  |
|---|---|
| Naam | FR4: Taak open zetten voor feedback klant |
| Primaire Actor | ACT2: Project Manager, ACT4: Tech Lead |
| Stakeholders | ACT1: Externe klant, ACT3: Software developer |
| Pre condities | Er bestaat op zijn minst één project, taak en klant.  |
| Post condities | De klant wordt op de hoogte gebracht dat er om feedback is gevraagd. |
| Triggers | De PM of TL stelt vast dat een taak nog niet duidelijk genoeg is voor voor de backlog. |
| Exceptions |  |
| Open issues | Heeft een klant één of meerdere representatieoren? Als meer, een selectie wie je op de hoogte brengt of broadcast naar iedereen die feedback mag geven? </br> Hoe willen we klanten op de hoogte stellen? aan de hand van mail/sms? enkel het portaal? </br> Wat kan de klant aanpassen in een taak? Wat moet er gebeuren als een klant bijvoorbeeld de cost estimate van een taak voor nu te hoog vindt? Blijft een taak als dit op de wishlist of wordt deze alsnog naar de backlog gehaald? |

##### FR4: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Geeft bij een taak op de wishlist aan wat mist of onduidelijk is aan de taak. |  |
| 2 |  | Registreert de taak als "waiting for customer" en stelt de klant (open issues) op de hoogte |

##### FR4: Alternative flow - Klant geeft meerdere wensen door in één taak op de wishlist

|Stap | Actor | System |
|---|---|---|
| 1A | Maakt per taak een nieuwe taak aan en geeft aan dat deze feedback nodig hebben van de klant |  |
| 2A |  | Resume normal flow but for every new task |

#### FR5: Goedkeuren extern toegevoegde taken

| |  |
|---|---|
| Naam | FR5: Goedkeuren extern toegevoegde taken |
| Primaire Actor | ACT2: Product manager, ACT4: Tech Lead  |
| Stakeholders | ACT1: Externe klant |
| Pre condities | Er is een taak toegevoegd in de wishlist van een project. |
| Post condities | De bovengenoemde taak is toegevoegd aan de backlog van het project. |
| Triggers | De primaire actor geeft aan dat een taak duidelijk genoeg is voor development. |
| Exceptions | De taak is in de tussentijd verwijderd door de externe klant? |
| Open issues |  |

##### FR5: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | De PM of TL geeft aan dat de taak voldoende is ingevuld voor development en kent er een time/cost estimate aan. |  |
| 2 |  |  |

##### FR5: Alternative flow - flow name


#### FR?: Overzicht geheel proces aanmaken en goedkeuren nieuwe taak vanuit klant.

|Stap | Actor | System |
|---|---|---|
| 1 | EK: Geeft aan een wens te hebben voor een project |  |
| 2 |  | Registreert de wens in de wishlist van het project als "waiting for PM" |
| 3 | PM: geeft aan dat de taak voldoende is ingevuld voor development en kent er een time/cost estimate aan. |  |
| 4 |  | Registreert de wens als "Waiting for EK" |
| 5 | EK: keurt de time/cost estimate goed |  |
| 6 |  | Registreert de wens als "Accepted" en zet deze taak in de backlog voor development |
| 7 | SD: werkt aan de taak en zet deze binnen Productive op In Progress, In review, Development, Testing, Staging en Live. |  |
| 8 |  | Stelt de klant op de hoogte als voor hem relevante taken in het "Live" bord terecht komen. (Of gewoon status closed?) |


|Stap | Actor | System |
|---|---|---|
| 3A | PM: geeft aan dat de taak onvoldoende is ingevuld voor development. |  |
| 4A |  | FR5: Goedkeuren extern toegevoegde taken |

| 5B | EK: Geeft aan dat de wens te duur is voor het resultaat |
| 6B |  | ??? |

<!-- 
https://www.studocu.com/row/document/riphah-international-university/computer-sciences/fully-dressed-use-case-example-pdf/19676384

https://www.tmaworld.com/2017/10/04/use-case-approach/#:~:text=Fully%20dressed%20use%20case%3A%20A,goals%2C%20tasks%2C%20and%20requirements.

 -->
#### FR?: Empty FDUC

| |  |
|---|---|
| Naam | FR?: Empty FDUC |
| Primaire Actor | ACT?:  |
| Stakeholders |  |
| Pre condities |  |
| Post condities |  |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

##### FR?: Main flow

|Stap | Actor | System |
|---|---|---|
|  |  |  |
|  |  |  |

##### FR?: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |
