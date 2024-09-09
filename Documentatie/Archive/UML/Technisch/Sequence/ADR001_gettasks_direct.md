```puml
title getTasks 'direct'
autonumber
participant TaskController as task
participant ProductiveService as prod_serv
database Productive_API as prod_api

?-> task : UI request
task --> prod_serv : getTasks(projectId)
prod_serv -->prod_api : http GET

```
