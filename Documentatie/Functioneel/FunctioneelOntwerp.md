# Functioneel ontwerp Project Management Portal

Dit document dient als toelichting op de functionele eisen van het Product Management Portal. Na het doornemen van dit document dienen alle betrokken partijen een duidelijk beeld te hebben van precies wat het opgeleverde Project Management Portal functioneel kan.

## Aannames en afhankelijkheden

De actuele technische aspecten van het systeem zijn vastgelegd in het [Technisch ontwerp](../Technisch/TechnischOntwerp.md). Voor het vaststellen van de functionele eisen zijn binnen dit document de volgende technische aannames gedaan:

- De API van Productive.io Kan alle door de klant gewenste informatie aanleveren.
- Het aantal naar de Productive API gestuurde requests blijft onder 100 per 30 sec.

## Domein

In dit hoofdstuk wordt toelichting gegeven op het domein waarin het systeem zich bevind. Aangezien het PMP zal functioneren als koppeling tussen de klant en het Productive systeem van Bluenotion is het onderstaande domeinmodel ingedeeld in concepten binnen Productive en concepten binnen Bluenotion (aangeduid in het vak Project management portal). Hierdoor wordt de data die het PMP verwacht van Productive in een vroeg stadium vastgelegd en de afhankelijkheid op deze data aangegeven.

```puml

skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 120

rectangle "Project management portal"{
  class Klant
  class Aanvraag
  class Doorontwikkeling
  class Incident
  class Impact
  class Urgentie
  class Prioriteit
  class SLA{
    reactietijd
    oplostijd
  }
  class Gebruiker
}
rectangle "Productive"{
  class Project
  class Taak
  class Takenlijst
  class Board
  class Status
}

SLA"1"--"1"Project :> Toegekend aan
SLA"1"--"1"Prioriteit :> Bevat tijden voor

' Klant beheert project
Klant "1"--"0..1" Project :> Eigenaar van
Klant "1..*"--"0..*" Project :> Beheerder van

' Klant aanvraag
Klant "1"--"0..*" Aanvraag :> Doet een
Aanvraag "1"--"0..*" Taak :> Resulteert in

' aanvraag is een...
Incident --|> Aanvraag : < Ingediend als
Doorontwikkeling --|> Aanvraag : < Ingediend als


' Incident priority
Impact "1"--"0-..*" Incident : < Ingediend met
Urgentie "1"--"0..*" Incident : < Ingediend met
Prioriteit .. (Impact, Urgentie)  

Taak"0..*"--"1"Takenlijst : > Weggeschreven op
Takenlijst"0..*"--"1"Board : < Onderdeel van

Taak"0..*"--"1"Prioriteit :< Van
Taak"0..*"--"1"Status :< Van

Board "1..*"--"1" Project :> Voor

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
| Werknemer | Een werknemer van Bluenotion die aan taken werkt en de status hiervan bijhoudt in Productive. | [NFR2](#requirements) |
| SLA | Een **klant** heeft een aantal afspraken voor een **project** vaststaan in een Service Level Agreement waar KPI's zijn vastgelegd die leidend zijn in de **prioriteit** en het **type** van een taak. | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Taak type | Het soort taak, afhankelijk van de SLA met de klant. | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Doorontwikkeling (Taak type) | Een verzoek tot aanpassen van iets binnen de software. Doorgaans komen deze wijzigingen neer op doorontwikkelingen van de software. | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)   |
| Servicevraag (Taak type)  | Een vraag die een **klant** heeft over de software waar geen verdere ontwikkeling voor nodig is.  |   |
| Incident (Taak type) | Het substantieel niet voldoen van de applicatie aan de overeengekomen specificaties alsmede de situatie waarin sprake is van niet-Beschikbaarheid die niet het gevolg is van onderhoud. | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Urgentie  | De spoedeisendheid van een incident voor de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](../Archive/Incident%20Impact,%20Urgentie%20en%20Prioriteit%20levels.md)   | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  |
| Impact  | De (ernst van de) gevolgen van een incident voor de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](../Archive/Incident%20Impact,%20Urgentie%20en%20Prioriteit%20levels.md)  | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)   |
| Prioriteit | De prioriteit van de taak, afhankelijk van of mensen nog kunnen werken en de wensen van de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](../Archive/Incident%20Impact,%20Urgentie%20en%20Prioriteit%20levels.md) | [FR3.3](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla)  [FR4.2](./Requirements/FR4_Versturen_notificaties.md#fr42-inlichten-bluenotion-bij-blockerscriticals) |
| Status (Taak)  | De status van een taak geeft aan in welk deel van het development proces een taak zich bevindt. Voorbeelden zijn Not started, Open en Closed.  |   |

### Lifecycle aanvragen

Aangezien een van de primaire doelen van het PMP het inzichtelijk maken van het aangevraagde, uitvoerende en uitgevoerde werk is volgt in dit hoofdstuk een toelichting op de lifecycle van een typische aanvraag/taak binnen Bluenotion. Het in dit hoofdstuk beschreven proces gebeurt in de huidige situatie in een combinatie van excel, Productive en email en telefonische communicatie. Aangezien details kwijt kunnen raken in het volledige [domein model](./FunctioneelOntwerp.md#domein) volgt eerst nog een snelle toelichting op het verschil tussen een aanvraag, taak, doorontwikkeling en incident in de context van hoe deze door Bluenotion in Productive gebruikt worden.

```puml
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 120

  class Klant
  class Aanvraag
  class Taak
  class Doorontwikkeling
  class Incident
  class Impact
  class Urgentie
  class Prioriteit


' Klant aanvraag
Klant "1"--"0..*" Aanvraag :> Doet een
Aanvraag "1"--"1..*" Taak :> Resulteert in


' Priority part
Incident --|> Aanvraag : < Ingediend als
Doorontwikkeling --|> Aanvraag : < Ingediend als


