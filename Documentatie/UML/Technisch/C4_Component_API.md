```puml
rectangle PMP{
rectangle "PMP API"{
    rectangle "Controllers"{
        rectangle "AccountController"
        rectangle "ProjectController"
        rectangle "TaskController"
        rectangle "CommentController"
        rectangle "ProductiveSyncController"
    }
    rectangle "Models"
}
    rectangle "Services"{
        interface "INotification"
        interface "IAccountService"
        interface "ITaskService"
        ' rectangle TaskService
        interface "IProjectService"
        ' rectangle ProjectService
        interface "ICommentService"

    }
}
    Controllers -[norank]-> Models : uses
    AccountController --> IAccountService
    TaskController --> ITaskService
    ProjectController --> IProjectService
    CommentController --> ICommentService
    ITaskService --> INotification
    IProjectService --> INotification
    ProductiveSyncController --> IProjectService
    ProductiveSyncController --> ITaskService
    ProductiveSyncController --> ICommentService
    ProductiveSyncController --> IAccountService
```
