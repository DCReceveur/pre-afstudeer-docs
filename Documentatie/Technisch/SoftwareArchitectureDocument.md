# Software Architecture Document

Binnen dit overzicht wordt aan de hand van het c4 model voor software architectuur documentatie een globaal overzicht gegeven van het geplande Project Management Portal.

## Context

Zoals beschreven in het [FO](../Functioneel/FunctioneelOntwerp.md) besproken dient het PMP als koppeling tussen Bluenotion en haar klanten zodat de klanten van Bluenotion door inzicht te krijgen in de status van hun project meer bij het ontwikkelproces betrokken kunnen zijn. Hiervoor maakt het PMP gebruik van een koppeling met de Productive waar de medewerkers van Bluenotion hun dagelijkse bezigheden registreren.*

<!-- *TODO: Hoort het messaging systeem en/of db hier wel te staan? is dit geen Container of component?
Argument voor weghalen is dat het dingen zijn die ik beheer, argument tegen is dat ze gezien kunnen worden als externe systemen die relevant zijn voor de context van het systeem. -->

{%
    include-markdown "../UML/Technisch/C4_Context.md"
%}

| Element | Toelichting |
|--|--|
| [Project Management Portal](#components) | Levert op vraag informatie aan de gebruikers over de projecten en taken zoals beschikbaar op de productive.io API. |
| [Productive (API)](#productive-api) | Productive houdt de huidige staat van binnen Bluenotion uitgevoerde projecten bij. Deze API en de achter liggende database dient als de single point of truth van het PMP systeem. |
| Messaging system | Verantwoordelijk voor het op de hoogte stellen van gebruikers als er acties ondernomen moeten worden. Voorbeelden zijn:</br>- Een taak die gereviewd moet worden</br>- Een critical of blocking issue |
| PMP Database | Omdat de Productive API rate limited is en er mogelijk data over projecten dient opgeslagen te worden die niet binnen productive beschikbaar is wordt gebruik gemaakt van een (voor de API) lokale database om opgevraagde data te cachen en overige data op te slaan. |

## Containers

{%
    include-markdown "../UML/Technisch/C4_Containers.md"
%}

| Container | Toelichting |
|---|---|
| [React front-end](#Component-FE) | Levert mogelijkheden tot interactie met de rest van het PMP systeem aan de hand van REST API calls naar de PMP API. |
| [PMP API](#Component-PMP-API) | Levert endpoints voor de React front-end om data uit de rest van het systeem uit te lezen en op te slaan.  |
| [PMP Services](#Component-PMP-Services) | Verantwoordelijk voor het afhandelen van domein logica en coördinatie van binnenkomende en uitgaande data naar andere componenten. |
| [PMP Database](#Component-PMP-DB) | De PMP Database is een MySQL** database waar data die niet opgeslagen kan worden in Productive opgeslagen kan worden. |
| [Notification system](#Component-Notification-system) | Verantwoordelijk voor het inlichten van de gebruiker bij evenementen waar directe actie voor nodig is zoals het inlichten van Bluenotion bij criticals/blocking issues ([FR4.2](../Functioneel/Requirements/FR4_Versturen_notificaties.md#fr42-inlichten-bluenotion-bij-blockerscriticals)) of het inlichten wanneer een klant extra informatie moet geven op een taak [FR4.1](../Functioneel/Requirements/FR4_Versturen_notificaties.md#fr41-inlichten-klant-wanneer-een-taak-wacht-op-input-van-de-klant).  |
| [Productive API](#Component-Productive-API) | De Productive API dient als data source voor alle project gerelateerde informatie binnen Bluenotion. Wijzigingen in Productive dienen (indien opgevraagd door de gebruiker) binnen 3 seconde na aanvraag beschikbaar te zijn voor de gebruiker ([NFR2.1, NFR3.2](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements)). Wijzigingen in de door Productive aangeleverde entiteiten zoals projecten en taken dienen zonder verlies doorgezet te worden naar Productive([NFR2.1, NFR8.1](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements)). |

## Components

### <a id="Component-FE" /></a>React front-end

<!-- TODO: De echte views hier in zetten. -->

{%
    include-markdown "../UML/Technisch/C4_Component_FE.md"
%}

#### Toelichting FE componenten

| Component | Uitleg |
|---|---|
| **View** | In de front-end zijn de views van MVC hetgeen dat data (uit de models) laat zien en interactie aanbiedt met de rest van het systeem (via de controllers) |
| **Admin** | Om meer zekerheid te bieden dat de klant niet "per ongeluk" in de admin omgeving terecht komt worden er aparte views aangemaakt met de functionaliteiten voor de Bluenotion Administrator (ACT2) |
| **Customer** | Binnen de Customer views worden de functionaliteiten voor de externe beheerder (ACT1) met betrekking tot het tonen van data geïmplementeerd. |
| **Partials** | Binnen de components worden generieke views gemaakt die onafhankelijk zijn van de gebruiker of die door de betreffende customer of admin views worden aangevuld. |
| **Generated API** | De generated API is de OpenAPI representatie van de back-end. Deze wordt [automatisch gegenereerd](https://openapi-generator.tech/) en is functioneel gelijk aan de [PMP API](#pmp-api) |

### <a id="Component-PMP-API" /></a>PMP API

<!-- TODO: Op welk niveau doe ik controllers en endpoints? Functioneel, entiteit of een mix van beide? -->

Het PMP API component is verantwoordelijk voor het beheer van de verschillende REST endpoints. De logica in dit component dient beperkt te worden tot configuratie van de endpoints, het afhandelen van role based autorisatie en model validatie.

{%
    include-markdown "../UML/Technisch/C4_Component_API.md"
%}

#### Toelichting API componenten

| Component | Uitleg |
|---|---|
| **Controllers**  | De controllers zijn verantwoordelijk voor het beschikbaar stellen van de juiste RESTful endpoints en het op basis van deze endpoints aanspreken van de juiste services om een antwoord terug te kunnen geven.  |
| **AccountController**  | Verantwoordelijk voor endpoints met betrekking tot inloggen of account management  |
| **ProjectController**  | Verantwoordelijk voor endpoints met betrekking tot Projecten of project management  |
| **TaskController**  | Verantwoordelijk voor endpoints met betrekking tot Taken of taak management  |
| **CommentController**  | Verantwoordelijk voor endpoints met betrekking tot Comments op taken (bijlages?). |
| **ProductiveSyncController** | Verantwoordelijk voor endpoints met betrekking tot communicatie met de Productive API.* |
| [**Models**](#Component-PMP-DB)  | De Models zijn data objecten die worden gebruikt voor data transfer tussen verschillende componenten. Later in dit document wordt [per laag toelichting](#Component-PMP-DB) gegeven op de models.  |

<!-- TODO: Is er een aparte endpoint nodig voor forced syncs en dergelijke? Deze was eerst bedoeld voor webhook management -->

<!-- TODO: is dit een ADR? -->

Eén gemaakte keuze bij het gebruik van de verschillende lagen en de communicatie hiertussen is dat de verschillende controllers enkel toegang hebben tot de verschillende service interfaces en niet de repository interfaces. Hierdoor zal voor lees acties binnen de services extra code geschreven moeten worden maar is de controller laag niet gekoppeld aan de onderliggende repositories.

https://www.oreilly.com/library/view/software-architecture-patterns/9781491971437/ch01.html


### <a id="Component-PMP-Services" /></a>PMP Services

De service laag is verantwoordelijk voor de business logica, [transformeren van input naar database models](#databasemodels) en het coördineren van "externe" verbindingen.

{%
    include-markdown "../UML/Technisch/C4_Component_Services.md"
%}

<!-- *TODO: interface naar de mailserver is nog niet uitgewerkt -->

#### Toelichting Service componenten

<!-- | ISyncProductive  | addTasks(<InputTaskModel[]>), modifyTasks(<InputTaskModel[]>), removeTasks(<InputTaskModel[]>) (*)  | -->

##### Interfaces

| Interface | Example signatures |
|---|---|
| ITaskService  | addTask(InputTaskModel), editTask(InputTaskModel), deleteTask(taskId)  |
| IProjectService  | add(InputProjectModel), edit(), delete  |
| ICommentService  | add, edit, delete  |
| INotification  | processNotificationSendRequest(NotificationSendRequest)  |
| IAccountService  | signIn(username, password), sendForgotPasswordEmail(username), resetPassword(username, password, code)  |
| dbContext | De interface die gebruikt wordt met de database te communiceren, meer hier over in [het hoofdstuk over de database en verschillende models](./SoftwareArchitectureDocument.md#Component-PMP-DB) |
| [Productive REST API](./SoftwareArchitectureDocument.md#productive-api) | De officiële [Productive API](https://developer.productive.io/) die gebruikt wordt voor synchronisatie tussen het PMP en Productive. |
| Mail | De interface die wordt gebruikt om de klant op de hoogte te brengen wanneer hij/zij zich niet in het PMP bevindt is voor nu nog niet gekozen.  |

*Sync zou ook een state kunnen ontvangen en deze vergelijken met de interne state in plaats van de veranderingen van een state.

##### Namespaces*

<!-- *TODO: beter benoemen dan namespaces -->

Het Services pakket is opgesplitst in drie componenten:

| Namespace | Uitleg |
|---|---|
| Repositories | Een groep classes die als enige communicatie kanaal dienen met de database. [repository pattern*](https://www.geeksforgeeks.org/repository-design-pattern/)  |
| PMP services  | De PMP services zijn een groepering aan services die niet te maken hebben met informatie uit Productive maar enkel informatie aanwezig in het PMP.   |
| Productive services | De Productive services zijn een groepering aan services de informatie nodig hebben van of informatie moet opslaan op de externe productive omgeving.  |

<!-- *TODO: Repo pattern beter toelichten & Read operaties gebruiken nu de repository binnen de controller class terwijl voor create update en delete de verschillende services worden gebruikt. Wat is netter en waarom? -->

##### Componenten

De verschillende componenten in de bovenstaande afbeelding zijn niet compleet maar dienen als uitleg op het soort componenten aanwezig in de applicatie en de rol die ze vervullen. Belangrijke componenten die mogelijk extra toelichting nodig hebben zijn:

| Component | Uitleg |
|---|---|
| BaseService  | Dient als basis class voor de andere service classes. beheert de referentie naar de database context en rechten van de huidige gebruiker.  |
| BaseProductiveService<T\>  | Dient als basis class voor service classes die moeten synchroniseren met Productive. Doet REST calls naar de Productive API wanneer er data wordt weggeschreven naar de database context.  |
| BaseRepository<T\>  | Dient als basis voor elke repository. Biedt standaard CRUD functionaliteiten aan.  |
| NotificationService  | Biedt communicatie met de mailserver (of andere communicatie tool) aan. Moet weten wie, wat, wanneer in welke taal gestuurd moet krijgen.  |
| AccountService  | Verantwoordelijk voor het afvangen van alle inlog gerelateerde taken.  |

<!-- TODO: beantwoorden sync ding -->

- Komen de syncs binnen op de zelfde endpoints als de berichten van de front-end? (Afhankelijk van de uitwisselbaarheid van pmp domein model in vergelijking met productive model)
- Hoe wordt onderscheid gemaakt tussen de wat wel en niet gesynchroniseerd hoort te worden (A. Verschillende controllers B. flag in controller)
- Hoe kom je er achter wanneer data fout is/niet overeenkomt met productive? (A. Wanneer een gebruiker iets probeert te updaten/verwijderen dat niet bestaat)
- Voor het synchroniseren naar productive van via de FE binnen gekomen data (Heeft repositories een koppeling met Productive API zodat wanneer insert of update dit direct wordt doorgestuurd)
- Productive kan ook gewoon een repository zijn?

### <a id="Component-PMP-DB" /></a>PMP Database and Data models

De database package is verantwoordelijk voor het low level beheer van de database verbinding en het database model. De verbinding en communicatie met de database wordt afgehandeld aan de hand van MS Entity Framework.

Aangezien er op verschillende plekken van dit document over "het model" gesproken wordt is een kleine toelichting van welke models welke rollen hebben binnen het systeem. In de software zullen binnen de API, Services en Database packages aparte models te vinden zijn:


<!-- Gevraag:

Welke models heb je nodig?

Endpoint input models
Endpoint output models
Database model
Productive input model? -->

#### API.Models

De classes onder API.Models dienen als input [DTOs](https://en.wikipedia.org/wiki/Data_transfer_object) voor de verschillende REST controllers. Binnen deze models wordt aan de hand van [ASP.NET Validatie attributen](https://learn.microsoft.com/en-us/aspnet/core/mvc/models/validation?view=aspnetcore-8.0#validation-attributes) de back-end validatie gedaan om er zeker van te zijn dat er geen vreemde data naar de API wordt gestuurd.

```C#
public class ProductiveTaskInputModel
{
    private int id;
    private string type; //Type van een task is altijd een task
    //Attributes
    private string title;
    private string description;
    private int number;
    private int task_number;
    private bool is_private;
    private DateTime due_date;
    private DateTime start_date;
    private DateTime closed_at;
    private DateTime created_at;
    private DateTime updated_at;
    private int repeat_schedule_id;
    private int repeat_on_monthday;
    private int[] repeat_on_weekday;
    private DateOnly repeat_on_date;
    private int repeat_origin_id;
    private string email_key;
    private int custom_fields;
    private int todo_count;
    private int open_todo_count;
    private int subtask_count;
    private int creation_method_id;
    private int[] todo_assignee_ids;
    private int task_dependency_count;
    private int type_id;
    private int blocking_dependency_count;
    private int waiting_on_dependency_count;
    private int linked_dependency_count;
    private int placement;
    private int subtask_placement;
    private bool closed;
    private TimeOnly due_time;
    private string[] tag_list;
    private DateTime last_activity_at;
    private int initial_estimate;
    private int remaining_time;
    private int billable_time;
    private int worked_time;
    private DateTime deleted_at;

    //relationships 0-n
    private int organization_id;
    private int project_id;
    private int creator_id;
    private int assignee_id;
    private int last_actor_id;
    private int task_list_id;
    private int parent_task_id;
    private int workflow_status_id;
    private int repeated_task_id;
    private int[] attachment_ids;
    private int[] custom_field_attachment_ids;
}

```

<!-- 
    TODO: Worden relationships gewoon entiteiten? forceer ik dan de structuur van productive op de EF models? Zouden de input models uberhaupt tot de EF db models komen of blijven dit apparte definities?
    Er is ook een argument te maken binnen de input models enkel een variable met de "naam van het type" relatie vast te leggen en in dit variable het meegegeven id op te slaan. 
-->

#### Services.Models

De classes onder Services.Models dienen als output [DTOs](https://en.wikipedia.org/wiki/Data_transfer_object) voor de verschillende REST controllers.

<!-- TODO: De database models dienen ook als output?... -->

#### Database.Models

Binnen de classes van het database.Models package wordt aan de hand van annotaties de Entity Framework verbinding op gezet. Hierdoor worden wijzigingen in het datamodel meegenomen met het versiebeheer wat het potentieel terug vinden (of draaien) van problemen eenvoudiger maakt.

<!-- TODO: is niet smart -->

Navragen: in het template project hebben de controllers een dependency op database.models om de database classes te gebruiken als return type. Na gesprek met Niels is me verteld dat er doorgaans geen dependency is tussen de controller en de database models maar al deze communicatie via de services loopt. Zou het netter zijn deze dependency te verwijderen en enkel Services.Models te gebruiken als output?

<!-- ### Notification system

### Productive API -->

### <a id="Component-Notification-system"></a>Notification system

Het notificatiesysteem is verantwoordelijk voor het inlichten van gebruikers wanneer het systeem iets belangrijks te melden heeft zoals wanneer een gebruiker een actie moet ondernemen als in [FR4.1](../Functioneel/Requirements/FR4_Versturen_notificaties.md#fr41-inlichten-klant-wanneer-een-taak-wacht-op-input-van-de-klant) of bij issues met prioriteit 1(Kritiek) en 2(Hoog) als in [FR4.2](../Functioneel/Requirements/FR4_Versturen_notificaties.md#fr42-inlichten-bluenotion-bij-blockerscriticals).

De details van het notificatie systeem zijn nog niet uitgewerkt, er zal een mail client opgezet worden die gemachtigd is berichten te sturen naar de klant. Als alternatief zou ook een SMS systeem mogelijk kunnen zijn.

<!-- TODO: Details wel uitwerken -->

### <a id="Component-Productive-API"></a>Productive API

De Productive api biedt mogelijkheid om data uit Productive te halen en naar Productive te sturen. Zoals beschreven in het [FO](../Functioneel/FunctioneelOntwerp.md#domein) is Productive de tooling die Bluenotion gebruikt voor project management. De Productive API is een restful API die een aantal endpoints aanbiedt voor het uitlezen en bewerken van gegevens binnen productive. Voor de architectuur van het PMP zijn een aantal dingen belangrijk:

- De rate limits

Productive heeft om misbruik van de API te voorkomen de rate limits ingesteld. Er worden binnen de Productive API drie verschillende rate limits gehanteerd:

| Endpoint | Limiet |
|--|--|
| Reports | [10 requests in 30 sec](https://developer.productive.io/index.html#header-rate-limits) |
| Webhooks | [Opgezette webhooks sturen maximaal 1000 requests per 5 min](https://developer.productive.io/webhooks.html#webhooks) |
| De rest van de endpoints | [100 requests per 10 sec](https://developer.productive.io/index.html#header-rate-limits) |

- De beschikbare functionaliteiten

Welke functionaliteiten binnen Productive beschikbaar zijn is afhankelijk van de [aangeboden endpoints](https://developer.productive.io/index.html) en het abonnement dat Bluenotion bij Productive heeft afgesloten. Binnen het aan het begin van het project lopende abonnement zijn sommige functies (zoals meer dan 3 [custom fields](https://developer.productive.io/working_with_custom_fields.html#working_with_custom_fields) en [task dependencies](https://developer.productive.io/taskdependency.html#taskdependency)) niet beschikbaar. De opdrachtgever geeft aan dat wisselen van abonnement een optie is maar dat dit wegens hoge kosten liever niet gedaan wordt. Er zal dus gekeken moeten worden naar of en hoe alle benodigde data in Productive geplaatst kan worden zonder over deze limieten heen te gaan.

## Code

### Productive API sync



<!-- De productive API biedt webhooks om voor de volgende objecten een bericht te krijgen wanneer een create, update of delete wordt uitgevoerd.

Aparte endpoints:

{%
    include-markdown "../UML/Technisch/Sequence/C4_Code_Productive_sync_multiple.md"
%}

Om te garanderen dat het PMP alle data weergeeft dat in productive aanwezig is dient er op een zeker moment data opgehaald te worden vanuit de Productive API. Binnen dit hoofdstuk wordt de (voorlopig) gekozen aanpak voor deze synchronisatie toegelicht. Andere overwogen aanpakken en de bijhorende voor/nadelen zijn te vinden in [ADR001](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md).

Zoals beschreven in ADR001 wordt er voor "normaal" gebruik van het systeem data binnengehaald aan de hand van webhooks.

Can a bad sync happen, how would you notice and how would you solve it? -->

## Architectural Decision Records

{%
    include-markdown "../UML/Technisch/SAD_ADRs.md"
%}

Verantwoordingen toe te voegen:

- Keuze mail server
<!-- - Keuze synchronisatie op service, repository of database niveau. (database is het consistentste, service het meest flexibel. Waarom waar?) -->
- Keuze gescheiden houden van productive input controllers en user input controllers. (mocht één van de twee wijzigen mag de ander er geen last van hebben)
- Productive webhook endpoints, per "object" of event? <https://developer.productive.io/webhooks.html#webhooks>
- Basis tests met webhooks: als applicatie uit staat en aan de hand van de webhooks data naar het PMP wordt gestuurd wordt er vanuit productive automatisch een (aantal) nieuwe poging(en) gedaan om de data nogmaals te versturen. Als in de tussentijd het PMP weer draait kan het zijn dat updates over de zelfde taak in de verkeerde volgorde aankomen. Het is van belang dat er hierom gekeken wordt naar wanneer welke wijziging is gemaakt (welke timestamp?) voordat ze worden doorgevoerd.
- In het geval dat het PMP geen directe reactie krijgt van productive bij bijvoorbeeld het aanmaken van een taak dienen de taken A. niet aangemaakt te worden met een foutmelding? B. aangemaakt te worden en op een later moment gesynchroniseerd te worden?
- Filtering pagination & sorting [technisch ontwerp](./TechnischOntwerp.md#filtering-pagination-and-sorting)

Is dit wel een ADR?

<!-- - TODO: Discussie over endpoints op maat voor bepaalde views of CRUD endpoints en sorteren en filteren op de frontend. -->
