
<!-- Wat is nodig in een communicatie prototype? -->

<!-- - Set up endpoint
- Set up webhook
- Test webhook resend delay
- Komt data snel genoeg binnen dat je er op kan vertrouwen? -->

<!-- Twee mogelijke prototypes: -->

# Communicatie met productive

In dit document wordt in meer detail in gegaan op de verschillende opties voor synchronisatie tussen het PMP en de data uit Productive. Een korte omschrijving van het probleem en de gekozen oplossing is te vinden in [ADR001](./Decisions/Architecture/ADR001-Communicatie_met_de_Productive_API.md), dit document dient voor meer diepgang op het onderwerp indien de lezer van ADR001 behoefte heeft aan meer diepgang op de verschillende overwogen opties.

Voor het project moet data uit en verstuurd worden naar productive. Deze data moet als single source of truth Productive gebruiken en dient met 50 gebruikers reactietijden te hebben van minder dan 3 sec zoals beschreven in [NFR3](./FunctioneelOntwerp.md#nonfunctional-requirements) en [NFR5](./FunctioneelOntwerp.md#nonfunctional-requirements). Om de haalbaarheid deze NFR's te pijlen is gebruik gemaakt van de [scherm ontwerpen](./FunctioneelOntwerp.md#scherm-ontwerpen) uit het FO. Binnen de Productive API is vervolgens gezocht welke endpoints deze informatie zouden kunnen aanleveren als de front-end direct met productive zou communiceren als bij [ADR001-O1](./Decisions/Architecture/ADR001-Communicatie_met_de_Productive_API.md#o1-directe-communicatie-met-productive-zonder-caching). De resultaten hiervan zijn opgenomen in de onderstaande tabel:

| Scherm | [/projects](https://developer.productive.io/projects.html#projects) | [/tasks](https://developer.productive.io/tasks.html#tasks) | [/people](https://developer.productive.io/people.html#people) | [/companies](https://developer.productive.io/companies.html#companies) | [/attachments](https://developer.productive.io/attachments.html#attachments) | [/comments](https://developer.productive.io/comments.html#comments) | [/activities](https://developer.productive.io/activities.html#activities) |
|--|--|--|--|--|--|--|--|
| [Klant: Projecten pagina](./FunctioneelOntwerp.md#klant-projecten-pagina) | x | x | x |  |  |  |  |
| [Admin: Projecten pagina](./FunctioneelOntwerp.md#admin-projecten-pagina) | x |  | x | x |  |  |  |
| [Klant: Taken lijst](./FunctioneelOntwerp.md#klant-taken-lijst) |  | x | x |  |  |  |  |
| [Klant: Project overzicht](./FunctioneelOntwerp.md#klant-project-overzicht) | x | x |  |  |  |  |  |
| [Klant: Taken detail](./FunctioneelOntwerp.md#klant-taken-detail) |  | x | x |  | x | x | x |
| [Admin: Taken lijst](./FunctioneelOntwerp.md#admin-taken-lijst) |  | x | x |  |  |  |  |
| [Admin: Taken detail](./FunctioneelOntwerp.md#admin-taken-detail) |  | x | x |  |  x | x | x |
| [Klant: Documentatie pagina](./FunctioneelOntwerp.md#ontwerpen-fr7-inzien-project-documentatie)* |  |  |  |  |  |  |  |
| [Admin: Toevoegen documentatie](./FunctioneelOntwerp.md#ontwerpen-fr7-inzien-project-documentatie)* |  |  |  |  |  |  |  |
| [Admin: Controleren aanvraag](./FunctioneelOntwerp.md#ontwerpen-fr8-controleren-aanvraag) |  | x | x |  | x | x | x |

*Waar slaan we documenten op?

Voor het uitlezen van data voor één pagina zouden bij sommige pagina's 5 verschillende Productive endpoints benaderd worden. Als volgens [NFR5.1](./FunctioneelOntwerp.md#nonfunctional-requirements) 50 gebruikers gelijktijdig bijvoorbeeld de details van een taak bekijken zou dit resulteren in 250 requests naar de Productive API. Er van uit gaande dat een pagina informatie nodig heeft van gemiddeld 3 a 4 endpoints zou de meest basale implementatie gebaseerd op directe communicatie met productive (met een rate limit van 100 requests per 10 sec) zich limiteren tot rond de 30 gelijktijdige gebruikers. (100/3.5=28.5)

Om er voor te zorgen dat de software aan alle eisen voldoet zal er dus één van twee (of beide) dingen moeten gebeuren:

A. Er dient tijdens de ontwikkeling van de front-end rekening gehouden te worden met welke data wanneer wordt getoond om de hoeveelheid requests naar productive te beperken.

B. De synchronisatie met productive dient losgekoppeld te worden van de front-end zodat Bluenotion zelf controle heeft over het aantal requests dat de front-end mag doen.

## Kwaliteit eisen

Om tot een passende oplossing te komen voor de synchronisatie tussen het PMP en Productive worden binnen dit document voor de opties als beschreven in [ADR001](./Decisions/Architecture/ADR001-Communicatie_met_de_Productive_API.md) een aantal test opstellingen opgezet. Aan de hand van deze testopstellingen zullen de opties op de volgende eisen getest worden:

| Eis | O1 | O2 | O3 | O4 | O5 |
|--|--|--|--|--|--|
| NFR5.1 & NFR5.2: Kan 50 gelijktijdige gebruikers ondersteunen | + | ++ | + | - | - |
| NFR2.1 & NFR8.3Delay tussen wijziging in Productive en sync in het PMP | ++ | + | -- | + | ++ |
| NFR3.2: Aantal requests naar Productive API | -- | ++ | + | -- | -- |
| NFR3.1: Aantal requests naar eigen API/db | ++ | + | + | -- | -- |
| NFR2.1: Compleetheid & Betrouwbaarheid gesynchroniseerde data | ++ | + | -- | ++ | ++ |
| NFR8.*: Opties voor catastrophisch herstel | ++ | +/- | +/- | +/- | +/- |
| Implementatie complexiteit | + | - | + | - | - |
| Totaal: | 8 | 6 | 0 | -1 | -2 |

Deze eisen zijn gebaseerd op de NFR's zoals beschreven en terug te vinden in het [functioneel ontwerp](./FunctioneelOntwerp.md#nonfunctional-requirements).

## Polling ADR001-O1

Er zou direct vanuit de front-end of back-end on demand data uit productive opgevraagd kunnen worden. Productive biedt endpoints met standaard [filter](https://developer.productive.io/#header-filtering) en [sorting](https://developer.productive.io/#header-sorting) opties die deze optie zouden kunnen faciliteren.

| Aanvraag | Resultaat* | Omgeving |
|-|-|-|
| Open taken (alle projecten vd klant)</br><https://api.productive.io/api/v2/tasks?page[size]=200&filter[company_id]=149808&filter[status]=1> | 77 resultaten over 1 pagina van 272KB in 499ms | klant |
| Projecten van klant</br><https://api.productive.io/api/v2/projects?page[size]=200&filter[company_id]=149808> | 2 resultaten over 1 pagina van 54KB in 292ms per pagina | klant |
| Alle taken van een project</br><https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877> | 845 resultaten op 5 pagina's van 438KB in 939ms per pagina | klant |
| Klanten lijst</br><https://api.productive.io/api/v2/companies?page[size]=200> | 307 resultaten over 2 pagina's van 158KB in 601ms per pagina | admin |
| Alle lopende projecten</br><https://api.productive.io/api/v2/projects?page[size]=200&filter[status]=1> | 233 resultaten over 2 pagina's van 358KB in 1434 ms per pagina | admin |
| Recente taken</br><https://api.productive.io/api/v2/tasks?page[size]=200&sort=-last_activity> | 27199 resultaten over 136 pagina's van 618KB in 2.29 s**  per pagina | admin |
| Alle open taken van een project</br><https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877&filter[status]=1> | 77 resultaten op 1 pagina van 272KB in 708ms per pagina | klant/admin |

*De getoonde resultaat grootte en tijd zijn voor het ophalen van één pagina. Er staan maximaal 200 items op één pagina dus resultaten met meer dan 200 items krijgen in het totaal een langere reactietijd.

**Zou mogelijk met de extra stap naar de back-end boven de 3 sec response time uitkomen zoals beschreven in de NFR

## Webhooks ADR001-O2

Productive biedt webhooks aan waarmee je automatisch op de hoogte wordt gebracht van wijzigingen in het Productive model. Aan de hand van deze webhooks zou het mogelijk zijn de PMP database automatisch te laten synchroniseren met alle wijzigingen direct wanneer Productive het PMP op de hoogte stelt van de wijzigingen. Productive biedt voor de volgende entiteiten Create, Update en Delete webhooks aan:

| Webhook entity | Create Id | Update Id | Delete Id | REST data source equivalent | Used in initial screen designs |
|--|--|--|--|--|--|
| Task  | 1 | 24 | 25 | [Tasks](https://developer.productive.io/tasks.html#tasks) | X |
| Invoice  | 2 | 14 | 15 | [Invoice](https://developer.productive.io/invoices.html#invoices) |  |
| Deal  | 3 | 12 | 13 | [Deals](https://developer.productive.io/deals.html#deals) |  |
| Budget  | 4 | 16 | 20 | Onbekend |  |
| Project  | 5 | 10 | 11 | [Projects](https://developer.productive.io/projects.html#projects) | X |
| Time entry  | 7 | 8 | 9 | [Time_entries](https://developer.productive.io/time_entries.html#time-entries) |  |
| Booking  | 17 | 18 | 19 | [Booking](https://developer.productive.io/bookings.html#bookings) |  |
| Expense  | 21 | 22 | 23 | [Expenses](https://developer.productive.io/expenses.html#expenses) |  |
| Person  | 26 | 27 | 28 | [People](https://developer.productive.io/people.html#people) | X |
| Company  | 29 | 30 | 31 | [Companies](https://developer.productive.io/companies.html#companies) | X |
| Payment  | 32 | 33 | 34 | [Payments](https://developer.productive.io/payments.html#payments) |  |
| None |  |  |  | [Attachments](https://developer.productive.io/attachments.html#attachments) | X |
| None |  |  |  | [Comments](https://developer.productive.io/comments.html#comments) | X |
| None |  |  |  | [Activities](https://developer.productive.io/activities.html#activities) | X |

Hierbij valt op dat attachments, comments en activities geen webhooks hebben die specifiek enkel de attachment, comment en activities data doorgeeft. Bijlages en comments zouden waarschijnlijk doorgegeven worden bij updates van hun gerelateerde objecten. Zo zou binnen productive een comment met bijlage op een taak plaatsen bijvoorbeeld resulteren met een trigger op de Task update hook en zal hier een referentie in zitten met de bijgevoegde bijlage.*

*Dit is nog niet uitgebreid getest en kan een fout begrip van het systeem zijn.

## Time based synchronisatie ADR001-O3

Binnen ADR001-O3 wordt gesproken over timer based synchronisatie. Technisch gezien zou er aan de hand van een proces dat elke x aantal seconde of minuten nieuwe data binnen haalt van de Productive API een synchronisatie opgezet kunnen worden die ongeacht de hoeveelheid gebruikers altijd een stabiel aantal requests doet naar de Productive API. Met een limiet van 100 requests in 10 seconde en filters als "last_activity_after" zouden waarschijnlijk genoeg requests mogelijk zijn om data te synchroniseren.

Het grote nadeel van deze aanpak is dat je als gebruiker niet weet of de data up to date is. Data kan wel automatisch bij binnenkomst aan de front-end doorgegeven worden maar er zal altijd een periode zijn waarin je data verouderd is aan het eind van de update cycle. Ook legt deze aanpak een relatief grote druk op het netwerk. Om deze redenen is geen prototype van een time based synchronisatie opgezet en verder gegaan met de overige keuzes.

## Change based polling ADR001-O4

Eén optie om up to date te blijven met productive is door bij elke data request voor een project of taak de lokale data van de entiteit te vergelijken met de data zoals beschikbaar op Productive. Als het "last_activity_at" date time veld in het PMP lager is dan die van Productive weet je dat de lokale data bijgewerkt moet worden. Dit kan vervolgens gedaan worden aan de hand van het /activities endpoint of de endpoint van de bijbehorende entiteit. Onder volgt een stroomschema van dit proces.

```plantuml

start
:get relevant project from local db;
if (Project found) then (no)
    :get project from productive;
    note right: Request to Productive API
    if(Productive contains project data) then (yes)
        :get all activities from productive*;
            note left: Request to Productive API as n1
    else (no)
    :Show project not found;
    endif
else (yes) 
    :get Activities from productive since last local update;
    note left: Request to Productive API
    if(Activities>0) then (yes)
    :Write changes to local db;
    else (no)
    endif
endif

:show data to user;
stop

```

Als aan de hand van de Activities endpoint alle relevante data binnengehaald kan worden zou het PMP met deze oplossing na maximaal* 2 requests naar productive altijd zekerheid kunnen bieden dat de aangeboden data compleet en correct is.

*Deze uitspraak is technisch gezien niet correct. Als de activity data meer dan 200 items bevat zouden er meer dan 2 requests naar Productive gestuurd moeten worden om alle data binnen te halen. TODO: corrigeren?

Het nadeel van deze optie zit hem echter ook in de twee requests naar Productive. Omdat de data van het eerste request als input dient voor de tweede request om de activities op te halen kunnen deze enkel sequentieel uitgevoerd worden.

## Gecombineerd webhooks en change based polling ADR001-O5

Door webhooks de standaard data synchronisatie te laten afhandelen zou het scenario dat het PMP twee sequentiele minder vaak voorkomen. Om er voor te zorgen dat data wanneer de gebruiker er om vraagt zeker up to date is kan gebruik gemaakt worden van het proces zoals beschreven bij [ADR001-O4](#change-based-polling-adr001-o4).*

TODO:
*De last activity geeft me geen garantie dat alle data tot dat punt is weggeschreven, alleen dat de activity van dat moment is weggeschreven. Kan ik iets zeggen over de activities die er voor kwamen en de garantie dat deze ook in de lokale database voorkomen?

## ADR001-O2 Webhooks Proof of Concept

Van de initieel voorgestelde opties [ADR001-O1 tm ADR001-O5](/Documentatie/Decisions/Architecture/ADR001-Communicatie_met_de_Productive_API.md) leek [ADR001-O2](/Documentatie/Decisions/Architecture/ADR001-Communicatie_met_de_Productive_API.md) de meest flexibele en schaalbare optie. Omdat deze optie wegens complexere implementatie toch lager scoorde dan ADR001-O1 is besloten te onderzoeken of deze optie ook in de praktijk naar verwachting functioneert en of het haalbaar is in de opgegeven afstudeer tijd is in drie fases een Proof of Concept prototype opgezet met de volgende eisen:

### Phase 1

De eerste fase van het onderzoek wordt gebruikt om snel potentiële problemen te vinden met de voorgestelde aanpak. Zonder veel werk te stoppen in het programmeren van het systeem wordt gekeken of alle data die nodig is voor een basis implementatie van het PMP via webhooks verkregen kan worden en indien dit niet het geval is wordt gekeken wat potentiële alternatieven zijn. Door vroegtijdig te kijken welke data via deze manier binnengehaald kan worden is de hoop dat mochten er problemen zijn met deze aanpak dat ze vroegtijdig naar boven komen en nagedacht kan worden over een andere keuze voor ADR001.

- Vraag: Hoe dicht in de buurt van de webhook limits komt het dagelijks gebruik van Bluenotion? 1000 per 5 min
- Vraag: Kan een systeem op basis van webhooks foutieve informatie ontdekken en herstellen?
- Is er een initiële dataset nodig?
- Wordt alle informatie die het PMP nodig heeft doorgegeven aan de hand van webhooks? Wat gebeurt er bijvoorbeeld met comments?
  A: Staan als activity onder het object waar een comment op is achter gelaten.

### Phase 2

Na binnen fase 1 gekeken te hebben naar of alle data technisch gezien beschikbaar is is het doel van fase 2 een kleinschalig prototype op te zetten die voor één project de benodigde data in een lokale database zet. Hierbij is vooral het testen van de compleetheid en accuraatheid van de data belangrijk. Door eerst op kleine schaal data te synchroniseren is de hoop dat potentiële edge cases sneller opvallen en opgelost kunnen worden.

- POC: Worden binnen de webhooks alle identificerende data van objecten meegegeven of kan data uit de Productive API ambigu zijn?
- POC: Zet een procedure op die bij Productive kijkt of de webhooks actief zijn en indien dit niet het geval is webhooks kan activeren.
- POC: Zet een procedure op die aan de hand van webhooks één project passief op hoogte houdt met wijzigingen binnen Productive. (create, update delete webhooks on at least task & project)
- POC: Zet een aantal API endpoints op die (tijdelijke) Project/Taak data accepteren en doorsturen naar Productive via de Productive REST APi
- POC: (afhankelijk initiële dataset vraag) Zet een procedure op die voor één project alle voor het PMP relevante Project en taak informatie ophaalt.*
*Dit is een grote. Er zou voor een initiële dataset veel data (boven de api limits) aan Productive gevraagd moeten worden.

Now make it crack.

### Phase 3

Binnen fase 3 wordt het kleinschalige POC uitgebreid naar een "volwaardige" synchronisatie module die zonder verdere input de PMP database synchroniseert met wijzigingen binnen Productive en visa versa. Alle data die niet aan de hand van de webhooks gesynchroniseerd kan worden dient in het FO/TO genoteerd te worden met een potentiële oplossing voor waar de data eventueel vandaan kan komen. Ook worden er binnen fase 3 zo veel mogelijk edge cases getest die er voor moeten zorgen dat de data die in het PMP komt te staan correct en compleet is.

- FO/TO: Verifieer of naast project en taak data andere data nodig is van de webhooks
- FO/TO: Noteer voor alle data vragen binnen het PMP eventuele resterende REST endpoints.
- POC: Breidt het POC uit door in plaats van data uit één project te verzamelen data uit alle projecten te verzamelen.

Now make it crack.

- Verifieer dat alle data binnen komt.*
  - Wat als de PMP server bezig is met het verwerken van een ander bericht?
  - Wat als de Productive server boven de 12 (max) retries komt?
  - Wat als wijzigingen over de zelfde data gaan en ongeveer tegelijkertijd gedaan worden?
  - Wat als data in een onverwachte volgorde binnenkomt/verwerkt wordt?
  - Hoe gaan we met attachments om? Zelf hosten? Gebruik maken van Productive "hosting"?
- Meet het gebruik van de webhooks tegenover de schatting van phase 1.

*Is dit concreet testbaar? Mogelijk met integratietests? Zijn dit "HAN deelvragen"? Moet ik überhaupt "HAN deelvragen" hebben?

1. Set up webhook
2. Post data to productive
3. Verify webhook trigger
4. Verify database

## Resultaten

### Fase 1

#### Hoe dicht in de buurt van de webhook limits komt het dagelijks gebruik van Bluenotion?

Om deze vraag te beantwoorden is gebruik gemaakt van de Productive activities endpoint. Deze endpoint geeft de mogelijkheid met filters activiteiten binnen taken, projecten, personen, bedrijven en meer te bekijken. Hiermee is het mogelijk alle productive wijzigingen op te vragen van bijvoorbeeld afgelopen week.

In 1 week, 3 pagina's van +/- 200 items

```https://api.productive.io/api/v2/activities?X-Feature-Flags=includes-overhaul&filter%5Bafter%5D=30-06-2024&filter%5Bbefore%5D=08-07-2024&page%5Bnumber%5D=3&page[size]=200```

Er is geen filter toegepast die enkel projecten, taken en comments dus er staan een aantal andere items in zoals boekingen maar het overgrote deel is data dat binnen het PMP nodig is. Dit houdt in dat binnen een reguliere week rond de 600 creates/updates/deletes zijn gedaan binnen productive op items waar het PMP in geïnteresseerd is. Aangezien webhooks gelimiteerd zijn aan 1000 requests per 5 min zit Bluenotion vooralsnog ver onder de limieten zoals opgelegd door Productive.

#### Kan een systeem op basis van webhooks foutieve informatie ontdekken en herstellen?

#### Is er een initiële dataset nodig?

Ja: De procedure zoals beschreven in ADR001-O4 resulteert in 2 of 3 database calls (lokaal en binnen de Productive API) voor één data vraag. Aangezien deze calls relatief dure/langzame operaties zijn zou een procedure waar enkel de "nodige" data uit Productive wordt gehaald resulteren in een tragere applicatie. Aangezien de datum gevonden in de eerste request als input dient voor de rest van de data requests moet de verzameling van deze data sequentieel gebeuren waardoor de snelheid van de applicatie nog verder zou afnemen en mogelijk boven het limiet zoals beschreven in [NFR3.1 en NFR3.2](/Documentatie/FunctioneelOntwerp.md#nonfunctional-requirements) zou komen.

Nee: Technisch gezien niet, er zou puur op aanvraag data verzameld kunnen worden.

#### Wordt alle informatie die het PMP nodig heeft doorgegeven aan de hand van webhooks

Hoe krijg ik een task_list_id? deze is niet aanwezig in /activities. niet includable vanuit activities, zou wel kunnen dat hij vanaf de webhooks te bereiken is.
TODO: test* Indien dit niet mogelijk is zou het kunnen dat de "status" zoals beschreven in het [functioneel ontwerp](/Documentatie/FunctioneelOntwerp.md#toelichting-statuses)

### Fase 2

### Fase 3

<!-- Afhankelijk van ADR001-Communicatie met de Productive API heeft de synchronisatie service een aantal verschillende rollen:

- Een manier van verificatie bieden of data gevonden in het PMP overeen komt met data gevonden in het project management systeem.

TODO: Procedure uittekenen

- Handmatige synchronisatie starten waarmee de initiële dataset wordt binnengehaald.

TODO: Procedure uittekenen

- Het opzetten en in stand houden van webhooks die gebruikt kunnen worden om wijzigingen door te geven aan het PMP.

De voorlopige opzet maakt gebruik van een initiële dataset en webhooks om data van Productive over te nemen naar de lokale PMP database. Door de data uit Productive naar een eigen database te halen krijgen we controle over de rate limits en dus schaalbaarheid van de applicatie.*

*Geeft dit een onveiliger systeem ivm meer user input?

Is er een initiële dataset nodig?

Ja: De procedure zoals beschreven in ADR001-O4 resulteert in 2 of 3 database calls (lokaal en binnen de Productive API) voor één data vraag. Aangezien deze calls relatief dure/langzame operaties zijn zou een procedure waar enkel de "nodige" data uit Productive wordt gehaald resulteren in een tragere applicatie. Aangezien de datum gevonden in de eerste request als input dient voor de rest van de data requests moet de verzameling van deze data sequentieel gebeuren waardoor de snelheid van de applicatie nog verder zou afnemen en mogelijk boven het limiet zoals beschreven in [NFR3.1 en NFR3.2](/Documentatie/FunctioneelOntwerp.md#nonfunctional-requirements) zou komen.

Nee: Technisch gezien niet, er zou puur op aanvraag data verzameld kunnen worden. -->


<!-- In plaats van een directe afhankelijkheid op de Productive API is het ook mogelijk de data van Productive in een eigen database bij te houden. Hierdoor zou het mogelijk zijn de PMP applicatie los te koppelen van de Productive rate limits en reactie tijden.

Om zekerheid te kunnen bieden over dat de gewenste data met webhooks correct gesynchroniseerd wordt dient er in een vroeg stadium een prototype opgezet te worden die een aantal belangrijke vragen beantwoord:

- Is er een initiële dataset nodig en zo ja, hoe kan deze binnengehaald worden?

*Get all activities zou ook een all tasks van project kunnen zijn? Historische activities doen er in dit geval niet zo toe. -->

<!-- Activities op een project sinds inputdatum.

https://api.productive.io/api/v2/activities?page[size]=200&filter[project_id]=485803&filter[after]=16-06-2024 -->
<!-- 
- Hoe kan incorrecte data ontdekt worden?

iets met project last changed verandert maar data niet doorgekomen?

- Hoe kan incorrecte data gecorrigeerd worden?

- Hoe betrouwbaar zijn de webhooks met betrekking tot delays en retries? -->


<!-- 


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
 -->
