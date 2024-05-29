# Functioneel ontwerp Project Management Portal

Dit document dient als toelichting op de functionele eisen van het Product Management Portal. Na het doornemen van dit document dienen alle betrokken partijen een duidelijk beeld te hebben van precies wat het opgeleverde Project Management Portal functioneel kan.

## Aannames en afhankelijkheden

Technische aspecten van het systeem zijn vastgelegd in het Technisch ontwerp. Voor het schrijven van dit document zijn wel de volgende technische aannames gedaan:

- De API van Productive.io Kan alle door de klant gewenste informatie aanleveren.
- Het aantal naar de Productive API gestuurde requests blijft onder 100 per 30 sec.
<!-- TODO: link naar TO zodra deze bestaat. -->

## Actors

De actors zijn de mensen/rollen die gebruik maken van het systeem. Voor elke actor wordt toegelicht wat zijn/haar rol is, hoe de actor in de situatie voor het PMP werkt en wat de actor uit het PMP kan verwachten.

### ACT1: Externe klant

Omschrijving: Een externe klant die een project wilt laten uitvoeren door Bluenotion.

Huidig proces: Een klant heeft een contract afgesloten bij Bluenotion voor een project. Op basis van gesprekken met de PM worden voor het project taken aangemaakt in Productive die door het development team worden opgepakt tot uiteindelijke realisatie van het product. Als de klant over de loop van het project wijzigingen wilt doen in de planning van het project loopt dit via de PM of een guest account met een apart bord in Productive.*

*Sommige klanten hebben direct toegang tot een voor hun aangemaakte productive omgeving om inzicht te kunnen krijgen in het project en al zelf taken in te schieten.

Doelen nieuwe project management portal:

- Inzicht geven in het door Bluenotion te verrichten werk door statussen toe te kennen aan taken.
- Inzicht geven in de aanvragen/taken die door mij (de externe klant) aangescherpt dienen te worden voor ontwikkeling door Bluenotion kan beginnen.
- Toevoegen van nieuwe aanvragen/taken voor een project
- Prioriteren van bestaande taken
- Aanpassen onduidelijke/incomplete taken
- Communiceren van impact in de vorm van ureninschattingen
- Inzicht geven in servicecontract van projecten

Aanspreekpunt: Jesse Bekke

### ACT2: Bluenotion Admin

Omschrijving: De Bluenotion admin is een medewerker van Bluenotion die het recht heeft de planning van projecten aan te passen. Doorgaans zijn dit project managers (PM) en tech leads (TL) maar andere medewerkers zouden ook de rol van Bluenotion Admin op zich kunnen nemen.

Huidig proces: Aan het eind van elke sprint wordt door de PM/TL een demo gegeven aan de klant met de in die sprint geboekte vooruitgang en de planning voor de volgende sprint. Bevindingen in deze review worden door de PM/TL verwerkt in de backlog op Productive. Indien een klant directe toegang heeft tot de Productive omgeving heeft de PM/TL de taak van het controleren en goedkeuren van de door de klant ingeschoten taken. Mochten er onduidelijkheden zijn in een taak of velden verkeerd ingevuld zijn (vaker voorkomend bij priority) is het aan de PM verdere verduidelijking te vragen aan de klant.

Doelen nieuwe project management portal:

- Taken goed of afkeuren voor de backlog op Productive.
- Taken handmatig aanpassen.
- Doorgeven aan de klant dat een taak incompleet of onduidelijk is.

Aanspreekpunt: Jesse Bekke

### ACT3: Bluenotion medewerker

Omschrijving: Dit is een medewerker van Bluenotion die meewerkt aan het development proces.

Huidig proces: Krijgt taken toegewezen, werkt aan taken en registreert de staat hiervan in Productive.

Doelen nieuwe project management portal: Zonder aanpassingen in de workflow zijn werk nog kunnen doen.

### ACT4: Notificatie manager

Omschrijving: De service die invitation links stuurt en informeert wanneer actie nodig is?

Huidig proces:

Doelen nieuwe project:

## Domein

In dit hoofdstuk wordt toelichting gegeven op het domein waarin het systeem zich bevind. Aangezien het PMP zal draaien als koppeling tussen de klant en het Productive systeem van Bluenotion is het onderstaande domeinmodel ingedeeld in concepten binnen Productive en concepten binnen Bluenotion (aangeduid in het vak Project management portal). Hiermee worden de afhankelijkheden naar het Productive systeem direct vastgelegd.

