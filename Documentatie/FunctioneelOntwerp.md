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

### ACT5: Externe klant (read)

Op basis van gesprek 11-06-2024:
Er werd gesproken over een admin en medewerkers account voor de externe klant. Voor zo ver ik heb begrepen is dit voornamelijk zodat niet voor iedereen die in het PMP komt tickets mag inschieten. Heeft het medewerkers account voor de externe klant leesrechten op alle functionaliteiten die ACT1 heeft of enkel een subset?

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
  ' rectangle "Aanvraag categorie" as Taak_type
  rectangle Incident
  rectangle Doorontwikkeling
  rectangle Impact
  rectangle Urgentie
  rectangle Servicevraag
}

rectangle "Productive"{
  rectangle Project
  rectangle Board
  rectangle Taak
  rectangle Werknemer
  rectangle Status

}
' Klant aanvraag
Klant "1..*" -- "0..*" Project : > Eigenaar van
Klant "1"--"0..*" Aanvraag :> Doet een
Doorontwikkeling "1"--"1..*" Taak :> Resulteert in
Incident "1"--"1..*" Taak :> Resulteert in
Project "0..*"--"1" SLA :> Valt onder


' Priority part
Incident --|> Aanvraag
Doorontwikkeling --|> Aanvraag
Servicevraag --|> Aanvraag

Impact "1"--"0-..*" Incident : > Ingediend met
Urgentie "1"--"0..*" Incident : > Ingediend met
Prioriteit "1"--"1" Impact : < Bepalend voor
Prioriteit "1"--"1" Urgentie : < Bepalend voor

SLA "1"--"0..*" Aanvraag : > bepaalt tijdslimieten voor

' Productive task board part
Board "1..*"--"1" Project: > Planning voor 
Taak "0..*"--"1" Board: > Opgenomen in
Werknemer "0..*"--"0..*" Taak :> Werkt aan
Werknemer "0..*"--"0..*" Team :> Onderdeel van
Taak "1"--"1" Team :> beschrijft werkzaamheden voor
Taak "0..*"--"1" Status :> werkstatus voor 
```

### Toelichting domeinmodel

| Entiteit | Uitleg | Gebruik |
|---|---|---|
| Productive (groepering) | De entiteiten binnen de Productive groepering bestaan de huidige staat van het systeem binnen de Bluenotion Productive.io omgeving.  | Bovenstaand diagram  |
| Project management portal (groepering) | De entiteiten binnen de PMP groepering zijn gebaseerd op de Bluenotion workflow en de bijbehorende service level agreements. Deze entiteiten hebben geen al bestaande data in de Productive omgeving.  | Bovenstaand diagram  |
| Project | Een stuk software dat een **Klant** wilt laten ontwikkelen door Bluenotion. | [FR1.1](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr11-inzien-projecten) |
| Klant  | Een individu of organisatie die bij Bluenotion een of meer projecten heeft lopen bij Bluenotion | [FR1.1](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr11-inzien-projecten) |
| Aanvraag | Iets dat de **klant** wil in zijn/haar **project**. Dit is meestal een **doorontwikkeling**, **incident** of **servicevraag**. | [FR3.1](./Requirements/FR3_Toevoegen_aanvraag.md#fr31-toevoegen-nieuwe-aanvraag-in-een-project) |
| Taak | Een **Aanvraag** waar een [PM of TL](FunctioneelOntwerp.md#act2-bluenotion-admin) goedkeuring voor heeft gegeven voor ontwikkeling. Dit kunnen nieuwe functionaliteiten en bugfixes zijn. Toelichting over de lifecycle van taken is [hier onder](#lifecycle-aanvragen) te vinden. | [FR3.1](./Requirements/FR3_Toevoegen_aanvraag.md#fr31-toevoegen-nieuwe-aanvraag-in-een-project) |
| Bord | Een bord waar intern voor Bluenotion taken op worden bijgehouden. Zie [lifecycle taken](#lifecycle-aanvragen) voor meer informatie. | [FR3.1](./Requirements/FR3_Toevoegen_aanvraag.md#fr31-toevoegen-nieuwe-aanvraag-in-een-project) |
| Team | Een representatie van de rollen en beschikbare kennis binnen Bluenotion die worden gebruikt voor het toekennen van de juiste taak aan de juiste werknemers. (UX, FE, BE) | [FR8.2](./Requirements/FR8_Controleren_aanvraag.md#fr82-op-splitten-taak-naar-team-taken) |
| Werknemer | Een werknemer van Bluenotion die aan taken werkt en de status hiervan bijhoudt in Productive. | [NFR2](#nonfunctional-requirements) |
| SLA | Een **klant** heeft een aantal afspraken voor een **project** vaststaan in een Service Level Agreement waar KPI's zijn vastgelegd die leidend zijn in de **prioriteit** en het **type** van een taak. | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Taak type | Het soort taak, afhankelijk van de SLA met de klant. | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Doorontwikkeling (Taak type) | Een verzoek tot aanpassen van iets binnen de software. Doorgaans komen deze wijzigingen neer op doorontwikkelingen van de software. | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)   |
| Servicevraag (Taak type)  | Een vraag die een **klant** heeft over de software waar geen verdere ontwikkeling voor nodig is.  |   |
| Incident (Taak type) | Het substantieel niet voldoen van de applicatie aan de overeengekomen specificaties alsmede de situatie waarin sprake is van niet-Beschikbaarheid die niet het gevolg is van onderhoud. | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Urgentie  | De spoedeisendheid van een incident voor de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](#incident-impact-urgentie-en-prioriteit-levels)   | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Impact  | De (ernst van de) gevolgen van een incident voor de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](#incident-impact-urgentie-en-prioriteit-levels)  | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)   |
| Prioriteit | De prioriteit van de taak, afhankelijk van of mensen nog kunnen werken en de wensen van de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](#incident-impact-urgentie-en-prioriteit-levels) | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  [FR4.2](./Requirements/FR4_Versturen_notificaties.md#fr42-inlichten-bluenotion-bij-blockerscriticals) |
| Status (Taak)  | De status van een taak geeft aan in welk deel van het development proces een taak zich bevindt. Voorbeelden zijn Not started, Open en Closed.  |   |

### Lifecycle aanvragen

Aangezien een van de primaire doelen van het PMP het inzichtelijk maken van het aangevraagde, uitvoerende en uitgevoerde werk is volgt in dit hoofdstuk een toelichting op de lifecycle van een typische aanvraag/taak binnen Bluenotion. Dit proces kan per project verschillen met details als of klanten zelf toegang hebben tot Productive of toevoeging/weglaten van sommige task lists maar het blijft in grove lijnen over de meeste projecten het zelfde. Ter verheldering is de aanvraag/taak structuur uit het domeinmodel hier apart toegelicht.

Als een klant iets wil in zijn/haar project doen ze hier een aanvraag voor. Op basis van deze aanvraag maakt de PM of TL (afhankelijk van de functionele of technische aard van de aanvraag) hier taken van. Deze taken worden over de loop van tijd op verschillende borden gezet met verschillende verwachtingen van **wie** **wat** gaat doen met de taak. Hier onder volgt een generalisatie van hoe de workflow van de meeste projecten loopt.

#### Taak structuur

Belangrijk is om toe te lichten hoe Bluenotion om gaat met verschillende soorten aanvragen. Zoals in het schema te zien is wordt niet elke aanvraag een taak en wordt er op verschillende manieren met incidenten omgegaan dan met een doorontwikkeling. Verdere toelichting over hoe incidenten worden behandeld in vergelijking met doorontwikkelingen is te vinden in [de toelichting over incidenten](#incident-impact-urgentie-en-prioriteit-levels).

```plantuml
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 120

