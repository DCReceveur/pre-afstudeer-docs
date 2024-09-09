# Technisch ontwerp

## Data model

Data binnen het PMP is afkomstig uit twee bronnen, onderstaand is een korte toelichting op de bronnen, welke data er vandaan komt en hoe de koppeling ligt tussen de twee bronnen.

- Productive API

Binnen Productive wordt door developers gewerkt aan een project aan de hand van taken. Het PMP dient op de hoogte te zijn van de status van deze taken.

- Interne PMP database

De interne PMP database wordt gebruikt om extra data te koppelen aan Productive taken waar dit binnen productive niet mogelijk of praktisch is. Denk hierbij aan prioriteiten en koppelingen tussen klant accounts en verschillende projecten.

| Entiteit | Productive | PMP |
|---|---|---|
| Tickets | - Productive task id </br>- Productive project id</br>- Title</br>- Description</br>- Inschatting</br>- Dependency task_id's</br>- Of één van de partijen feedback moet geven op een taak? (custom field)</br>- Datum ingediend</br>- Datum laatste update | - Productive task id + PMP task id + last updated (sync record?)</br>- Productive project id</br>- PMP task+project id</br>- Prioriteit/urgentie/impact</br>- Ingediend door</br>- Type (Doorontwikkeling of issue) |
| Taken | - Productive task id</br>- Productive project id</br>- Title</br>- Description</br>- Inschatting</br>- Dependency task_id's</br>- Of één van de partijen feedback moet geven op een taak?</br>- Datum ingediend</br>- Datum laatste update | - Productive task id + PMP task id + last updated (sync record?)</br>- Productive project id</br>- PMP task+project id</br>- Prioriteit/urgentie/impact</br>- Ingediend door</br>- Type (Doorontwikkeling of issue) |
| Projecten | - Productive project id</br>- Title</br>- Archived? | - Project beheerders + medewerkers</br>- Project status (archived?) |

### Productive datamodel



Intern:

```puml
title Essential productive data
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 120

rectangle "Productive" {
  class Project {
    project_id
    name
    updated_on
  }
  
  class Task {
    task_id
    title
    description
    task_list_id
    status_id
    updated_on
    created_on
  }

  class Attachment{
    id
    url
  }
  
  class Task_list {
    task_list_id
    name
    board_id
  }
  
  class Board {
    board_id
    name
    project_id
  }
  
  class Status {
    status_id
    name
  }

  class CustomField{
    custom_field_id
    value
  }

  class Comment {
    comment_id
    content
    task_id
  }
}

class Ticket{
  id
  name
  description
  productive_id
  updated_on
  created_on
}

' Klant beheert project
Klant "1"--"0..1" Project :> Eigenaar van
Klant "1..*"--"0..*" Project :> Beheerder van

' Klant Ticket
Klant "1"--"0..*" Ticket :> Maakt een
Ticket "1"--"0..*" Task :> Resulteert in

Task "0..*" -- "1" Task_list : > Weggeschreven op
Task_list "0..*" -- "1" Board : < Onderdeel van

Task "0..*" -- "1" Status :< Van
Board "1..*" -- "1" Project :> Voor

Task "1" -- "0..*" Comment :< Heeft
Task "0..*" -- "1" CustomField

Task "0..*" -- "0..*" Task :> Depends on

Attachment -- Task
Attachment -- Comment

```


### PMP datamodel

