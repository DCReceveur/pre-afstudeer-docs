```puml
title get by project id with cache
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
