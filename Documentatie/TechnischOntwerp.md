# Technisch ontwerp

## ERD

```plantuml
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 130

rectangle "Productive"{
  
    entity Service_level_agreement{
        *Id
        --
        *Name
    }

    entity Priority{
        *Id
        --
        *Naam
    }
    entity ResponseTime{
        *Time_in_hours
    }
    entity SolvingTime{
        *Time_in_hours
    }

    Service_level_agreement .. Priority
    (Service_level_agreement, Priority) .. ResponseTime

    Service_level_agreement .. Priority
    (Service_level_agreement, Priority) .. SolvingTime

  entity Organization{
    *Id
    --
    *Tagname
  }

  entity Project{
    *Id
    --
    *Name
    *Created_at
    Last_activity_at
    Archived_at
  }

  entity Board{
    *Id
    --
    *Name
  }

  entity Task_list{
    *Id
    --
    *List_name
  }

  entity Task{
    *Id
    --
    *Title
    *Description
    *Created_at
    Due_date
    Start_date
    Due_date
    Closed_at
    Updated_at
    Parent_task_id <<FK>>
    Initial_time_estimate
    Remaining_time
    Worked_time
    Billable_time
  }

  entity Comment{
    *Id
    --
    *Created_at
    Updated_at
  }

  entity Todo{
    *Id
    --
    *Description
    *Created_at
    Closed_at

  }

  entity Company{
    *Id
    --
    *Name
  }

  entity ContactInformation{
    *Id
    --
    Phone_number
    Email
  }

  entity WorkflowStatus{
    *Id
    --
    *Name
    *Category
  }

  entity Person{
    *Id
    --
    FirstName
    LastName
    ContactDetails
  }

  entity Tag{
    *Id
    --
    Tagname
  }

  entity Attachment{
  *Id
  --
  Image
  }


  note "Bluenotion, Wilmar ect..." as orgNote
  note "Zou gebruikt kunnen worden voor doorontwikkeling vs incident" as tagNote
  note "Wie is de eigenaar van een bedrijf?" as ownerNote
  note "Category = not started, started, closed" as catNote
  Organization .... orgNote
  Tag .... tagNote
  Company .... ownerNote
  WorkflowStatus .... catNote
}

' Person ||..|| Company

Project ||..|{Board
Board ||..|{Task_list
Task_list ||..o{Task
Task ||..|{Comment :< Comment on
Task ||..|{Todo
Organization }o..|{Person :< Employee of
Organization ||..|{Project :> Developer of
Person ||..|{Task :< Assignee
Person ||..|{Task :< Creator
Person }|..||ContactInformation :< Info for
Person ||..|{Todo :< Assignee
Person ||..|{Project :> Manager of

Task ||..||Task :< Subtask of
Task }o..o{Tag
Task ||..|{Attachment
Comment ||..|{Attachment
Service_level_agreement ||..||Project
Organization ||..|{Company :< Customer of
Company ||..|{Project :> Owner of

Task ||..||WorkflowStatus

```

## Productive endpoints per scherm

| Scherm | /projects | /tasks | /people | /company | /attachments | /comments | /activities |
|--|--|--|--|--|--|--|--|
| Klant: Projecten pagina | x | x | x |  |  |  |  |
| Admin: Projecten pagina | x |  | x | x |  |  |  |
| Klant: Taken lijst |  | x | x |  |  |  |  |
| Klant: Project overzicht | x | x |  |  |  |  |  |
| Klant: Taken lijst |  | x | x |  |  |  |  |
| Klant: Taken detail |  | x | x |  | x | x | x |
| Admin: Taken lijst |  | x | x |  |  |  |  |
| Admin: Taken detail |  | x | x |  |  x | x | x |
| Klant: Documentatie pagina* |  |  |  |  |  |  |  |
| Admin: Toevoegen documentatie* |  |  |  |  |  |  |  |
| Admin: Controleren aanvraag |  | x | x |  | x | x | x |

*Waar slaan we documenten op?

Voor het uitlezen van data voor één pagina zouden bij sommige pagina's 5 verschillende Productive endpoints benaderd worden. Als volgens [NFR5.1](./FunctioneelOntwerp.md#nonfunctional-requirements) 50 gebruikers gelijktijdig bijvoorbeeld de details van een taak bekijken zou dit resulteren in 250 requests naar de Productive API. Er van uit gaande dat een pagina informatie nodig heeft van gemiddeld 3 a 4 endpoints zou de meest basale implementatie gebaseerd op directe communicatie met productive zich limiteren tot rond de 30 gelijktijdige gebruikers. (100/3.5=28.5)

## Interfaces

### REST API

Controllers worden per entiteit aangemaakt en volgen allemaal grofweg de zelfde structuur:

| Naam | Functie | Signature example |
|---|---|---|
| Find (GET) | Geeft de mogelijkheid om informatie over één van de entiteiten op te vragen op basis van een opgegeven unieke identifier.  |  ```public async Task<ActionResult<TaskModel>> Find([FromRoute] TaskId taskId)```  |
| GetAll (GET) | Levert alle entiteiten van het type aan die de gebruiker gemachtigd is te bekijken.  | ```public async Task<ActionResult<TasksModel>> GetAll()```  |
| Post (POST) | Endpoint om nieuwe entiteiten van het type aan te maken.  |  ```public async Task<ActionResult<TasksModel>> AddBookingWithActivity([FromBody] AddTaskModel model, CancellationToken cancellationToken)``` |
| Patch (PATCH)* | Endpoint om bestaande entiteiten op basis van hun unieke identificatie te wijzigen.  |  ```public async Task<ActionResult<TasksModel>> AddBookingWithActivity([FromBody] AddTaskModel model, CancellationToken cancellationToken)``` |
| Delete (DELETE) | Endpoint om bestaande entiteiten te verwijderen  | ```public async Task<NoContentResult> DeleteActivityAdmin([FromRoute] TaskId taskId, CancellationToken cancellationToken)```  |

TODO?: Een redenatie toevoegen over patch vs put?

#### filtering pagination & sorting

TODO: Vastleggen zodra ADR001 Decided is.