```plantuml
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 120
' top to bottom direction

rectangle "Project management portal"{

  rectangle Klant
  rectangle Aanvraag
  rectangle Team
  rectangle SLA
  rectangle Prioriteit
  rectangle Type
  rectangle Incident
  rectangle Doorontwikkeling
  rectangle Impact
  rectangle Urgentie
}

rectangle "Productive"{
  rectangle Project
  rectangle Board
  rectangle Taak
  rectangle Werknemer

}
' Klant aanvraag
Klant "1..*" -- "0..*" Project : > Eigenaar van
Klant "1"--"0..*" Aanvraag :> Doet een
Aanvraag "1"--"1..*" Taak :> Resulteert in
Project "0..*"--"1" SLA :> Valt onder


' Priority part
Incident --|> Type
Doorontwikkeling --|> Type
Aanvraag "0..*"--"1" Type : > Ingediend als
Impact "1"-r-"1" Prioriteit : < berekend met
Urgentie "1"-l-"1" Prioriteit : < berekend met
Prioriteit "1"--"0..*" Incident : < Ingediend als
SLA "1"--"0..*" Aanvraag : > bepaalt tijdslimieten voor

' Productive task board part
Board "1..*"--"1" Project: > Planning voor 
Taak "0..*"--"1" Board: > Opgenomen in
Werknemer "0..*"--"0..*" Taak :> Werkt aan
Werknemer "0..*"--"0..*" Team :> Onderdeel van
Taak "1"--"1" Team :> beschrijft werkzaamheden voor

```

Nu hebben enkel Issues een type/prio. Hoe wordt de prio van een doorontwikkeling bepaald? MoSCoW met de klant? Is dit iets dat de klant moet invoeren?

### Toelichting domeinmodel

