# ADR001-Communicatie met de Productive API

**Status:** Proposed

**Context:**

Voor de development teams wordt Productive gebruikt voor het project beheer, het Project Management Portal biedt de klant en de PM inzicht in en communicatie met deze Productive omgeving. Voor de development teams dient het werkproces niet aangepast te worden.

**Decision:**

## O2-Continu synchroniserende backend database aan de hand van Webhooks

Om de meest recente data te tonen uit productive terwijl de schaalbaarheid wordt behouden is gekozen gebruik te maken van de [Productive.io webhooks](https://developer.productive.io/webhooks.html#webhooks). Hiermee zou data automatisch gesynchroniseerd kunnen worden naar de back-end database vanuit waar (zonder verdere rate limits) de data verspreid kan worden naar verschillende gebruikers van het PMP.

**Consequences:**

- Door de back-end aan de hand van webhooks te synchroniseren ben je afhankelijk van de update rate van de webhooks. Dit is nog niet getest maar het zou kunnen dat hier een delay op zit die groter is dan een "handmatige" request bij een REST endpoint.

- Mocht de PMP back-end om wat voor reden niet dan ook geen OK status code terug sturen naar de webhook worden er door Productive nog 11 keer (over 12 uur) een poging gedaan de data te sturen. In het geval dat het PMP in deze tijd niet reageert zou er data in Productive staan die niet in het PMP aanwezig is en dus gesynchroniseerd moet worden.

- Webhooks zijn rate limited met 1000 requests per 5 min.

**Alternatives:**

## O1: Directe communicatie met productive zonder caching

Technisch gezien is voor de data over projecten en taken geen back end database nodig als de data direct van Productive's API gehaald wordt. Hiermee is het PMP [gelimiteerd aan 100 requests per 10 seconden](https://developer.productive.io/index.html#header-rate-limits) en dit biedt weinig flexibiliteit in data transformatie of implementatie van niet productive gerelateerde functionaliteit als het toevoegen van documentatie ([FR7](./FunctioneelOntwerp.md#fr71-openendownloaden-document)) of een service overview ([FR6](FunctioneelOntwerp.md#fr61-inzien-lijst-van-project-dependencies) ) in een project.

## O3: Timed data synchronisatie

Productive biedt de mogelijkheid [bulk requests](https://developer.productive.io/index.html#header-content-negotiation) te doen. Dit zou gebruikt kunnen worden om op aanvraag de back-end database te synchroniseren met de informatie zoals beschikbaar op Productive.

