# ADR000: Gelaagde rechten

<!-- TODO: Verder uitwerken -->

Title: Gelaagde rechten

Context: Beheerders en gebruikers kunnen deel zijn van Bluenotion of het bedrijf van de klant. Afhankelijk hiervan dienen verschillende acties beschikbaar en afgeschermd te zijn zoals aangegeven in de [rechten tabel](../FunctioneelOntwerp.md#rechten-tabel) van het functioneel ontwerp.

Decision: Beheerders en gebruikers rechten toekennen op corporatie niveau, bedrijf niveau en project niveau

Status: Proposed

Consequences:

Beheerders van een corporatie kunnen gebruikers toevoegen voor bedrijven en projecten.

Beheerders van bedrijven kunnen gebruikers toevoegen voor projecten.

Beheerders van projecten kunnen gebruikers toevoegen voor de projecten.

src: https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions