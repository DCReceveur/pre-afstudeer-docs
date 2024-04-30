# Kwaliteitseisen

Binnen dit document wordt toegelicht wanneer een wens, eis of taak "Ready" of "Done" is. Deze punten dienen gebruikt te worden als kwaliteits check voor de op te leveren producten.

## Definition of Ready

De definition of ready dient als ondersteuning voor verduidelijken van wensen en eisen voordat er aan de development van deze eisen en wensen wordt begonnen. Zodra een item de backlog verlaat dienen alle onderstaande statements als waar te zijn.

Documentatie eisen:

- In iedergeval de happy flow van de use case is opgenomen in het testrapport
- Er is een taak aangemaakt met tijds inschatting in Productive.
- Aangemaakte taken kunnen (indien opgepakt) binnen één dag van Ready naar Done.
- Voor actors, functionele requirements, niet functionele requirements en usecases worden unieke identifiers aangemaakt waar door de rest van de documentatie naar gerefereerd kan worden.
  - Actors: A1, A2, A3...
  - Functionele requirements: FR1, FR2, FR3...
  - Niet functionele requirements: NFR1, NFR2, NFR3...
  - Usecases: UC1, UC2, UC3...

Controle:

- PM/TL heeft de fully dressed usecase goedgekeurd in het Functioneel ontwerp.



## Definition of Done

- Resultaten van de gemaakte functionaliteit zijn opgenomen in het test rapport.
<!-- Doen we minimale unit test coverage? -->
- Code coverage is minimaal x%?
- Het Technisch ontwerp is bijgewerkt met de implementatie van de gemaakte functionaliteit.
- Pull requests worden door op zijn minst 1 collega nagekeken voor ze op test/deploy komen.
- Front-end code heeft geen errors in ESLint. <!-- (iets over waarschuwingen?) -->
- Back-end code heeft geen errors in StyleCop. <!-- (iets over waarschuwingen?) -->
- Alle code is geformatteerd aan de hand van Editorconfig en prettier naar de Bluenotion style guide. <!-- link naar style guide? -->
