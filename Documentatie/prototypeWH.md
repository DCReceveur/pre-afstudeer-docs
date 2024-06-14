
<!-- Wat is nodig in een communicatie prototype? -->

<!-- - Set up endpoint
- Set up webhook
- Test webhook resend delay
- Komt data snel genoeg binnen dat je er op kan vertrouwen? -->

<!-- Twee mogelijke prototypes: -->

# Communicatie met productive

Voor het project moet data uit en verstuurd worden naar productive. Deze data moet als single source of truth Productive gebruiken en dient reactietijden te hebben van minder dan 3 sec zoals beschreven in [NFR3](./FunctioneelOntwerp.md#nonfunctional-requirements) en [NFR5](./FunctioneelOntwerp.md#nonfunctional-requirements).

Op basis van de functionele requirements en de UX ontwerpen is een quick list gemaakt van data die vanuit Productive aangeleverd moet worden.

Klant:
Open taken (alle projecten vd klant) v
Projecten van klant v
Alle taken (1 project) v

Admin:
uren+budget project niveau* x
Klanten lijst v
Alle lopende projecten v
Recente taken v

*A. Is het nodig? deze was er uit op klant niveau [FDR001](./Decisions/Functional/FDR001-Tijd-en-kosten-niet-tonen.md) B. Welk endpoint kan ik deze data vinden?

## Prototype polling ADR001-O1

Er zou direct vanuit de front-end of back-end on demand data uit productive opgevraagd kunnen worden. Productive biedt endpoints met standaard [filter](https://developer.productive.io/#header-filtering) en [sorting](https://developer.productive.io/#header-sorting) opties die deze optie zouden kunnen faciliteren.

| Aanvraag | Resultaat* | Omgeving |
|-|-|-|
| Open taken (alle projecten vd klant)</br><https://api.productive.io/api/v2/tasks?page[size]=200&filter[company_id]=149808&filter[status]=1> | 77 resultaten over 1 pagina van 272KB in 499ms | klant |
| Projecten van klant</br><https://api.productive.io/api/v2/projects?page[size]=200&filter[company_id]=149808> | 2 resultaten over 1 pagina van 54KB in 292ms | klant |
| Alle taken van een project</br><https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877> | 845 resultaten op 5 pagina's van 438KB in 939ms | klant |
| Klanten lijst</br><https://api.productive.io/api/v2/companies?page[size]=200> | 307 resultaten over 2 pagina's van 158KB in 601ms | admin |
| Alle lopende projecten</br><https://api.productive.io/api/v2/projects?page[size]=200&filter[status]=1> | 233 resultaten over 2 pagina's van 358KB in 1434 ms | admin |
| Recente taken</br><https://api.productive.io/api/v2/tasks?page[size]=200&sort=-last_activity> | 27199 resultaten over 136 pagina's van 618KB in 2.29 s** | admin |
| Alle open taken van een project</br><https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877&filter[status]=1> | 77 resultaten op 1 pagina van 272KB in 708ms | klant/admin |

*De getoonde resultaat grootte en tijd zijn voor het ophalen van één pagina. Er staan maximaal 200 items op één pagina dus resultaten met meer dan 200 items krijgen in het totaal een langere reactietijd.

**Zou mogelijk met de extra stap naar de back-end boven de 3 sec response time uitkomen zoals beschreven in de NFR

## Prototype webhooks ADR001-O2

In plaats van een directe afhankelijkheid op de Productive API is het ook mogelijk de data van Productive in een eigen database bij te houden. Hierdoor zou het mogelijk zijn de PMP applicatie los te koppelen van de Productive rate limits en reactie tijden. Om te kunnen garanderen dat data van productive in de PMP database terecht komt en taken en wijzigingen gemaakt in het PMP ook terecht komen op Productive zijn een aantal vragen beantwoord worden:

- Wanneer wordt data binnen gehaald?

  - Data wordt een keer binnen gehaald als baseline.

Aangezien de volledige lijst van taken op het moment 27199 taken bevat zijn voor een baseline sync op zijn minst 136 requests nodig voor enkel de taak data. Mocht er voor elke taak ook de comments over de taak binnen gehaald willen worden is dit met 15486 comments zitten we al boven de 200 requests en is er dus (geen rekening houdend met de processing time van het PMP) al twee keer een wacht periode nodig om onder de 100 requests per 10 sec uit te komen. Dit is geen deal breaker voor een proces dat als het goed is maar een keer uitgevoerd moet worden maar hier dient wel over nagedacht te worden.

  - Data wordt gesynchroniseerd aan de hand van de webhooks.

Heeft de initiële database populatie nodig maar werkt hierna voor reads enkel met de PMP database.

Hoe weet je wat "relevante" data is en wat slaan we waarom op?

- Wanneer wordt data naar Productive gestuurd?

  - Direct

Zodra een gebruiker van het PMP een wijziging in een productive item doet sturen we dit naar de Productive API

  - Bulk

Er is een vast moment waarop alle synchronisatie naar productive wordt afgehandeld.

- Is er een mogelijkheid te detecteren wanneer data niet overeenkomt?

Als een gebruiker iets probeert in te voeren en een project/taak blijkt niet te bestaan

Als er van de webhook een wijziging binnen komt die niet overeen komt met de wijziging zoals eerder lokaal gedaan



  - Error bij inserts/updates?

  - Data opvragen bij inserts/updates?

  - Resultaten van de webhook?


- Is het mogelijk data te herstellen wanneer data niet overeenkomt?

  - Aan de hand van baseline import

  - Op object basis