```puml
title Essential PMP data
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 120

rectangle Productive{
    class "Task" as productive_task
    class "Project" as productive_project
    class "Attachment" as productive_attachment
    class "Comment" as productive_comment
}

rectangle PMP{
    class Ticket{
        Guid id
        int productive_id
        Type
        datetime last_updated_at
    }
    note right
        Refers to Productive Task
    end note
    class Task{
        Guid id
        int productive_id
        datetime last_updated_at
    }
    note right
        Refers to Productive Task
    end note
    class Bedrijf{
        Guid id
    }
    class Prioriteit{
        int urgentie
        int impact
    }
    class Klant{
        Guid id
        String voornaam
        String achternaam
        String email
    }
    class Project{
        Guid id
        int productive_id
        datetime last_updated_at
    }
    note right
        Refers to Productive Project. 
        Last updated needed? 
        Volgens mij zou alleen de naam kunnen veranderen?
    end note
}

Klant "1..*"--"0..*" Project :> Beheerder van
Klant "1..*"--"0..*" Bedrijf :> Beheerder van
Project "0..*"--"1" Bedrijf :> Uitgevoerd voor
Klant "1"--"0..*" Ticket :> Maakt een
Ticket "1"--"0..*" Task :> Resulteert in
Ticket "0..*"--"1" Project :> Werk voor
Ticket "0..*" -- "1" Prioriteit :> Ingediend met

Task "1"--"1" productive_task :> Links to
Ticket "1"--"1" productive_task :> Links to
Project "1"--"1" productive_project :> Links to

productive_comment -- productive_task :> placed on
productive_attachment -- productive_task :> bijlagen op
productive_attachment -- productive_comment :> bijlagen op

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

Voor het uitlezen van data voor één pagina zouden bij sommige pagina's 5 verschillende Productive endpoints benaderd worden. Als volgens [NFR5.1](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) 50 gebruikers gelijktijdig bijvoorbeeld de details van een taak bekijken zou dit resulteren in 250 requests naar de Productive API. Er van uit gaande dat een pagina informatie nodig heeft van gemiddeld 3 a 4 endpoints zou de meest basale implementatie gebaseerd op directe communicatie met productive zich limiteren tot rond de 30 gelijktijdige gebruikers. (100/3.5=28.5)

## Interfaces

### REST API

Controllers worden per entiteit aangemaakt en volgen allemaal grofweg de zelfde structuur:

| Naam | Functie | Signature example |
|---|---|---|
| Find (GET) | Geeft de mogelijkheid om informatie over één van de entiteiten op te vragen op basis van een opgegeven unieke identifier.  |  ```public async Task<ActionResult<TaskModel>> Find([FromRoute] TaskId taskId)```  |
| GetAll (GET) | Levert alle entiteiten van het type aan die de gebruiker gemachtigd is te bekijken.  | ```public async Task<ActionResult<TasksModel>> GetAll()```  |
| Post (POST) | Endpoint om nieuwe entiteiten van het type aan te maken.  |  ```public async Task<ActionResult<TasksModel>> AddBookingWithActivity([FromBody] AddTaskModel model, CancellationToken cancellationToken)``` |
| Patch (PATCH) | Endpoint om bestaande entiteiten op basis van hun unieke identificatie te wijzigen.  |  ```public async Task<ActionResult<TasksModel>> AddBookingWithActivity([FromBody] AddTaskModel model, CancellationToken cancellationToken)``` |
| Delete (DELETE) | Endpoint om bestaande entiteiten te verwijderen  | ```public async Task<NoContentResult> DeleteActivityAdmin([FromRoute] TaskId taskId, CancellationToken cancellationToken)```  |

<!-- TODO?: Een redenatie toevoegen over patch vs put? -->

optie:

endpoints ontwerpen zoals de repositories zodat filtering op de endpoints zelf toegepast kan worden.

<!-- TODO: endpoint voorstellen nalopen -->

GET /projects

```C#
List[ProjectModel] getProjects(ProjectSearchInputModel inputmodel){}

ProjectSearchInputModel{
  maybe Guid pmp_project_id
  maybe int productive_id //Is dit nodig?
  maybe Guid customer_id
  boolean force_productive_sync
}

ProjectRowItemModel{
  Guid pmp_project_id
  String name
  boolean actie_vereist
}
```

/tickets

```C#
GET /tickets
List[TicketRowItemModel] getTickets(TicketSearchInputModel inputmodel){}

GET /tickets/{id} //Detail kan ook naar zijn eigen slug. /ticket oid?
List[TicketDetailModel] getTickets(TicketSearchInputModel inputmodel){}

TicketSearchInputModel{
  maybe Guid Pmp_Id
  maybe int Productive_Id //Is dit nodig?
  maybe Guid Customer_Id
  maybe Guid Project_Id
  maybe boolean Action_required
  boolean Force_Productive_Sync
}

TicketRowItemModel{
  Guid pmp_ticket_id
  String name
  boolean actie_vereist
  String beschrijving
  String type
  int prioriteit
  String status //waarschijnlijk geen string
  datetime created_at
  datetime updated_at
}

TicketDetailModel{
  Guid pmp_ticket_id
  String name
  boolean actie_vereist
  String beschrijving
  String type
  int prioriteit
  String status //waarschijnlijk geen string
  datetime created_at
  datetime updated_at

  int impact
  int urgentie
  String prioriteit
  int inschatting
  String aangemaakt_door //Customer ID?

  task dependency graph? //TODO: Bijwerken na gesprek UX 10-09
  //Comments, screenshots en log is extra api call?

}
```

GET /onboarding_tasks

```C#
List[OnboardingTaskModel] getOnboardingTasks(OnboardingTasksSearchInputModel inputmodel){}

