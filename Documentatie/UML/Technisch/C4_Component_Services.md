```puml
top to bottom direction
skinparam linetype ortho

interface "INotification" as INotification
interface "IAccountService"
interface "ITaskService"
interface "IProjectService"
interface "ICommentService"

' Main Services functionality
rectangle "Services"{
    rectangle "Repositories" as Repositories{
        rectangle "BaseRepository<T>" as BaseRepository
        rectangle AccountRepository
        rectangle TaskRepository
        rectangle ProjectRepository
        rectangle CommentRepository
    }
    rectangle "PMP Services"{
    rectangle "Notification service" as NotificationService
    rectangle AccountService
    rectangle ProductiveSyncService
    }
    rectangle "BaseService"
    rectangle "Productive services" as ProductiveServices{
        rectangle TaskService
        rectangle ProjectService
        rectangle CommentService
    rectangle "BaseProductiveService<T>" as ProductiveService
    }
    rectangle Models
}
' Others
interface dbContext
interface "Mail*" as Mail
interface "Productive REST API" as PRA
rectangle "Other components"{
    rectangle "Productive API" as productive
    rectangle "Mail server" as mail
    rectangle Database as db
}

' Relations to servicebases
ProductiveService-->BaseService
AccountService-[norank]->BaseService
NotificationService-[norank]->BaseService
TaskService-->ProductiveService
ProjectService-->ProductiveService
CommentService-->ProductiveService

' Interfaces to services
IAccountService-->AccountService
ITaskService-->TaskService
IProjectService-->ProjectService
ICommentService-->CommentService
INotification --> NotificationService

' Externals
BaseService --> Repositories
ProductiveService --> PRA
Repositories-->dbContext
NotificationService-->Mail

PRA-->productive
dbContext-->db
Mail-->mail

' Relations to repository
AccountRepository -->BaseRepository
TaskRepository -->BaseRepository
ProjectRepository -->BaseRepository
CommentRepository -->BaseRepository

```