' Incident part
Impact "1"--"0-..*" Incident : < Ingediend met
Urgentie "1"--"0..*" Incident : < Ingediend met
Prioriteit .. (Impact, Urgentie)  
```

| Entiteit | Uitleg |
|---|---|
| Aanvraag | Iets dat de **klant** wil in zijn/haar **project**. Dit is meestal een **doorontwikkeling**, **incident** of **servicevraag**. |
| Taak | Een **Aanvraag** waar een [PM of TL](#act2-interne-beheerder) goedkeuring voor heeft gegeven voor ontwikkeling. Dit kunnen nieuwe functionaliteiten en bugfixes zijn. 
| Incident  | Het substantieel niet voldoen van de applicatie aan de overeengekomen specificaties alsmede de situatie waarin sprake is van niet-Beschikbaarheid die niet het gevolg is van onderhoud. |
| Urgentie  | De spoedeisendheid van een incident voor de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](../Archive/Incident%20Impact,%20Urgentie%20en%20Prioriteit%20levels.md)   |
| Impact  | De (ernst van de) gevolgen van een incident voor de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](../Archive/Incident%20Impact,%20Urgentie%20en%20Prioriteit%20levels.md)  |
| Prioriteit | De prioriteit van de taak, afhankelijk van of mensen nog kunnen werken en de wensen van de klant, welke bepaald moet worden aan de hand van het overzicht zoals vastgesteld in het SLA volgens de [volgende tabel](../Archive/Incident%20Impact,%20Urgentie%20en%20Prioriteit%20levels.md) |

<!-- **Aanvraag**: Als een klant iets wil in zijn/haar project doen ze hier een aanvraag voor.

**Taak**: Een goedgekeurde aanvraag die op de backlog van productive terecht komt.

**Incident**: Een taak waar eerder aangeleverde functionaliteit niet werkt naar behoren. Incidenten krijgen een urgentie en impact aan de hand waarvan een prioriteit wordt toegewezen.

**Doorontwikkeling**: Een taak waar nieuwe functionaliteit wordt gebouwd voor een project. -->

<!-- Dit proces kan per project verschillen met details als of klanten zelf toegang hebben tot Productive of toevoeging/weglaten van sommige task lists maar het blijft in grove lijnen over de meeste projecten het zelfde. Ter verheldering is de aanvraag/taak structuur uit het domeinmodel hier apart toegelicht. -->

 Op basis van deze aanvraag maakt de PM of TL (afhankelijk van de functionele of technische aard van de aanvraag) hier verschillende taken van voor verschillende teams binnen Bluenotion. Deze taken worden over de loop van tijd op verschillende [Productive borden](./FunctioneelOntwerp.md#bord-structuur) gezet met verschillende verwachtingen van **wie** **wat** gaat doen met de taak.
Het proces van een aanvraag tot een uiteindelijke taak loopt als volgt:
<!-- Hier onder volgt een generalisatie van hoe de workflow van de meeste projecten loopt. -->

```puml
| Externe beheerder |
start
repeat
#Red:Plaats aanvraag;
note right: FR3.1 Toevoegen nieuwe taak
' note right: inclusief urgentie en impact
' #Gray:System: Zet status op "Waiting for review Bluenotion";
| Bluenotion admin |
#LightBlue:Controleren aanvraag;
note left: FR8.1 Controleren aanvraag 
#LightBlue:if (Aanvraag één duidelijke functionaliteit?) then (yes) 
else (no) 
  #LightBlue:if (Aanvraag bestaat uit meerdere functionaliteiten) then (yes)
  #LightBlue:Maak aanvraag aan per functionaliteit;
  note left 
  *extra FR?
  end note 
  else (no)
  endif
  #LightBlue:Wijzig omschrijving;
endif
  #LightBlue:Add time estimate;
  #lightBlue:Vraag om feedback;
  ' #Gray:System: Zet status op "Waiting for review customer";
| Externe beheerder |
  #Red:Controleren taak;
  note right: FR3.2 Toelichting geven op aanvraag
  #Red:if(Eens met de omschrijving en time estimate?) then (no)
  #Red:if(Wil aanvraag annuleren) then (yes)
  #Red:Aanvraag annuleren;
  end
  else(no)
  endif
  #Red:Wijzigen aanvraag;
  else(yes)
  #Red:Accepteer taak;
  

| Bluenotion admin |
#LightBlue:Accepteren taak;
#LightBlue:Opsplitten taak;
note left 
  FR8.2: Op splitten taak naar "team" taken.
  Deze taken komen op de backlog.
end note

stop 

| Externe beheerder |
  endif

  repeat while

' legend right
'     | Color | Status |
'     |<#Red>| ACT1: Externe beheerder |
'     |<#LightBlue>| ACT2: Interne beheerder |
'     |<#Gray>| PMP back-end |
' endlegend

```

*Note: De laatste check en het opsplitsen van taken naar taken voor de UX, UI, BE, FE zou voor "Vraag om feedback" kunnen gebeuren als hier wens naar is. De reden waarom dit op het moment apart gebeurt is zodat er nog een laatste controle wordt gedaan op een taak voordat deze geaccepteerd wordt en zodat mocht de scope van een aanvraag niet duidelijk zijn is het niet nodig hier subtaken van te maken.

### Bord structuur

Zodra voor een doorontwikkeling of incident een taak is aangemaakt komt deze op een bord terecht in productive. Aan de hand van deze borden houdt Bluenotion bij hoe veel werk nog open staat voor elk project en wie verantwoordelijk is voor de volgende stap voor de betreffende taken.

```puml
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
(wishlist) #Tomato
(aanvragen) #Tomato
' (awaiting customer) as awaiting_customer #red
actor "Externe beheerder" as EK

note "Input nodig van klant" as customernotifynote 
' #Purple
note "input nodig van Bluenotion" as bluenote 
' #Lightblue

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
' EK ..[norank]..> backlog : Oude situatie


legend left
    | Color | Status |
    | <#Tomato> | Not started |
    |<#Orange>| Open |
    |<#99FF00>| Done |
    |<#Green>| Closed |
'    |<#Purple> | Waiting for review customer |
'    |<#LightBlue>  | Waiting for review Bluenotion |
    | ✓ | Accepted |
endlegend

