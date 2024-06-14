# Technisch ontwerp

## ERD

```plantuml
skinparam linetype ortho
skinparam nodesep 130
skinparam ranksep 130

rectangle "Productive"{
  
    entity Service_level_agreement{
        *Id
        --
        *Name
    }

    entity Priority{
        *Id
        --
        *Naam
    }
    entity ResponseTime{
        *Time_in_hours
    }
    entity SolvingTime{
        *Time_in_hours
    }

    Service_level_agreement .. Priority
    (Service_level_agreement, Priority) .. ResponseTime

    Service_level_agreement .. Priority
    (Service_level_agreement, Priority) .. SolvingTime

  entity Organization{
    *Id
    --
    *Tagname
  }

  entity Project{
    *Id
    --
    *Name
    *Created_at
    Last_activity_at
    Archived_at
  }

  entity Board{
    *Id
    --
    *Name
  }

  entity Task_list{
    *Id
    --
    *List_name
  }

  entity Task{
    *Id
    --
    *Title
    *Description
    *Created_at
    Due_date
    Start_date
    Due_date
    Closed_at
    Updated_at
    Parent_task_id <<FK>>
    Initial_time_estimate
    Remaining_time
    Worked_time
    Billable_time
  }

  entity Comment{
    *Id
    --
    Created_at
    Updated_at
  }

  entity Todo{
    *Id
    --
    *Description
    *Created_at
    Closed_at

  }

  entity Company{
    *Id
    --
    *Name
  }

  entity ContactInformation{
    *Id
    --
    Phone_number
    Email
  }

  entity WorkflowStatus{
    *Id
    --
    *Name
    *Category
  }

  entity Person{
    *Id
    --
    FirstName
    LastName
    ContactDetails
  }

  entity Tag{
    *Id
    --
    Tagname
  }

  entity Attachment{
  *Id
  --
  Image
  }


  note "Bluenotion, Wilmar ect..." as orgNote
  note "Zou gebruikt kunnen worden voor doorontwikkeling vs incident" as tagNote
  note "Wie is de eigenaar van een bedrijf?" as ownerNote
  note "Category = not started, started, closed" as catNote
  Organization .... orgNote
  Tag .... tagNote
  Company .... ownerNote
  WorkflowStatus .... catNote
}

' Person ||..|| Company

Project ||..|{Board
Board ||..|{Task_list
Task_list ||..o{Task
Task ||..|{Comment :< Comment on
Task ||..|{Todo
Organization }o..|{Person :< Employee of
Organization ||..|{Project :> Developer of
Person ||..|{Task :< Assignee
Person ||..|{Task :< Creator
Person }|..||ContactInformation :< Info for
Person ||..|{Todo :< Assignee
Person ||..|{Project :> Manager of

Task ||..||Task :< Subtask of
Task }o..o{Tag
Task ||..|{Attachment
Comment ||..|{Attachment
Service_level_agreement ||..||Project
Organization ||..|{Company :< Customer of
Company ||..|{Project :> Owner of

Task ||..||WorkflowStatus

```
