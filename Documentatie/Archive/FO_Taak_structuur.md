Verwijderd wegens weinig toegevoegde waarde in vergelijking met domeinmodel.

# Taak structuur

Belangrijk is om toe te lichten hoe Bluenotion om gaat met verschillende soorten aanvragen. Zoals in het schema te zien is wordt niet elke aanvraag een taak en wordt er op verschillende manieren met incidenten omgegaan dan met een doorontwikkeling. Verdere toelichting over hoe incidenten worden behandeld in vergelijking met doorontwikkelingen is te vinden in [de toelichting over incidenten](#incident-impact-urgentie-en-prioriteit-levels).

```plantuml
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 120

rectangle "Klant " {
  rectangle Klant
  rectangle Aanvraag
}

rectangle "PM/TL " {
  rectangle Taak
  rectangle Doorontwikkeling
  rectangle Servicevraag
  rectangle Status
  rectangle Board
  rectangle "Bij incident" {
    rectangle Incident
    rectangle Impact
    rectangle Urgentie
    rectangle Prioriteit
  }
}

' Klant aanvraag
Klant "1"--"0..*" Aanvraag :> Doet een
Doorontwikkeling "1"-RIGHT-"1..*" Taak :> Resulteert in
Incident "1"--"1..*" Taak :> Resulteert in


' Priority part
Incident --|> Aanvraag
Doorontwikkeling --|> Aanvraag
Servicevraag -LEFT-|> Aanvraag
Taak "0..*"--"1" Status : > werkstatus voor 
Taak "0..*"--"1" Board : > Wordt bijgehouden op

' Incident part
Impact "1"--"0-..*" Incident : < Ingediend met
Urgentie "1"--"0..*" Incident : < Ingediend met
Prioriteit "1"--"1" Impact : < Bepalend voor
Prioriteit "1"--"1" Urgentie : < Bepalend voor
```

**Servicevragen**: Servicevragen komen over het algemeen niet in Productive terecht maar worden doorgaans via de mail of telefoon direct beantwoord.*

**Doorontwikkeling**: Extra functionaliteiten aangevraagd door de klant worden zonder prioriteit, in een scope in productive gezet.

**Incident**: Een incident wordt net als een doorontwikkeling in een scope in productive gezet maar deze heeft een impact en urgentie die de prioriteit bepaald.

*Bluenotion heeft enkel een 2e lijns servicedesk, bereikbaar door de 1e lijn van de klant maar niet door eindgebruikers.