rectangle "Klant " {
  rectangle Klant
  rectangle Aanvraag
}

rectangle "PM/TL " {
  rectangle Taak
  rectangle Doorontwikkeling
  rectangle Servicevraag
  rectangle Status
  rectangle Board
  rectangle "Bij incident" {
    rectangle Incident
    rectangle Impact
    rectangle Urgentie
    rectangle Prioriteit
  }
}

' Klant aanvraag
Klant "1"--"0..*" Aanvraag :> Doet een
Doorontwikkeling "1"-RIGHT-"1..*" Taak :> Resulteert in
Incident "1"--"1..*" Taak :> Resulteert in


' Priority part
Incident --|> Aanvraag
Doorontwikkeling --|> Aanvraag
Servicevraag -LEFT-|> Aanvraag
Taak "0..*"--"1" Status : > werkstatus voor 
Taak "0..*"--"1" Board : > Wordt bijgehouden op

' Incident part
Impact "1"--"0-..*" Incident : < Ingediend met
Urgentie "1"--"0..*" Incident : < Ingediend met
Prioriteit "1"--"1" Impact : < Bepalend voor
Prioriteit "1"--"1" Urgentie : < Bepalend voor


```

**Servicevragen**: Servicevragen komen over het algemeen niet in Productive terecht maar worden doorgaans via de mail of telefoon direct beantwoord.*

**Doorontwikkeling**: Extra functionaliteiten aangevraagd door de klant worden zonder prioriteit, in een scope in productive gezet.

**Incident**: Een incident wordt net als een doorontwikkeling in een scope in productive gezet maar deze heeft een impact en urgentie die de prioriteit bepaald.

*Bluenotion heeft enkel een 2e lijns servicedesk, bereikbaar door de 1e lijn van de klant maar niet door eindgebruikers.

#### Bord structuur

Zodra voor een doorontwikkeling of incident een taak is aangemaakt komt deze op een bord terecht in productive. Aan de hand van deze borden houdt Bluenotion bij hoe veel werk nog open staat voor elk project en wie verantwoordelijk is voor de volgende stap voor de betreffende taken.

```plantuml
title Boards and statuses
skinparam nodesep 10
skinparam ranksep 10
left to right direction
skinparam groupInheritance 3

' skinparam linetype polyline
' skinparam linetype ortho
(backlog) #orange
(in progress) as in_progress  #orange
(in review) as in_review #orange 
(development) #99FF00
(staging) #99FF00
(live) #green
(wishlist) #Orange
(aanvragen) #Orange
' (awaiting customer) as awaiting_customer #red
actor "Externe klant" as EK

note "Input nodig van klant" as customernotifynote #Purple
note "input nodig van Bluenotion" as bluenote #Lightblue

customernotifynote .[norank]. wishlist
customernotifynote .[norank]. staging
customernotifynote .[norank]. aanvragen
bluenote .[norank]. aanvragen
bluenote .[norank]. wishlist

aanvragen -DOWN-> backlog : ✓
wishlist -[norank]-> backlog : ✓
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
EK --> aanvragen : Voorgestelde situatie
EK -[norank]-> backlog : Oude situatie


legend left
    | Color | Status |
    |<#Orange>| Open |
    |<#99FF00>| Done |
    |<#Green>| Closed |
    |<#Purple> | Waiting for review customer |
    |<#LightBlue>  | Waiting for review Bluenotion |
    | ✓ | Accepted |
