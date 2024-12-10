# OND01-Communicatie met productive

Dit document dient antwoord te geven op de vraag "Hoe kan het PMP op een schaalbare en betrouwbare manier data synchroniseren van en naar Productive?". De resultaten van dit onderzoek zijn in het kort vastgelegd in [ADR001](../../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md). Dit document dient als toelichting op de aanpak om tot de beslissing in [ADR001](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md) te komen.

Om deze hoofdvraag te kunnen beantwoorden dienen er eerst een aantal deelvragen beantwoord te worden:

- DV1: Wat zijn vaak gebruikte manieren van data synchronisatie die toe te passen zijn bij dit project?
- DV2: Hoe dicht zit de verwachte gebruik frequentie van de applicatie tegen de rate limits?
- DV3: Welke synchronisatie methoden schalen goed met het aantal requests?
- DV4: (Hoe) Is te garanderen dat data correct en consistent is?
- DV5: Hoe kunnen atomic transactions en data consistency worden gegarandeerd bij overschrijding van de rate limits of algehele onbereikbaarheid van de Productive API?

## Samenvatting

## Methodiek

De bij dit onderzoek toegepaste onderzoeksmethodiek en de redenatie achter de keuze voor deze onderzoeksmethodiek is te vinden in het [Onderzoeksplan](OND01-Onderzoeksplan.md). Kort samengevat wordt er gebruik gemaakt van de Realize as required onderzoek patroon met een library onderzoek om de zwakheden van dit patroon af te vangen. Welke deelvragen worden beantwoord tijdens alle fases van het onderzoek is ook genoteerd in het onderzoeksplan en de introductie van elke onderzoek fase in dit document.

## Resultaten

Binnen dit hoofdstuk zijn de resultaten van de verschillende onderzoeksfases opgenomen.

### Library

<!-- basic rate limiting info, not super useful https://www.elastic.io/integration-best-practices/api-rate-limiting-techniques-workarounds/ -->
<!-- push/pull data reference, apiclient checklist https://airbyte.com/data-engineering-resources/api-to-database -->
<!-- how to httpclient bokkie https://josef.codes/you-are-probably-still-using-httpclient-wrong-and-it-is-destabilizing-your-software/  -->
<!-- polling best practices https://www.merge.dev/blog/api-polling-best-practices -->
<!-- https://www.geeksforgeeks.org/webhook-vs-api-polling-in-system-design/ -->
 <!-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-start     =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- -->

