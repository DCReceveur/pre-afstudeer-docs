# Functioneel ontwerp Project Management Portal

## Domain model

```plantuml

abstract abstract
entity Project
entity Task {
  priority
  type
  status
}

entity User
entity ProductiveProject
entity ProductiveBoard

entity Klant
entity Tech_lead
entity Project_manager

ProductiveProject -- ProductiveBoard : > manages
Task::status--ProductiveBoard
Klant --|> User
Tech_lead --|> User
Project_manager --|> User

'TL en PM zijn niet de 'owner' van het project
User -- Project : > Owner of
Project -- Task : < Work for

```

## Actors

### ACT1: Externe klant

Omschrijving: Een externe klant die een project wilt laten uitvoeren door Bluenotion.

Huidig proces: Een klant heeft een contract afgesloten bij Bluenotion voor een project. Op basis van gesprekken met de PM worden voor het project taken aangemaakt in Productive die door het development team worden opgepakt tot uiteindelijke realisatie van het product. Als de klant over de loop van het project wijzigingen wilt doen in de planning van het project loopt dit via de PM of een guest account met een apart bord in Productive.*

*Sommige klanten hebben direct toegang tot een voor hun aangemaakte productive omgeving om inzicht te kunnen krijgen in het project en al zelf taken in te schieten.

Doelen nieuwe project management portal:

- Inzicht krijgen in het door Bluenotion te verrichten werk.
- Inzicht krijgen in het door de externe klant te verrichten werk.
- toevoegen van nieuwe taken.
- Prioriteren van bestaande taken?

<!-- Een externe klant heeft een contract getekend voor een project bij Bluenotion. De klant kan tickets inschieten via het systeem met bugs of extra gewenste functionaliteiten. Na goedkeuring van deze tickets kan het ontwikkel team de tickets op pakken en de klant de voorgang hiervan real time inzien. -->

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

### Functioneel

- FR1: Inzien projecten
  - Als PM wil ik een eenduidig overzicht van alle projecten die lopen binnen Bluenotion zodat ik snel de status met een klant kan bespreken. (ACT1)
  - Als externe klant wil ik een eenduidig overzicht van alle voor mij relevante projecten zodat ik snel kan zien welke projecten actief aan gewerkt worden. (ACT2)

- FR2: Inzien uit te voeren taken in een project
  - Als externe klant wil ik een overzicht van het geplande werk zodat ik zicht kan houden op de ontwikkeltijd en kosten. (ACT2)
  - Als PM wil ik de zelfde informatie kunnen zien als een externe klant zodat ik bij vragen de klant kan ondersteunen. (ACT1)
  - Als software developer wil ik niet mijn werkwijze aanpassen om een externe klant inzicht te geven in mijn werk. (ACT3)

- FR3: Toevoegen nieuwe taak in een project
  - Als externe klant wil ik bij mijn projecten de optie om nieuwe taken toe te voegen zodat ik issues en door ontwikkelingen kan doorgeven.

- FR4: Feedback geven op taken
  - Als PM wil ik bij taken die onduidelijk of incorrect ingevuld zijn de klant de optie geven deze onduidelijkheid te verhelderen. (ACT2)
  - Als TL wil ik bij taken die onduidelijk of incorrect ingevuld zijn de klant de optie geven deze onduidelijkheid te verhelderen. (ACT4)
  - Als externe klant wil ik bij taken die extra toelichting nodig hebben feedback kunnen geven op deze taken zodat ze goedgekeurd kunnen worden voor de backlog. (ACT1)

- FR5: Goedkeuren extern toegevoegde taken
  - Als PM wil ik bij taken die toegevoegd zijn door een externe klant taken goedkeuren voor ze op de backlog terecht komen.

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

- Toevoegen/aanpassen SLA? (PM)

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
