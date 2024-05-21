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

In dit hoofdstuk wordt toelichting gegeven op het domein waarin het systeem zich bevind. Aangezien het PMP zal draaien als koppeling tussen de klant en het Productive systeem van Bluenotion is het onderstaande domeinmodel ingedeeld in concepten binnen productive en concepten binnen Bluenotion (aangeduid in het vak Project management portal). Hiermee worden de afhankelijkheden naar het productive systeem direct vastgelegd.

```plantuml

'abstract placeholder
' skinparam linetype polyline
skinparam linetype ortho




rectangle "Project management portal"{
together{
entity Klant
entity Aanvraag
entity Team
entity SLA
}

rectangle "Productive"{
together{
  entity Project
  entity Board
  entity Taak
  entity Prioriteit
  entity Type
  entity Werknemer
}


note "1. Blocker \n2. Critical \n3. Major \n4. Minor \n5. Trivial \n6. Reminder" as TaakPrioriteiten
note "1. Bug\n2. Story\n3. Task\n4. Improvement \n5. New feature" as TaakTypes
}

}

TaakPrioriteiten .. Prioriteit
TaakTypes .. Type

Klant "1..*?" -- "0..*" Project : > Eigenaar van
Board "1..*"--"1" Project: > Planning voor 
Taak "0..*"--"1" Board: > Opgenomen in
Prioriteit "1"--"0..*" Taak: > Voor
Taak "0..*"--L--"1" Type : > Ingediend als
Aanvraag "1"--"1..*" Taak :> Resulteert in
Werknemer "0..*"-R-"0..*" Taak :> Werkt aan
Werknemer "0..*"--"0..*" Team :> Onderdeel van
Taak "1"--"1" Team :> beschrijft werkzaamheden voor

Klant "1"-L-"0..*" Aanvraag :> Doet een
Project "0..*"--"1" SLA :> Valt onder
SLA "0..*"--"0..*" Type :> Bepaalt
SLA "0..*"--"0..*" Prioriteit :> Bepaalt
```

### Toelichting domeinmodel

