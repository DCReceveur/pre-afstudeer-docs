```puml

start
:get relevant project from local db;
if (Project found) then (no)
    :get project from productive;
    note right: Request to Productive API
    if(Productive contains project data) then (yes)
        :get all activities from productive*;
            note left: Request to Productive API as n1
    else (no)
    :Show project not found;
    endif
else (yes) 
    :get Activities from productive since last local update;
    note left: Request to Productive API
    if(Activities>0) then (yes)
    :Write changes to local db;
    else (no)
    endif
endif

:show data to user;
stop

```