In dit hoofdstuk wordt in meer detail in gegaan op de verschillende opties voor synchronisatie tussen [data uit het PMP](../Technisch/TechnischOntwerp.md#pmp-datamodel) en de [data uit Productive](../Technisch/TechnischOntwerp.md#productive-datamodel). Dit library onderzoek dient antwoord te geven op DV1 en inzicht te geven in DV5 Een korte omschrijving van het probleem en de gekozen oplossing is te vinden in [ADR001](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md), dit document dient voor meer diepgang op het onderwerp indien de lezer van ADR001 behoefte heeft aan meer diepgang op de verschillende overwogen opties.

Voor het project moet data uit en verstuurd worden naar productive. Deze data moet als single source of truth Productive gebruiken en dient met 50 gebruikers reactietijden te hebben van minder dan 3 sec zoals beschreven in [NFR3](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) en [NFR5](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements). Om de haalbaarheid deze NFR's te pijlen is gebruik gemaakt van de [scherm ontwerpen.](../Functioneel/Schermontwerpen.md)

Voor het uitlezen van data voor één pagina zouden bij sommige pagina's 5 verschillende Productive endpoints benaderd worden. Als volgens [NFR5.1](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) 50 gebruikers gelijktijdig bijvoorbeeld de details van een taak bekijken zou dit resulteren in 250 requests naar de Productive API. Er van uit gaande dat een pagina informatie nodig heeft van gemiddeld 3 a 4 endpoints zou de meest basale implementatie gebaseerd op directe communicatie met productive (met een rate limit van 100 requests per 10 sec) zich limiteren tot rond de 30 gelijktijdige gebruikers. (100/3.5=28.5)

Om er voor te zorgen dat de software aan alle eisen voldoet zal er dus één van twee (of beide) dingen moeten gebeuren:

A. Er dient tijdens de ontwikkeling van de front-end rekening gehouden te worden met welke data wanneer wordt getoond om de hoeveelheid requests naar productive te beperken.

B. De synchronisatie met productive dient losgekoppeld te worden van de front-end zodat Bluenotion zelf controle heeft over het aantal requests dat de front-end mag doen.

<!-- TODO: Hier kun je iets zeggen over architectuur patroon xyz zegt loskoppelen FE & BE -->

Een van de beste manieren om rate limits te "omzeilen" van rate limits is gebruik maken van een architectuur waar de api wijzigingen "pushen" (webhooks) in plaats van dat jij ze moet "pullen" (polling). Productive faciliteert beiden oplossingen, in [beschikbaarheid data](#beschikbaarheid-data) wordt nagekeken of beiden oplossingen alle benodigde data kunnen voorzien.

#### Webhooks ADR001-O2

Om de meest recente data te tonen uit productive terwijl de schaalbaarheid wordt behouden kan er gebruik gemaakt worden van de [Productive.io webhooks](https://developer.productive.io/webhooks.html#webhooks). Hiermee zou data automatisch gesynchroniseerd kunnen worden naar de back-end database vanuit waar (zonder verdere rate limits) de data verspreid kan worden naar verschillende gebruikers van het PMP.

##### Data uitlezen

In dit geval zou het PMP bij bijvoorbeeld het opvragen van taken die bij een project horen enkel met zijn eigen database communiceren.

```puml
title getTasks 'local'
autonumber
participant TaskController as task
participant TaskService as task_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db

?-> task : UI request
task --> task_serv : getTasks(projectId)
task_serv --> pers_serv : getTasks(projectId)
pers_serv --> pmp_db : SELECT....

```

<!-- TODO: Zijn gets nodig om via een service te doen? Is het netter de controller direct met de repositories te laten praten of heeft de service laag hier toch een rol in?

Terminologie opzoeken transparant vs non-transparant layers of iets dergelijks 

redenering: Binnen BN worden voornamelijk open lagen gebruikt waar de controllers voor simpele lees acties direct met de repositories werken.
-->

##### Data wijzigen binnen productive

Indien via het PMP een wijziging wordt doorgevoerd zoals het toevoegen van een taak of comment of het wijzigen van een status komt dit binnen bij het PMP en wordt de PMP database bijgewerkt.

```puml
title Add task via Productive
autonumber
participant ProductiveSyncController as prod_sync
participant SyncService as sync_serv
participant TaskService as task_serv
participant "PersistenceService" as pers_serv
database PMP_database as pmp_db

[-> prod_sync : webhook message
prod_sync -> sync_serv : processSyncRequest(message)
sync_serv -> task_serv : addTask(TaskInfo) 
task_serv -> pers_serv : addOrUpdate(TaskInfo)
pers_serv -> pmp_db : INSERT TaskInfo
note right 
    %autonumber%: Could be inserted/updated with "synced flag"
end note
```

##### Data wijzigen binnen het PMP

Als via het PMP een wijziging wordt doorgevoerd kan deze direct of op een rustig moment doorgestuurd worden naar Productive. Met het op het moment verwachtte gebruik van het PMP zou een directe synchronisatie waarschijnlijk* de betere optie zijn.

*Deze mening is puur gebaseerd op het redundant wegschrijven van data en [NFR2.1](../../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) en [NFR8.2](../../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) zonder verdere uitgebreide redenatie of onderzoek.

```puml
title Add task via PMP
autonumber
participant TaskController as task_ctrl
participant TaskService as task_serv
participant ProductiveService as prod_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db
database Productive_API as prod_api

[->task_ctrl : UI request(TaskInfo)
task_ctrl -> task_serv : addTask(TaskInfo)

task_serv -> prod_serv : syncTask(TaskInfo)
prod_serv -> prod_api: HTTP POST
alt http success

task_serv -> pers_serv : insertOrUpdateTask(TaskInfo)

pers_serv -> pmp_db : INSERT TaskInfo
note right 
    %autonumber%: Could be inserted/updated with "not synced flag"
end note
else http failure
prod_serv -> task_ctrl : throw SynchronizationException
end

```

<!-- Productive biedt webhooks aan waarmee je automatisch op de hoogte wordt gebracht van wijzigingen in het Productive model. Aan de hand van deze webhooks zou het mogelijk zijn de PMP database automatisch te laten synchroniseren met alle wijzigingen direct wanneer Productive het PMP op de hoogte stelt van de wijzigingen. Productive biedt voor de volgende entiteiten Create, Update en Delete webhooks aan:

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

*Dit is nog niet uitgebreid getest en kan een fout begrip van het systeem zijn. -->

##### Webhook types

Binnen het vooronderzoek bleek dat Productive twee "types" webhooks biedt, om een geïnformeerde keuze te kunnen maken is gekeken naar de verschillen tussen deze twee types en wat dit betekend voor het PMP project.

###### Type 1: Webhook

Dit zijn reguliere webhooks, in te dienen bij Productive via de REST API met een event en een callback adres. Op het callback adres dient een endpoint beschikbaar te zijn die het HTTP bericht en zijn content verwerkt en een 2xx response code terug dient te sturen.

###### Type 2: Zapier

Om een begrip op te bouwen over wat een Zapier webhook is wordt uitgegaan van [dit artikel](https://caisy.io/blog/webhooks-vs-zapier). Uit dit artikel blijkt dat Zapier automatie tooling is die gebruikt kan worden om zonder code te schrijven simpele taken te automatiseren tussen verschillende applicaties. Hiermee heb je de optie snel simpele procedures op te zetten maar verlies je een stukje flexibiliteit door Zapiers proprietary protocol.

##### Extra kosten

Tijdens het uitwerken van de workshop fase van dit onderzoek waren een aantal webhooks aangemaakt binnen Productive om te kunnen testen precies welke data wanneer binnen zou komen bij een implementatie die gebruik maakt van webhooks. De opvolgende week bleek echter dat alle aangemaakte webhooks disabled waren. Dit bleek te liggen aan het binnen Bluenotion gebruikte subscriptie plan waar [webhooks niet in aangeboden](https://help.productive.io/en/articles/3693279-using-webhooks-in-productive) werden. Na contact gelegd te hebben met de klanten service van Productive met de vraag waarom de webhooks de week er voor wel werkte bleek er een trail aangezet te zijn voor het "ultimate" plan die was verlopen. Hierdoor is data synchronisatie aan de hand van webhooks wel een mooie oplossing maar de extra kosten verbonden aan deze oplossing maken het aanzienlijk minder aantrekkelijk.

<!-- ##### Conclusie

De eerste indruk van Zapier is dat de vereenvoudigde automatisering voor kleinere/eenvoudigere projecten nuttig kan zijn, zoals het inlichten van een persoon bij een specifiek soort ticket. Hiervoor zou geen code geschreven hoeven worden en zou puur in de GUI van Zapier kunnen gebeuren.

Aangezien in het PMP de webhooks gebruikt zouden worden om de gehele dataset te synchroniseren en er binnen dit project toch endpoints geschreven moeten worden om data over projecten en taken te verwerken voor de front-end zie ik de voordelen van Zapier binnen het PMP vooralsnog niet opwegen tegen de extra kosten en verlaagde maten van flexibiliteit. -->

#### Polling

Binnen een architectuur die gebruik maakt van polling om data te synchroniseren ligt het aantal requests dat naar de Productive api gestuurd moeten worden gemiddeld hoger dan bij het gebruik van webhooks maar ook hier zijn verschillende opties die elk op gebied van hoeveelheid requests en consistentie van data kunnen verschillen. Binnen dit hoofdstuk wordt toegelicht hoe de verschillende strategieën binnen het PMP toegepast zouden kunnen worden.

##### Direct ADR001-O1

Directe communicatie met Productive vanuit de PMP back-end is de eenvoudigste maar minst efficiënte oplossing. Omdat per pagina verschillende componenten van verschillende entiteiten verschillende data punten nodig hebben lopen het aantal requests naar de Productive API snel op.

```puml
title Direct polling
autonumber
participant "Front-end" as FE
participant TaskController as task
participant TaskService as task_serv
participant "ActivitiesController" as act 
participant "Productive API" as prod

?-> FE : User opens dashboard
FE --> task : getTasks(projectId)
task --> task_serv : getTasks(projectId)
task_serv --> prod: GET /tasks filter=projectId

FE --> act : getActivities(customerId)
act --> prod: GET /activities filter=customerId
```

Ook is dankzij de simpliciteit van de oplossing het niet mogelijk tijdens tijdelijk wegvallen van de Productive API of het bereiken van de rate limits de laatst geverifieerde data te retourneren.

##### Timed ADR001-O3

Eén manier van data synchroniseren naar een lokale data source is door periodiek specifieke data op te vragen aan de externe api. Hiermee is het mogelijk zelf controle uit te oefenen over hoe veel requests er per tijds unit naar de externe server gaan omdat het geheel los is gekoppeld van wat gebruikers opvragen.
Ook is het mogelijk aan de hand van [bulk requests](https://developer.productive.io/index.html#header-content-negotiation) sommige schrijf acties lokaal bij te houden en in bulk requests te synchroniseren.

```puml
title Add task from pmp
autonumber
participant TaskController as task
participant ProductiveService as prod_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db


?-> task : UI request
task -> prod_serv : addTask(TaskInfo)
prod_serv -> pers_serv : addTask(TaskInfo)
pers_serv -> pmp_db : INSERT...
```

```puml
title Bulk sync tasks
autonumber
participant ProductiveSyncController as prod_sync
participant ProductiveService as prod_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db
database Productive_API as prod_api

?-> prod_sync : cron job sync
prod_sync -> prod_serv : syncLocalChanges
prod_serv -> pers_serv : lc = getLocalChanges
pers_serv -> pmp_db : select where synced=0

prod_serv -> prod_api : HTTP GET 
prod_serv -> pers_serv : setToSynced(lc)**
pers_serv -> pmp_db : UPDATE/DELETE...
```
**Dit zou ook kunnen gebeuren als de gesynchroniseerde items terug komen via de webhook

<!-- serviceworker https://web.dev/patterns/web-apps/periodic-background-sync -->
<!-- chronic rate limiting overflow vs acute  https://stackoverflow.com/questions/49014207/how-to-deal-with-api-that-rate-limits-requests -->

##### Change based ADR001-O4

Eén optie om up to date te blijven met productive is door bij elke data request voor een project of taak de lokale data van de entiteit te vergelijken met de data zoals beschikbaar op Productive. Als het "last_activity_at" date time veld in het PMP lager is dan die van Productive weet je dat de lokale data bijgewerkt moet worden. Dit kan vervolgens gedaan worden aan de hand van het /activities endpoint of de endpoint van de bijbehorende entiteit. Onder volgt een stroomschema van dit proces.

```puml

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

##### Cached ADR001-O5

De laatste oplossing die in dit onderzoek wordt aangekaart is een polling oplossing die gebruik maakt van een vorm van caching. Elke vorm van caching heeft ook zijn voor en nadelen maar op globaal niveau zou een poll oplossing met cache er als volgt uit zien:

Er kan gebruik gemaakt worden van een cache met een tijd waarna records verlopen. Data over taken of projecten kan aan de hand van webhooks of direct polling opgehaald en weggeschreven worden waarna het PMP pas nieuwe data gaat ophalen zodra data voor een bepaalde tijd niet meer is ververst. Hiermee wordt het dubbel ophalen van data als er bijvoorbeeld van het dashboard naar een project wordt genavigeerd voorkomen.

```puml
title GET /projects
autonumber
participant projectController as project_ctrl
participant projectService as project_serv
participant projectRepository as project_repo
participant ProductiveApiClient as prod_api
database "PMP Database" as PMP_DB
database "Productive Database" as prod_db

[->project_ctrl : GET
project_ctrl -> project_serv : getProjects(customerId)
project_serv -> project_repo : getProjects() // After date toevoegen?
project_repo -> PMP_DB : SELECT ...
  alt now() - project.updated_at > 1 min
    project_serv -> prod_api : fetchedProjects = fetch(expiredProjects)
    prod_api -> prod_db : GET /projects
    project_serv -> project_repo: update(fetchedProjects)
  end

project_repo -> project_ctrl : projects
project_repo -> PMP_DB : update
```

Hier zijn nog een aantal belangrijk opmerkingen bij te maken:

- Wanneer ergens een update gedaan wordt moeten beiden data sources genotificeerd worden. Qua consistentie lijkt het mij beter om de lokale versie te invalideren en op te vragen bij de remote source.
- In het geval dat de externe source niet reageert met een http success code zou de keuze gemaakt kunnen worden de oudere versies van de data terug te sturen. Dit zou wel conflicterende data kunnen opleveren.
- In het geval dat de externe source niet reageert met http success code zouden uitgaande berichten (voornamelijk write requests) in een queue gezet kunnen worden om periodiek opnieuw te versturen.

De bovenstaande caching oplossing maakt gebruik van een database als "cache". Qua cache oplossingen is dit [een van de langzamere opties](https://nickcraver.com/blog/2019/08/06/stack-overflow-how-we-do-app-caching/). Hier wordt kort voor en nadelen van verschillende caching locaties beschreven.

###### Memory

Voordeel:

- Memory is snel
- Memory is [volatile](https://www.techtarget.com/whatis/definition/volatile-memory)
- Memory cache is eenvoudig te invalideren

Nadeel:

- Bij grotere datasets wordt memory duur

###### Database

Voordeel:

- Database data is persistent bij uitval
- Het is mogelijk inzicht te krijgen in wanneer de laatste keer is dat informatie is opgevraagd

Nadeel:

- Data opvragen van een database is (in vergelijking met memory) relatief langzaam

###### Redis

<!-- TODO: Redis stukje schrijven -->

<!-- Er zou direct vanuit de front-end of back-end on demand data uit productive opgevraagd kunnen worden. Productive biedt endpoints met standaard [filter](https://developer.productive.io/#header-filtering) en [sorting](https://developer.productive.io/#header-sorting) opties die deze optie zouden kunnen faciliteren.

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

**Zou mogelijk met de extra stap naar de back-end boven de 3 sec response time uitkomen zoals beschreven in de NFR -->


#### Time based synchronisatie ADR001-O3

Binnen ADR001-O3 wordt gesproken over timer based synchronisatie. Technisch gezien zou er aan de hand van een proces dat elke x aantal seconde of minuten nieuwe data binnen haalt van de Productive API een synchronisatie opgezet kunnen worden die ongeacht de hoeveelheid gebruikers altijd een stabiel aantal requests doet naar de Productive API. Met een limiet van 100 requests in 10 seconde en filters als "last_activity_after" zouden waarschijnlijk genoeg requests mogelijk zijn om data te synchroniseren.

Het grote nadeel van deze aanpak is dat je als gebruiker niet weet of de data up to date is. Data kan wel automatisch bij binnenkomst aan de front-end doorgegeven worden maar er zal altijd een periode zijn waarin je data verouderd is aan het eind van de update cycle. Ook legt deze aanpak een relatief grote druk op het netwerk. Om deze redenen is geen prototype van een time based synchronisatie opgezet en verder gegaan met de overige keuzes.

#### Change based polling ADR001-O4

Eén optie om up to date te blijven met productive is door bij elke data request voor een project of taak de lokale data van de entiteit te vergelijken met de data zoals beschikbaar op Productive. Als het "last_activity_at" date time veld in het PMP lager is dan die van Productive weet je dat de lokale data bijgewerkt moet worden. Dit kan vervolgens gedaan worden aan de hand van het /activities endpoint of de endpoint van de bijbehorende entiteit. Onder volgt een stroomschema van dit proces.

```puml

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

#### Gecombineerd webhooks en change based polling ADR001-O5

Door webhooks de standaard data synchronisatie te laten afhandelen zou het scenario dat het PMP twee sequentiële requests moet doen minder vaak voorkomen. Om er voor te zorgen dat data wanneer de gebruiker er om vraagt zeker up to date is kan gebruik gemaakt worden van het proces zoals beschreven bij [ADR001-O4](#change-based-polling-adr001-o4).*

Open vraag:
*De last activity geeft me geen garantie dat alle data tot dat punt is weggeschreven, alleen dat de activity van dat moment is weggeschreven. Kan ik iets zeggen over de activities die er voor kwamen en de garantie dat deze ook in de lokale database voorkomen?

 <!-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-end     =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- -->

### Field

#### Beschikbaarheid data

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

#### Limits

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

### Workshop

 <!-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-start     =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- -->

 Van de initieel voorgestelde opties [ADR001-O1 tm ADR001-O5](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md) leek [ADR001-O2](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md) de meest flexibele en schaalbare optie. Omdat deze optie wegens complexere implementatie toch lager scoorde dan ADR001-O1 is besloten te onderzoeken of deze optie ook in de praktijk naar verwachting functioneert en of het haalbaar is in de opgegeven afstudeer tijd is in twee fases een Proof of Concept prototype opgezet met de volgende eisen:

#### Requirements prioritization

 Om tot een passende oplossing te komen voor de synchronisatie tussen het PMP en Productive worden binnen dit document voor de opties als beschreven in [ADR001](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md) een aantal test opstellingen opgezet. Aan de hand van deze testopstellingen zullen de opties op de volgende eisen getest worden:

| Eis | O1 | O2 | O3 | O4 | O5 |
|--|--|--|--|--|--|
| NFR5.1 & NFR5.2: Kan 50 gelijktijdige gebruikers ondersteunen | + | ++ | + | - | - |
| NFR2.1 & NFR8.3Delay tussen wijziging in Productive en sync in het PMP | ++ | + | -- | + | ++ |
| NFR3.2: Aantal requests naar Productive API | -- | ++ | + | -- | -- |
| NFR3.1: Aantal requests naar eigen API/db | ++ | + | + | -- | -- |
| NFR2.1: Compleetheid & Betrouwbaarheid gesynchroniseerde data | ++ | + | -- | ++ | ++ |
| NFR8.*: Opties voor catastrophisch herstel | ++ | +/- | +/- | +/- | +/- |
| Implementatie complexiteit | + | - | + | - | - |
| Beschikbaar in het huidige Productive pakket | ++ | -- | ++ | ++ | -- |
| Totaal: | 10 | 4 | 2 | 1 | -4 |

Deze eisen zijn gebaseerd op de NFR's zoals beschreven en terug te vinden in het [functioneel ontwerp](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements).

#### Proof of Concept

 Na in het library onderzoek een aantal verschillende potentiële oplossingen uitgelicht te hebben en ze (voor zo ver mogelijk) op meetbare data gerangschikt te hebben wordt in elk geval de meest veelbelovende oplossing uitgewerkt naar een Proof of Concept prototype. Het doel van dit prototype is op kleine schaal project en taak data van en naar een lokale database te synchroniseren. Door eerst op (relatief) kleine schaal een prototype te maken vallen fouten in de synchronisatie eerder op en mocht de oplossing niet voldoen aan de verwachtingen kan er snel omgeslagen worden naar een andere potentiële oplossing. De eisen voor het PoC prototype zijn als volgt:
 
 <!-- 
 - POC: Worden binnen de webhooks alle identificerende data van objecten meegegeven of kan data uit de Productive API ambigu zijn?
 - POC: Zet een procedure op die bij Productive kijkt of de webhooks actief zijn en indien dit niet het geval is webhooks kan activeren.
 - POC: Zet een procedure op die aan de hand van webhooks één project passief op hoogte houdt met wijzigingen binnen Productive. (create, update delete webhooks on at least task & project)
 - POC: Zet een aantal API endpoints op die (tijdelijke) Project/Taak data accepteren en doorsturen naar Productive via de Productive REST APi
 - POC: (afhankelijk initiële dataset vraag) Zet een procedure op die voor één project alle voor het PMP relevante Project en taak informatie ophaalt.*
 *Dit is een grote. Er zou voor een initiële dataset veel data (boven de api limits) aan Productive gevraagd moeten worden.
 
 Polling POC -->
 
 Te beantwoorden vragen:

- Welke data is binnen het PMP nodig om efficient Productive uit te lezen? (welke keys/entiteiten moeten lokaal beschikbaar zijn?)
- Hoe zet je veilig een cache laag op die wanneer de zelfde data meerdere keren opgevraagd wordt niet elke keer de data aan Productive vraagt?
- Hoe zet je een procedure op die schrijf acties in Productive in "real time" laat gebeuren maar geen gegevens kwijt raakt als de API overbelast is?

 POC eisen:

- ASP.NET endpoint voor het opvragen van alle taken van een project
- ASP.NET endpoint voor het toevoegen van een nieuwe taak aan een project
- Binnen 10 seconde herhalende requests resulteren niet in meer requests naar Productive
- Relationele database met opzet van het lokale datamodel
- Correcte foutafhandeling bij overbelaste Productive API

 Na het opzetten van het proof of concept worden de resultaten van het onderzoek en opgeleverde POC besproken met een techlead van Bluenotion om de haalbaarheid en compleetheid van het opgeleverde product aan de hand van peer review te testen.

#### Minimal Viable Product

 Binnen fase 3 wordt het kleinschalige POC uitgebreid naar een "volwaardige" synchronisatie module die zonder verdere input de PMP database synchroniseert met wijzigingen binnen Productive en visa versa. Alle data die niet aan de hand van de webhooks gesynchroniseerd kan worden dient in het FO/TO genoteerd te worden met een potentiële oplossing voor waar de data eventueel vandaan kan komen. Ook worden er binnen fase 3 zo veel mogelijk edge cases getest die er voor moeten zorgen dat de data die in het PMP komt te staan correct en compleet is.

 - FO/TO: Verifieer of naast project en taak data andere data nodig is van de webhooks
 - FO/TO: Noteer voor alle data vragen binnen het PMP eventuele resterende REST endpoints.
 - POC: Breidt het POC uit door in plaats van data uit één project te verzamelen data uit alle projecten te verzamelen.
 
 Na het opzetten van het minimal viable product worden de resultaten van het onderzoek en opgeleverde MVP besproken met een techlead van Bluenotion om de haalbaarheid en compleetheid van het opgeleverde product aan de hand van peer review te testen.
 
 - Verifieer dat alle data binnen komt.*
   - Wat als de PMP server bezig is met het verwerken van een ander bericht?
   - Wat als de Productive server boven de 12 (max) retries komt?
   - Wat als wijzigingen over de zelfde data gaan en ongeveer tegelijkertijd gedaan worden?
   - Wat als data in een onverwachte volgorde binnenkomt/verwerkt wordt?
   - Hoe gaan we met attachments om? Zelf hosten? Gebruik maken van Productive "hosting"?

 <!-- - Meet het gebruik van de webhooks tegenover de schatting van phase 1. -->
 
 <!-- TODO: *Is dit concreet testbaar? Mogelijk met integratietests? Zijn dit "HAN deelvragen"? Moet ik überhaupt "HAN deelvragen" hebben? -->
 
 <!-- 1. Set up webhook
 1. Post data to productive
 2. Verify webhook trigger
 3. Verify database -->
 <!-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-end     =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- -->

#### Lab




## Discussie

## Conclusie

Als Productive klanten met het Professional pakket zou toestaan webhooks te gebruiken of als Bluenotion ooit overschakelt naar het ultimate pakket zou een implementatie die aan de hand van webhooks een lokale database bijwerkt voor zo ver ik heb ondervonden de meest schaalbare wijze van synchronisatie zijn.

Database caching geeft in het geval van dit project de meest flexibele oplossing waar het mogelijk is data lokaal weg te schrijven en later naar Productive te versturen en "oude" data toch aan de klant te kunnen tonen. Het is hierbij wel van belang dat er een procedure wordt opgezet waar mogelijke conflicten die kunnen voorkomen van een aparte datasource getoond kunnen worden en het liefst ook opgelost.

## Bronnen