| Term | Uitleg | Oorsprong |
|---|---|---|
| Project | Een stuk software dat een **Klant** wilt laten ontwikkelen door Bluenotion. | FR1 |
| Klant  | Een individu of organisatie die bij Bluenotion een of meer projecten heeft lopen bij Bluenotion | FR1 |
| Aanvraag | Iets dat de **klant** wil in zijn/haar **project** | FR3 |
| Taak | Een **Aanvraag** waar een [PM](#act2-product-manager) of [TL](#act4-tech-lead) goedkeuring voor heeft gegeven voor ontwikkeling. Dit kunnen nieuwe functionaliteiten en bugfixes zijn. Toelichting over de lifecycle van taken is [hier onder](#lifecycle-taken) te vinden. | FR2, FR3 |
| Bord | Een bord waar intern voor Bluenotion taken op worden bijgehouden. Zie [lifecycle taken](#lifecycle-taken) voor meer informatie. | FR3,FR4,FR5 |
| Team | Een representatie van de rollen en beschikbare kennis binnen Bluenotion die worden gebruikt voor het toekennen van de juiste taak aan de juiste werknemers. (UX, FE, BE) | FR??? Niet besproken |
| Prioriteit | De prioriteit van de taak, afhankelijk van of mensen nog kunnen werken en de wensen van de opdrachtgever. | FR? |
| Type | Het soort taak, afhankelijk van de SLA met de klant. | FR? |
| Werknemer | Een werknemer van Bluenotion die aan taken werkt en de status hiervan bijhoudt in Productive. | NFR2 |
| SLA | Een **klant** heeft een aantal afspraken voor een **project** vaststaan in een Service Level Agreement waar KPI's zijn vastgelegd die leidend zijn in de **prioriteit** en het **type** van een taak. |  |

#### Taak Impact, Urgentie en Prioriteit levels

TODO: Toelichten prioriteit taken

![alt text](image.png)

### Lifecycle taken

Aangezien het beheren van de workflow van taken een groot aspect zijn van het PMP is een korte toelichting gemaakt op de levensloop van een typische taak. Dit proces kan per project verschillen met details als of klanten zelf toegang hebben tot Productive of toevoeging/weglaten van sommige task lists maar het blijft in grove lijnen over de meeste projecten het zelfde.

Als een klant iets wil in zijn/haar project doen ze hier een aanvraag voor. Op basis van deze aanvraag maakt de PM of TL (afhankelijk van de functionele of technische aard van de aanvraag) hier taken van. Deze taken worden over de loop van tijd op verschillende borden gezet met verschillende verwachtingen van **wie** **wat** gaat doen met de taak. Hier onder volgt een generalisatie van hoe de workflow van de meeste projecten loopt.

```plantuml
title Boards and statuses

left to right direction
skinparam groupInheritance 3

' skinparam linetype polyline
' skinparam linetype ortho
(backlog) #orange
(in progress) as in_progress  #orange
(in review) as in_review #orange 
(development) #orange
(staging) #orange
(live) #green
(wishlist) #red
(aanvragen) #red
(awaiting customer) as awaiting_customer #red
actor "Externe klant" as EK


aanvragen -DOWN-> backlog : ✓
wishlist -[norank]-> in_progress : ✓
backlog -DOWN-> in_progress : ✓
in_progress -DOWN-> in_review : ✓
in_review -DOWN-> development : ✓
development -DOWN-> staging : ✓
staging -DOWN-> live : ✓
in_review -[norank]-> backlog : Denied by reviewer
wishlist -[norank]-> wishlist : Denied by PM/TL
aanvragen -[norank]-> aanvragen : Denied by PM/TL
development -[norank]-> backlog : Denied by customer
staging -[norank]-> backlog : Denied by customer
in_progress -[norank]-> wishlist : functionality is nice to have but outside of scope
EK --> aanvragen
aanvragen -[norank]-> awaiting_customer : \t Denied by PM/TL
awaiting_customer -[norank]->aanvragen : Added feedback \t

legend left
    | Color | Status |
    |<#Red>| Not started |
    |<#Orange>| Started/Open |
    |<#Green>| Finished/closed |
    | ✓ | Accepted |
endlegend

```

Toelichting borden:

- **Aanvragen**</br>Taken die door de klant zijn ingeschoten maar nog niet geaccepteerd door de PM en/of TL komen op de aanvragen lijst terecht.
- **Awaiting customer** (new!)</br> Taken die incorrect of incompleet zijn ingevuld door de klant worden door de PM of TL op dit bord neergezet met een vraag voor extra feedback van de klant.
- **Wishlist**</br>Taken die tijdens ontwikkeling naar boven zijn gekomen als "Nice to haves" en worden opgepakt als er tijd over is.
- **Backlog**</br>De backlog is waar geaccepteerde taken terecht komen. Vanaf de backlog pakken de aangewezen teams de taken op.
- **In progress**</br>Zodra een developer een taak op pakt wordt deze als In progress geregistreerd.
- **In review**</br>Nadat een developer aan een taak heeft gewerkt wordt deze klaar gezet voor review.
- **Development**</br>Alle afgeronde taken die draaien in de dev omgeving?
- **Staging**</br>Alle afgeronde taken die draaien in de test omgeving tot.... sprint review?
- **Live**</br>Alle afgeronde taken die draaien op de klant omgeving.

Toelichting statussen:

De klant is geïnteresseerd in delen van dit proces en zou ingelicht moeten worden als er voor hem relevante wijzigingen zijn in taken.

- **Not started** </br> Een taak die nog niet gestart is. Dit kan meerdere redenen hebben die naar de klant gecommuniceerd dienen te worden.
  - **Waiting for reply PM/TL** </br> Een taak die binnen is gekomen via de klant waar nog geen goedkeuring op is gegeven door een PM/TL. Deze taken kunnen enkel voorkomen in de TODO: NAVRAGEN ~~wishlist~~ en aanvragen lijsten.
  - **Waiting for reply customer** </br> Een taak die is gecontroleerd door de PM/TL en met vraag voor extra verduidelijking terug wordt gestuurd naar de opdrachtgever.
- **Started/Open** </br> Een taak die is goedgekeurd door een PM/TL waar verschillende medewerkers van Bluenotion aan (gaan) werken.
- **Finished/Closed** </br> Een taak die is afgerond en op de live omgeving staat. Deze taken dienen als archief van geleverd werk.

## Requirements

```plantuml
left to right direction

:ACT1 Externe klant: as KL
:ACT4 Tech lead: as TL
:ACT2 Product manager: as PM

(FR1: Inzien projecten) as FR1
(FR2: Inzien taken) as FR2
(FR3: Toevoegen taak) as FR3
(FR4: Vragen feedback klant) as FR4
(FR5: Goedkeuren extern toegevoegde taken) as FR5

KL -DOWN-> FR1
KL -DOWN-> FR2
KL -DOWN-> FR3


TL-DOWN->FR5
PM-DOWN->FR5
TL-DOWN->FR4
PM-DOWN->FR4

PM-LEFT-|>KL
TL-LEFT-|>KL


```

### User stories

| User story no | Gerelateerde actors  | User story  | Resulterende requirement(s)  |
|---|---|---|---|
| US1   | ACT1  | Als PM wil ik een eenduidig overzicht van alle projecten die lopen binnen Bluenotion zodat ik snel de status met een klant kan bespreken.  | FR1  |
| US2  | ACT2 | Als externe klant wil ik een eenduidig overzicht van alle voor mij relevante projecten zodat ik snel kan zien welke projecten actief aan gewerkt worden.  | FR1  |
| US3  | ACT2 | Als externe klant wil ik een overzicht van het geplande werk zodat ik zicht kan houden op de ontwikkeltijd en kosten. | FR2 |
| US4?  | ACT1  | Als PM wil ik de zelfde informatie kunnen zien als een externe klant zodat ik bij vragen de klant kan ondersteunen.  | FR2   |
| US5  | ACT3  | Als Bluenotion medewerker wil ik niet mijn werkwijze aanpassen om een nieuw systeem voor de klant te ondersteunen.  |   |
| US6  | ACT2  | Als externe klant wil ik bij mijn projecten de optie om nieuwe taken toe te voegen zodat ik issues en door ontwikkelingen kan doorgeven.  | FR2  |
| US7  | ACT1, ACT2  | Als PM wil ik bij taken die onduidelijk of incorrect ingevuld zijn de klant de optie geven deze onduidelijkheid te verhelderen.  | FR2  |
| US8  | ACT2  | Als externe klant wil ik bij taken die extra toelichting nodig hebben feedback kunnen geven op deze taken zodat ze goedgekeurd kunnen worden voor de backlog.  | FR2  |
| US9  | ACT2  | Als externe klant wil ik een eenduidig overzicht van taken die wachten op mijn input voordat er aan gewerkt wordt zodat deze taken niet onnodig lang blijven liggen.  | FR2  |
| US10  | ACT1  | Als PM wil ik bij taken die toegevoegd zijn door een externe klant taken goedkeuren voor ze op de backlog terecht komen.  | FR2  |
| US11  |   | Als ?software developer? wil ik geen data over het netwerk sturen waar de klant geen toegang toe heeft.  |   |


<!-- Is dit een fr of valt dit onder fr aanmaken/feedback geven? -->
<!-- - FR?: Toevoegen screenshots aan een taak
- FR?: Mention screenshots in taak description
- FR?: Aanpassen geaccepteerde taken? Kunnen taken die al op de backlog (of verder) nog aangepast worden door de klant? idee: naam en beschrijving niet, comments kunnen wel toegevoegd worden?
- FR?: Aanpassen prioriteit
- FR?: Aanpassen taak type
- FR?: Priority afleiden van de SLA
- FR?: Verkopen extra uren indien deze binnen Bluenotion beschikbaar zijn.
- FR?: Pre-project proces vastleggen in PMP
- FR?: Authenticatie en Autorisatie gebeurt binnen het PMP
- FR?: Klanten kunnen enkel data zien en aanpassen voor de projecten waar ze beheerder van zijn.
- FR?: Acties die effect hebben op de staat van een project (bijvoorbeeld FR3, FR4, FR5) dienen gelogd te worden.
- FR?: klanten kunnen tickets voor verschillende omgevingen aanmaken.
- FR?: Bij het accepteren van een taak aanvinken voor welke teams dat de taak is en subtaken aanmaken voor UX, FE, BE.... (Niet besproken) -->

### Requirements table

| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Dependencies | Document references |
|---|---|---|---|---|---|
|   |   |   |   |   |   |
| FR1  | Inzien project plannings informatie |   | Must have  | NFR0.5  |   |
| FR1.1  |   | Inzien projecten  | Must have  | NFR0.5  |   |
| FR1.2  |   | Inzien totaal geplande uren+kosten  | Must have  | FR1.1  |   |
| FR2  | Inzien taken  |   |   |   |   |
| FR2.1  |   | Inzien taken van project  | Must have  |   |   |
| FR2.2  |   | Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed | Must have |  |  |
| FR2.3  |   | Inzien taak details  | Must have  |   |   |
| FR2.4  |   | Tonen taken in Gantt chart?  | Could have |  |  |
| FR2.5  |   | Aanpassen taak prioriteit? (TODO: navragen, escalatie prioriteit punt 9.3 bronze SLA) |  |  |  |
| FR2.6  |   | Comments toevoegen op lopende taak?  |   |  |  |
| FR2.7  |   | Filteren taken op: incident of doorontwikkeling  | Should have  |   |   |
| FR3 | Toevoegen taken |  |  |  |  |
| FR3.1  |   | Toevoegen nieuwe taak (extern)  | Must have  |   |   |
| FR3.2  |   | Toelichting geven op taak (extern)  | Must have  |   |   |
| FR3.3  |   | Controleren aanvraag (intern)  | Must have  |   |   |
| FR3.4  |   | Op splitten taak naar "team" taken | Could have |   |   |
| FR3.5  |   | Toevoegen taken past zich aan aan de klant zijn SLA | Could have | FR1.4 |  |
| FR3.6 |   | Toevoegen bijlagen bij taak | Must have |  |  |
| FR3.7  |   | Toevoegen bijlagen binnen feedback | Should have? |  |  |
| FR4?  | Versturen notificaties  |   |   |   |   |
| FR4.1?  |   | Inlichten klant wanneer een taak wacht op input van de klant  |   |   |   |
| FR4.2?  |   | Inlichten Bluenotion bij blockers/criticals?  |   |   |   |
| FR5? | Opstellen project |  |  |  |  |
| FR5.1  |   | Afhandelen project setup binnen PMP  | Could have  |   |   |
| FR6  | Inzien project service statuses  |   |   |   |   |
| FR6.1  |   | Inzien lijst van project dependencies  |   |   |   |
| FR6.2  |   | Inzien huidige status (online/offline) project dependencies |   |   |   |
| FR6.3  |   | Beheren project services  |   |   |   |
| FR7  | Inzien project documentatie |  |  |  |  |
| FR7.1  |   | Openen/downloaden document  |   |   |   |
| FR7.2  |   | Filteren documentnaam/categorie?  |   |   |   |
| FR7.3  |   | Beheren project documentatie  |   |   |   |
| NFR  | Usability  |   |   |   |   |
|   |   | Het systeem dient beschikbaar te zijn in Nederlands en Engels, met optie tot uitbreiding.  |   |   |   |
| NFR  | Reliability  |   |   |   |   |
|   |   | Informatie over projecten en taken komen altijd overeen met de informatie op Productive.  |   |   |   |
|   |   | Het systeem geeft bij 95% van de requests in een maand antwoord zoals beschreven in dit document.  |   |   |   |
| NFR  | Performance  |   |   |   |   |
|   |   | Onder normale omstandigheden wordt data die niet afkomstig is van de Productive API binnen 1? seconde na aanvraag getoond aan de gebruiker.  |   |   |   |
|   |   | Onder normale omstandigheden wordt data die afkomstig is van de Productive API binnen 3? seconden na aanvraag getoond aan de gebruiker. |   |   |   |
| NFR  | Security |  |  |  |  |
|   |   | Authenticatie: Uitnodigen nieuwe gebruikers via e-mail | Must have |  |  |
|   |   | Authenticatie: Aanmelden met e-mail en wachtwoord  | Must have  |   |   |
|   |   | Autorisatie: Afschermen ongerelateerde project/taak info  | Must have  |   |   |
|   |   | Autorisatie: Autorisatie gebeurt volledig binnen de back-end en database |   |   |   |
|   |   | Accounting: Loggen write events  | Must have?  |   |   |
|   |   | Accounting: Loggen read events?  | Could have?  |   |   |
|   |   | Het systeem is AVG/GDPR compliant (TODO: smart uitwerken.)  |   |   |   |
|   |   |   |   |   |   |
| NFR  | Scalability  |   |   |   |   |
|   |   | De software komt met 50? gelijktijdige gebruikers niet aan de Productive API rate limits  | Should have  |   |   |
|   |   | De software komt ongeacht hoeveelheid gelijktijdige gebruikers niet aan de Productive API rate limits?  | Would have  |   |   |
| NFR  | Portability  |  |   |   |   |
|   |   | Het systeem schaalt "netjes"? op alle Windows en MAC versies van de afgelopen 3? jaar  |   |   |   |
|   |   | Het systeem is platform onafhankelijk (zou implementaties kunnen hebben met bijvoorbeeld Jira, GitLab, Trello)  | Would  |   |   |
|   |   | Het systeem werkt in alle FireFox, Chrome, Edge en Safari versies van de afgelopen 3? jaar.  |   |   |   |
| NFR | Compatibility  |   |   |   |   |
|   |   | Het systeem werkt op alle Windows en MAC versies van de afgelopen 3? jaar  | Must have  |   |   |
| NFR  | Maintainability  |   |   |   |   |
|   |   | Het systeem kan bij verlies van de database binnen 3 uur hersteld worden naar een werkende state.  |   |   |   |
|  |   |  Bij verlies van de database raken geen gegevens over projecten of taken verloren.|  |  |  |
|   |   | Bij verlies van de database raken geen gegevens ouder dan 24 uur verloren.  |   |   |   |

### unsorted

| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Dependencies | Document references |
|---|---|---|---|---|---|
| FR1.3  |   | Toekennen overige project uren  | Could have  | FR1.2  |   |
| FR1.4  |   | Toekennen SLA KPI's | Could have  | FR1.1  |   |
|   |   |   |   |   |   |
| NFR0  | Opzetten technische infrastructuur  |   | Must have  |   |   |
| NFR0.1  |   | Opzetten initial Front-end  | Must have  |   |   |
| NFR0.2  |   | Opzetten initial Back-end  | Must have  |   |   |
| NFR0.3  |   | Opzetten initial database  | Must have  |   |   |
| NFR0.4  |   | Opzetten test infrastructuur  | Must have  |   |   |
| NFR0.5  |   | Opzetten verbinding Productive.io API | Must have  |  |  |
| NFR0.6  |   | Opzetten mailing system  | Must have  |   |   |
| NFR0.7  |   | Opzetten internationalisatie infrastructuur | Should have |  |  |
|   |   |   |   |   |   |
|   |   |   |   |   |   |
|   |   |   |   |   |   |
|   |   |   |   |   |   |
|   |   |   |   |   |   |

<!-- NFR categories: https://www.altexsoft.com/blog/non-functional-requirements/ -->
<!-- https://www.altexsoft.com/blog/software-requirements-specification/ -->
<!-- Tracability matrix: https://www.researchgate.net/figure/Requirements-traceability-matrix-for-online-shopping-system_tbl4_280083523 -->

### Fully dressed Use Cases

#### FR1.1: Inzien projecten

| FR1.1 | Inzien projecten  |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | PM, TL, SD |
| Pre condities | De klant kan inloggen in het PMP. |
| Post condities | De klant heeft een lijst met de voor hem beschikbare projecten. |
| Triggers | De klant vraagt de lijst met voor hem beschikbare projecten op |
| Exceptions |  |
| Open issues | Data verzamelen: Wie is de klant, wat zijn zijn projecten? |

##### FR1.1: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Vraagt de lijst met alle beschikbare projecten op |  |
| 2 |  | Toont alle voor de klant beschikbare projecten |

##### FR1.1: Alternative flow - no projects for customer

|Stap| Actor | System |
|---|---|---|
| 2A |  | Toont geen projecten omdat er geen projecten aan de klant gekoppeld zijn. |

#### FR1.2: Inzien totaal geplande uren+kosten

| FR1.2 | Inzien totaal geplande uren+kosten  |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders |  |
| Pre condities | De klant is aangemeld in het PMP </br> De klant heeft op zijn minst één project in het PMP. |
| Post condities | De klant heeft een overzicht van de op het moment openstaande hoeveelheid uren en de kosten hiervan bij een project.  |
| Triggers | De klant opent het project overview |
| Exceptions |  |
| Open issues |  |

##### FR1.2: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Opent de project overview van een van zijn projecten |  |
| 2 |  | Toont de actuele tijd en kosten planning |

##### FR1.2: Alternative flow - Geen uren ingepland op het project

|Stap | Actor | System |
|---|---|---|
| 2 |  | Toont de actuele tijd en kosten planning als 0 |

#### FR2.1: Inzien taken van project

| FR2.1 | Inzien taken van project |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | PM |
| Pre condities | De klant kan inloggen in het PMP. </br> De klant heeft op zijn minst één gepland, lopend of afgerond project bij Bluenotion. |
| Post condities | De klant heeft een overzicht van de taken die voor de software developers op de planning staan. [(planning van lifecycle taken)](#lifecycle-taken) |
| Triggers | De klant vraagt de details voor een project op |
| Exceptions | Het opgevraagde project bestaat niet |
| Open issues |  |

<!-- TODO: Exception staat ook bij preconditie -->

##### FR2.1: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Vraagt voor een project alle bijbehorende taken op |  |
| 2 |  | Presenteert een aantal lijsten met uit te voeren taken, geplande taken, taken waar de gebruiker feedback op moet geven en afgeronde taken. |

##### FR2.1: Alternative flow - Project heeft geen taken

|Stap | Actor | System |
|---|---|---|
| 2A |  | Toont lege takenlijsten |

#### FR2.2: Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed

| FR2.2 | Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | PM |
| Pre condities | De klant kan inloggen in het PMP. </br> De klant heeft op zijn minst één gepland, lopend of afgerond project bij Bluenotion. |
| Post condities | De klant heeft een gefilterd/gesorteerd overzicht van alle voor hem relevante taken. |
| Triggers | De klant vraagt de details voor een project op |
| Exceptions | Het opgevraagde project bestaat niet |
| Open issues |  |

##### FR2.2: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Vraagt voor een project alle bijbehorende taken op |  |
| 2 |  | Presenteert een aantal lijsten met uit te voeren taken, geplande taken, taken waar de gebruiker feedback op moet geven en afgeronde taken. |

##### FR2.2: Alternative flow - Project heeft geen taken

|Stap | Actor | System |
|---|---|---|
| 2A |  | Toont lege takenlijsten |

#### FR2.3: Inzien taak details

| FR2.3 | Inzien taak details |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | PM |
| Pre condities | De klant kan inloggen in het PMP. </br> De klant heeft op zijn minst één gepland, lopend of afgerond project bij Bluenotion met op zijn minst één bijbehorende taak. |
| Post condities | De klant heeft een overzicht van de voor hem relevante informatie over een taak zoals de status, geplande uren/kosten, due date, priority en type. (heeft een klant toegang tot de comments van een taak?) |
| Triggers | De klant vraagt de details voor een taak |
| Exceptions | De opgevraagde taak bestaat niet |
| Open issues |  |

##### FR2.3: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Vraagt voor een specifieke taak de taak details op |  |
| 2 |  | Toont de naam, status, geplande uren/kosten, due date, prioriteit en type van de geselecteerde taak. |

#### FR2.4: Tonen taken in Gantt chart

| FR? | Tonen taken in Gantt chart |
|---|---|
| Prioriteit | Could have |
| Primaire Actor | ACT1: Externe klant  |
| Stakeholders |  |
| Pre condities | Er zijn taken ingepland voor een project van de klant |
| Post condities | De gebruiker krijgt een overzicht van wanneer welke taken gepland staan. |
| Triggers | De klant geeft aan een visueel overzicht te willen van wanneer welke taken af zijn. |
| Exceptions |  |
| Open issues | Is dit wel een wens?</br>Timeline vs GANTT chart |

TODO: open issues navragen

##### FR2.4: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Aanvraag |  |
| 2 |  | Resultaat |

##### FR2.4: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

#### FR2.5: Aanpassen taak prioriteit

TODO: verder uitwerken.

| FR2.5 | Aanpassen taak prioriteit |
|---|---|
| Prioriteit | ?  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | PM |
| Pre condities | Taak is een incident |
| Post condities | Escalatie naar het juiste niveau. |
| Triggers | De klant is het niet eens met de toegekende prioriteit (punt 9.3 SLA) |
| Exceptions |  |
| Open issues |  |

##### FR2.5: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan het niet eens te zijn met de toegekende prioriteit |  |
| 2 |  | Geeft de optie de prioriteit aan te passen? |
| 3 | Past de impact of urgentie aan |  |
| 4 |  | Berekent de nieuwe prioriteit voor de taak, toont deze en slaat hem op bij de taak. |
| 2 |  | Geeft aan contact op te moeten nemen met de servicedesk? |
| 2 |  | ? |


##### FR2.5: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
| 4A |  | Geeft aan dat de nieuwe prioriteit 1 of 2 is en daarmee direct contact op genomen dient te worden met Bluenotion. |

#### FR2.6: Comments toevoegen op lopende taak?

TODO: het zou me niets verbazen als deze FR niet bestaat.

| FR2.6 | Comments toevoegen op lopende taak? |
|---|---|
| Prioriteit |   |
| Primaire Actor | ACT?:  |
| Stakeholders |  |
| Pre condities |  |
| Post condities |  |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

##### FR2.6: Main flow

|Stap | Actor | System |
|---|---|---|
|  |  |  |
|  |  |  |

##### FR2.6: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

#### FR3.1: Toevoegen nieuwe taak in een project

| FR3.1 | Toevoegen nieuwe taak in een project |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | PM |
| Pre condities | De klant kan inloggen in het PMP. </br> De klant heeft op zijn minst één gepland, lopend of afgerond project bij Bluenotion. (TODO: hoort afgerond in deze lijst?) |
| Post condities | Er is binnen Productive een nieuwe taak toegevoegd aan de aanvragen lijst. |
| Triggers | De klant geeft aan werk gedaan te willen hebben. |
| Exceptions | Het opgevraagde project bestaat niet. |
| Open issues | Maakt de PM/TL hier ook gebruik van of is dit specifiek voor de klant? </br> Kunnen projecten permanent gesloten/gearchiveerd zijn en dus niet meer bijgevuld worden? |

##### FR3.1: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan een aanvraag te hebben voor een bestaand project |  |
| 2 |  | Presenteert de gebruiker met een aantal invoer velden om informatie te verzamelen op de taak. |
| 3 | Vult de gepresenteerde velden in met informatie over de taak. |  |
| 4 |   | Toont de ingevoerde informatie nogmaals en vraagt de gebruiker of de informatie correct is.  |
| 5 | Controleert de ingevulde informatie en geeft aan dat de informatie correct is. |  |
| 6 |  | Maakt op basis van de ingevulde gegevens een taak aan op de aanvragen lijst in Productive. </br> TODO: navragen, tonen verwachte reactie tijd/opvolg instructies? Dit zou afhankelijk zijn van het SLA dus deel van FR3.5? |

*Schatting van de door de actor aan te leveren informatie:

Titel, korte omschrijving, Screenshot (urgentie & impact zie FR3.5)

##### FR3.1: Alternative flow - Hoge prioriteit taak

A: Doorgeven hoge prioriteit

B: Aanpassen naar lage prioriteit

|Stap | Actor | System |
|---|---|---|
| 4A |  | De taak heeft een prioriteit van 1 of 2 (zie [toelichting prioriteit taken](#taak-impact-urgentie-en-prioriteit-levels)) |
| 5A   |   | Geeft aan dat de taak critical is en vraagt om critical taken telefonisch door te geven. |
| 6A | De klant geeft de taak telefonisch door | |
| 6B | De klant past de urgentie of impact aan zodat de taak een prioriteit boven de 3 krijgt |  |
| 7B |  | Resume main flow at 4 |

##### FR3.1: Alternative flow - Incomplete invoer

A: Aanvullen missende informatie

|Stap | Actor | System |
|---|---|---|
| 3A  | Vult vereiste informatie niet in in de invoervelden  |   |
| 4A  |  | Geeft aan welke velden informatie missen  |
| 5A  | Vult de informatie aan |  |
| 6A  |   |  Resume main flow at 4 |

#### FR3.2: Toelichting geven op taak

| FR3.2 | Toelichting geven op taak |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe klant  |
| Stakeholders | ACT2: PM |
| Pre condities | De actor heeft een taak bij een project waar vraag naar feedback voor is gedaan. |
| Post condities | De feedback staat bij de taak in productive. </br> De taak staat niet meer geregistreerd als "waiting for feedback" |
| Triggers | De PM of TL heeft één of meer vragen gesteld bij een taak |
| Exceptions |  |
| Open issues | Wat als de gebruiker de functionaliteit na nader bespreking niet meer hoeft? |

##### FR3.2: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Navigeert naar de aanvraag details in het PMP  |   |
| 2 |   | Toont de vragen zoals gesteld door de PM/TL  |
| 3 | Vult de aanvraag waar nodig aan met de gevraagde informatie |   |
| 4 |   | Zet de nieuwe versie van de aanvraag in productive in de lijst met aanvragen.  |

##### FR3.2: Alternative flow - Annulering aanvraag

A: Gebruiker annuleert de aanvraag.

|Stap | Actor | System |
|---|---|---|
| 3A | De gebruiker kiest er voor de aanvraag te annuleren |  |
| 3A |  | Registreer de aanvraag als closed in productive |

TODO: is het wel closed of een andere status? Moet ik hier iets zeggen over logging?

#### FR3.3: Controleren aanvraag

| FR3.3 | Controleren aanvraag|
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT2: Project Manager, ACT4: Tech Lead |
| Stakeholders | ACT1: Externe klant, ACT3: Software developer |
| Pre condities | Er is een project waar een klant een aanvraag heeft gedaan.  |
| Post condities | De klant wordt op de hoogte gebracht dat er om feedback is gevraagd. </br> De taak staat op het "Awaiting customer" bord. |
| Triggers | Er staan taken in de "Aanvraag" lijst. |
| Exceptions | In de tijd dat de vraag wordt gecontroleerd is de taak door de klant verwijderd. |
| Open issues | Heeft een klant één of meerdere representatieoren? Als meer, een selectie wie je op de hoogte brengt of broadcast naar iedereen die feedback mag geven? </br> Hoe willen we klanten op de hoogte stellen? aan de hand van mail/sms? enkel het portaal? </br> Wat kan de klant aanpassen in een taak? Wat moet er gebeuren als een klant bijvoorbeeld de cost estimate van een taak voor nu te hoog vindt? Blijft een taak als dit op de aanvragen of wordt deze alsnog naar de backlog gehaald? |

##### FR3.3: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan welke taak open gezet moet worden voor feedback  |   |
| 2 |   | Geeft de actor de mogelijkheid de taak zelf aan te passen.  |
| 3 | Geeft aan welke punten ontbreken of onduidelijk zijn.  |   |
| 4 |   | Zet de taak op "awaiting customer" met de bijbehorende feedback.  |

TODO: Waar komt feedback? Wordt dit bijgehouden in de comments van de taak? De omschrijving? Apart in het PMP?

##### FR3.3: Alternative flow - Taak is zelf aan te vullen

|Stap | Actor | System |
|---|---|---|
| 3A | Past de ontbrekende/onduidelijke punten zelf aan |  |
| 4A |  | Zet de nieuwe versie van de taak op "awaiting customer" zodat de klant goedkeuring kan geven voordat er aan begonnen wordt.  |

#### FR3.4: Op splitten taak naar "team" taken

| FR? | Op splitten taak naar "team" taken  |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT2: PM  |
| Stakeholders |  |
| Pre condities | Een klant heeft een taak in de aanvragen toegevoegd. |
| Post condities | Er zijn verschillende taken aangemaakt voor elk team dat iets met de taak moet doen. |
| Triggers | De PM merkt op dat verschillende teams aan één taak moeten werken. |
| Exceptions |  |
| Open issues | Kunnen dependencies gebruikt worden? Hoofd en subtaken? TODO's? Wanneer is de controle voorbij?  |

##### FR3.4: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | De actor geeft aan een aanvraag te willen splitten naar verschillende taken |  |
| 2 |  | Het systeem geeft een aantal opties (teams) waar binnen dat project taken voor aangemaakt kunnen worden |
| 3 | De actor geeft aan welke teams aan de taak gaan werken |  |
| 4 |  | Het systeem maakt verschillende taken aan voor de betreffende teams, zet ze op de "aanvraag" lijst en refereer in de originele taak naar de nieuwe (dependency/sub?) taken |
| 5 | De actor voert voor de nieuwe taken een estimate in per sub taak |  |
| 6 |  | Het systeem zet de taken na goedkeuring externe klant op de backlog |

TODO: navragen, stap 5 zou ook kunnen gebeuren aan de hand van de "standaard split"

##### FR3.4: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

#### FR3.5: Toevoegen taken past zich aan aan de klant zijn SLA

| FR3.5 | Toevoegen taken past zich aan aan de klant zijn SLA |
|---|---|
| Prioriteit |   |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders |  |
| Pre condities | De klant heeft een project waarvan de SLA in het PMP systeem is ingeladen. |
| Post condities | Taak prioriteit, incident reactie en response tijd worden aan de hand van de SLA berekend. |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

##### FR3.5: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 |   |   |
| 2 |   |   |

##### FR3.5: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

#### FR3.6: Toevoegen bijlagen bij taak

| FR3.6 | Toevoegen bijlagen bij taak |
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders |  |
| Pre condities | De klant zit op de taak detail pagina of is een aanvraag aan het doen. |
| Post condities | Er zijn bijlages toegevoegd aan de aanvraag |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

##### FR3.6: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | De actor kiest er voor een bijlage toe te voegen |  |
| 2 |  | Het systeem presenteert een manier om de bijlage te selecteren |
| 3 | De actor kiest één of meerdere bestanden om als bijlage toe te voegen. |  |
| 4 |  | Het systeem upload de bestanden en refereert bij de taak naar deze bestanden. |

##### FR3.6: Alternative flow - Upload fails

|Stap | Actor | System |
|---|---|---|
| 4 |  | Het systeem geeft aan dat bestanden niet geüpload kunnen worden |
| 5 | Slaat de taak op zonder bijlage. |  |

TODO: FR3.7: Toevoegen bijlagen binnen feedback is hetzelfde als FR3.6?

#### FR4: Versturen notificatie

| FR? | Empty FDUC |
|---|---|
| Prioriteit |   |
| Primaire Actor | ACT?:  |
| Stakeholders |  |
| Pre condities |  |
| Post condities |  |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

##### FR4: Main flow

|Stap | Actor | System |
|---|---|---|
|  |  |  |
|  |  |  |

##### FR4: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |


#### FR5: Goedkeuren extern toegevoegde taken

| |  |
|---|---|
| Prioriteit | Must have  |
| Naam | FR5: Goedkeuren extern toegevoegde taken |
| Primaire Actor | ACT2: Product manager, ACT4: Tech Lead  |
| Stakeholders | ACT1: Externe klant |
| Pre condities | Er is een taak toegevoegd in de aanvragen lijst van een project. |
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

#### FR?: Overzicht geheel proces aanmaken en goedkeuren nieuwe taak vanuit klant

|Stap | Actor | System |
|---|---|---|
| 1 | EK: Geeft aan een aanvraag te hebben voor een project |  |
| 2 |  | Registreert de aanvraag in de aanvragenlijst van het project als "waiting for PM" |
| 3 | PM: geeft aan dat de taak voldoende is ingevuld voor development en kent er een time/cost estimate aan. |  |
| 4 |  | Registreert de aanvraag als "Waiting for EK" |
| 5 | EK: keurt de time/cost estimate goed |  |
| 6 |  | Registreert de aanvraag als "Accepted" en zet deze taak in de backlog voor development |
| 7 | SD: werkt aan de taak en zet deze binnen Productive op In Progress, In review, Development, Testing, Staging en Live. |  |
| 8 |  | Stelt de klant op de hoogte als voor hem relevante taken in het "Live" bord terecht komen. (Of gewoon status closed?) |

|Stap | Actor | System |
|---|---|---|
| 3A | PM: geeft aan dat de taak onvoldoende is ingevuld voor development. |  |
| 4A |  | FR5: Goedkeuren extern toegevoegde taken |
| 5B | EK: Geeft aan dat de aanvraag te duur is voor het resultaat |  |
| 6B |  | ??? |

<!-- 
https://www.studocu.com/row/document/riphah-international-university/computer-sciences/fully-dressed-use-case-example-pdf/19676384

https://www.tmaworld.com/2017/10/04/use-case-approach/#:~:text=Fully%20dressed%20use%20case%3A%20A,goals%2C%20tasks%2C%20and%20requirements.

 -->

#### FR?: Empty FDUC

| FR? | Empty FDUC |
|---|---|
| Prioriteit |   |
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
