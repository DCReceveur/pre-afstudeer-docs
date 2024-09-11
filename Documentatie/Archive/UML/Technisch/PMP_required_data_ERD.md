```puml
title Essential PMP data
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 120

rectangle Productive{
    class "Task" as productive_task
    class "Project" as productive_project
    class "Attachment" as productive_attachment
    class "Comment" as productive_comment
}

rectangle PMP{
    class Ticket{
        Guid id
        int productive_id
        Type
        datetime last_updated_at
    }
    note right
        Refers to Productive Task
    end note
    class Task{
        Guid id
        int productive_id
        datetime last_updated_at
    }
    note right
        Refers to Productive Task
    end note
    class Bedrijf{
        Guid id
    }
    class Prioriteit{
        int urgentie
        int impact
    }
    class Klant{
        Guid id
        String voornaam
        String achternaam
        String email
    }
    class Project{
        Guid id
        int productive_id
        datetime last_updated_at
    }
    note right
        Refers to Productive Project. 
        Last updated needed? 
        Volgens mij zou alleen de naam kunnen veranderen?
    end note
}

Klant "1..*"--"0..*" Project :> Beheerder van
Klant "1..*"--"0..*" Bedrijf :> Beheerder van
Project "0..*"--"1" Bedrijf :> Uitgevoerd voor
Klant "1"--"0..*" Ticket :> Maakt een
Ticket "1"--"0..*" Task :> Resulteert in
Ticket "0..*"--"1" Project :> Werk voor
Ticket "0..*" -- "1" Prioriteit :> Ingediend met

Task "1"--"1" productive_task :> Links to
Ticket "1"--"1" productive_task :> Links to
Project "1"--"1" productive_project :> Links to

productive_comment -- productive_task :> placed on
productive_attachment -- productive_task :> bijlagen op
productive_attachment -- productive_comment :> bijlagen op

```
