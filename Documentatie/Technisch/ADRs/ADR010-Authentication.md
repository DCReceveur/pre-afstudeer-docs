# ADR010 Authentication

**Status:** Proposed

**Context:**

Om gebruikers enkel interactie te bieden met onderdelen van het systeem waar ze recht toe hebben is het van belang dat er nagedacht wordt over Authenticatie, Autorisatie en Accounting. Het uitgangspunt is dat onderscheid gemaakt kan worden tussen de verschillende actors zoals genoemd in het [Functioneel Ontwerp](../../Functioneel/FunctioneelOntwerp.md#actors). De autorisatie opties om dit voor elkaar te krijgen zijn uit te zetten in twee brede categorieën:

**Decision:**

## O1-Intern

**Consequences:**

Pro:

- Geeft volledige controle en overzicht over wie waar wanneer bij mag.

Con:

- Er moet (in ieder geval) een authenticatie en autorisatie systeem gemaakt worden binnen het PMP.
- Wijzigingen binnen productive worden gedaan door een bot/automation account met een referentie naar de gebruiker die de wijziging heeft aangevraagd maar er is binnen productive (meestal) geen account representatie van de gebruiker zelf.
- Gebruikers van het PMP krijgen aparte inlog gegevens voor het PMP.

## Alternatives

## O2-Extern

<!-- Het voornaamste twee voordelen die gehaald kunnen worden uit een extern authenticatie systeem zijn een stukje extra zekerheid over de beveiliging van de procedure en (in het geval van de [Productive SSO](https://productive.io/blog/introducing-single-sign-on-support-sso-in-productive/)) de optie binnen Productive in comments of taken naar de klant te refereren. -->

Pro:

- Extra zekerheid over de beveiliging van het authenticatie systeem.
- Geeft de optie (in het geval van de [Productive SSO](https://productive.io/blog/introducing-single-sign-on-support-sso-in-productive/)) de optie binnen Productive in comments of taken naar de klant te refereren.

Con:

- Creëert een afhankelijkheid op een systeem van een derde waar de klant mogelijk helemaal geen account bij heeft.

## O3-Hybrid

Er kan ook een keuze gemaakt worden een combinatie van de twee systemen te gebruiken. Dit zou betekenen dat gebruikers die geen productive account hebben gebruik kunnen maken van het interne login systeem maar gebruikers die wel een productive account tot hun beschikking hebben gebruik kunnen maken van de al bestaande infrastructuur.
