# Reflectie proces feedback cycle

## Situatie

Tijdens het afstudeer project ben ik zelf verantwoordelijk voor het op de hoogte houden van de verschillende stakeholders van het project. Volgens het plan van aanpak zou dit gebeuren aan de hand van [OpenUp](https://www.utm.mx/~caff/doc/OpenUPWeb/) met name de iteratie review/retrospective.

## Taak

Houdt de stakeholders gerelateerd aan het project op de hoogte van ontwikkelingen en geef ze de optie de richting van het project bij te sturen.

## Actie

In de eerste drie iteraties heb ik vrij nauw contact gehad met de opdrachtgever en is aan de hand van interne meetings met voorbeelden aan de hand van fully dressed use-cases, schermontwerpen en een vooraf opgesteld vragenlijstje informatie vergaard en verspreid over de staat van het project.

<!-- TODO: notulen linken -->

In de hierop volgende iteraties is dit contact aanzienlijk verminderd. Niet voor elke iteratie werd een review ingepland of ingeplande reviews werden niet opgevolgd. Functionele en technische vragen werden meer gesteld aan de hand van direct contact.

## Resultaat

Door deze verminderde maten van contact hebben de stakeholders vanuit het bedrijf en de opleiding na de elaboratie fase weinig zicht gehad tot de progressie van het project. Hierdoor is met name de gekozen implementatie van de module die met Productive communiceert met de bijbehorende caching vrijwel niet besproken.

Hiermee is de gekozen oplossing op dit gebied ongetest en kan ik niet met zekerheid zeggen of de oplossing is wat de opdrachtgever wilt. Ook hebben de stakeholders vanuit het bedrijf en vanuit de HAN weinig zicht op de daadwerkelijke status van het project.

## Reflectie

De reden waarom ik in de latere iteraties minder contact had met de stakeholders en niet alle reviews werden ingepland of opgevolgd heeft deels te maken met de wisseling van project planning naar het onderzoek en PoC. De eerste paar sprints hadden duidelijke artefacten in de geschreven documentatie en schermontwerpen die gebruikt konden worden om aan de opdrachtgever aan te tonen wat de staat van het project was waarna hij weer terug kon koppelen met zijn mening.

Met een focus op het PoC over datasynchronisatie met Productive hadden latere iteraties hadden aanzienlijk minder duidelijke artefacten die gebruikt konden worden om progressie te pijlen. In de review van Elaboratie fase 2 stond een procedure basis data over tickets en projecten te synchroniseren. Naast aan de hand van postman http requests sturen naar een lokaal draaiende API was er geen meetbare criteria (tests) deze functionaliteit te bevestigen of ontkrachten.

Aangezien alleen de opdrachtgever en UX designer aanwezig waren bij de iteratie reviews en de het onderzoek en PoC niet in de zelfde duidelijke manier gecommuniceerd werden als de functionele aspecten van de eerdere iteraties werden de reviews steeds korter met minder relevante informatie stromen tussen de verschillende partijen.

Achteraf zie ik in ieder geval twee punten in dit proces waar ik anders had kunnen handelen dat het proces en uiteindelijke resultaat zouden kunnen verbeteren:

1. Artefacten creëren voor de technische aspecten van het project

Door voor de technische aspecten meetbare artefacten te creëren is het eenvoudiger progressie te tonen aan de stakeholders. Als zoals besproken in het PvA en DoR voordat er aan een micro-increment wordt gewerkt in het testplan opgenomen wordt wat de acceptatie criteria zijn en deze voor de review worden nagelopen is er voor minder technisch aangelegde stakeholders een duidelijke checklist in natuurlijke taal die de staat van het project communiceert.

2. Bedrijfsbegeleider betrekken bij reviews

Omdat de eerste paar iteratie reviews voornamelijk betrekking hadden op functionele en visuele (UX) aspecten van het project en de bedrijfsbegeleider voornamelijk focus heeft op de technische aspecten van projecten is hij niet aanwezig geweest bij de eerste paar reviews. Nadat het project zich meer op de achterliggende techniek begon te focussen had ik de bedrijfsbegeleider meer kunnen betrekken als stakeholder. Door tijdens reviews (en mogelijk andere contact momenten) een technisch oog op de aangeleverde oplossing te hebben komen alternatieven en/of bevestigingen ook zonder specifiek gecreëerde artefacten eerder aan het licht.
