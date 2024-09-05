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