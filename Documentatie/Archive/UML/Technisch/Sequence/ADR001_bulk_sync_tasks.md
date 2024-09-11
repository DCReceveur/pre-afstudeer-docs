```puml
title Bulk sync tasks
autonumber
participant ProductiveSyncController as prod_sync
participant ProductiveService as prod_serv
participant PersistenceService as pers_serv
database PMP_database as pmp_db
database Productive_API as prod_api

?-> prod_sync : cron job sync
prod_sync -> prod_serv : syncLocalChanges
prod_serv -> pers_serv : lc = getLocalChanges
pers_serv -> pmp_db : select where synced=0

prod_serv -> prod_api : HTTP GET 
prod_serv -> pers_serv : setToSynced(lc)**
pers_serv -> pmp_db : UPDATE/DELETE...
```