endlegend

```

<!-- | Awaiting customer (new)  | Taken die incorrect of incompleet zijn ingevuld door de klant worden door de PM of TL op dit bord neergezet met een vraag voor extra feedback van de klant.  | ACT1: Externe klant | -->
Toelichting borden:
| Bord | Doel | Verantwoordelijke partij |
|---|---|---|
| Aanvragen (new) | Taken die door de klant zijn ingeschoten maar nog niet geaccepteerd door de PM en/of TL komen op de aanvragen lijst terecht.  | ACT2: Bluenotion admin|
| Wishlist  | Taken die tijdens ontwikkeling naar boven zijn gekomen als "Nice to haves" en worden opgepakt als er tijd over is.  | ACT1: Externe klant |
| Backlog  | De backlog is waar geaccepteerde taken terecht komen. Vanaf de backlog pakken de aangewezen teams de taken op.  | ACT3: Bluenotion medewerker |
| In progress  | Zodra een developer een taak op pakt wordt deze als In progress geregistreerd.  | ACT3: Bluenotion medewerker |
| In review  | Nadat een developer aan een taak heeft gewerkt wordt deze klaar gezet voor review.  | ACT3: Bluenotion medewerker |
| Development  | Functionaliteit is gebouwd maar staat nog niet op de test versie. | ACT2: Bluenotion admin |
| Staging  | Functionaliteit is gebouwd en staat op de test versie  | ACT1: Externe klant |
| Live  | Alle afgeronde taken die draaien op de productie omgeving.  | N/A |

#### Status structuur

Huidige situatie:

Zoals te zien in het vorige hoofdstuk over de [verschillende borden](#bord-structuur) die worden gebruikt binnen Bluenotion zijn er verschillende momenten waarop input van de klant nodig of gewenst is om een taak voort te zetten. Op het moment komt feedback van de klant voornamelijk op twee manieren binnen:

- Directe communicatie

Directe communicatie met de klant wordt vaak gebruikt als er iets onduidelijk blijkt in de aanvraag. Dit loopt doorgaans via de mail of telefoon.

- Sprint review

Tijdens de sprint review hebben beide partijen de mogelijkheid aan de hand van een demo input te leveren voor het project. Taken die hier worden besproken staan doorgaans op "staging".

Om de klant mee te nemen in het ontwerp proces dient hij op de hoogte te zijn van de status van zijn project. Wel is aan de klanten die toegang hebben tot de Productive omgeving opgevallen dat een overvloed aan informatie ook weer voor onduidelijkheid kan zorgen. Om deze reden is het belangrijk de klant te informeren wanneer wat van hem verwacht wordt zonder een overvloed van informatie.

Voorgestelde situatie:

Bluenotion werkt bij start van het project per taak met een status die aangeeft of een taak "Open", "Done", "Vakantie/Vrij" of "Closed" is. Het hele proces van aanvraag tm implementatie bevindt zich in de "Open" status. Door naast Open twee extra statuses toe te voegen voor wanneer een taak wacht op feedback van de klant of wacht op feedback van Bluenotion is het mogelijk binnen Productive zonder een taak van bord te wisselen een taak "open te zetten voor review". Zo kan er bijvoorbeeld een taak met onduidelijke beschrijving uit de aanvragen opengezet worden voor verduidelijking en een taak uit staging klaargezet voor review in de applicatie.

| Status  | Uitleg  | [Workflow stage](https://help.productive.io/en/articles/5813154-creating-and-managing-workflows)  |
|---|---|---|
| Waiting for review customer  | Geeft aan dat een taak aan het wachten is op feedback van de klant.  | Not started  |
| Waiting for review Bluenotion | Geeft aan dat een taak aan het wachten is op feedback van Bluenotion. | Not started |
| Open  | Geeft aan dat Bluenotion actief aan het werk is aan een taak.  | Started  |
| Done  | Geeft aan dat Bluenotion aan een taak heeft gewerkt en deze klaar is voor review.  | Started  |
| Closed  | Geeft aan dat de klant een afgeronde taak heeft gereviewd en goedgekeurd.  | Closed  |

#### Incident Impact, Urgentie en Prioriteit levels

Incident:
Een incident is een aanvraag die te maken heeft met het niet goed functioneren van de huidige applicatie op de manier zoals wel uitdrukkelijk overeengekomen. De prioriteit van een incident wordt bepaald aan de hand van de verwachte impact en urgentie.

<Table>

<tr><th>Impact</th><th>Urgentie</th></tr>
<tr>
<td>
De impact van een incident geeft aan hoe veel of weinig mensen last hebben van het incident.

| Categorie  | Omschrijving  |
|---|---|
| Hoog (H)  | - Een grote groep werknemers van Opdrachtgever wordt geraakt </br> - Een grote groep Eindgebruikers wordt geraakt </br> - Er bestaat een groot risico op reputatieschade  |
| Middel (M)  | - Een beperkte groep van de werknemers van Opdrachtgever wordt geraakt  </br> - Een beperkte groep Eindgebruikers wordt geraakt </br> - Het ontstaan van enige reputatieschade is aannemelijk  |
| Laag (L)  | - Slechts een klein aantal werknemers van Opdrachtgever wordt geraakt </br> - Slechts een klein aantal Eindgebruikers wordt geraakt </br>  - Er is slechts een kleine kans op reputatieschade  |

</td>
<td>
De spoedeisendheid van een Incident voor de opdrachtgever.

| Categorie  | Omschrijving  |
|---|---|
| Hoog (H)  | - de schade van het Incident neemt snel toe </br> - de verstoorde processen zijn sterk aan tijd gebonden </br> - snel ingrijpen kan voorkomen dat het Incident ernstiger wordt  |
| Middel (M)  | - de schade van het Incident zal aanzienlijk toenemen gedurende de tijd </br> - de verstoorde processen kunnen enige tijd worden uitgesteld   |
| Laag (L)  | - de schade van het Incident zal weinig toenemen gedurende de tijd </br> - de verstoorde processen zijn niet of nauwelijks aan tijd gebonden  |

</td>
</tr>

</Table>

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
| US1   | ACT2  | Als Bluenotion admin wil ik een eenduidig overzicht van alle projecten die lopen binnen Bluenotion zodat ik snel de status met een klant kan bespreken.  | [FR1.1](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr11-inzien-projecten) |
| US2  | ACT1 | Als externe klant wil ik een eenduidig overzicht van alle voor mij relevante projecten zodat ik snel kan zien welke projecten actief aan gewerkt worden.  | [FR1.2](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr12-inzien-totaal-geplande-urenkosten) |
| US3  | ACT1 | Als externe klant wil ik een overzicht van het geplande werk zodat ik zicht kan houden op de ontwikkeltijd en kosten. | [FR1.2](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr12-inzien-totaal-geplande-urenkosten), [FR2.1](./Requirements/FR2_Inzien_taken.md#fr21-inzien-taken-van-project), [FR2.2](./Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed), [FR2.3](./Requirements/FR2_Inzien_taken.md#fr23-inzien-taak-details), [FR2.4](./Requirements/FR2_Inzien_taken.md#fr24-tonen-taken-in-gantt-chart) |
| US4  | ACT2  | Als Bluenotion admin wil ik de zelfde informatie kunnen zien als een externe klant zodat ik bij vragen de klant kan ondersteunen.  |  X |
| US5  | ACT3  | Als Bluenotion medewerker wil ik niet mijn werkwijze aanpassen om een nieuw systeem voor de klant te ondersteunen.  | [NFR2.1](#nonfunctional-requirements)  |
| US6  | ACT1  | Als externe klant wil ik bij mijn projecten de optie om nieuwe taken toe te voegen zodat ik issues en door ontwikkelingen kan doorgeven.  | [FR3.1](./Requirements/FR3_Toevoegen_aanvraag.md#fr31-toevoegen-nieuwe-taak-in-een-project) |
| US7  | ACT1, ACT2  | Als Bluenotion admin wil ik bij taken die onduidelijk of incorrect ingevuld zijn de klant de optie geven deze onduidelijkheid te verhelderen.  | [FR2.6](./Requirements/FR2_Inzien_taken.md#fr26-comments-toevoegen-op-lopende-taak), [FR3.2](./Requirements/FR3_Toevoegen_aanvraag.md#fr32-toelichting-geven-op-taak), [FR8.1](./Requirements/FR8_Controleren_aanvraag.md#fr81-controleren-aanvraag), [FR8.2](./Requirements/FR8_Controleren_aanvraag.md#fr82-op-splitten-taak-naar-team-taken) |
| US8  | ACT1  | Als externe klant wil ik bij taken die extra toelichting nodig hebben feedback kunnen geven op deze taken zodat ze goedgekeurd kunnen worden voor de backlog.  | [FR2.2](./Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) |
| US9  | ACT1  | Als externe klant wil ik een eenduidig overzicht van taken die wachten op mijn input voordat er aan gewerkt wordt zodat deze taken niet onnodig lang blijven liggen.  | [FR2.2](./Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed), [FR4.1](./Requirements/FR4_Versturen_notificaties.md#fr41-versturen-notificatie) |
| US10  | ACT2  | Als Bluenotion admin wil ik bij taken die toegevoegd zijn door een externe klant taken goedkeuren voor ze op de backlog terecht komen.  | [FR8.1](./Requirements/FR8_Controleren_aanvraag.md#fr81-controleren-aanvraag), [FR8.2](./Requirements/FR8_Controleren_aanvraag.md#fr82-op-splitten-taak-naar-team-taken)  |
| US11  |   | Als ?software developer? wil ik geen data over het netwerk sturen waar de klant geen toegang toe heeft.  |   |
| US12 | ACT2 | Als Bluenotion admin wil ik dat de klant afbeeldingen kan invoegen om problemen/aanvragen toe te lichten. | [FR3.4](./Requirements/FR3_Toevoegen_aanvraag.md#fr34-toevoegen-bijlagen-bij-taak) |
| US13 | ACT1 | Als externe klant wil ik alle informatie over mijn te bouwen/gebouwde systeem op één centrale plek bekijken | [FR6.1](FunctioneelOntwerp.md#fr61-inzien-lijst-van-project-dependencies), [FR6.2](./Requirements/FR6_Inzien_project_service_statuses.md#fr62-inzien-huidige-status-onlineoffline-project-dependencies), [FR7.1](./Requirements/FR7_Inzien_project_documentatie.md#fr71-openendownloaden-document), [FR7.2](./Requirements/FR7_Inzien_project_documentatie.md#fr72-filteren-documentnaamcategorie) |
| US14 | ACT3 | Als software developer wil ik niet dat mensen toegang krijgen tot data die mogelijk privacy gevoelig is en/of niet bedoeld is voor de betreffende persoon. | [NFR4.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.2](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.3](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.4](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US15 | ACT3 | Als software developer wil ik dat als er iets niet naar behoren werkt er logs beschikbaar zijn om het probleem te herleiden. | [NFR4.5](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.6](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US16 | ACT3 | Als medewerker van Bluenotion wil ik dat alle klanten van Bluenotion om kunnen gaan met het PMP. | [NFR1.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR6.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR6.3](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR7.1](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US17 | ACT1 | Als externe klant wil ik niet beïnvloed worden door andere mensen die tegelijkertijd het PMP gebruiken. | [NFR2.2](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR5.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR5.2](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US18 | ACT2 | Als Bluenotion admin wil ik dat het systeem bij verlies van database binnen 3 uur hersteld kan worden naar een werkende state. | [NFR8.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR8.2](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR8.3](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US19 | ACT2 | Als Bluenotion admin wil ik alle project management en project gerelateerde klantcontact via het zelfde kanaal afhandelen | [FR5.1](./Requirements/FR5_Opstellen_project.md#fr51-afhandelen-project-setup) |
| US20 | ACT1, ACT2 | Als Bluenotion admin wil ik servicevragen gescheiden houden van taken zodat developers hier minder tijd aan kwijt zijn. | [FR9](./Requirements/FR9_Tenant_level_chat.md) |

### Requirements traceability matrix

```plantuml
title Use case diagram
left to right direction

