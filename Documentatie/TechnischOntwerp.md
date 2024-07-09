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

optie:

endpoints ontwerpenzoals de repositories zodat filtering op de endpoints zelf toegepast kan worden.

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

<!-- Een voorbeeld van de signatures van ITaskService zou er als volgt uit zien:
public async Task<ActionResult<TaskModel>> Find(int taskId)
public async Task<ActionResult<TasksModel>> GetAll()
public async Task<ActionResult<TaskModel>> AddTask(AddTaskModel model)
public async Task<ActionResult<TaskModel>> UpdateTask(UpdateTaskModel model)
public async Task<ActionResult<boolean>> DeleteTask(int taskId) -->

```plantuml
 left to right direction
package api{
  package Controllers{
    class "ProjectController" as Project_Controller
    class "TaskController" as Task_Controller
    class "AccountController" as Account_Controller
  }
  package Interfaces{
    interface "IAccountService" as IAccount_Service
    interface "ITaskService" as ITask_Service
    interface "IProjectService" as IProject_Service
    interface "ICommentService" as IComment_Service
    interface "INotificationService" as INotification_Service
    interface "IBijlageService" as IBijlage_Service
  }
}


package Services{

  package Interfaces{
  interface "IAccountRepository" as IAccount_Repository
  interface "ITaskRepository" as ITask_Repository
  interface "IProjectRepository" as IProject_Repository
  interface "ICommentRepository" as IComment_Repository
  interface "ILogRepository" as ILog_Repository
  }
  package service{
    class TaskService{
      -ITask_Repository
      addTaskToProject(TaskInputModel, ProjectId)
      ChangeTaskStatus(TaskInputModel)
    }
    class NotificationService{
      -ILogRepository
      +SendEmailNotification(Template, data)
    }

    class AccountService{
      -IAccount_Repository
    }
    class ProjectService{
      -IProject_Repository
    }
    class CommentService{
      -IComment_Repository
      +AddComment()
      +ModifyComment()
      +DeleteComment()
    }
    class BijlageService{
      -ITask_Repository
      -IComment_Repository
    }
    class SynchronizationService{
      +ManualSynchronization()
      +RunWebhooks()
    }
  }
}


package Repositories{
  class AccountRepository<Account>
  class TaskRepository<Task>
  class ProjectRepository<Project>
  class CommentRepository<Comment>
  class LogRepository<Log>
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


' Services.interfaces ordening
IAccount_Repository -[hidden]- ITask_Repository
ITask_Repository -[hidden]- IProject_Repository
IProject_Repository -[hidden]- IComment_Repository
IComment_Repository -[hidden]- ILog_Repository

' API.Interfaces ordening
IAccount_Service -[hidden]- ITask_Service
ITask_Service -[hidden]- IProject_Service
IProject_Service -[hidden]- IComment_Service
IComment_Service -[hidden]- INotification_Service
INotification_Service -[hidden]- IBijlage_Service

' Controller.Interfaces ordening

CommentService -[hidden]- NotificationService

Project_Controller -[hidden]- Task_Controller
Task_Controller -[hidden]- Account_Controller

' Repositories ordening
AccountRepository -[hidden]- TaskRepository
TaskRepository -[hidden]- ProjectRepository
ProjectRepository -[hidden]- CommentRepository
CommentRepository -[hidden]- LogRepository

' Service ordening
' AccountService
AccountService -[hidden]->TaskService
TaskService -[hidden]->ProjectService
ProjectService -[hidden]->CommentService
CommentService -[hidden]->NotificationService
NotificationService -[hidden]->BijlageService

' Service inheritance 

IAccount_Service<|--AccountService
ITask_Service<|--TaskService
IProject_Service<|--ProjectService
IComment_Service<|--CommentService
INotification_Service<|--NotificationService
IBijlage_Service<|--CommentService

' Repositories inheritance 

IAccount_Repository<|--AccountRepository
ITask_Repository<|--TaskRepository
IProject_Repository<|--ProjectRepository
IComment_Repository<|--CommentRepository
ILog_Repository<|-- LogRepository

AccountRepository--|>BaseRepository
TaskRepository--|>BaseRepository
ProjectRepository--|>BaseRepository
CommentRepository--|>BaseRepository
LogRepository--|>BaseRepository

' Service dependencies

IAccount_Repository<--AccountService
ITask_Repository<--TaskService
IProject_Repository<--ProjectService
IComment_Repository<--CommentService
ILog_Repository<--NotificationService
ITask_Repository<--BijlageService
IComment_Repository<--BijlageService

' Controller dependencies

Project_Controller -LEFT-> IAccount_Service
Task_Controller -LEFT-> ITask_Service
Project_Controller -LEFT-> IProject_Service
Task_Controller -LEFT-> IComment_Service
Account_Controller -LEFT-> IAccount_Service





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

### SynchronizationService

Afhankelijk van ADR001-Communicatie met de Productive API heeft de synchronisatie service een aantal verschillende rollen:

- Een manier van verificatie bieden of data gevonden in het PMP overeen komt met data gevonden in het project management systeem.

TODO: Procedure uittekenen

- Handmatige synchronisatie starten waarmee de initiële dataset wordt binnengehaald.

TODO: Procedure uittekenen

- Het opzetten en in stand houden van webhooks die gebruikt kunnen worden om wijzigingen door te geven aan het PMP.

De voorlopige opzet maakt gebruik van een initiële dataset en webhooks om data van Productive over te nemen naar de lokale PMP database. Door de data uit Productive naar een eigen database te halen krijgen we controle over de rate limits en dus schaalbaarheid van de applicatie.*

*Geeft dit een onveiliger systeem ivm meer user input?

Is er een initiële dataset nodig?

Ja: De procedure zoals beschreven in ADR001-O4 resulteert in 2 of 3 database calls (lokaal en binnen de Productive API) voor één data vraag. Aangezien deze calls relatief dure/langzame operaties zijn zou een procedure waar enkel de "nodige" data uit Productive wordt gehaald resulteren in een tragere applicatie. Aangezien de datum gevonden in de eerste request als input dient voor de rest van de data requests moet de verzameling van deze data sequentieel gebeuren waardoor de snelheid van de applicatie nog verder zou afnemen en mogelijk boven het limiet zoals beschreven in [NFR3.1 en NFR3.2](/Documentatie/FunctioneelOntwerp.md#nonfunctional-requirements) zou komen.

Nee: Technisch gezien niet, er zou puur op aanvraag data verzameld kunnen worden.

Omdat het verzamelen en tonen van accurate data afkomstig uit Productive een van de hoofd functionaliteiten is het van belang dat de synchronisatie module goed functioneert. Om deze reden wordt een prototype opgezet die volgens de voorgestelde oplossing [(ADR001-O2)](/Documentatie/Decisions/Architecture/ADR001-Communicatie_met_de_Productive_API.md#o2-continu-synchroniserende-backend-database-aan-de-hand-van-webhooks) aan de hand van webhooks een lokale database gesynchroniseerd houdt. De volgende eisen zijn opgesteld voor het prototype:

Phase 1:

- Vraag: Hoe dicht in de buurt van de webhook limits komt het dagelijks gebruik van Bluenotion? 1000 per 5 min
- Vraag: Kan een systeem op basis van webhooks foutieve informatie ontdekken en herstellen?
- Is er een initiële dataset nodig?

Phase 2:

- POC: Zet een procedure op die bij Productive kijkt of de webhooks actief zijn en indien dit niet het geval is webhooks kan activeren.
- POC: Zet een procedure op die aan de hand van webhooks één project passief op hoogte houdt met wijzigingen binnen Productive. (create, update delete webhooks on at least task & project)
- POC: Zet een aantal API endpoints op die (tijdelijke) Project/Taak data accepteren en doorsturen naar Productive via de Productive REST APi
- POC: (afhankelijk initiële dataset vraag) Zet een procedure op die voor één project alle voor het PMP relevante Project en taak informatie ophaalt.*
*Dit is een grote. Er zou voor een initiële dataset veel data (boven de api limits) aan Productive gevraagd moeten worden.

Now make it crack.

Phase 3:

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

*Is dit concreet testbaar? Mogelijk met integratietests?

1. Set up webhook
2. Post data to productive
3. Verify webhook trigger
4. Verify database

### DB