```puml
title sync from productive sync controller
ProductiveSyncController-->ISyncProductive : result = processSyncRequest(obj)
ISyncProductive-->Repository: result = add(obj)
Repository-->Database: result = commit()
' Database-->Repository
' Repository-->ISyncProductive
' ISyncProductive-->ProductiveSyncController

```

Samengevoegde endpoints:

```puml
title sync from FE endpoints
TaskController-->ITaskService:addTask(obj)

ITaskService-->ProductiveService:add(obj)
note over ProductiveService
    Uitdaging bij hergebruik controllers: 
    Niet data afkomstig van Productive 
    nogmaals terug sturen naar Productive.
end note 
ITaskService-->Repository:add(obj)
```

```puml
title Sync from FE endpoints without local save but with logging?

TaskController-->ITaskService:addTask(task)
ITaskService-->"TaskRepository":asyncAddPmpTaskEvent(task)
ITaskService-->"Productive REST API":async POST task
ITaskService<--"Productive REST API":HTTP201
ITaskService-->"TaskRepository":asyncAddTask(task)
ITaskService-->"TaskRepository":asyncMarkTaskEventHandled(task?)
ITaskService-->TaskController:HTTP201

```

<!-- TODO: Is het hele tmp task event verhaal nodig? -->

```puml
title hooked sync

TaskController --> ITaskService:addTask(task)
ITaskService --> TaskRepository:asyncAddTask(task)


```
