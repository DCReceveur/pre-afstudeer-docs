```puml

rectangle API.Models{
        rectangle AddCustomerModel as cm1
        rectangle SearchProjectModel as sp1
        rectangle UpdateTaskListModel as ut1
        rectangle DeleteTaskModel as dt1
}

rectangle Services.Models{
        rectangle CustomerModel as cm2
        rectangle ProjectModel as sp2
        rectangle TasklistModel as ut2
        rectangle TaskModel as dt2
}

rectangle Database.Models{
        rectangle Customer as cm3
        rectangle Project as sp3
        rectangle Tasklist as ut3
        rectangle Task as dt3    
}

note "API input" as n1
note "API output" as n2
note "Database model" as n3

API.Models .right. n1
Services.Models .right. n2
Database.Models .right. n3

cm1-->cm2
cm2-->cm3

sp1-->sp2
sp2-->sp3

ut1-->ut2
ut2-->ut3


dt1-->dt2
dt2-->dt3

```
