```puml
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 120

  class Klant
  class Aanvraag
  class Taak
  class Doorontwikkeling
  class Incident
  class Impact
  class Urgentie
  class Prioriteit


' Klant aanvraag
Klant "1"--"0..*" Aanvraag :> Doet een
Aanvraag "1"--"1..*" Taak :> Resulteert in


' Priority part
Incident --|> Aanvraag : < Ingediend als
Doorontwikkeling --|> Aanvraag : < Ingediend als


' Incident part
Impact "1"--"0-..*" Incident : < Ingediend met
Urgentie "1"--"0..*" Incident : < Ingediend met
Prioriteit .. (Impact, Urgentie)  
```