```

<!-- | Awaiting customer (new)  | Taken die incorrect of incompleet zijn ingevuld door de klant worden door de PM of TL op dit bord neergezet met een vraag voor extra feedback van de klant.  | ACT1: Externe beheerder | -->

#### Toelichting borden

| Bord | Doel | Verantwoordelijke partij |
|---|---|---|
| Aanvragen (nieuw) | Taken die door de klant zijn ingeschoten maar nog niet geaccepteerd door de PM en/of TL komen op de aanvragen lijst terecht.  | ACT2: Interne beheerder|
| Wishlist  | Taken die tijdens ontwikkeling naar boven zijn gekomen als "Nice to haves" en worden opgepakt als er tijd over is.  | ACT1: Externe beheerder |
| Backlog  | De backlog is waar geaccepteerde taken terecht komen. Vanaf de backlog pakken de aangewezen teams de taken op.  | ACT3: Interne medewerker |
| In progress  | Zodra een developer een taak op pakt wordt deze als In progress geregistreerd.  | ACT3: Interne medewerker |
| In review  | Nadat een developer aan een taak heeft gewerkt wordt deze klaar gezet voor review.  | ACT3: Interne medewerker |
| Development  | Functionaliteit is gebouwd maar staat nog niet op de test versie. | ACT2: Interne beheerder |
| Staging  | Functionaliteit is gebouwd en staat op de test versie  | ACT1: Externe beheerder |
| Live  | Alle afgeronde taken die draaien op de productie omgeving.  | N/A |

#### Toelichting statuses

De status die bij de bovenstaande borden staat aangegeven is de standaard status van taken op dat bord. Op het moment worden statuses voornamelijk gebruikt om te binnen Productive te filteren op welke taken Open en Closed zijn. Aan de hand hiervan kan een klant met directe toegang tot Productive zien waar aan gewerkt wordt of kan de PM de status van taken door communiceren.

| Status  | Uitleg  | [Workflow stage](https://help.productive.io/en/articles/5813154-creating-and-managing-workflows)  |
|---|---|---|
| Open  | Geeft aan dat Bluenotion actief aan het werk is aan een taak.  | Started  |
| Done  | Geeft aan dat Bluenotion aan een taak heeft gewerkt en deze klaar is voor review.  | Started  |
| Vakantie/vrij | Geeft aan dat de persoon die met deze taak aan de slag moet op het moment niet beschikbaar is. | Started |
| Closed  | Geeft aan dat de klant een afgeronde taak heeft gereviewd en goedgekeurd.  | Closed  |

<!-- ### Aanpassingen domein
TODO: verhaaltje over de aanpassingen in het domein?
Om de functionaliteiten van het PMP op zo'n manier te realiseren dat over alle verschillende projecten door de klant en PM gewerkt kan worden binnen het PMP en de interne medewerkers van Bluenotion verder kunnen werken binnen Productive is [FDR004](./FDRs/FDR004-Aanpassingen-Productive-workflow.md) opgezet. -->

## Actors en user stories

De actors zijn de rollen die mensen aannemen als ze gebruik maken van het systeem. Voor elke actor wordt toegelicht wat zijn/haar rol is, hoe de actor in de situatie voor het PMP werkt en wat de actor uit het PMP kan verwachten.

Het PMP heeft te maken met twee groepen gebruikers, interne (Bluenotion) gebruikers en externe (Klant) gebruikers. Wegens veiligheidsoverwegingen (TODO: schrijven FDR) is er de keuze gemaakt deze gebruikers verder op te delen in een medewerkers en een beheerders groep. Het idee hier achter is dat gebruikers op drie niveau's binnen het systeem rechten kunnen krijgen:

- **Corporatie**
    - Interne beheerder: Verantwoordelijk voor globaal project en klant beheer.
    - Interne medewerker: Gemachtigd alle projecten van alle klanten in te zien.
- **Bedrijf**
    - Interne beheerder: Verantwoordelijk voor intern beheer van projecten voor het aangewezen bedrijf.
    - Interne medewerker: Gemachtigd alle projecten van het aangewezen bedrijf in te zien.
    - Externe beheerder: Gemachtigd aanvragen te doen en taken te accepteren voor het aangewezen project.
    - Externe medewerker: Gemachtigd alle projecten van het aangewezen bedrijf in te zien.
- **Project**
    - Interne beheerder: Verantwoordelijk voor intern beheer van het aangewezen project.
    - Interne medewerker: Gemachtigd alle informatie over het aangewezen project in te zien.
    - Externe beheerder: Gemachtigd aanvragen te doen en taken te accepteren voor het aangewezen project.
    - Externe medewerker: Gemachtigd alle informatie over het aangewezen project in te zien.

Twee aspecten die opvallend zijn aan deze opzet zijn:

- Dat er geen externe beheerders of medewerkers toegevoegd kunnen worden op corporatie niveau. (TODO: FDR?)
- Dat interne en externe medewerkers de zelfde omschrijving (en toegang hebben tot [de zelfde FR's](#rechten-tabel)) maar hier toch aparte actors van zijn gemaakt. (TODO: FDR?)

Ter simplificatie wordt binnen dit project gesproken over 4 primaire actors in plaats van de bovengenoemde 10. Dit omdat de verschillen tussen verschillende rollen op verschillende niveau's niet zo zeer invloed hebben op welke acties een actor kan/mag uitvoeren maar op welke objecten binnen het systeem deze acties uitgevoerd mogen worden.

### ACT1: Externe beheerder

Omschrijving: Een externe beheerder die een project wilt laten uitvoeren door Bluenotion.

Huidig proces: Een klant heeft een contract afgesloten bij Bluenotion voor een project. Op basis van gesprekken met de PM worden voor het project taken aangemaakt in Productive die door het development team worden opgepakt tot uiteindelijke realisatie van het product. Als de klant over de loop van het project wijzigingen wilt doen in de planning van het project loopt dit via de PM of een guest account met een apart bord in Productive.*

*Sommige klanten hebben direct toegang tot een voor hun aangemaakte productive omgeving om inzicht te kunnen krijgen in het project en al zelf taken in te schieten.

Doelen nieuwe project management portal:

- Inzicht geven in het door Bluenotion te verrichten werk door statussen toe te kennen aan taken.
- Inzicht geven in de aanvragen/taken die door mij (de externe beheerder) aangescherpt dienen te worden voor ontwikkeling door Bluenotion kan beginnen.
- Toevoegen van nieuwe aanvragen/taken voor een project
- Prioriteren van bestaande taken
- Aanpassen onduidelijke/incomplete taken
- Communiceren van impact in de vorm van ureninschattingen
- Inzicht geven in servicecontract van projecten

Aanspreekpunt: Jesse Bekke

### ACT2: Interne beheerder

Omschrijving: De Bluenotion admin is een medewerker van Bluenotion die het recht heeft de planning van projecten aan te passen. Doorgaans zijn dit project managers (PM) en tech leads (TL) maar andere medewerkers zouden ook de rol van Bluenotion Admin op zich kunnen nemen.

Huidig proces: Aan het eind van elke sprint wordt door de PM/TL een demo gegeven aan de klant met de in die sprint geboekte vooruitgang en de planning voor de volgende sprint. Bevindingen in deze review worden door de PM/TL verwerkt in de backlog op Productive. Indien een klant directe toegang heeft tot de Productive omgeving heeft de PM/TL de taak van het controleren en goedkeuren van de door de klant ingeschoten taken. Mochten er onduidelijkheden zijn in een taak of velden verkeerd ingevuld zijn (vaker voorkomend bij priority) is het aan de PM verdere verduidelijking te vragen aan de klant.

Doelen nieuwe project management portal:

- Taken goed of afkeuren voor de backlog op Productive.
- Taken handmatig aanpassen.
- Doorgeven aan de klant dat een taak incompleet of onduidelijk is.

Aanspreekpunt: Jesse Bekke

### ACT3: Interne medewerker

Omschrijving: Dit is een medewerker van Bluenotion die meewerkt aan het development proces.

Huidig proces: Krijgt taken toegewezen, werkt aan taken en registreert de staat hiervan in Productive.

Doelen nieuwe project management portal: Zonder aanpassingen in de workflow zijn werk nog kunnen doen.

### ACT4: Notificatie manager

Omschrijving: De service die invitation links stuurt en informeert wanneer actie nodig is?

Huidig proces:

Doelen nieuwe project:

### ACT5: Externe medewerker

Op basis van gesprek 11-06-2024:
Er werd gesproken over een admin en medewerkers account voor de externe beheerder. Voor zo ver ik heb begrepen is dit voornamelijk zodat niet voor iedereen die in het PMP komt tickets mag inschieten. Heeft het medewerkers account voor de externe beheerder leesrechten op alle functionaliteiten die ACT1 heeft of enkel een subset?

### User stories

TODO: nalopen actor user story koppeling

```puml
left to right direction
skinparam packageStyle rect

