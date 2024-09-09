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