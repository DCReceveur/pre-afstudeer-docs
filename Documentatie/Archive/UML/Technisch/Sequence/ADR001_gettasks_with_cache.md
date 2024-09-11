<!-- 
Om er voor te zorgen dat niet elke keer dat het dashboard wordt geopend een aanvraag gedaan moet worden voor de projecten is het een optie deze periodiek op te halen.



```puml
title bad flowchart update on dashboard
| User |
start
:Opens PMP dashboard;
| FE Module |
: Requests projects list for user;
| PMP API |
:Checks local database for Projects and Tasks belonging to the user;
if (All projects found up to date) then (yes)
:Send project data to FE;
| FE Module |
:Displays "Overige projecten" list;
stop
| PMP API |
else (Projects need to be updated)
| Productive API |
:GET Tickets for project which need a update;
| PMP API |
: Transform Productive data to PMP formats;
| PMP Database |
:Add new Ticket data ;
| FE Module |
:Displays "Overige projecten" list;
stop

``` -->

<!-- Old ADR001-O5 -->


```puml
title get tickets by project id with cache
TicketController -> TicketService : GetTicketsByProjectId([id])
TicketService -> TicketRepository : GetByProjectId([id])
    alt "Project found && !Refresh needed"
            note right
                Refresh needed = last_synced-datetime.now>refresh_required_interval
            end note
        TicketService <- TicketRepository : Tickets
        TicketController <- TicketService : Tickets
    else "Project not found || Refresh needed"
        TicketService -> SyncService : SyncTicketsForProjects([id])
        SyncService -> TicketApiClient : GetTicketsByProjectId([id])
        SyncService -> TicketRepository : AddOrUpdateTickets(Tickets)
        TicketController <- SyncService : Tickets
end alt
```

```puml
title get tickets by project id above rate limit
TicketController -> TicketService : GetTicketsByProjectId([id])
TicketService -> TicketRepository : GetByProjectId([id])
    alt "Project not found || Refresh needed"
        TicketService -> SyncService : SyncTicketsForProjects([id])
        SyncService -> TicketApiClient : GetTicketsByProjectId([id])
        SyncService <- TicketApiClient : http 429 too many requests
        TicketService <- SyncService : TooManyRequestsException
        TicketController <- TicketService : Cached Tickets
        note left
            Exception? Automatic refresh?
        end note
end alt
```

