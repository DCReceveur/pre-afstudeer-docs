# poc scope

## Situatie

Er werkt gelijktijdig nog een stagiaire aan een automatische vertaal functie voor het zelfde klant portaal. Om er voor te zorgen dat er tegen het eind van de stage geen complexe integratie moet gebeuren tussen de twee systemen om tot één portaal te komen is gekozen beiden in de zelfde code base te werken. Nadat het PoC taken kon ophalen en aanmaken kreeg ik van de mede stagiaire de vraag wanneer ik tussen projecten kon wisselen. Deze vraag kwam voort uit "FR1.1: Inzien projecten" en "FR2.1: Inzien taken van project" waar een gebruiker de voor hem beschikbaar gestelde projecten kan zien en op basis van deze projecten de verschillende taken kan opvragen. Omdat de opdracht van deze stagiaire per project vertalingen moet kunnen genereren was hij afhankelijk van een vorm van project selectie.

## Taak

Werk verder aan de geplande functionaliteiten voor de PoC terwijl je afhankelijkheden van je collega's faciliteert.

## Actie

Omdat het ophalen van projecten eigenlijk gepland stond voor het op het PoC volgende MvP maar de endpoints voor taken intussen stond heb ik besloten ook vast een lokaal endpoint te maken voor projecten en een api client opgezet voor Productive project data. Met deze actie werden het PoC en MvP gecombineerd tot één groter prototype waarin alle must haves volgens de DoD uitgewerkt werden. Dit combineren was voornamelijk een poging tot tijdswinning omdat de functionaliteiten tussen de twee prototypes grotendeels overeen kwamen.

Om er voor te zorgen dat mijn mede stagiair ook zonder deze uitbreidingen vooruit kon heb ik aan de hand van het [PMP datamodel](../../Technisch/TechnischOntwerp.md#pmp-datamodel) verteld dat entiteit "Project" binnen het PMP identificeerbaar is met een Guid en dat het geselecteerde project waarschijnlijk in een sessie bewaard zal worden maar ik hier nog niet mee bezig ben geweest. Tot ik het project selecteer menu had gemaakt zou hij voor de front end gebruik maken van een statisch placeholder Guid.

Na op de back-end de project relevante endpoints en api client had opgezet ben ik begonnen met het opzetten van de relevante front-end van de project selector samen met het testen van de back-end functionaliteit. Het opzetten van de front-end samen met het testen en regelen van de autorisatie bleek uitdagender dan verwacht en heeft tot een lange ontwikkeltijd geleid.

## Resultaat

Het PoC dat de focus moest leggen op de wijze van data synchronisatie is qua scope uit de hand gelopen. In plaats van dat mijn focus lag op het leveren van een proof of concept met een kleinere goed uitgewerkte synchronisatie module lag mijn focus op het leveren van een volwaardig MvP inclusief tests, documentatie en front-end. Dit heeft naar mijn mening waardevolle tijd afgenomen die besteed kon worden aan het uitwerken van het caching mechanisme achter de Productive communicatie.

Het opgeleverde synchronisatie mechanisme zal met de verwachte druk op het systeem geen rate limits raken maar is niet goed opgewassen tegen groei van deze druk en heeft geen graceful failures waarin bij gebrek aan communicatie van productive alsnog data verwerkt kan worden.

## Reflectie

De feature creep van het PoC/MvP heeft een aantal oorzaken en resultaten:

1. Eén oorzaak voor de ongecontroleerde feature creep van het PoC is het slecht bijhouden van de takenlijsten zoals benoemd in [reflectie Planning](acceptatiecriteria.md).
    Zoals in deze reflectie besproken is naar maten dat het project vorderde steeds minder aan de takenlijst gewerkt.
2. Te grote initiële opzet MvP.
    Het MvP dat zou volgen uit het PoC had een scope van "alle must haves". Dit was vanaf het begin al een ambitieus plan om binnen de eerste twee constructie iteraties af te krijgen.
3. Incorrect handelen bij vraag naar wijziging.
    In plaats van het PoC en MvP samen te voegen tot één prototype was het wellicht beter geweest het PoC af te maken zoals gepland en deze voor te leggen bij de bedrijfsbegeleider. Zo kan er voeger in het proces feedback gegeven worden wat naderhand refactoren scheelt.

    <!-- TODO: continue -->