:ACT1 Externe beheerder: as ACT1
:ACT2 Interne beheerder: as ACT2
:ACT3 Interne medewerker: as ACT3
:ACT5 Externe medewerker: as ACT5
ACT2-LEFT-|>ACT3
ACT2-LEFT-|>ACT1
ACT1-LEFT-|>ACT5
ACT3-LEFT-|>ACT5

usecase US1
usecase US2
usecase US3
usecase US4
usecase US5
usecase US6
usecase US7
usecase US8
usecase US9
usecase US10
usecase US12
usecase US13
usecase US14
usecase US15
usecase US16
usecase US17
usecase US18
usecase US19
usecase US20
usecase US21
usecase US22

ACT2--US1
ACT1--US2
ACT1--US3
ACT2--US4
ACT3--US5
ACT1--US6
ACT1--US7
ACT2--US7

ACT1--US8
ACT1--US9
ACT2--US10
ACT2--US12
ACT1--US13
ACT3--US14
ACT3--US15
ACT3--US16
ACT1--US17
ACT2--US18
ACT2--US19
ACT1--US20
ACT2--US20

ACT2--US21
ACT1--US22
ACT3--US24

```

Eisen en wensen gesteld aan het systeem worden eerst geregistreerd als een user story.

| User story no | Gerelateerde actors  | Omschrijving  | Resulterende requirement(s)  |
|---|---|---|---|
| US1   | ACT2  | Als Bluenotion admin wil ik een eenduidig overzicht van alle projecten die lopen binnen Bluenotion zodat ik snel de status met een klant kan bespreken.  | [FR1.1](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr11-inzien-projecten) |
| US2  | ACT1 | Als externe beheerder wil ik een eenduidig overzicht van alle voor mij relevante projecten zodat ik snel kan zien welke projecten actief aan gewerkt worden.  | [FR1.2](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr12-inzien-totaal-geplande-urenkosten) |
| US3  | ACT1 | Als externe beheerder wil ik een overzicht van het geplande werk zodat ik zicht kan houden op de ontwikkeltijd en kosten. | [FR1.2](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr12-inzien-totaal-geplande-urenkosten), [FR2.1](./Requirements/FR2_Inzien_taken.md#fr21-inzien-taken-van-project), [FR2.2](./Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed), [FR2.3](./Requirements/FR2_Inzien_taken.md#fr23-inzien-taak-details), [FR2.4](./Requirements/FR2_Inzien_taken.md#fr24-tonen-taken-in-gantt-chart) |
| US4  | ACT2  | Als Bluenotion admin wil ik de zelfde informatie kunnen zien als een externe beheerder zodat ik bij vragen de klant kan ondersteunen.  |  X |
| US5  | ACT3  | Als Bluenotion medewerker wil ik niet mijn werkwijze aanpassen om een nieuw systeem voor de klant te ondersteunen.  | [NFR2.1](#nonfunctional-requirements)  |
| US6  | ACT1  | Als externe beheerder wil ik bij mijn projecten de optie om nieuwe taken toe te voegen zodat ik issues en door ontwikkelingen kan doorgeven.  | [FR3.1](./Requirements/FR3_Toevoegen_aanvraag.md#fr3-toevoegen-aanvraag) |
| US7  | ACT1, ACT2  | Als Bluenotion admin wil ik bij taken die onduidelijk of incorrect ingevuld zijn de klant de optie geven deze onduidelijkheid te verhelderen.  | [FR3.2](./Requirements/FR3_Toevoegen_aanvraag.md#fr32-toelichting-geven-op-aanvraag), [FR8.1](./Requirements/FR8_Controleren_aanvraag.md#fr81-controleren-aanvraag), [FR8.2](./Requirements/FR8_Controleren_aanvraag.md#fr82-op-splitten-taak-naar-team-taken) |
| US8  | ACT1  | Als externe beheerder wil ik bij taken die extra toelichting nodig hebben feedback kunnen geven op deze taken zodat ze goedgekeurd kunnen worden voor de backlog.  | [FR3.2](./Requirements/FR3_Toevoegen_aanvraag.md#fr32-toelichting-geven-op-aanvraag) |
| US9  | ACT1  | Als externe beheerder wil ik een eenduidig overzicht van taken die wachten op mijn input voordat er aan gewerkt wordt zodat deze taken niet onnodig lang blijven liggen.  | [FR2.2](./Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed), [FR4.1](./Requirements/FR4_Versturen_notificaties.md#fr41-inlichten-klant-wanneer-een-taak-wacht-op-input-van-de-klant) |
| US10  | ACT2  | Als Bluenotion admin wil ik bij taken die toegevoegd zijn door een externe beheerder taken goedkeuren voor ze op de backlog terecht komen.  | [FR8.1](./Requirements/FR8_Controleren_aanvraag.md#fr81-controleren-aanvraag), [FR8.2](./Requirements/FR8_Controleren_aanvraag.md#fr82-op-splitten-taak-naar-team-taken)  |
| US11  |   | Als ?software developer? wil ik geen data over het netwerk sturen waar de klant geen toegang toe heeft.  |   |
| US12 | ACT2 | Als Bluenotion admin wil ik dat de klant afbeeldingen kan invoegen om problemen/aanvragen toe te lichten. | [FR3.4](./Requirements/FR3_Toevoegen_aanvraag.md#fr34-toevoegen-bijlagen-bij-taak) |
| US13 | ACT1 | Als externe beheerder wil ik alle informatie over mijn te bouwen/gebouwde systeem op één centrale plek bekijken. | [FR6.1](./Requirements/FR6_Inzien_project_service_statuses.md#fr61-inzien-lijst-van-project-dependencies), [FR6.2](./Requirements/FR6_Inzien_project_service_statuses.md#fr62-inzien-huidige-status-onlineoffline-project-dependencies), [FR7.1](./Requirements/FR7_Inzien_project_documentatie.md#fr71-openendownloaden-document), [FR7.2](./Requirements/FR7_Inzien_project_documentatie.md#fr72-filteren-documentnaamcategorie) |
| US14 | ACT3 | Als software developer wil ik niet dat mensen toegang krijgen tot data die mogelijk privacy gevoelig is en/of niet bedoeld is voor de betreffende persoon. | [NFR4.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.2](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.3](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.4](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US15 | ACT3 | Als software developer wil ik dat als er iets niet naar behoren werkt er logs beschikbaar zijn om het probleem te herleiden. | [NFR4.5](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR4.6](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US16 | ACT3 | Als medewerker van Bluenotion wil ik dat alle klanten van Bluenotion om kunnen gaan met het PMP. | [NFR1.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR6.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR5.3](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR7.1](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US17 | ACT1 | Als externe beheerder wil ik niet beïnvloed worden door andere mensen die tegelijkertijd het PMP gebruiken. | [NFR2.2](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR5.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR5.2](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US18 | ACT2 | Als Bluenotion admin wil ik dat het systeem bij verlies van database binnen 3 uur hersteld kan worden naar een werkende state. | [NFR8.1](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR8.2](FunctioneelOntwerp.md#nonfunctional-requirements), [NFR8.3](FunctioneelOntwerp.md#nonfunctional-requirements) |
| US19 | ACT2 | Als Bluenotion admin wil ik alle project management en project gerelateerde klantcontact via het zelfde kanaal afhandelen | [FR5.1](./Requirements/FR5_Opstellen_project.md#fr51-afhandelen-project-setup) |
| US20 | ACT1, ACT2 | Als Bluenotion admin wil ik servicevragen gescheiden houden van taken zodat developers hier minder tijd aan kwijt zijn. | [FR9](./Requirements/FR9_Tenant_level_chat.md) |
| US21 | ACT2 | Als Bluenotion admin wil ik per project aan kunnen passen welke productive [borden voor het PMP betekenis hebben](FunctioneelOntwerp.md#bord-structuur) zodat het PMP kan werken met projecten die op verschillende manieren zijn opgezet. | [FR5.2](./Requirements/FR5_Opstellen_project.md) |
| US22 | ACT1 | Als externe beheerder wil ik mijn aanvragen kunnen annuleren zodat geen tijd wordt besteed aan taken die ik niet belangrijk vindt. |  |
| US23 | ACT1 | Als externe beheerder wil ik screenshots kunnen toevoegen aan mijn tickets en opmerkingen om mijn punten te verduidelijken. | [FR3.4](./Requirements/FR3_Toevoegen_aanvraag.md#fr34-toevoegen-bijlagen-bij-taak) |
| US24 | ACT3 | Als interne medewerker wil ik mijn workflow niet moeten wijzigen om een nieuw klantportaal te faciliteren | NFR8.4 |

## Requirements

Binnen dit hoofdstuk worden de functionele en non-functionele eisen gesteld aan het systeem toegelicht. Binnen dit hoofdstuk staat de requirements traceability matrix waarin requirements van user story tot implementatie door de documentatie gevolgd kan worden.

### Use case diagram

```puml
title Usecase diagram PMP
left to right direction
skinparam packageStyle rect
:ACT1 Externe beheerder: as ACT1
:ACT2 Interne beheerder: as ACT2
:ACT3 Interne medewerker: as ACT3
:ACT4 notification manager: as ACT4
:ACT5 Externe medewerker: as ACT5
ACT2-LEFT-|>ACT3
ACT2-LEFT-|>ACT1
ACT1-LEFT-|>ACT5
ACT3-LEFT-|>ACT5
 
