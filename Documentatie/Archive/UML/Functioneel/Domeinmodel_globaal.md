```puml
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 120

rectangle "Project management portal"{
  class Klant
  class Aanvraag
  class Doorontwikkeling
  class Incident
  class Impact
  class Urgentie
  class Prioriteit
  class SLA{
    reactietijd
    oplostijd
  }
}
rectangle "Productive"{
  class Project{
    Nr. 1
  }
  class Taak{
    Nr. 2
  }
  class Takenlijst{
    Nr. 3
  }
  class Board{
    Nr. 4
  }
  class Status{
    Nr. 5
  }
}

SLA"1"--"1"Project :> Toegekend aan
SLA"1"--"1"Prioriteit :> Bevat tijden voor

' Klant beheert project
Klant "1"--"0..1" Project :> Eigenaar van
Klant "1..*"--"0..*" Project :> Beheerder van

' Klant aanvraag
Klant "1"--"0..*" Aanvraag :> Doet een
Aanvraag "1"--"0..*" Taak :> Resulteert in

' aanvraag is een...
Incident --|> Aanvraag : < Ingediend als
Doorontwikkeling --|> Aanvraag : < Ingediend als


' Incident priority
Impact "1"--"0-..*" Incident : < Ingediend met
Urgentie "1"--"0..*" Incident : < Ingediend met
Prioriteit .. (Impact, Urgentie)  

Taak"0..*"--"1"Takenlijst : > Weggeschreven op
Takenlijst"0..*"--"1"Board : < Onderdeel van

Taak"0..*"--"1"Prioriteit :< Van
Taak"0..*"--"1"Status :< Van

Board "1..*"--"1" Project :> Voor

```