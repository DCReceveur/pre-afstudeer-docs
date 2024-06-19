---
# Configuration for the Jekyll template "Just the Docs"
parent: Decisions
nav_order: 100
title: ADR001 Communicatie met de Productive API
# https://adr.github.io/madr/
# These are optional elements. Feel free to remove any of them.
status: proposed
date: 22-05-2024
---
# ADR001 Communicatie met de Productive API

## Context and Problem Statement

Binnen Bluenotion wordt voor de start van het project Productive gebruikt voor het beheer van wie, wat, wanneer moet doen. Het Project Management Portal dient voornamelijk de klant inzicht te geven in en interactie aan te bieden met het actieve Productive systeem. Er is geen wens vanuit de development teams om over te schakelen naar een nieuw systeem voor project management.

## Decision Drivers

* Rate limit op Productive API
* Risico op dubbele of verloren data
* Complexiteit synchronisatie

## Considered Options

* O1: Continu synchroniserende backend database aan de hand van REST calls
* O2: Continu synchroniserende backend database aan de hand van Webhooks
* O3: Data synchronisatie on request
* O4: Directe communicatie met productive zonder caching

## Decision Outcome

Chosen option: O2 Continu synchroniserende backend database aan de hand van webhooks omdat het limiet van de webhooks hoog ligt. Limiet op verloren data is hoger dan directe communicatie. Complexiteit ligt niet heel hoog.

Chosen option: "{title of option 1}", because
{justification. e.g., only option, which meets k.o. criterion decision driver | which resolves force {force} | … | comes out best (see below)}.

<!-- This is an optional element. Feel free to remove. -->
### Consequences

* Good, because {positive consequence, e.g., improvement of one or more desired qualities, …}
* Bad, because {negative consequence, e.g., compromising one or more desired qualities, …}
* … <!-- numbers of consequences can vary -->

<!-- This is an optional element. Feel free to remove. -->
## Validation

{describe how the implementation of/compliance with the ADR is validated. E.g., by a review or an ArchUnit test}

<!-- This is an optional element. Feel free to remove. -->
## Pros and Cons of the Options

### O1: Continu synchroniserende backend database aan de hand van REST calls

Door op de backend een proces te starten dat elke x minuten een aantal synchronisatie requests doet zou in de back-end zonder verdere communicatie met de Productive API alle nodige informatie in het systeem staan. In deze synchronisatie requests zouden ook nieuw aangemaakte taken doorgestuurd kunnen worden naar Productive.

#### O1: Positief

* Als er een vast moment is wanneer de database hoort te synchroniseren het snel duidelijk is wanneer dit niet gebeurt.
* Ongeacht de hoeveelheid gebruikers die het systeem gebruiken blijven de hoeveelheid API calls naar productive het zelfde. Hiermee is de schaalbaarheid van de applicatie losgekoppeld van de Productive rate limit.

#### O1: Neutraal

* Het gebruik van de Productive API zou constant relatief hoog liggen maar (als het goed is) nooit boven de rate limit komen.

#### O1: Negatief

* Het loskoppelen van de synchronisatie heeft als resultaat dat als een gebruiker informatie opvraagt en aan het eind van de synchronisatie cycle zit de gebruiker relatief oude informatie kan krijgen.

### O2: Continu synchroniserende backend database aan de hand van Webhooks

Door op de backend te abonneren op een aantal [webhooks](https://developer.productive.io/webhooks.html) voor bijvoorbeeld projecten en taken kan de back-end automatisch nieuwe informatie van productive binnen krijgen en de REST calls gebruiken om updates weg te schrijven naar Productive.

#### O2: Positief

* Er is minder actieve communicatie nodig met Productive in vergelijking met [O1](#o1-continu-synchroniserende-backend-database-aan-de-hand-van-rest-calls).
* Webhooks hebben binnen productive de hoogste rate limit met 1000 requests per 5 minuten.
* Zodra er op Productive een wijziging doorgevoerd wordt zou de backend van het PMP hier een bericht over krijgen met de nieuwe data.

#### O2: Neutraal

#### O2: Negatief

* Data wegschrijven naar productive zal via een aparte procedure moeten gebeuren.

### O3: Data synchronisatie on request

In plaats van dat de back end zelf verantwoordelijk is voor wanneer data binnengehaald van en verstuurd wordt naar Productive is het ook een optie dit enkel op aanvraag te doen. Hiermee limiteer je de hoeveelheid data die over en weer wordt gestuurd tot enkel de data waar de gebruiker geïnteresseerd in is.

#### O3: Positief

* Er wordt nooit informatie opgevraagd die niet strict gezien nodig is. Hiermee wordt het [Principle of Least Privilige](https://www.paloaltonetworks.com/cyberpedia/what-is-the-principle-of-least-privilege#:~:text=The%20principle%20of%20least%20privilege%20(PoLP)%20is%20an%20information%20security,to%20complete%20a%20required%20task.) gehanteerd.

#### O3: Neutraal

?

#### O3: Negatief

* De hoeveelheid aanvragen naar de Productive API is gekoppeld aan de hoeveelheid gebruikers op dat moment.

{example | description | pointer to more information | …}

* Good, because {argument a}
* Good, because {argument b}
* Neutral, because {argument c}
* Bad, because {argument d}
* …

### O4: Directe communicatie met productive zonder caching

Bij directe communicatie met de Productive API is de back end van het PMP enkel verantwoordelijk voor transformatie van de data naar een format dat bruikbaar is voor de klant en wat de Productive API verwacht en aanlevert. Er wordt geen data in een back end database opgeslagen dus het hele project management blijft binnen Productive.

### O4: Positief

* Data is altijd up to date.
* Het kan niet voorkomen dat verschillende data sources (back end database & Productive API) voor de zelfde projecten/taken conflicterende data hebben.
* Er wordt nooit informatie opgevraagd die niet strict gezien nodig is. Hiermee wordt het [Principle of Least Privilige](https://www.paloaltonetworks.com/cyberpedia/what-is-the-principle-of-least-privilege#:~:text=The%20principle%20of%20least%20privilege%20(PoLP)%20is%20an%20information%20security,to%20complete%20a%20required%20task.) gehanteerd.

### 04: Neutraal

### 04: Negatief

* Schaalbaarheid is direct gekoppeld aan de Productive API rate limits.
* Het is moeilijker extra informatie over taken of projecten op te slaan die niet relevant zijn / waar geen velden voor bestaan in Productive.


<!-- This is an optional element. Feel free to remove. -->
## More Information

{You might want to provide additional evidence/confidence for the decision outcome here and/or
 document the team agreement on the decision and/or
 define when this decision when and how the decision should be realized and if/when it should be re-visited and/or
 how the decision is validated.
 Links to other decisions and resources might here appear as well.}

