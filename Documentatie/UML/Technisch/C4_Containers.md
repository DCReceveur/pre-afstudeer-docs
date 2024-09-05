```puml

actor Klant
actor Admin

rectangle Browser{
component "React front-end" as PWA
}

component PMP{
component "PMP API" as API
component "PMP Database" as DB
component "PMP Services" as Service
}

rectangle "Notification system" as NS
database "Productive.io API" as PR_API

Klant --> PWA : HTTP(S)/JSON
Admin --> PWA : HTTP(S)/JSON
PWA --> API : HTTP(S)/JSON
Service --> DB : MS Entity framework
API-->Service
Service --> PR_API : HTTP(S)/JSON
PR_API -[norank]-> API : HTTP(S)/JSON via webhooks
Service --> NS : SMTP?

```