usecase "FR1.1: Inzien projecten \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR1_1 #FF9999 
usecase "FR1: Inzien project plannings informatie" as FR1 
usecase "FR1.2: Inzien totaal geplande uren+kosten \n <color:#FF0000> <size:20>●</size></color>" as FR1_2 #999999 
usecase "FR2.1: Inzien taken van project \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR2_1 #FF9999 
usecase "FR2.2: Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR2_2 #FF9999 
usecase "FR2.3: Inzien taak details \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR2_3 #FF9999 
usecase "FR2: Inzien taken" as FR2 
usecase "FR2.4: Tonen taken in Gantt chart \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR2_4 #BB9999 
usecase "FR3.1: Toevoegen nieuwe taak \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_1 #FF9999 
usecase "FR3.2: Toelichting geven op aanvraag (extern) \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_2 #FF9999 
usecase "FR3.3: Toevoegen taken past zich aan aan de klant zijn SLA \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_3 #BB9999 
usecase "FR3.4: Toevoegen bijlagen bij taak \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_4 #FF9999 
usecase "FR3.5: Aanpassen taak prioriteit \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_5 #BB9999 
usecase "FR3: Toevoegen aanvraag" as FR3 
usecase "FR3.6: Annuleren aanvraag \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_6 #DD9999 
usecase "FR4.1: Inlichten klant wanneer een taak wacht op input van de klant \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR4_1 #DD9999 
usecase "FR4: Versturen notificaties" as FR4 
usecase "FR4.2: Inlichten Bluenotion bij blockers/criticals \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR4_2 #BB9999 
usecase "FR5.1: Afhandelen project setup binnen PMP \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR5_1 #BB9999 
usecase "FR5.2: Instellen productive boards & taak status \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR5_2 #BB9999 
usecase "FR5.3: Beheren project documentatie \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR5_3 #BB9999 
usecase "FR5: Beheren project" as FR5 
usecase "FR5.3: Beheren project services \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR5_3 #BB9999 
usecase "FR6.1: Inzien lijst van project dependencies \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR6_1 #BB9999 
usecase "FR6: Inzien project service statuses" as FR6 
usecase "FR6.2: Inzien huidige status (online/offline) project dependencies \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR6_2 #BB9999 
usecase "FR7.1: Openen/downloaden document \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR7_1 #BB9999 
usecase "FR7: Inzien project documentatie" as FR7 
usecase "FR7.2: Filteren documentnaam/categorie \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR7_2 #BB9999 
usecase "FR8.1: Controleren aanvraag (intern) \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR8_1 #FF9999 
usecase "FR8: Controleren aanvraag" as FR8 
usecase "FR8.2: Op splitten taak naar team taken \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR8_2 #BB9999 
usecase "FR9.1: Starten nieuwe chat \n <color:#FF0000> <size:20>●</size></color>" as FR9_1 #999999 
usecase "FR9.2: Bericht sturen niet afgesloten chat \n <color:#FF0000> <size:20>●</size></color>" as FR9_2 #999999 
usecase "FR9.3: Hervatten afgesloten chat \n <color:#FF0000> <size:20>●</size></color>" as FR9_3 #999999 
usecase "FR9: Chat met tenants" as FR9 
usecase "FR9.4: Sluiten chat \n <color:#FF0000> <size:20>●</size></color>" as FR9_4 #999999 
usecase "FR10.1: Uitnodigen gebruiker \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR10_1 #FF9999 
usecase "FR10.2: Wijzigen rechten \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR10_2 #FF9999 
usecase "FR10: Beheren gebruikers" as FR10 
usecase "FR10.3: Verwijderen gebruiker \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR10_3 #FF9999
 
      ACT5 -DOWN-> FR1
      FR1 -DOWN->  FR1_1
      
      FR1 -DOWN->  FR1_2
       
      ACT5 -DOWN-> FR2
      FR2 -DOWN->  FR2_1
      
      FR2 -DOWN->  FR2_2
      
      FR2 -DOWN->  FR2_3
      
      FR2 -DOWN->  FR2_4
       
      ACT1 -DOWN-> FR3
      FR3 -DOWN->  FR3_1
      
      FR3 -DOWN->  FR3_2
      
      FR3 -DOWN->  FR3_3
      
      FR3 -DOWN->  FR3_4
      
      FR3 -DOWN->  FR3_5
      
      FR3 -DOWN->  FR3_6
       
      ACT4 -DOWN-> FR4
      FR4 -DOWN->  FR4_1
      
      FR4 -DOWN->  FR4_2
       
      ACT2 -DOWN-> FR5
      FR5 -DOWN->  FR5_1
      
      FR5 -DOWN->  FR5_2
      
      FR5 -DOWN->  FR5_3
      
      FR5 -DOWN->  FR5_3
       
      ACT5 -DOWN-> FR6
      FR6 -DOWN->  FR6_1
      
      FR6 -DOWN->  FR6_2
       
      ACT5 -DOWN-> FR7
      FR7 -DOWN->  FR7_1
      
      FR7 -DOWN->  FR7_2
       
      ACT2 -DOWN-> FR8
      FR8 -DOWN->  FR8_1
      
      FR8 -DOWN->  FR8_2
       
      ACT5 -DOWN-> FR9
      FR9 -DOWN->  FR9_1
      
      FR9 -DOWN->  FR9_2
      
      FR9 -DOWN->  FR9_3
      
      FR9 -DOWN->  FR9_4
       
      ACT2 -DOWN-> FR10
      FR10 -DOWN->  FR10_1
      
      FR10 -DOWN->  FR10_2
      
      FR10 -DOWN->  FR10_3
      
