### /tickets/{ticketId}/tasks

Endpoints for managing task related data.

??? "/tickets/{ticketId}/tasks"

    #### GET

    Provides a list of tasks belonging to the given ticket.

    TODO: Kan ook deel zijn van GET /tickets/{ticketId}/details

    ??? "**Request:** GET `/tickets/{ticketId}/tasks`"

        **Path parameters:**

        ticketId

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        |  |  |

        **Request body:**

        N/A

        **Response body:**

        ```json
        {
        "tasks":[{
                    "taskId":"12345678-6C19-4ABA-B43B-6C10034657CE",
                    "task_name": "Schermontwerpen maken",
                    "task_team": "UX",
                    "status": "Done",
                    "dependencies":[
                        {
                            "dependent_taskId":"98765432-6C19-4ABA-B43B-6C10034657CE",
                            "dependencyType":1, //Blocking
                        },
                        {
                            "dependent_taskId":"ABCDEFG-6C19-4ABA-B43B-6C10034657CE",
                            "dependencyType":1, //Blocking
                        },
                    ]
                },
                {
                    "taskId":"98765432-6C19-4ABA-B43B-6C10034657CE",
                    "task_name": "Views updaten",
                    "task_team": "FE",
                    "status": "Started",
                    "dependencies":[
                        {
                            "dependent_taskId":"12345678-6C19-4ABA-B43B-6C10034657CE",
                            "dependencyType":2 //Waiting
                        },
                        {
                            "dependent_taskId":"ABCDEFG-6C19-4ABA-B43B-6C10034657CE",
                            "dependencyType":1 //Blocking
                        },
                    ]

                },
                {
                    "taskId":"ABCDEFG-6C19-4ABA-B43B-6C10034657CE",
                    "task_name": "Database server updaten",
                    "task_team": "BE",
                    "status": "Open",
                    "dependencies":[
                        {
                            "dependent_taskId":"12345678-6C19-4ABA-B43B-6C10034657CE",
                            "dependencyType":2 //Waiting
                        },
                        {
                            "dependent_taskId":"98765432-6C19-4ABA-B43B-6C10034657CE",
                            "dependencyType":2 //Waiting
                        },
                    ]
                },
            ],
        }
        ```

        **Errors:**

        | Error response | Cause |
        |---|---|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

        **Authentication, Authorization, Auditing:**

        Only returns tickets you have at least read rights for, no logging.

    #### DELETE

    /tickets/{ticketId}/tasks/{taskId}

    TODO

    Removes a task from a ticket