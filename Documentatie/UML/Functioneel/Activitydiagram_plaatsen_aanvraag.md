```puml
| Externe beheerder |
start
repeat
#Red:Plaats aanvraag;
note right: FR3.1 Toevoegen nieuwe taak
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

```
