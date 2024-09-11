```puml
top to bottom direction
skinparam linetype ortho
skinparam nodesep 10
skinparam ranksep 10

rectangle "React front-end"{
    rectangle "View" as view{
        rectangle "Admin" as Admin{
            rectangle "AdminProjectView"
            rectangle "AdminProjectDetailView"
            rectangle "AdminTaskDetailView"
            rectangle "AdminCommentsView"
        }
        rectangle "Customer" as Customer{
            rectangle "CustomerProjectView"
            rectangle "CustomerProjectDetailView"
            rectangle "CustomerTaskDetailView"
            rectangle "CustomerCommentsView"
        }
        rectangle "Partials" as Partials{
            rectangle "ProjectsPartial"
            rectangle "ProjectDetailsPartial"
            rectangle "TaskDetailPartial"
            rectangle "CommentsPartial"   
        }
    }

    rectangle "Generated API" as GeneratedAPI{
        rectangle "Generated Controllers"
        rectangle "Generated Models"
    }

    view-->GeneratedAPI
    Admin-->Partials : uses
    Customer-->Partials : uses
}
```