:ACT1 Externe klant: as KL
:ACT2 Bluenotion Admin: as ADM
:ACT4 Notification manager: as Notification

(FR1: Inzien project plannings informatie) as FR1
(FR2: Inzien taken) as FR2
(FR3: Toevoegen aanvraag) as FR3
(FR4: Versturen notificaties) as FR4
(FR5: Opstellen project) as FR5
(FR6: Inzien project service statuses) as FR6
(FR7: Inzien project documentatie) as FR7
(FR8: Controleren aanvraag) as FR8
(FR9: Tenant level chat voor directe communicatie) as FR9

KL -DOWN-> FR1
KL -DOWN-> FR2
KL -DOWN-> FR3
KL -DOWN-> FR6
KL -DOWN-> FR7
KL -DOWN-> FR9

ADM-DOWN->FR5
ADM-DOWN->FR8
Notification-DOWN->FR4

ADM-LEFT-|>KL

```

| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Dependencies | Document references | Status |
|---|---|---|---|---|---|---|
| FR1  | Inzien project plannings informatie |   |   | NFR0.5  | [Requirement overzicht](./Requirements/FR1_Inzien_project_plannings_informatie.md)  | UX |
| FR1.1  |   | Inzien projecten  | Must have  | NFR0.5  | [US1](#user-stories), [US2](#user-stories), [Fully dressed usecase description](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr11-alternative-flow---no-projects-for-customer)  | UX |
| FR1.2  |   | Inzien totaal geplande uren+kosten  | Won't have [FDR001](../Decisions/Functional/FDR001-Tijd-en-kosten-niet-tonen.md)  | FR1.1  | [US3](#user-stories), [Fully dressed usecase description](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr12-inzien-totaal-geplande-urenkosten)  | UX |
| FR2  | Inzien taken  |   |   |   | [Requirement overzicht](./Requirements/FR2_Inzien_taken.md)  |  |
| FR2.1  |   | Inzien taken van project  | Must have  |   | [US3](#user-stories), [Fully dressed usecase description](./Requirements/FR2_Inzien_taken.md#fr21-inzien-taken-van-project)  | UX |
| FR2.2  |   | Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed | Must have |  | [US3](#user-stories), [US8](#user-stories), [US9](#user-stories), [Fully dressed usecase description](./Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) | UX |
| FR2.3  |   | Inzien taak details  | Must have  |   | [US3](#user-stories), [Fully dressed usecase description](./Requirements/FR2_Inzien_taken.md#fr23-inzien-taak-details)  | UX |
| FR2.4  |   | Tonen taken in Gantt chart?  | Could have | FR2.1 | [US3](#user-stories), [Fully dressed usecase description](./Requirements/FR2_Inzien_taken.md#fr24-main-flow) | UX |
| FR2.7  |   | Filteren taken op: incident of doorontwikkeling  | Should have  |   |  | Afstemming |
| FR3 | Toevoegen aanvraag |  |  |  | [Requirement overzicht](./Requirements/FR3_Toevoegen_aanvraag.md) |
| FR3.1  |   | Toevoegen nieuwe taak | Must have  |   | [US6](#user-stories), [Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr31-toevoegen-nieuwe-aanvraag-in-een-project)  | UX |
| FR3.2  |   | Toelichting geven op taak (extern)  | Must have  |   | [US7](#user-stories), [Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr32-toelichting-geven-op-taak)  | UX |
| FR3.3  |   | Toevoegen taken past zich aan aan de klant zijn SLA | Could have | FR1.4 | [Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla) | Afstemming |
| FR3.4 |   | Toevoegen bijlagen bij taak | Must have |  | [US12](#user-stories), [Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr34-toevoegen-bijlagen-bij-taak) | UX |
| FR3.5  |   | Aanpassen taak prioriteit| Could have | FR3.3 |[Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr35-aanpassen-taak-prioriteit)  | UX |
| FR4  | Versturen notificaties  |   |   |   | [Requirement overzicht](./Requirements/FR4_Versturen_notificaties.md)  ||
| FR4.1  |   | Inlichten klant wanneer een taak wacht op input van de klant  | Should have  |   | [US9](#user-stories), [Fully dressed usecase description](./Requirements/FR4_Versturen_notificaties.md#fr41-inlichten-klant-wanneer-een-taak-wacht-op-input-van-de-klant)  | UX |
| FR4.2  |   | Inlichten Bluenotion bij blockers/criticals  | Could have  |   | [Fully dressed usecase description](./Requirements/FR4_Versturen_notificaties.md#fr42-inlichten-bluenotion-bij-blockerscriticals)  | UX |
| FR5? | Opstellen project |  |  |  |  | Afstemming |
| FR5.1  |   | Afhandelen project setup binnen PMP  | Could have  |   | [US19](#user-stories), [Fully dressed usecase description](./Requirements/FR5_Opstellen_project.md#fr51-afhandelen-project-setup)   | Afstemming |
| FR6  | Inzien project service statuses  |   |   |   | [Requirement overzicht](./Requirements/FR6_Inzien_project_service_statuses.md)  ||
| FR6.1  |   | Inzien lijst van project dependencies  | Could have  |   | [US13](#user-stories), [Fully dressed usecase description](./Requirements/FR6_Inzien_project_service_statuses.md#fr61-inzien-lijst-van-project-dependencies)  | Afstemming |
| FR6.2  |   | Inzien huidige status (online/offline) project dependencies | Could have  | FR6.1  | [US13](#user-stories),[Fully dressed usecase description](./Requirements/FR6_Inzien_project_service_statuses.md#fr62-inzien-huidige-status-onlineoffline-project-dependencies)  | Afstemming |
| FR6.3  |   | Beheren project services  | Could have  | FR6.1  | [Fully dressed usecase description](./Requirements/FR6_Inzien_project_service_statuses.md#fr63-beheren-project-services)  | Afstemming |
| FR7  | Inzien project documentatie |  |  |  | [Requirement overzicht](./Requirements/FR7_Inzien_project_documentatie.md) ||
| FR7.1  |   | Openen/downloaden document  | Could have  |   | [US13](#user-stories), [Fully dressed usecase description](./Requirements/FR7_Inzien_project_documentatie.md#fr71-openendownloaden-document)  | UX |
| FR7.2  |   | Filteren documentnaam/categorie?  | Could have  | FR7.1  | [US13](#user-stories), [Fully dressed usecase description](./Requirements/FR7_Inzien_project_documentatie.md#fr72-filteren-documentnaamcategorie)  | UX |
| FR7.3  |   | Beheren project documentatie  | Could have  | FR7.1  | [Fully dressed usecase description](./Requirements/FR7_Inzien_project_documentatie.md#fr73-beheren-project-documentatie)  | UX |
| FR8 | Controleren aanvraag |  |  |  | [Requirement overzicht](./Requirements/FR8_Controleren_aanvraag.md) ||
| FR8.1  |   | Controleren aanvraag (intern)  | Must have  |   | [US7](#user-stories), [Fully dressed usecase description](./Requirements/FR8_Controleren_aanvraag.md#fr81-controleren-aanvraag), [US10](#user-stories)  | UX |
| FR8.2  |   | Op splitten taak naar "team" taken | Could have |   | [US7](#user-stories), [Fully dressed usecase description](./Requirements/FR8_Controleren_aanvraag.md#fr82-op-splitten-taak-naar-team-taken), [US10](#user-stories)  | UX |
| FR9  | Chat met tenants  |   | Won't have [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) |   | [Requirement overzicht](./Requirements/FR9_Tenant_level_chat.md) | Rejected |
| FR9.1 | | Starten nieuwe chat  | Won't have [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) |   | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR9_Tenant_level_chat.md#fr91-starten-nieuwe-chat)  | Rejected  |
| FR9.2 | | Bericht sturen niet afgesloten chat  | Won't have [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) |   | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR9_Tenant_level_chat.md#fr92-bericht-sturen-niet-afgesloten-chat)  | Rejected  |
| FR9.3 | | Hervatten afgesloten chat  | Won't have [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) |   | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR9_Tenant_level_chat.md#fr93-hervatten-afgesloten-chat)  | Rejected  |
| FR9.4 | | Sluiten chat  | Won't have [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) |   | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR9_Tenant_level_chat.md#fr94-sluiten-chat)  | Rejected  |


<!-- | FR2.6  |   | Comments toevoegen op aanvraag/taak  |  Could have  |  |  [US7](#user-stories), [Fully dressed usecase description](#fr26-comments-toevoegen-op-lopende-taak)  | -->

#### Nonfunctional requirements

| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) |  Document references |
|---|---|---|---|---|
| NFR1  | Usability  |      |   |   |
|   | NFR1.1  | Het systeem dient beschikbaar te zijn in Nederlands en Engels, met optie tot uitbreiding.  | Should have     | [US16](#user-stories)  |
| NFR2 | Reliability  |      |   |   |
|   | NFR2.1  | Informatie over projecten en taken komen altijd overeen met de informatie op Productive.  | Must have  |      |
|   | NFR2.2  | Het systeem geeft bij 95% van de requests in een maand antwoord zoals beschreven in dit document.  | Must have  |    [US17](#user-stories)   |
| NFR3 | Performance  |   |   |      |
|   | NFR3.1  | Onder normale omstandigheden wordt data die niet afkomstig is van de Productive API binnen 1? seconde na aanvraag getoond aan de gebruiker.  | Should have  |    [US17](#user-stories)   |
|   | NFR3.2  | Onder normale omstandigheden wordt data die afkomstig is van de Productive API binnen 3? seconden na aanvraag getoond aan de gebruiker. | Should have  |    [US17](#user-stories)  |
| NFR4 | Security |  |  |    |
|   | NFR4.1  | Authenticatie: Uitnodigen nieuwe gebruikers via e-mail | Must have |   [US14](#user-stories) |
|   | NFR4.2  | Authenticatie: Aanmelden met e-mail en wachtwoord  | Must have  |    [US14](#user-stories)  |
|   | NFR4.3  | Autorisatie: Afschermen ongerelateerde project/taak info  | Must have  |    [US14](#user-stories)  |
|   | NFR4.4  | Autorisatie: Autorisatie gebeurt volledig binnen de back-end en database | Should have  |    [US14](#user-stories)  |
|   | NFR4.5  | Accounting: Loggen write events  | Must have?  |    [US15](#user-stories)  |
|   | NFR4.6  | Accounting: Loggen read events?  | Could have?  |    [US15](#user-stories)  |
|   | NFR4.7  | Het systeem is AVG/GDPR compliant  | Must have  |      |
| NFR5 | Scalability  |   |   |      |
|   | NFR5.1  | De software komt met 50? gelijktijdige gebruikers niet aan de Productive API rate limits  | Should have  |    [US17](#user-stories)  |
|   | NFR5.2  | De software komt ongeacht hoeveelheid gelijktijdige gebruikers niet aan de Productive API rate limits?  | Would have     | [US17](#user-stories)  |
| NFR6 | Portability  |  |   |      |
|   | NFR6.1  | Het systeem schaalt "netjes"? op alle Windows en MAC versies van de afgelopen 3? jaar  | Should have  |    [US16](#user-stories)  |
|   | NFR6.2  | Het systeem is platform onafhankelijk (zou implementaties kunnen hebben met bijvoorbeeld Jira, GitLab, Trello)  | Would have     |   |
|   | NFR6.3  | Het systeem werkt in alle FireFox, Chrome, Edge en Safari versies van de afgelopen 3? jaar.  | Must have  |    [US16](#user-stories)  |
| NFR7 | Compatibility  |   |   |      |
|   | NFR7.1  | Het systeem werkt op alle Windows en MAC versies van de afgelopen 3? jaar  | Must have  |    [US16](#user-stories)  |
| NFR8 | Maintainability  |   |   |      |
|   | NFR8.1  | Het systeem kan bij verlies van de database binnen 3 uur hersteld worden naar een werkende state.  | Could have  |    [US18](#user-stories)  |
|   | NFR8.2  |  Bij verlies van de database raken geen gegevens over projecten of taken verloren. | Must have |   [US18](#user-stories)  |
|   | NFR8.3  | Bij verlies van de database raken geen gegevens ouder dan 24 uur verloren.  | Must have  |    [US18](#user-stories)  |

### unsorted

| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Dependencies | Document references |
|---|---|---|---|---|---|
| FR1.3  |   | Toekennen overige project uren  | Could have  | FR1.2  |   |
| FR1.4  |   | Toekennen SLA KPI's | Could have  | FR1.1  |   |

<!-- TODO: Sources netjes documenteren maar sources:
NFR categories: https://www.altexsoft.com/blog/non-functional-requirements/
https://www.altexsoft.com/blog/software-requirements-specification/
Tracability matrix: https://www.researchgate.net/figure/Requirements-traceability-matrix-for-online-shopping-system_tbl4_280083523 -->

## Scherm ontwerpen

Naar vraag van Roel Dekkers, de inhouse UX designer zijn de bovengenoemde functionaliteiten ingedeeld ingedeeld per omgeving. Om groeperingen van de functionaliteiten binnen het programma en de interacties tussen de verschillende omgevingen zijn ze per 'pagina' gegroepeerd. Dit hoeven geen pagina's te zijn in de uiteindelijk te bouwen applicatie maar dienen als ondersteuning bij het UX ontwerp.

Algemeen:

| Pagina  | Doel  | Oorsprong  |
|---|---|---|
| Registreren  | Het registreren van een nieuwe gebruiker in het PMP.  | [NFR4](#nonfunctional-requirements)  |
| Aanmelden  | Het aanmelden van een bestaande gebruiker in het PMP  | [NFR4](#nonfunctional-requirements)  |
| Wachtwoord vergeten  | Het resetten van een wachtwoord van een bestaande gebruiker in het PMP  | [NFR4](#nonfunctional-requirements)  |
| Over ons  | Een pagina met een korte omschrijving van Bluenotion en wat we doen  |   |
| Contact  | Contact informatie hoe mensen ons naast het PMP kunnen bereiken  |   |

Klant:

| Pagina  | Doel(en)  |
|---|---|
| Mijn projecten pagina | - Een globaal overzicht geven van de voor de klant beschikbare projecten. [FR1.1](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr11-inzien-projecten)</br>- Project status en details tonen [FR1.2](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr12-inzien-totaal-geplande-urenkosten) </br>- Om het extra duidelijk te maken voor de klant wanneer er iets van de klant wordt verwacht hier ook het lijstje met de "waiting for customer" lijst? [FR2.2](./Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) |
| Project detail pagina  | - Een globaal overzicht geven van het door de klant geselecteerde project met snelle overzichten van de filters/lijstjes als beschreven in [FR2.2](./Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) </br>-Overzicht van de voor het project relevante dependencies en services zoals beschreven in [FR6.1](./Requirements/FR6_Inzien_project_service_statuses.md#fr61-inzien-lijst-van-project-dependencies) en [FR6.2](./Requirements/FR6_Inzien_project_service_statuses.md#fr62-inzien-huidige-status-onlineoffline-project-dependencies).</br>- Een overzicht van de geplande uren/kosten [FR1.2](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr12-inzien-totaal-geplande-urenkosten) </br>- Optie voor een timeline of Gantt chart view? [FR2.4](./Requirements/FR2_Inzien_taken.md#fr24-tonen-taken-in-gantt-chart) |
| Taken lijst pagina  | - De taken lijstjes van de project detail pagina met extra informatie als wanneer er voor het laatst aan de taak is gewerkt, de datum waarop verwacht wordt dat de taak klaar is, tijd/kosten inschatting & status? [FR1.2](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr12-inzien-totaal-geplande-urenkosten), [FR2.1](./Requirements/FR2_Inzien_taken.md#fr21-inzien-taken-van-project) & [FR2.2](./Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) |
| Taak detail pagina  | - De pagina waar alle beschikbare informatie voor een taak te vinden is inclusief de aan de taak gekoppelde bijlages en comments. [FR2.3](./Requirements/FR2_Inzien_taken.md#fr23-inzien-taak-details) </br>- De gebruiker dient ook comments toe te kunnen voegen [FR3.2](./Requirements/FR3_Toevoegen_aanvraag.md#fr32-toelichting-geven-op-taak) |
| Toevoegen aanvraag pop-up/pagina/stappen&vragen  | - Invoervelden waar de gebruiker een aanvraag kan doen. Invoer bestaat uit: naam, omschrijving, screenshot/bijlages, type (doorontwikkeling of issue), urgentie en impact (in geval van issue) [FR3.1](./Requirements/FR3_Toevoegen_aanvraag.md#fr31-toevoegen-nieuwe-aanvraag-in-een-project), [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla), [FR3.4](./Requirements/FR3_Toevoegen_aanvraag.md#fr34-toevoegen-bijlagen-bij-taak) |
| Aanpassen taak/aanvraag  | - Het aanpassen van een al toegevoegde taak of aanvraag. Zelfde invoer velden als Toevoegen aanvraag maar met ingevulde gegevens en de comments zoals op de taak detail pagina. [FR3.5](./Requirements/FR3_Toevoegen_aanvraag.md#fr35-aanpassen-taak-prioriteit)  |
| Documentatie pagina  | - Een pagina waar de gebruiker voor het project beschikbaar gestelde documenten en tutorials kan bekijken/downloaden. [FR7.1](./Requirements/FR7_Inzien_project_documentatie.md#fr71-openendownloaden-document)</br> - Een zoek functie voor de documenten [FR7.2](./Requirements/FR7_Inzien_project_documentatie.md#fr72-filteren-documentnaamcategorie) |
| Chat venster  | - Een plek waar de gebruiker zijn* meest recente open en gesloten chats kan zien. </br> - Een plek waar de gebruiker berichten kan sturen naar Bluenotion medewerkers. |

*Klopt het dat de gebruiker zijn chats moet kunnen zien of alle chats van zijn tenant? Klinkt privacy gevoelig.

Admin:

| Pagina  | Doel(en)  |
|---|---|
| Projecten pagina  | - Zelfde pagina als "Mijn projecten pagina" van de klant maar zonder filter op project eigenaar. [US4](#user-stories) |
| Tenant pagina | - Tonen tenant informatie en een lijst van alle projecten van deze tenant. </br> Tonen chat/communicatie met de tenant [FR9](./Requirements/FR9_Tenant_level_chat.md) |
| Project setup pagina  | - Het afhandelen van het proces dat met de klant wordt aangegaan voordat aan een project wordt begonnen. Nog niet verder uitgewerkt. [FR5.1](./Requirements/FR5_Opstellen_project.md#fr51-afhandelen-project-setup)  |
| Project dependencies pagina | - Het toevoegen, verwijderen of wijzigen van de dependencies/services van een project [FR6.3](./Requirements/FR6_Inzien_project_service_statuses.md#fr63-beheren-project-services) |
| Project documentatie pagina  | - Het toevoegen, verwijderen of wijzigen van aan een project gekoppelde documentatie en tutorials [FR7.3](./Requirements/FR7_Inzien_project_documentatie.md#fr73-beheren-project-documentatie)   |
| Taak detail pagina  | - Controleren van een aanvraag met de mogelijkheid feedback te geven aan de klant (Zou voor de front-end kunnen via de zelfde pagina als die van de klant?)(FR8.1) </br> - Knop met accepteren/taak splitsen [FR8.2](./Requirements/FR8_Controleren_aanvraag.md#fr82-op-splitten-taak-naar-team-taken)  |
| Chat venster | - Een plek waar de gebruiker kan reageren op vragen gesteld door een klant. |
| Chat historie | - Een overzicht van alle gesloten en open chats van alle klanten? |

### Ontwerpen FR1 Inzien project plannings informatie

#### Klant: Projecten pagina

#### Admin: Projecten pagina

### Ontwerpen FR2 Inzien taken

#### Klant: Taken lijst

#### Klant: Taken detail

#### Admin: Taken lijst

#### Admin: Taken detail

### Ontwerpen FR3 Toevoegen taken

#### Klant: Toevoegen aanvraag

### Ontwerpen FR4 Versturen notificaties

### Ontwerpen FR5 Opstellen project

waarschijnlijk buiten scope

### Ontwerpen FR6 Inzien project service statuses

waarschijnlijk buiten scope

### Ontwerpen FR7 Inzien project documentatie

waarschijnlijk buiten scope

### Ontwerpen FR8 Controleren aanvraag
