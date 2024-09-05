```puml

rectangle "ADR001-O2-Continu synchroniserende backend database aan de hand van Webhooks" as ADR001 #Orange
rectangle "ADR002-O1-React native" as ADR002 #Green
rectangle "ADR003-O1-asp.net core" as ADR003 #Green
rectangle "ADR004-Database system-O1-SQL" as ADR004 #Orange
rectangle "ADR005-Database-ORM"
rectangle "ADR006-Frontend backend Communicatie"
rectangle "ADR007-MVC Design pattern"
rectangle "ADR008-Taak Mijlpalen"
rectangle "ADR010-Authentication" #Orange
rectangle "ADR?-filtering pagination & sorting" as Sorting


ADR001 <-- Sorting : Depends on

legend left
    | Color | Status |
    |<#Orange>| Proposed |
    |<#Green>| Accepted |
    |<#Red>| Rejected |
    | <#LightSlateGray> | Deprecated |
    | <#Maroon> | Superseded by |
endlegend

```