Afhankelijk van [ADR001](/Documentatie/Decisions/Architecture/ADR001-Communicatie_met_de_Productive_API.md) zou er voor de PMP API gekeken moeten/kunnen worden naar filtering en pagination voor de RESTful endpoints. Bij de endpoints zoals aangeleverd door de Productive API op alle endpoints beiden filters en paginatie beschikbaar. Hiermee kunnen de hoeveelheid en welke records records die in een keer verstuurd worden beperkt worden en dus kunnen dus de reactiesnelheid en flexibiliteit van de endpoints vergroten. Met het voorlopig besluit van [ADR001-O2](/Documentatie/Decisions/Architecture/ADR001-Communicatie_met_de_Productive_API.md#o2-continu-synchroniserende-backend-database-aan-de-hand-van-webhooks) waar het PMP een eigen database heeft waar de meeste productive data aan de hand van webhooks gesynchroniseerd wordt naar de lokale PMP database zouden filters en paginatie op de endpoints het uiteindelijke dataverkeer sterk verminderen.

Om een grove schatting te maken van hoe nodig het inperken van de endpoint responses kan gekeken worden naar de resultaten van het pollen van endpoints voor een van de (wat grotere) projecten bij Bluenotion als te vinden in [OND01 Productive Sync](/Documentatie/Onderzoek/OND01-ProductiveSync.md#polling-adr001-o1) waar aan één project 845 taken gekoppeld zijn waar voor het opsturen van de data 939ms (voor 1 pagina) nodig was. 

Door hier extra filters aan te hangen voor enkel het doorsturen van bijvoorbeeld taken die niet closed zijn of gekoppeld zijn aan een bepaald bord of takenlijst zou de filtertijd mogelijk wel vergroot worden maar de hoeveelheid te versturen data zou verminderen.

| Aanvraag | Resultaat | Uitleg |
|---|---|---|
| <https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877>  | 5 pagina's met 200 records van +/-438 KB met gemiddelde reactietijd van +/-900ms  | Zo veel mogelijk taken voor een midden groot project zoals gebruikt in [OND01 Productive Sync](/Documentatie/Onderzoek/OND01-ProductiveSync.md#polling-adr001-o1). |
| <https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877&filter[status]=1> | 1 pagina met 77 records van +/-272 KB met gemiddelde reactietijd van +/-600ms  | Zelfde taken maar met filter die gesloten taken weg laat. |
| <https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877&filter[status]=1&filter[task_list_name]=backlog>  | 1 pagina met 7 records van +/-73KB met gemiddelde reactietijd van +/-350ms   | De zelfde taken maar met filter die gesloten taken weg laat en enkel taken terug geeft die op de backlog staan.  |

Met enkel deze filters zou [FR2.2](/Documentatie/Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) naast de feedback intern+extern al geïmplementeerd kunnen worden. Het filteren van de taken op feedback nodig van Bluenotion of de klant zouden zoals beschreven in het FO bij de [Toelichting statuses](/Documentatie/FunctioneelOntwerp.md#toelichting-statuses) kunnen gebeuren op basis de [workflow_status_id](https://developer.productive.io/tasks.html#header-supported-filter-params) filter kunnen gebeuren.

Met oog op de [schermontwerpen](/Documentatie/FunctioneelOntwerp.md#scherm-ontwerpen) ligt het maximale aantal van de zelfde items items dat op één pagina in een keer geladen moet worden niet veel hoger dan 15. Als er gebruik gemaakt gaat worden van een lokale database voor de productive data zoals beschreven in [ADR001-O2](/Documentatie/Decisions/Architecture/ADR001-Communicatie_met_de_Productive_API.md#o2-continu-synchroniserende-backend-database-aan-de-hand-van-webhooks) zou sortering, filtering en pagination op API endpoint niveau een waardevolle toevoeging kunnen zijn aan het project.


<!-- https://learn.microsoft.com/en-us/aspnet/core/mvc/controllers/filters?view=aspnetcore-8.0 -->
<!-- https://medium.com/@alrazak/pagination-and-filtering-in-rest-api-9fc4643d9cfe -->

### Services

De servicelaag biedt een aantal interfaces aan om met domein entiteiten te werken. Binnen de servicelaag wordt een vertaalslag gedaan van input model naar het database model zodat er geen directe koppeling bestaat tussen de database en de front-end (Zie [SAD data modellen hoofdstuk](/Documentatie/SoftwareArchitectureDocument.md#databasemodels)). Verder heeft de servicelaag de verantwoordelijkheid de juiste resources aan te spreken voor bijvoorbeeld het synchroniseren van Productive resources naar de database of aanroepen van de notificatie manager wanneer er een notificatie gestuurd moet worden.

Aangezien de services de domein logica afhandelen zullen verschillende service interfaces ook verschillende signatures krijgen. De basis van de services blijft wel over de meeste services gelijk. Om de scheiding tussen tussen de front-end en database in stand te houden krijgt entity service een Find, GetAll, Add, Update en Delete endpoint. Die vanuit verschillen de andere controllers en services aangeroepen kunnen worden.

Een voorbeeld van de signatures van ITaskService zou er als volgt uit zien:
public async Task<ActionResult<TaskModel>> Find(int taskId)
public async Task<ActionResult<TasksModel>> GetAll()
public async Task<ActionResult<TaskModel>> AddTask(AddTaskModel model)
public async Task<ActionResult<TaskModel>> UpdateTask(UpdateTaskModel model)
public async Task<ActionResult<boolean>> DeleteTask(int taskId)

```plantuml

package Interfaces{
  interface "INotification" as IN
  interface "IAccountService" as IA
  interface "ITaskService" as IT
  interface "IProjectService" as IP
  interface "ICommentService" as IC
}

package Services{
  class TaskService{
    -TaskRepository
    +Find(int Id)
    +GetAll()
    +Add(AddTaskModel)
    +Update(UpdateTaskModel)
    +Delete(int TaskId)
  }
  class NotificationService{
    -LogRepository
  }
  class AccountService{
    -AccountRepository
    +Find(int Id)
    +GetAll()
    +Add(AddAccountModel)
    +Update(UpdateAccountModel)
    +Delete(int AccountId)
  }
  class ProjectService{
    -ProjectRepository
    +Find(int Id)
    +GetAll()
    +Add(AddProjectModel)
    +Update(UpdateProjectModel)
    +Delete(int ProjectId)
  }
  class CommentService{
    -CommentRepository
    +Find(int Id)
    +GetAll()
    +Add(AddCommentModel)
    +Update(UpdateCommentModel)
    +Delete(int CommentId)
  }
  
}

package Repositories{
  class AccountRepository
  class TaskRepository
  class ProjectRepository
  class CommentRepository
  class LogRepository
  class "BaseRepository<T>" as BaseRepository{
    Get(int Id)
    GetAll()
    Add(TAddModel model)
    Update(TUpdateModel model)
    Delete(TDeleteModel model)

  }
}

package ExchangeServer{
  class MailClient
}


IN<|--NotificationService
IA<|--AccountService
IT<|--TaskService
IP<|--ProjectService
IC<|--CommentService

AccountRepository--|>BaseRepository
TaskRepository--|>BaseRepository
ProjectRepository--|>BaseRepository
CommentRepository--|>BaseRepository
LogRepository--|>BaseRepository

AccountService-->AccountRepository
TaskService-->TaskRepository
ProjectService-->ProjectRepository
CommentService-->CommentRepository
NotificationService-->MailClient
NotificationService-->LogRepository : *TODO: Betere logging procedure opzetten

```

*TODO: Betere logging procedure opzetten

<!-- #### IProjectService

#### ICommentService

#### INotification

#### IAccountService

ITaskService	addTask(InputTaskModel), editTask(InputTaskModel), deleteTask(taskId)
IProjectService	add, edit, delete
ICommentService	add, edit, delete
INotification	processNotificationSendRequest(NotificationSendRequest)
IAccountService	signIn(username, password), sendForgotPasswordEmail(username), resetPassword(username, password, code)

AccountController	Verantwoordelijk voor endpoints met betrekking tot inloggen of account management
ProjectController	Verantwoordelijk voor endpoints met betrekking tot Projecten of project management
TaskController	Verantwoordelijk voor endpoints met betrekking tot Taken of taak management
CommentController	Verantwoordelijk voor endpoints met betrekking tot Comments op taken (bijlages?).
ProductiveSyncController	Verantwoordelijk voor endpoints met betrekking tot communicatie met de Productive API en de bijhorende webhooks. -->

### DB?