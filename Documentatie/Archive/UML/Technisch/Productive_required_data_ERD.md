

Intern:

```puml
title Essential productive data
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 120

rectangle "Productive" {
  class Project {
    project_id
    name
    updated_on
  }
  
  class Task {
    task_id
    title
    description
    task_list_id
    status_id
    updated_on
    created_on
  }

  class Attachment{
    id
    url
  }
  
  class Task_list {
    task_list_id
    name
    board_id
  }
  
  class Board {
    board_id
    name
    project_id
  }
  
  class Status {
    status_id
    name
  }

  class CustomField{
    custom_field_id
    value
  }

  class Comment {
    comment_id
    content
    task_id
  }
}

class Ticket{
  id
  name
  description
  productive_id
  updated_on
  created_on
}

' Klant beheert project
Klant "1"--"0..1" Project :> Eigenaar van
Klant "1..*"--"0..*" Project :> Beheerder van

' Klant Ticket
Klant "1"--"0..*" Ticket :> Maakt een
Ticket "1"--"0..*" Task :> Resulteert in

Task "0..*" -- "1" Task_list : > Weggeschreven op
Task_list "0..*" -- "1" Board : < Onderdeel van

Task "0..*" -- "1" Status :< Van
Board "1..*" -- "1" Project :> Voor

Task "1" -- "0..*" Comment :< Heeft
Task "0..*" -- "1" CustomField

Task "0..*" -- "0..*" Task :> Depends on

Attachment -- Task
Attachment -- Comment

```
