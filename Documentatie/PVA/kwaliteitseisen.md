# Kwaliteitseisen

Binnen dit document wordt toegelicht wanneer een wens, eis of taak "Ready" of "Done" is. Deze punten dienen gebruikt te worden als kwaliteits check voor de op te leveren producten.

## Definition of Ready

De definition of ready dient als ondersteuning voor verduidelijken van wensen en eisen voordat er aan de development van deze eisen en wensen wordt begonnen. Zodra een item de backlog verlaat dienen alle onderstaande statements als waar te zijn.

Documentatie eisen:

- FO: Bevat user story met de eis
- FO: Bevat fully dressed use case die de eis beschrijft
- FO: Aangemaakte taken hebben een prioriteit (MoSCoW of nummering?)
- FO: Er zijn wire frames of mockups gemaakt van de te realiseren functionaliteit.
- FO: Voor actors, functionele requirements, niet functionele requirements en use cases worden unieke identifiers aangemaakt waar door de rest van de documentatie naar gerefereerd kan worden.
  - Actors: ACT1, ACT2, ACT3...
  - Functionele requirements: FR1, FR2, FR3...
  - Niet functionele requirements: NFR1, NFR2, NFR3...
  - Use cases: UC1, UC2, UC3...
- TR: In ieder geval de happy flow van de use case is opgenomen in het testrapport.
- Onderzoek: Er zijn duidelijke hoofd en deelvragen en een methode gekozen waarop deze beantwoord zullen worden.
- Planning: Er is een taak aangemaakt met tijds inschatting in Productive.
- Planning: Aangemaakte taken kunnen (indien opgepakt) binnen één dag van Ready naar Done.
- Alle documentatie: Binnen documenten worden de boven genoemde unieke identifiers gebruikt voor de tracability van verschillende requirements.
- Alle documentatie: Documentatie is geschreven in het Nederlands

Controle:

- PM/TL heeft de fully dressed use case goedgekeurd in het Functioneel ontwerp. (of gewoon userstory?)

## Definition of Done

- TR: Resultaten van de gemaakte functionaliteit zijn opgenomen in het test rapport.
<!-- Doen we minimale unit test coverage? -->
- TR: Code coverage is minimaal x%?
- TO: Het Technisch ontwerp is bijgewerkt met de implementatie van de gemaakte functionaliteit.
- SAD: Het Software Architecture Document is bijgewerkt met eventueel aangepaste architecturale beslissingen.
- Code: Pull requests worden door op zijn minst 1 collega nagekeken voor ze op test/deploy komen.
- Code: Front-end code heeft geen errors in ESLint. <!-- (iets over waarschuwingen?) -->
- Code: Back-end code heeft geen errors in StyleCop. <!-- (iets over waarschuwingen?) -->
- Code: Alle code is geformatteerd aan de hand van Editorconfig en prettier naar de Bluenotion style guide. <!-- link naar style guide? -->
- Code: Binnen de code wordt gebruik gemaakt van de FR, NFR en UC unieke identifiers (zie DoR) voor de tracability binnen de code.
- Code: Geschreven in het Engels
