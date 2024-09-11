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