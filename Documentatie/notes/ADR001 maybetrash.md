
Van de [Productive website over webhooks](https://help.productive.io/en/articles/3693279-using-webhooks-in-productive):
 > It is possible to have a maximum of 25 active webhooks simultaneously. Currently, the same limit applies to Ultimate, Premium, and Enterprise plans.

Na bespreking met de PM is er besloten Productive taken gescheiden te houden van de tickets die een gebruiker in zou dienen. Dit in combinatie met de limitaties die webhooks met zich meebrengen zou er gebruik gemaakt kunnen worden van een hybride oplossing tussen webhooks en directe communicatie met eventueel een caching mechanisme.

<!-- ```puml
| Gebruiker |
start
:Gebruiker opent dashboard;
| Systeem |
split
:Vraagt lijst van projecten ect uit locale db ;
| Gebruiker |
:Ziet data uit locale db;
stop
| Systeem |
split again

:Vraagt lijst van projecten ect uit Productive db ;
split
:Voegt eventueel nieuwe data toe aan de locale db ;
split again
:Update de getoonde data met de nieuwe Productive data ;
end split
| Gebruiker |
:Ziet up to date data ;

end split
stop
```


```puml
title get by project id
TicketController -> TicketService : GetTicketsByProjectId(id)
TicketService -> TicketRepository : GetByProjectId(id)
TicketService <. TicketRepository : Tickets
TicketController <. TicketService : Tickets
```

```puml
title get by project id
TicketController -> TicketService : GetTicketsByProjectId([id])
TicketService -> TicketRepository : GetByProjectId([id])
alt "project found"
TicketService <- TicketRepository : Tickets
TicketController <- TicketService : Tickets
else "Project not found || syncflag set to true"
TicketService -> SyncService : SyncTicketsForProjects([id])
SyncService -> TicketApiClient : GetTicketsByProjectId([id])
SyncService -> TicketRepository : AddOrUpdateTickets(Tickets)
TicketService -> TicketRepository : GetByProjectId([id])
TicketService <- TicketRepository : Tickets
TicketController <- TicketService : Tickets
end alt
``` -->


<!-- ```puml
start
:User opens dashboard;
:Get project cache from local db;
if (IsAdmin || UpdateNeeded) then (True)
:Set updating flag to true;
:Api request for projects since last update;
:Write projects to db;
else (False)
endif
:Send project list to front-end;

end
``` -->


| Last_Synced | Last_Used | Record_Type | Productive_Id | Pmp_Id |
|---|---|---|---|---|
| datetime | datetime | Ticket | 4297842 | Guid |
| datetime | datetime | Project | 34354 | Guid |
| datetime | datetime | Activities* | 34354 | Guid |

*Needed for comments?

```puml
title passively creating the db population based on usage
start
:Webhook receives data;
if(type==tracked) then (false)
    end
else (true)
    :search parent id in pmp db;
if(parent found) then (true)
    ':create/edit item;
    'end
else (false)
:Api request for parent data*;
if(parent data found) then (yes)
    :create parent item**;
else (no)
    :Some error?;
    end
endif
endif
:create item;
end
```

*Requests zouden in bulk kunnen gebeuren wanneer het systeem niet veel wordt gebruikt waarbij data intern opgeslagen zou kunnen worden als "niet geverifieerd". Dit kan wel voor complexere scenario's zorgen waar data tussen de twee verschillende datasources niet overeen komt.

**TODO: Recursief parent weer zoeken? Overlaten aan sync service? Als het een project is alle tickets binnenhalen?

Tracked items: Task, Projects, People?, Comments?, Boards/task_lists?

What if:

- Webhooks go down

```puml
start
:Manual sync started;
if(Webhooks down) then (true)
:Restore webhooks;
else (false)
endif
:Api request for projects since last update;
:Add, edit and archive projects in local db;
:Api request for tickets since last update;
:Add, edit and archive tickets in local db;
end
```

- Incorrect data is added to the pmp db


<!-- ```puml
| Externe beheerder |
start
repeat
#Red:Plaats aanvraag;
note right: FR3.1 Toevoegen nieuwe taak
' note right: inclusief urgentie en impact
' #Gray:System: Zet status op "Waiting for review Bluenotion";
| Bluenotion admin |
#LightBlue:Controleren aanvraag;
note left: FR8.1 Controleren aanvraag 
#LightBlue:if (Aanvraag één duidelijke functionaliteit?) then (yes) 
else (no) 
  #LightBlue:if (Aanvraag bestaat uit meerdere functionaliteiten) then (yes)
  #LightBlue:Maak aanvraag aan per functionaliteit;
  note left 
  *extra FR?
  end note 
  else (no)
  endif
  #LightBlue:Wijzig omschrijving;
endif
  #LightBlue:Add time estimate;
  #lightBlue:Vraag om feedback;
  ' #Gray:System: Zet status op "Waiting for review customer";
| Externe beheerder |
  #Red:Controleren taak;
  note right: FR3.2 Toelichting geven op aanvraag
  #Red:if(Eens met de omschrijving en time estimate?) then (no)
  #Red:if(Wil aanvraag annuleren) then (yes)
  #Red:Aanvraag annuleren;
  end
  else(no)
  endif
  #Red:Wijzigen aanvraag;
  else(yes)
  #Red:Accepteer taak;
  

| Bluenotion admin |
#LightBlue:Accepteren taak;
#LightBlue:Opsplitten taak;
note left 
  FR8.2: Op splitten taak naar "team" taken.
  Deze taken komen op de backlog.
end note

stop 

| Externe beheerder |
  endif

  repeat while

' legend right
'     | Color | Status |
'     |<#Red>| ACT1: Externe beheerder |
'     |<#LightBlue>| ACT2: Interne beheerder |
'     |<#Gray>| PMP back-end |
' endlegend

``` -->