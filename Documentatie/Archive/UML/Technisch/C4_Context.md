```puml

actor Klant
actor Admin

rectangle "Productive (API)" as productive
rectangle "Messaging system" as message
rectangle "Project Management Portal" as PMP
rectangle "PMP Database" as DB
' rectangle "PMP database" as BE_DB
Klant --> PMP : "Manages projects in                           "
Admin --> PMP : "Validates tasks in           "

PMP --> productive : "Retrieves project data from"
' PMP --> BE_DB : "Caches project data in"
PMP --> message : "Informs customers using"
PMP--> DB

```