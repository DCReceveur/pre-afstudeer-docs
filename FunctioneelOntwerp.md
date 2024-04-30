# Actors & userstories

- Externe klant

  - Als klant wil ik inzicht krijgen in de status van taken gerelateerd
    aan mijn project om wel geïnformeerde beslissingen te kunnen maken.

  - Als klant wil ik feedback kunnen geven op het gedane werk om het
    product te krijgen dat ik wil.

  - Als klant wil ik een consistente plek waar ik alle voor mij
    relevante gegevens terug kan vinden (iets met huis steil/wisselen
    van projectmanagement software)

<span class="mark">Aanspreekpunt: Jesse Bekke</span>

- Product owner

  - Als product owner wil ik dat taken waar mogelijk herleidbaar zijn
    naar de oorspronkelijke wens/feedback om de facturatie te
    verantwoorden.

  - Als product owner wil ik dat taken en feedback met juiste
    prioritering (op basis van SLA) in productive terecht komen.

  - Als product owner wil ik af kunnen tekenen op door de klant
    voorgestelde taken met een time en cost estimate.

<span class="mark">Aanspreekpunt: Jesse Bekke</span>

- Software developer Bluenotion is geen stakeholder in dit project.

Aanspreekpunt: NVT

# Eisen

<span class="mark">TODO: FRUPS+</span>

## Functioneel

- Inzien project status

  - Beschikbare projecten voor meerdere projecten bij 1 klant?

  - Uren/kosten verbruikt en totaal?

  - Quicklist van huidige taken?

  - Timeline?

  - PM contact info/eind sprint/volgend contact moment?

- Inzien taken

  - Uit te voeren taken?

  - “In progress” taken?

  - Voltooide taken?

  - 

  - per taak: status, time/cost, due date?, task changelog + ability to
    add comment?

- Toevoegen taak

  - Toevoegen problem omschrijving & screenshots

  - Task priority aan de hand van een vragenlijstje en SLA

  - Na terugkoppeling van PM met time/cost estimates een
    bevestiging/annulering optie?

## Nonfunctioneel

- Het systeem zou moeten werken binnen het huidige productive abonnent

  - 2 custom fields

  - 10 public project reports

  - 5 private project reports

- (Scalability) productive.io api ratelimit 100 requests per 10 sec.
  <span class="mark">smart maken scalability eis</span>

- Productive.io dient als Single Source Of Truth

- <span class="mark">Werkt op alle Windows en MacOS versies van de
  afgelopen 2 jaar?</span>

- <span class="mark">Het systeem dient beschikbaar te zijn in Nederlands
  en Engels, met optie tot uitbreiding.</span>

- Voor de back-end wordt gebruik gemaakt van .NET
  <span class="mark">framework</span> om bedrijf standaarden te
  hanteren.

- Voor het front-end wordt gebruik gemaakt van React Native om bedrijf
  standaarden te hanteren.