legend left
   | **Done** | **Planned** | **Milestone** |
   | <color:#999999><size:20>●</size></color> | <color:#999999><size:20>○</size></color>| Define |
   | <color:#AA55AA><size:20>●</size></color> | <color:#AA55AA><size:20>○</size></color>| UX |
   | <color:#349034><size:20>●</size></color> | <color:#349034><size:20>○</size></color>| FE |
   | <color:#02CB02><size:20>●</size></color> | <color:#02CB02><size:20>○</size></color>| BE |
   | <color:#00FF00><size:20>●</size></color> | <color:#00FF00><size:20>○</size></color>| Testing |
   | <color:#FF0000><size:20>●</size></color> | <color:#FF0000><size:20>○</size></color>| Rejected |

  | **Task color** | **Priority** |
  | <#FF9999> | Must have |
  | <#DD9999> | Should have |
  | <#BB9999> | Could have |
  | <#999999> | Won't have |
  end legend
```

### Requirements traceability matrix

| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Document references | Status |
|---|---|---|---|---|---|
| FR1 | Inzien project plannings informatie |  |  | [Requirement overzicht](./Requirements/FR1_Inzien_project_plannings_informatie.md) |  |
| FR1.1 |  | Inzien projecten | Must have | [US1](FunctioneelOntwerp.md#user-stories), [US2](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR1_Inzien_project_plannings_informatie.md#FR1.1) | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR1.2 |  | Inzien totaal geplande uren+kosten | Won't have FDR001 | [US3](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR1_Inzien_project_plannings_informatie.md#fr12-inzien-totaal-geplande-urenkosten), [FDR001](./FDRs/FDR001-Tijd-en-kosten-niet-tonen.md) | [x] Rejected |
| FR2 | Inzien taken |  |  | [Requirement overzicht](./Requirements/FR2_Inzien_taken.md) |  |
| FR2.1 |  | Inzien taken van project | Must have | [US3](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR2_Inzien_taken.md#fr21-inzien-taken-van-project) | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR2.2 |  | Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed | Must have | [US3](FunctioneelOntwerp.md#user-stories), [US8](FunctioneelOntwerp.md#user-stories), [US9](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR2.3 |  | Inzien taak details | Must have | [US3](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR2_Inzien_taken.md#fr23-inzien-taak-details)  | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR2.4 |  | Tonen taken in Gantt chart | Could have | [US3](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR2_Inzien_taken.md#fr24-main-flow) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3 | Toevoegen aanvraag |  |  | [Requirement overzicht](./Requirements/FR3_Toevoegen_aanvraag.md) |  |
| FR3.1 |  | Toevoegen nieuwe taak | Must have | [US6](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr31-toevoegen-nieuwe-aanvraag-in-een-project) | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3.2 |  | Toelichting geven op aanvraag (extern) | Must have | [US7](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr32-toelichting-geven-op-aanvraag) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3.3 |  | Toevoegen taken past zich aan aan de klant zijn SLA | Could have | [Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla) | [ ] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3.4 |  | Toevoegen bijlagen bij taak | Must have | [US12](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr34-toevoegen-bijlagen-bij-taak) | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3.5 |  | Aanpassen taak prioriteit | Could have | [Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr35-aanpassen-taak-prioriteit) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3.6 |  | Annuleren aanvraag | Should have | [Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr36-annuleren-aanvraag) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR4 | Versturen notificaties |  |  | [Requirement overzicht](./Requirements/FR4_Versturen_notificaties.md) |  |
| FR4.1 |  | Inlichten klant wanneer een taak wacht op input van de klant | Should have | [US9](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR4_Versturen_notificaties.md#fr41-inlichten-klant-wanneer-een-taak-wacht-op-input-van-de-klant) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR4.2 |  | Inlichten Bluenotion bij blockers/criticals | Could have | [Fully dressed usecase description](./Requirements/FR4_Versturen_notificaties.md#fr42-inlichten-bluenotion-bij-blockerscriticals) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR5 | Beheren project |  |  |  |  |
| FR5.1 |  | Afhandelen project setup binnen PMP | Could have | [US19](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR5_Opstellen_project.md#fr51-afhandelen-project-setup)  | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR5.2 |  | Instellen productive boards & taak status | Could have | [US20](#user-stories) [FR5.2](./Requirements/FR5_Opstellen_project.md#fr52-instellen-productive-boards-en-taak-status) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR5.3 |  | Beheren project documentatie | Could have |  [Fully dressed usecase description](./Requirements/FR7_Inzien_project_documentatie.md#fr73-beheren-project-documentatie) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR5.3 |  | Beheren project services | Could have | [Fully dressed usecase description](./Requirements/FR5_Opstellen_project.md#fr53-beheren-project-services) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR6 | Inzien project service statuses |  |  | [Requirement overzicht](./Requirements/FR6_Inzien_project_service_statuses.md)  |  |
| FR6.1 |  | Inzien lijst van project dependencies | Could have | [US13](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR6_Inzien_project_service_statuses.md#fr61-inzien-lijst-van-project-dependencies) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR6.2 |  | Inzien huidige status (online/offline) project dependencies | Could have | [US13](FunctioneelOntwerp.md#user-stories),[Fully dressed usecase description](./Requirements/FR6_Inzien_project_service_statuses.md#fr62-inzien-huidige-status-onlineoffline-project-dependencies) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR7 | Inzien project documentatie |  |  | [Requirement overzicht](./Requirements/FR7_Inzien_project_documentatie.md) |  |
| FR7.1 |  | Openen/downloaden document | Could have | [US13](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR7_Inzien_project_documentatie.md#fr71-openendownloaden-document) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR7.2 |  | Filteren documentnaam/categorie | Could have | [US13](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR7_Inzien_project_documentatie.md#fr72-filteren-documentnaamcategorie) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR8 | Controleren aanvraag |  |  | [Requirement overzicht](./Requirements/FR8_Controleren_aanvraag.md) |  |
| FR8.1 |  | Controleren aanvraag (intern) | Must have | [US7](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR8_Controleren_aanvraag.md#fr81-controleren-aanvraag), [US10](FunctioneelOntwerp.md#user-stories) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR8.2 |  | Op splitten taak naar team taken | Could have | [US7](FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR8_Controleren_aanvraag.md#fr82-op-splitten-taak-naar-team-taken), [US10](FunctioneelOntwerp.md#user-stories) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR9 | Chat met tenants |  | Won't have | [Requirement overzicht](./Requirements/FR9_Tenant_level_chat.md), [FDR002](./FDRs/FDR002-Tenant-level-chat.md) |  |
| FR9.1 |  | Starten nieuwe chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR9_Tenant_level_chat.md#fr91-starten-nieuwe-chat), [FDR002](./FDRs/FDR002-Tenant-level-chat.md) | [x] Rejected |
| FR9.2 |  | Bericht sturen niet afgesloten chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR9_Tenant_level_chat.md#fr92-bericht-sturen-niet-afgesloten-chat), [FDR002](./FDRs/FDR002-Tenant-level-chat.md) | [x] Rejected |
| FR9.3 |  | Hervatten afgesloten chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR9_Tenant_level_chat.md#fr93-hervatten-afgesloten-chat), [FDR002](./FDRs/FDR002-Tenant-level-chat.md) | [x] Rejected |
| FR9.4 |  | Sluiten chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](./Requirements/FR9_Tenant_level_chat.md#fr94-sluiten-chat), [FDR002](./FDRs/FDR002-Tenant-level-chat.md) | [x] Rejected |
| FR10 | Beheren gebruikers |  |  | [Requirement overzicht](./Requirements/FR8_Controleren_aanvraag.md) |  |
| FR10.1 |  | Uitnodigen gebruiker | Must have |  | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR10.2 |  | Wijzigen rechten | Must have |  | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR10.3 |  | Verwijderen gebruiker | Must have |  | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |

### Nonfunctional requirements

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
|   | NFR8.2  | Bij verlies van de database raken geen gegevens over projecten of taken verloren. | Must have |   [US18](#user-stories)  |
|   | NFR8.3  | Bij verlies van de database raken geen gegevens ouder dan 24 uur verloren.  | Must have  |    [US18](#user-stories)  |
|   | NFR8.4  | Medewerkers van Bluenotion kunnen met minimale aanpassingen in de workflow zijn werk nog kunnen doen. | Should have | [US23](#user-stories) |

**Unsorted**

| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Dependencies | Document references |
|---|---|---|---|---|---|
| FR1.3  |   | Toekennen overige project uren  | Could have  | FR1.2  |   |
| FR1.4  |   | Toekennen SLA KPI's | Could have  | FR1.1  |   |

### Authenticatie, Autorisatie, Accounting

#### Rechten tabel

TODO: Rename rechten tabel naar iets duidelijkers? actor requirement matrix oid?

|  | Beheerder extern | Medewerker extern | Beheerder intern | Medewerker intern |
|--|--|--|--|--|
| Project | FR2: Inzien taken</br>FR3: Toevoegen aanvraag</br>FR6: Inzien project service statuses</br>FR7: Inzien project documentatie</br>FR10: Beheren gebruikers | FR2: Inzien taken</br>FR6: Inzien project service statuses</br>FR7: Inzien project documentatie | FR2: Inzien taken</br>FR3: Toevoegen aanvraag</br>FR6: Inzien project service statuses</br>FR7: Inzien project documentatie</br>FR8: Controleren aanvraag</br>FR10: Beheren gebruikers | FR2: Inzien taken</br>FR6: Inzien project service statuses</br>FR7: Inzien project documentatie|
| Bedrijf | FR1: Inzien project plannings informatie</br>FR2: Inzien taken</br>FR3: Toevoegen aanvraag</br>FR6: Inzien project service statuses</br>FR7: Inzien project documentatie</br>FR10: Beheren gebruikers | FR1: Inzien project plannings informatie</br>FR2: Inzien taken</br>FR6: Inzien project service statuses</br>FR7: Inzien project documentatie | FR1: Inzien project plannings informatie</br>FR2: Inzien taken</br>FR3: Toevoegen aanvraag</br>FR5: Beheren project</br>FR6: Inzien project service statuses</br>FR7: Inzien project documentatie</br>FR8: Controleren aanvraag</br>FR10:Beheren gebruikers | FR1: Inzien project plannings informatie</br>FR2: Inzien taken</br>FR6: Inzien project service statuses</br>FR7: Inzien project documentatie|
| Corporatie | N/A | N/A | FR1: Inzien project plannings informatie</br>FR2: Inzien taken</br>FR3: Toevoegen aanvraag</br>FR5: Beheren project</br>FR6: Inzien project service statuses</br>FR7: Inzien project documentatie</br>FR8: Controleren aanvraag</br>FR10: Beheren gebruikers | FR1: Inzien project plannings informatie</br>FR2: Inzien taken</br>FR6: Inzien project service statuses</br>FR7: Inzien project documentatie|

#### Authenticatie

Authenticatie wordt gedaan aan de hand van PMP interne accounts zoals beschreven in [ADR010-O1](../Technisch/ADRs/ADR010-Authentication.md#o1-intern). Hiermee worden voor klanten van Bluenotion die toegang dienen te krijgen tot het PMP accounts aangemaakt en uitnodigings links verstuurd naar de betreffende gebruiker. De gebruiker is zelf verantwoordelijk voor het aanmaken en periodiek wijzigen van het te gebruiken wachtwoord.

#### Autorisatie

Voor autorisatie wordt gebruik gemaakt van claims die binnen het PMP gekoppeld zijn aan de gebruikers accounts, de voorgestelde claims zijn gebaseerd op de [actors van het systeem](#actors-en-user-stories) en zien er als volgt uit:

| Naam | Omschrijving | Oorsprong |
|---|---|---|
| Company admin (comp_id) |  Heeft volledige read en write toegang tot alle data gerelateerd aan zijn/haar bedrijf |  [ACT1 Externe beheerder](#act1-externe-beheerder) |
| Organization admin (org_id) | Heeft volledige read en write toegang tot alle data gerelateerd aan zijn/haar organisatie.  | [ACT2 Bluenotion admin](#act2-interne-beheerder)  |
| Organization employee (org_id) | Heeft leestoegang tot alle data gerelateerd aan zijn/haar organisatie, de mogelijkheid hier comments aan toe te voegen, taaklijsten en statussen aan te passen.  |  [ACT3 Bluenotion medewerker](#act3-interne-medewerker) |
| System | Heeft leestoegang en de optie mailtjes te sturen. | [ACT4 Notificatie manager](#act4-notificatie-manager) |
| Company employee (comp_id) | Heeft lees rechten op alle data gerelateerd aan zijn/haar bedrijf  |  [ACT5 Externe beheerder read](#act5-externe-medewerker) |

Ter verduidelijking over welke groep bij welke data mag is een deel van de relevante informatie uit het productive data model gehaald:

```puml