| Entiteit | Uitleg | Gebruik |
|---|---|---|
| Productive (groepering) | De entiteiten binnen de Productive groepering bestaan de huidige staat van het systeem binnen de Bluenotion Productive.io omgeving.  | Bovenstaand diagram  |
| Project management portal (groepering) | De entiteiten binnen de PMP groepering zijn gebaseerd op de Bluenotion workflow en de bijbehorende service level agreements. Deze entiteiten hebben geen al bestaande data in de Productive omgeving.  | Bovenstaand diagram  |
| Project | Een stuk software dat een **Klant** wilt laten ontwikkelen door Bluenotion. | [FR1.1](#fr11-inzien-projecten) |
| Klant  | Een individu of organisatie die bij Bluenotion een of meer projecten heeft lopen bij Bluenotion | [FR1.1](#fr11-inzien-projecten) |
| Aanvraag | Iets dat de **klant** wil in zijn/haar **project**. | [FR3.1](#fr31-toevoegen-nieuwe-taak-in-een-project) |
| Taak | Een **Aanvraag** waar een [PM of TL](FunctioneelOntwerp.md#act2-bluenotion-admin) goedkeuring voor heeft gegeven voor ontwikkeling. Dit kunnen nieuwe functionaliteiten en bugfixes zijn. Toelichting over de lifecycle van taken is [hier onder](#lifecycle-taken) te vinden. | [FR3.1](#fr31-toevoegen-nieuwe-taak-in-een-project) |
| Bord | Een bord waar intern voor Bluenotion taken op worden bijgehouden. Zie [lifecycle taken](#lifecycle-taken) voor meer informatie. | [FR3.1](#fr31-toevoegen-nieuwe-taak-in-een-project) |
| Team | Een representatie van de rollen en beschikbare kennis binnen Bluenotion die worden gebruikt voor het toekennen van de juiste taak aan de juiste werknemers. (UX, FE, BE) | [FR2.8](#functionele-requirements) |
| Werknemer | Een werknemer van Bluenotion die aan taken werkt en de status hiervan bijhoudt in Productive. | [NFR2](#nonfunctional-requirements) |
| SLA | Een **klant** heeft een aantal afspraken voor een **project** vaststaan in een Service Level Agreement waar KPI's zijn vastgelegd die leidend zijn in de **prioriteit** en het **type** van een taak. | [FR3.3](#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Taak type | Het soort taak, afhankelijk van de SLA met de klant. | [FR3.3](#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Wijzigingsverzoek (Taak type) | Een verzoek tot aanpassen van iets binnen de software. Doorgaans komen deze wijzigingen neer op doorontwikkelingen van de software. | [FR3.3](#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)   |
| Incident (Taak type) | Het substantieel niet voldoen van de applicatie aan de overeengekomen specificaties alsmede de situatie waarin sprake is van niet-Beschikbaarheid die niet het gevolg is van onderhoud. | [FR3.3](#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Urgentie  | De spoedeisendheid van een incident voor de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](#incident-impact-urgentie-en-prioriteit-levels)   | [FR3.3](#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Impact  | De (ernst van de) gevolgen van een incident voor de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](#incident-impact-urgentie-en-prioriteit-levels)  | [FR3.3](#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)   |
| Prioriteit | De prioriteit van de taak, afhankelijk van of mensen nog kunnen werken en de wensen van de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](#incident-impact-urgentie-en-prioriteit-levels) | [FR3.3](#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  [FR4.2](#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla) |

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
wishlist -[norank]-> wishlist : Denied by PM,TL of klant
aanvragen -[norank]-> aanvragen : Denied by PM/TL
development -[norank]-> backlog : Denied by customer
staging -[norank]-> backlog : Denied by customer
in_progress -[norank]-> wishlist : Functionality is nice to have but outside of scope
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
- **Awaiting customer** (new)</br> Taken die incorrect of incompleet zijn ingevuld door de klant worden door de PM of TL op dit bord neergezet met een vraag voor extra feedback van de klant.
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
  - **Waiting for reply PM/TL** </br> Een taak die binnen is gekomen via de klant waar nog geen goedkeuring op is gegeven door een PM/TL.
  - **Waiting for reply customer** </br> Een taak die is gecontroleerd door de PM/TL en met vraag voor extra verduidelijking terug wordt gestuurd naar de opdrachtgever.
  - **Nice to have, outside current scope** </br> Een taak die tijdens het ontwikkelen van een door de klant aangevraagde functionaliteit door het Bluenotion team is geregistreerd als een verbetering op de software maar waarover nog geen afstemming is voor verdere ontwikkeling.
- **Started/Open** </br> Een taak die is goedgekeurd door een PM/TL waar verschillende medewerkers van Bluenotion aan (gaan) werken.
- **Finished/Closed** </br> Een taak die is afgerond en op de live omgeving staat. Deze taken dienen als archief van geleverd werk.

#### Incident Impact, Urgentie en Prioriteit levels

Incident:
Een incident is een aanvraag die te maken heeft met het niet goed functioneren van de huidige applicatie op de manier zoals wel uitdrukkelijk overeengekomen.

Impact:

De impact van een incident geeft aan hoe veel of weinig mensen last hebben van het incident. Urgentie wordt vastgelegd met de onderstaande tabel.

| Categorie  | Omschrijving  |
|---|---|
| Hoog (H)  | - Een grote groep werknemers van Opdrachtgever wordt geraakt </br> - Een grote groep Eindgebruikers wordt geraakt </br> - Er bestaat een groot risico op reputatieschade  |
| Middel (M)  | - Een beperkte groep van de werknemers van Opdrachtgever wordt geraakt  </br> - Een beperkte groep Eindgebruikers wordt geraakt </br> - Het ontstaan van enige reputatieschade is aannemelijk  |
| Laag (L)  | - Slechts een klein aantal werknemers van Opdrachtgever wordt geraakt </br> - Slechts een klein aantal Eindgebruikers wordt geraakt </br>  - Er is slechts een kleine kans op reputatieschade  |

Urgentie:

De spoedeisendheid van een Incident voor de opdrachtgever.

| Categorie  | Omschrijving  |
|---|---|
| Hoog (H)  | - de schade van het Incident neemt snel toe </br> - de verstoorde processen zijn sterk aan tijd gebonden </br> - snel ingrijpen kan voorkomen dat het Incident ernstiger wordt  |
| Middel (M)  | - de schade van het Incident zal aanzienlijk toenemen gedurende de tijd </br> - de verstoorde processen kunnen enige tijd worden uitgesteld   |
| Laag (L)  | - de schade van het Incident zal weinig toenemen gedurende de tijd </br> - de verstoorde processen zijn niet of nauwelijks aan tijd gebonden  |

Prioriteit:

Afhankelijk van de aan een incident toegekende impact en urgentie wordt door Bluenotion aan het Incident conform onderstaande matrix een Prioriteit toegekend.

| Impact &#8594; </br> Urgentie &#8595; | Hoog  | Middel  | Laag  |
|---|---|---|---|
| Hoog  | 1  | 2  | 3  |
| Middel  | 2  | 3  | 4  |
| Laag  | 3  | 4  | 5  |

Aan de hand van deze prioriteit worden per SLA voor de klant een verwachting geschetst van de reactie en oplostijd. De bepaling van de Urgentie, Impact en Prioriteit is per SLA het zelfde. Binnen verschillende SLA levels worden echter verschillende beloftes gedaan op basis van de prioriteit. Onderstaand is een voorbeeld van de wacht en oplostijd van de Bluenotion Gold level SLA:

| Prioriteit | Reactietijd (in uren) | Oplostijd |
|---|---|---|
| 1 (Kritiek) | 1 uur | 2 uur |
| 2 (Hoog) | 2 uur | 4 uur |
| 3 (Gemiddeld) | 4 uur | 8 uur |
| 4 (Laag) | 12 uur | 1 werkdag |
| 5 (Gering) | 2 werkdagen | 4 werkdagen |

## Requirements

Binnen dit hoofdstuk worden de functionele en non-functionele eisen gesteld aan het systeem toegelicht. Binnen dit hoofdstuk staat de requirements traceability matrix waarin requirements van user story tot implementatie door de documentatie gevolgd kan worden.

### User stories

Eisen en wensen gesteld aan het systeem worden eerst geregistreerd als een user story.

| User story no | Gerelateerde actors  | User story  | Resulterende requirement(s)  |
|---|---|---|---|
| US1   | ACT2  | Als PM wil ik een eenduidig overzicht van alle projecten die lopen binnen Bluenotion zodat ik snel de status met een klant kan bespreken.  | [FR1.1](#fr11-inzien-projecten) |
| US2  | ACT1 | Als externe klant wil ik een eenduidig overzicht van alle voor mij relevante projecten zodat ik snel kan zien welke projecten actief aan gewerkt worden.  | [FR1.2](#fr12-inzien-totaal-geplande-urenkosten) |
| US3  | ACT1 | Als externe klant wil ik een overzicht van het geplande werk zodat ik zicht kan houden op de ontwikkeltijd en kosten. | [FR1.2](#fr12-inzien-totaal-geplande-urenkosten), [FR2.1](#fr21-inzien-taken-van-project), [FR2.2](#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed), [FR2.3](#fr23-inzien-taak-details), [FR2.4](#fr24-tonen-taken-in-gantt-chart) |
| US4?  | ACT2  | Als PM wil ik de zelfde informatie kunnen zien als een externe klant zodat ik bij vragen de klant kan ondersteunen.  |  X |
| US5  | ACT3  | Als Bluenotion medewerker wil ik niet mijn werkwijze aanpassen om een nieuw systeem voor de klant te ondersteunen.  | [NFR2.1](#nonfunctional-requirements)  |
| US6  | ACT1  | Als externe klant wil ik bij mijn projecten de optie om nieuwe taken toe te voegen zodat ik issues en door ontwikkelingen kan doorgeven.  | [FR3.1](#fr31-toevoegen-nieuwe-taak-in-een-project) |
| US7  | ACT1, ACT2  | Als PM wil ik bij taken die onduidelijk of incorrect ingevuld zijn de klant de optie geven deze onduidelijkheid te verhelderen.  | [FR2.6](#fr26-comments-toevoegen-op-lopende-taak), [FR3.2](#fr32-toelichting-geven-op-taak), [FR8.1](#fr81-controleren-aanvraag), [FR8.2](#fr82-op-splitten-taak-naar-team-taken) |
| US8  | ACT1  | Als externe klant wil ik bij taken die extra toelichting nodig hebben feedback kunnen geven op deze taken zodat ze goedgekeurd kunnen worden voor de backlog.  | [FR2.2](#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) |
| US9  | ACT1  | Als externe klant wil ik een eenduidig overzicht van taken die wachten op mijn input voordat er aan gewerkt wordt zodat deze taken niet onnodig lang blijven liggen.  | [FR2.2](#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed), [FR4.1](#fr41-versturen-notificatie) |
| US10  | ACT2  | Als PM wil ik bij taken die toegevoegd zijn door een externe klant taken goedkeuren voor ze op de backlog terecht komen.  | [FR8.1](#fr81-controleren-aanvraag), [FR8.2](#fr82-op-splitten-taak-naar-team-taken)  |
| US11  |   | Als ?software developer? wil ik geen data over het netwerk sturen waar de klant geen toegang toe heeft.  |   |
| US12 | ACT2 | Als PM wil ik dat de klant afbeeldingen kan invoegen om problemen/aanvragen toe te lichten. | [FR3.4](#fr34-toevoegen-bijlagen-bij-taak) |
| US13 | ACT1 | Als externe klant wil ik alle informatie over mijn te bouwen/gebouwde systeem op één centrale plek bekijken | [FR6.1](FunctioneelOntwerp.md#fr61-inzien-lijst-van-project-dependencies), [FR6.2](FunctioneelOntwerp.md#fr62-inzien-huidige-status-onlineoffline-project-dependencies), [FR7.1](FunctioneelOntwerp.md#fr71-openendownloaden-document), [FR7.2](FunctioneelOntwerp.md#fr72-filteren-documentnaamcategorie) |
| US14 | ACT3 | Als software developer wil ik niet dat mensen toegang krijgen tot data die mogelijk privacy gevoelig is en/of niet bedoeld is voor de betreffende persoon. | [NFR4.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.2](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.3](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.4](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US15 | ACT3 | Als software developer wil ik dat als er iets niet naar behoren werkt er logs beschikbaar zijn om het probleem te herleiden. | [NFR4.5](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.6](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US16 | ACT3 | Als medewerker van Bluenotion wil ik dat alle klanten van Bluenotion om kunnen gaan met het PMP. | [NFR1.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR6.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR6.3](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR7.1](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US17 | ACT1 | Als externe klant wil ik niet beïnvloed worden door andere mensen die tegelijkertijd het PMP gebruiken. | [NFR2.2](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR5.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR5.2](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US18 | ACT2 | Als PM wil ik dat het systeem bij verlies van database binnen 3 uur hersteld kan worden naar een werkende state. | [NFR8.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR8.2](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR8.3](FunctioneelOntwerp.md#nonfunctional-requirements) |

### Requirements traceability matrix

#### Functionele requirements

```plantuml
title Use case diagram
left to right direction

:ACT1 Externe klant: as KL
:ACT2 Bluenotion Admin: as ADM
:ACT4 Notification manager: as Notification

(FR1: Inzien project plannings informatie) as FR1
(FR2: Inzien taken) as FR2
(FR3: Toevoegen taken) as FR3
(FR4: Versturen notificaties) as FR4
(FR5: Opstellen project) as FR5
(FR6: Inzien project service statuses) as FR6
(FR7: Inzien project documentatie) as FR7
(FR8: Controleren aanvraag) as FR8

KL -DOWN-> FR1
KL -DOWN-> FR2
KL -DOWN-> FR3
KL -DOWN-> FR6
KL -DOWN-> FR7

ADM-DOWN->FR5
ADM-DOWN->FR8
Notification-DOWN->FR4

ADM-LEFT-|>KL

```

| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Dependencies | Document references |
|---|---|---|---|---|---|
| FR1  | Inzien project plannings informatie |   | Must have  | NFR0.5  |   |
| FR1.1  |   | Inzien projecten  | Must have  | NFR0.5  | [US1](#user-stories), [US2](#user-stories), [Fully dressed usecase description](#fr11-inzien-projecten)  |
| FR1.2  |   | Inzien totaal geplande uren+kosten  | Must have  | FR1.1  | [US3](#user-stories), [Fully dressed usecase description](#fr12-inzien-totaal-geplande-urenkosten)  |
| FR2  | Inzien taken  |   |   |   |   |
| FR2.1  |   | Inzien taken van project  | Must have  |   | [US3](#user-stories), [Fully dressed usecase description](#fr21-inzien-taken-van-project)  |
| FR2.2  |   | Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed | Must have |  | [US3](#user-stories), [US8](#user-stories), [US9](#user-stories), [Fully dressed usecase description](#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) |
| FR2.3  |   | Inzien taak details  | Must have  |   | [US3](#user-stories), [Fully dressed usecase description](#fr23-inzien-taak-details)  |
| FR2.4  |   | Tonen taken in Gantt chart?  | Could have |  | [US3](#user-stories), [Fully dressed usecase description](#fr24-tonen-taken-in-gantt-chart) |
| FR2.5  |   | Aanpassen taak prioriteit? (TODO: navragen, escalatie prioriteit punt 9.3 bronze SLA) |  |  |[Fully dressed usecase description](#fr25-aanpassen-taak-prioriteit)  |
| FR2.6  |   | Comments toevoegen op lopende taak?  |   |  |  [US7](#user-stories), [Fully dressed usecase description](#fr26-comments-toevoegen-op-lopende-taak)  |
| FR2.7  |   | Filteren taken op: incident of doorontwikkeling  | Should have  |   |   |
| FR3 | Toevoegen taken |  |  |  |  |
| FR3.1  |   | Toevoegen nieuwe taak | Must have  |   | [US6](#user-stories), [Fully dressed usecase description](#fr31-toevoegen-nieuwe-taak-in-een-project)  |
| FR3.2  |   | Toelichting geven op taak (extern)  | Must have  |   | [US7](#user-stories), [Fully dressed usecase description](#fr32-toelichting-geven-op-taak)  |
| FR3.3  |   | Toevoegen taken past zich aan aan de klant zijn SLA | Could have | FR1.4 | [Fully dressed usecase description](#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla) |
| FR3.4 |   | Toevoegen bijlagen bij taak | Must have |  | [US12](#user-stories), [Fully dressed usecase description](#fr34-toevoegen-bijlagen-bij-taak) |
| FR4?  | Versturen notificaties  |   |   |   |   |
| FR4.1?  |   | Inlichten klant wanneer een taak wacht op input van de klant  |   |   | [US9](#user-stories), [Fully dressed usecase description](#fr41-versturen-notificatie)  |
| FR4.2?  |   | Inlichten Bluenotion bij blockers/criticals?  |   |   |   |
| FR5? | Opstellen project |  |  |  |  |
| FR5.1  |   | Afhandelen project setup binnen PMP  | Could have  |   |   |
| FR6  | Inzien project service statuses  |   |   |   |   |
| FR6.1  |   | Inzien lijst van project dependencies  | Could have  |   | [US13](#user-stories)  |
| FR6.2  |   | Inzien huidige status (online/offline) project dependencies | Could have  |   | [US13](#user-stories)  |
| FR6.3  |   | Beheren project services  | Could have  |   |   |
| FR7  | Inzien project documentatie |  |  |  |  |
| FR7.1  |   | Openen/downloaden document  | Could have  |   | [US13](#user-stories)  |
| FR7.2  |   | Filteren documentnaam/categorie?  | Could have  |   | [US13](#user-stories)  |
| FR7.3  |   | Beheren project documentatie  | Could have  |   |   |
| FR8 | Controleren aanvraag |  |  |  |  |
| FR8.1  |   | Controleren aanvraag (intern)  | Must have  |   | [US7](#user-stories), [Fully dressed usecase description](#fr81-controleren-aanvraag), [US10](#user-stories)  |
| FR8.2  |   | Op splitten taak naar "team" taken | Could have |   | [US7](#user-stories), [Fully dressed usecase description](#fr82-op-splitten-taak-naar-team-taken), [US10](#user-stories)  |

#### Nonfunctional requirements

| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Dependencies | Document references |
|---|---|---|---|---|---|
| NFR1  | Usability  |   |   |   |   |
|   | NFR1.1  | Het systeem dient beschikbaar te zijn in Nederlands en Engels, met optie tot uitbreiding.  |   |   | [US16](#user-stories)  |
| NFR2 | Reliability  |   |   |   |   |
|   | NFR2.1  | Informatie over projecten en taken komen altijd overeen met de informatie op Productive.  |   |   |   |
|   | NFR2.2  | Het systeem geeft bij 95% van de requests in een maand antwoord zoals beschreven in dit document.  |   |   | [US17](#user-stories)   |
| NFR3 | Performance  |   |   |   |   |
|   | NFR3.1  | Onder normale omstandigheden wordt data die niet afkomstig is van de Productive API binnen 1? seconde na aanvraag getoond aan de gebruiker.  |   |   | [US17](#user-stories)   |
|   | NFR3.2  | Onder normale omstandigheden wordt data die afkomstig is van de Productive API binnen 3? seconden na aanvraag getoond aan de gebruiker. |   |   | [US17](#user-stories)  |
| NFR4 | Security |  |  |  |  |
|   | NFR4.1  | Authenticatie: Uitnodigen nieuwe gebruikers via e-mail | Must have |  | [US14](#user-stories) |
|   | NFR4.2  | Authenticatie: Aanmelden met e-mail en wachtwoord  | Must have  |   | [US14](#user-stories)  |
|   | NFR4.3  | Autorisatie: Afschermen ongerelateerde project/taak info  | Must have  |   | [US14](#user-stories)  |
|   | NFR4.4  | Autorisatie: Autorisatie gebeurt volledig binnen de back-end en database |   |   | [US14](#user-stories)  |
|   | NFR4.5  | Accounting: Loggen write events  | Must have?  |   | [US15](#user-stories)  |
|   | NFR4.6  | Accounting: Loggen read events?  | Could have?  |   | [US15](#user-stories)  |
|   | NFR4.7  | Het systeem is AVG/GDPR compliant (TODO: smart uitwerken?)  |   |   |   |
| NFR5 | Scalability  |   |   |   |   |
|   | NFR5.1  | De software komt met 50? gelijktijdige gebruikers niet aan de Productive API rate limits  | Should have  |   | [US17](#user-stories)  |
|   | NFR5.2  | De software komt ongeacht hoeveelheid gelijktijdige gebruikers niet aan de Productive API rate limits?  | Would have  |   | [US17](#user-stories)  |
| NFR6 | Portability  |  |   |   |   |
|   | NFR6.1  | Het systeem schaalt "netjes"? op alle Windows en MAC versies van de afgelopen 3? jaar  |   |   | [US16](#user-stories)  |
|   | NFR6.2  | Het systeem is platform onafhankelijk (zou implementaties kunnen hebben met bijvoorbeeld Jira, GitLab, Trello)  | Would  |   |   |
|   | NFR6.3  | Het systeem werkt in alle FireFox, Chrome, Edge en Safari versies van de afgelopen 3? jaar.  |   |   | [US16](#user-stories)  |
| NFR7 | Compatibility  |   |   |   |   |
|   | NFR7.1  | Het systeem werkt op alle Windows en MAC versies van de afgelopen 3? jaar  | Must have  |   | [US16](#user-stories)  |
| NFR8 | Maintainability  |   |   |   |   |
|   | NFR8.1  | Het systeem kan bij verlies van de database binnen 3 uur hersteld worden naar een werkende state.  |   |   | [US18](#user-stories)  |
|   | NFR8.2  |  Bij verlies van de database raken geen gegevens over projecten of taken verloren.|  |  | [US18](#user-stories)  |
|   | NFR8.3  | Bij verlies van de database raken geen gegevens ouder dan 24 uur verloren.  |   |   | [US18](#user-stories)  |

### unsorted

| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Dependencies | Document references |
|---|---|---|---|---|---|
| FR1.3  |   | Toekennen overige project uren  | Could have  | FR1.2  |   |
| FR1.4  |   | Toekennen SLA KPI's | Could have  | FR1.1  |   |
| NFR0  | Opzetten technische infrastructuur  |   | Must have  |   |   |
| NFR0.1  |   | Opzetten initial Front-end  | Must have  |   |   |
| NFR0.2  |   | Opzetten initial Back-end  | Must have  |   |   |
| NFR0.3  |   | Opzetten initial database  | Must have  |   |   |
| NFR0.4  |   | Opzetten test infrastructuur  | Must have  |   |   |
| NFR0.5  |   | Opzetten verbinding Productive.io API | Must have  |  |  |
| NFR0.6  |   | Opzetten mailing system  | Must have  |   |   |
| NFR0.7  |   | Opzetten internationalisatie infrastructuur | Should have |  |  |
|   |   |   |   |   |   |

<!-- 
Notes on functional requirements:
FR4.2 inlichten bluenotion bij critical/blocker zou aan de hand van telefoon kunnen?

 -->

<!-- TODO: Sources netjes documenteren maar sources:
NFR categories: https://www.altexsoft.com/blog/non-functional-requirements/
https://www.altexsoft.com/blog/software-requirements-specification/
Tracability matrix: https://www.researchgate.net/figure/Requirements-traceability-matrix-for-online-shopping-system_tbl4_280083523 -->

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
| Pre condities | De klant kan inloggen in het PMP. </br> De klant heeft op zijn minst één gepland of lopend project bij Bluenotion. |
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
| 6 |  | Maakt op basis van de ingevulde gegevens een taak aan op de aanvragen lijst in Productive. </br> TODO: navragen, tonen verwachte reactie tijd/opvolg instructies? Dit zou afhankelijk zijn van het SLA dus deel van FR3.3? |

*Schatting van de door de actor aan te leveren informatie:

Titel, korte omschrijving, Screenshot (urgentie & impact zie FR3.3)

##### FR3.1: Alternative flow - Hoge prioriteit taak

A: Doorgeven hoge prioriteit

B: Aanpassen naar lage prioriteit

|Stap | Actor | System |
|---|---|---|
| 4A |  | De taak heeft een prioriteit van 1 of 2 (zie [toelichting prioriteit taken](FunctioneelOntwerp.md#taak-impact-urgentie-en-prioriteit-levels)) |
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
| Stakeholders | ACT2: Bluenotion admin |
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


#### FR3.3: Toevoegen taken past zich aan aan de klant zijn SLA

| FR3.3 | Toevoegen taken past zich aan aan de klant zijn SLA |
|---|---|
| Prioriteit |   |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders |  |
| Pre condities | De klant heeft een project waarvan de SLA in het PMP systeem is ingeladen. |
| Post condities | Taak prioriteit, incident reactie en response tijd worden aan de hand van de SLA berekend. |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

##### FR3.3: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 |   |   |
| 2 |   |   |

##### FR3.3: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

#### FR3.4: Toevoegen bijlagen bij taak

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

##### FR3.4: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | De actor kiest er voor een bijlage toe te voegen |  |
| 2 |  | Het systeem presenteert een manier om de bijlage te selecteren |
| 3 | De actor kiest één of meerdere bestanden om als bijlage toe te voegen. |  |
| 4 |  | Het systeem upload de bestanden en refereert bij de taak naar deze bestanden. |

##### FR3.4: Alternative flow - Upload fails

|Stap | Actor | System |
|---|---|---|
| 4 |  | Het systeem geeft aan dat bestanden niet geüpload kunnen worden |
| 5 | Slaat de taak op zonder bijlage. |  |

#### FR4.1: Versturen notificatie

<!-- Is dit een eis? -->

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

##### FR4.1: Main flow

|Stap | Actor | System |
|---|---|---|
|  |  |  |
|  |  |  |

##### FR4.1: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

#### FR5.1: Afhandelen project setup

| FR5.1 | Afhandelen project setup |
|---|---|
| Prioriteit | Could have  |
| Primaire Actor | ACT1: Externe klant |
| Stakeholders | ACT2: Bluenotion admin |
| Pre condities | Beiden actoren hebben inlog gegevens voor het PMP |
| Post condities | Een project is gestart met initiële scope |
| Triggers | Op aanvraag van Externe klant |
| Exceptions |  |
| Open issues | Procedure vast leggen |

##### FR5.1: Main flow

|Stap | Actor | System |
|---|---|---|
|  |  |  |
|  |  |  |

##### FR5.1: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

#### FR6.1: Inzien lijst van project dependencies

TODO: fully dressed versie uitwerken.

| FR6.1 | Inzien lijst van project dependencies |
|---|---|
| Prioriteit |   |
| Primaire Actor | ACT?:  |
| Stakeholders |  |
| Pre condities |  |
| Post condities |  |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

#### FR6.2: Inzien huidige status (online/offline) project dependencies

TODO: fully dressed versie uitwerken.

| FR6.2 | Inzien huidige status (online/offline) project dependencies |
|---|---|
| Prioriteit |   |
| Primaire Actor | ACT?:  |
| Stakeholders |  |
| Pre condities |  |
| Post condities |  |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

#### FR6.3: Beheren project services

TODO: fully dressed versie uitwerken.

| FR6.3 | Beheren project services |
|---|---|
| Prioriteit |   |
| Primaire Actor | ACT?:  |
| Stakeholders |  |
| Pre condities |  |
| Post condities |  |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

#### FR7.1: Openen/downloaden document

TODO: fully dressed versie uitwerken.

| FR7.1 | Openen/downloaden document |
|---|---|
| Prioriteit |   |
| Primaire Actor | ACT?: |
| Stakeholders |  |
| Pre condities |  |
| Post condities |  |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

##### FR7.1: Main flow

|Stap | Actor | System |
|---|---|---|
|  |  |  |
|  |  |  |

##### FR7.1: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

#### FR7.2: Filteren documentnaam/categorie

TODO: fully dressed versie uitwerken.

| FR7.2 | Filteren documentnaam/categorie |
|---|---|
| Prioriteit |   |
| Primaire Actor | ACT?: |
| Stakeholders |  |
| Pre condities |  |
| Post condities |  |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

#### FR7.3: Beheren project documentatie

TODO: fully dressed versie uitwerken.

| FR7.3 | Beheren project documentatie |
|---|---|
| Prioriteit |   |
| Primaire Actor | ACT?: |
| Stakeholders |  |
| Pre condities |  |
| Post condities |  |
| Triggers |  |
| Exceptions |  |
| Open issues |  |

#### FR8.1: Controleren aanvraag

| FR8.1 | Controleren aanvraag|
|---|---|
| Prioriteit | Must have  |
| Primaire Actor | ACT2: Bluenotion admin |
| Stakeholders | ACT1: Externe klant, ACT3: Software developer |
| Pre condities | Er is een project waar een klant een aanvraag heeft gedaan.  |
| Post condities | De klant wordt op de hoogte gebracht dat er om feedback is gevraagd. </br> De taak staat op het "Awaiting customer" bord. |
| Triggers | Er staan taken in de "Aanvraag" lijst. |
| Exceptions | In de tijd dat de vraag wordt gecontroleerd is de taak door de klant verwijderd. |
| Open issues | Heeft een klant één of meerdere representatieoren? Als meer, een selectie wie je op de hoogte brengt of broadcast naar iedereen die feedback mag geven? </br> Hoe willen we klanten op de hoogte stellen? aan de hand van mail/sms? enkel het portaal? </br> Wat kan de klant aanpassen in een taak? Wat moet er gebeuren als een klant bijvoorbeeld de cost estimate van een taak voor nu te hoog vindt? Blijft een taak als dit op de aanvragen of wordt deze alsnog naar de backlog gehaald? |

##### FR8.1: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan welke taak open gezet moet worden voor feedback  |   |
| 2 |   | Geeft de actor de mogelijkheid de taak zelf aan te passen.  |
| 3 | Geeft aan welke punten ontbreken of onduidelijk zijn.  |   |
| 4 |   | Zet de taak op "awaiting customer" met de bijbehorende feedback.  |

TODO: Waar komt feedback? Wordt dit bijgehouden in de comments van de taak? De omschrijving? Apart in het PMP?

##### FR8.1: Alternative flow - Taak is zelf aan te vullen

|Stap | Actor | System |
|---|---|---|
| 3A | Past de ontbrekende/onduidelijke punten zelf aan |  |
| 4A |  | Zet de nieuwe versie van de taak op "awaiting customer" zodat de klant goedkeuring kan geven voordat er aan begonnen wordt.  |

#### FR8.2: Op splitten taak naar "team" taken

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

##### FR8.2: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | De actor geeft aan een aanvraag te willen splitten naar verschillende taken |  |
| 2 |  | Het systeem geeft een aantal opties (teams) waar binnen dat project taken voor aangemaakt kunnen worden |
| 3 | De actor geeft aan welke teams aan de taak gaan werken |  |
| 4 |  | Het systeem maakt verschillende taken aan voor de betreffende teams, zet ze op de "aanvraag" lijst en refereer in de originele taak naar de nieuwe (dependency/sub?) taken |
| 5 | De actor voert voor de nieuwe taken een estimate in per sub taak |  |
| 6 |  | Het systeem zet de taken na goedkeuring externe klant op de backlog |

TODO: navragen, stap 5 zou ook kunnen gebeuren aan de hand van de "standaard split"

##### FR8.2: Alternative flow - flow name

|Stap | Actor | System |
|---|---|---|
|  |  |  |

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
<!-- 
https://www.studocu.com/row/document/riphah-international-university/computer-sciences/fully-dressed-use-case-example-pdf/19676384

https://www.tmaworld.com/2017/10/04/use-case-approach/#:~:text=Fully%20dressed%20use%20case%3A%20A,goals%2C%20tasks%2C%20and%20requirements.

 -->

## Scherm ontwerpen

### Ontwerpen FR1 Inzien project plannings informatie

### Ontwerpen FR2 Inzien taken

### Ontwerpen FR3 Toevoegen taken

### Ontwerpen FR4? Versturen notificaties

### Ontwerpen FR5? Opstellen project

### Ontwerpen FR6 Inzien project service statuses

### Ontwerpen FR7 Inzien project documentatie

### Ontwerpen FR8 Controleren aanvraag