OnboardingTasksSearchInputModel{
  maybe Guid Pmp_Id
  maybe Guid Customer_Id
  maybe Guid Project_Id
  maybe boolean Action_required
}
```

#### filtering pagination and sorting

<!-- TODO: Vastleggen zodra ADR001 Decided is. -->

Afhankelijk van [ADR001](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md) zou er voor de PMP API gekeken moeten/kunnen worden naar filtering en pagination voor de RESTful endpoints. Bij de endpoints zoals aangeleverd door de Productive API op alle endpoints beiden filters en paginatie beschikbaar. Hiermee kunnen de hoeveelheid en welke records records die in een keer verstuurd worden beperkt worden en dus kunnen dus de reactiesnelheid en flexibiliteit van de endpoints vergroten. Met het voorlopig besluit van [ADR001-O2](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md#o2-continu-synchroniserende-backend-database-aan-de-hand-van-webhooks) waar het PMP een eigen database heeft waar de meeste productive data aan de hand van webhooks gesynchroniseerd wordt naar de lokale PMP database zouden filters en paginatie op de endpoints het uiteindelijke dataverkeer sterk verminderen.

Om een grove schatting te maken van hoe nodig het inperken van de endpoint responses kan gekeken worden naar de resultaten van het pollen van endpoints voor een van de (wat grotere) projecten bij Bluenotion als te vinden in [OND01 Productive Sync](../Onderzoek/OND01-ProductiveSync.md#polling-adr001-o1) waar aan één project 845 taken gekoppeld zijn waar voor het opsturen van de data 939ms (voor 1 pagina) nodig was.

Door hier extra filters aan te hangen voor enkel het doorsturen van bijvoorbeeld taken die niet closed zijn of gekoppeld zijn aan een bepaald bord of takenlijst zou de filtertijd mogelijk wel vergroot worden maar de hoeveelheid te versturen data zou verminderen.

| Aanvraag | Resultaat | Uitleg |
|---|---|---|
| <https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877>  | 5 pagina's met 200 records van +/-438 KB met gemiddelde reactietijd van +/-900ms  | Zo veel mogelijk taken voor een midden groot project zoals gebruikt in [OND01 Productive Sync](../Onderzoek/OND01-ProductiveSync.md#polling-adr001-o1). |
| <https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877&filter[status]=1> | 1 pagina met 77 records van +/-272 KB met gemiddelde reactietijd van +/-600ms  | Zelfde taken maar met filter die gesloten taken weg laat. |
| <https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877&filter[status]=1&filter[task_list_name]=backlog>  | 1 pagina met 7 records van +/-73KB met gemiddelde reactietijd van +/-350ms   | De zelfde taken maar met filter die gesloten taken weg laat en enkel taken terug geeft die op de backlog staan.  |

Met enkel deze filters zou [FR2.2](../Functioneel/Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) naast de feedback intern+extern al geïmplementeerd kunnen worden. Het filteren van de taken op feedback nodig van Bluenotion of de klant zouden zoals beschreven in het FO bij de [Toelichting statuses](../Functioneel/FunctioneelOntwerp.md#toelichting-statuses) kunnen gebeuren op basis de [workflow_status_id](https://developer.productive.io/tasks.html#header-supported-filter-params) filter kunnen gebeuren.

Met oog op de [schermontwerpen](../Functioneel/Schermontwerpen.md) ligt het maximale aantal van de zelfde items items dat op één pagina in een keer geladen moet worden niet veel hoger dan 15. Als er gebruik gemaakt gaat worden van een lokale database voor de productive data zoals beschreven in [ADR001-O2](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md#o2-continu-synchroniserende-backend-database-aan-de-hand-van-webhooks) zou sortering, filtering en pagination op API endpoint niveau een waardevolle toevoeging kunnen zijn aan het project.

<!-- https://learn.microsoft.com/en-us/aspnet/core/mvc/controllers/filters?view=aspnetcore-8.0 -->
<!-- https://medium.com/@alrazak/pagination-and-filtering-in-rest-api-9fc4643d9cfe -->

### Services

De servicelaag biedt een aantal interfaces aan om met domein entiteiten te werken. Binnen de servicelaag wordt een vertaalslag gedaan van input model naar het database model zodat er geen directe koppeling bestaat tussen de database en de front-end (Zie [SAD data modellen hoofdstuk](./SoftwareArchitectureDocument.md#databasemodels)). Verder heeft de servicelaag de verantwoordelijkheid de juiste resources aan te spreken voor bijvoorbeeld het synchroniseren van Productive resources naar de database of aanroepen van de notificatie manager wanneer er een notificatie gestuurd moet worden.

Aangezien de services de domein logica afhandelen zullen verschillende service interfaces ook verschillende signatures krijgen. De basis van de services blijft wel over de meeste services gelijk. Om de scheiding tussen tussen de front-end en database in stand te houden krijgt entity service een Find, GetAll, Add, Update en Delete endpoint. Die vanuit verschillen de andere controllers en services aangeroepen kunnen worden.

<!-- Een voorbeeld van de signatures van ITaskService zou er als volgt uit zien:
public async Task<ActionResult<TaskModel>> Find(int taskId)
public async Task<ActionResult<TasksModel>> GetAll()
public async Task<ActionResult<TaskModel>> AddTask(AddTaskModel model)
public async Task<ActionResult<TaskModel>> UpdateTask(UpdateTaskModel model)
public async Task<ActionResult<boolean>> DeleteTask(int taskId) -->

```puml
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

### Synchronisatieservice

De synchronisatieservice heeft twee verantwoordelijkheden: Het opzetten en onderhouden van de webhooks en het aanbieden van een mogelijkheid om handmatig een synchronisatie procedure te starten voor bijvoorbeeld de initiële setup of disaster recovery.

Aangezien dit een essentieel onderdeel is van het PMP is het totstandkomings proces en ontwerp van de synchronisatieservice vastgelegd in [Onderzoek 1 Productive sync](../Onderzoek/OND01-ProductiveSync.md)

### DB