rectangle Organization as org
rectangle Company as comp
rectangle User as usr
rectangle Project as prj
rectangle Board as brd
rectangle Task as tsk
rectangle "Task list" as tsk_lst
org -- comp :< customer of
comp -- prj :< project for
prj--brd :< board for
brd--tsk_lst :< list on
tsk_lst--tsk :< task on

comp -- usr :< works at
org -- usr :< works at

```

In dit overzicht is te zien dat gebruikers op beiden company niveau en organisatie niveau kunnen zitten. Twee dingen die in dit diagram minder duidelijk zijn aangegeven zijn de "works at" relatie (die zoals in de verschillende rollen aangegeven kunnen bestaan uit een admin functie of een generieke medewerkers functie) en waar comments bestaan in Productive.

Comments kunnen binnen productive op de volgende plekken toegevoegd worden:

- Budgets - deal relationship
- Companies - company relationship
- Deals - deal relationship
- Discussions - discussion relationship
- Invoices - invoice relationship
- People - person relationship
- Purchase Orders - purchase_order relationship
- Tasks - task relationship

Bron: https://developer.productive.io/comments.html#comments

Uiteraard worden de comments meegenomen onder de rechten regels zoals [hierboven](#autorisatie) beschreven.

TODO: Keep in mind dat de Bluenotion api key enkel resultaten van org Bluenotion kent

#### Accounting

Om problemen binnen het systeem te kunnen herleiden naar hun oorsprong dient voor alle wijzigingen die vanuit het PMP naar Productive de gebruiker en wijziging gelogd te worden.

TODO: is dit alles?

## Bronnen

TODO: Sources netjes documenteren maar sources:

NFR categories: https://www.altexsoft.com/blog/non-functional-requirements/
https://www.altexsoft.com/blog/software-requirements-specification/
Tracability matrix: https://www.researchgate.net/figure/Requirements-traceability-matrix-for-online-shopping-system_tbl4_280083523