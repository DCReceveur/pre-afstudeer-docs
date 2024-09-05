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
