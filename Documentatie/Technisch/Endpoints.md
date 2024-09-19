# Endpoints

In dit document wordt per endpoint aangegeven wat voor data ze verwachten, terug kunnen geven en wat voor foutmeldingen er te verwachten zijn.

## PMP

Endpoint overzicht uit het TO:

| Endpoint | Gebruikt in | Filter fields | Sortable fields |
|---|---|---|---|
| /projects | [View1](../Functioneel/Schermontwerpen.md#view1-dashboard), [View2](../Functioneel/Schermontwerpen.md#view2-mijn-projecten) | company_id, action_required, pmp_project_id | Datum ingediend, laatste update |
| /tickets | [View1](../Functioneel/Schermontwerpen.md#view1-dashboard), [View3](../Functioneel/Schermontwerpen.md#view3-taak-detail-view), [View4](../Functioneel/Schermontwerpen.md#view4-toevoegen-taak-view) | pmp_project_id, status, action_required, type, prioriteit | titel, type, prio, datum ingediend, laatste update |
| /tasks | ViewX Toekennen taak zonder ticket | pmp_project_id, status | datum ingediend, laatste update |
| /feed | [View1](../Functioneel/Schermontwerpen.md#view1-dashboard), [View3](../Functioneel/Schermontwerpen.md#view3-taak-detail-view) | project_id, ticket_id |  |
| /onboarding | [View1](../Functioneel/Schermontwerpen.md#view1-dashboard) | pmp_project_id |  |
| /attachments | [View3](../Functioneel/Schermontwerpen.md#view3-taak-detail-view), [View4](../Functioneel/Schermontwerpen.md#view4-toevoegen-taak-view) | ticket_id |  |
| /manuals | [View5](../Functioneel//Schermontwerpen.md#view5-documentatie-view) | pmp_project_id |  |

/tickets & /projects hebben een {controller}/{id}/details endpoint om de ticket detail view en project settings te faciliteren.

### /projects

Endpoints for managing PMP project data.

??? "/projects"

    #### GET

    Provides a filterable list of projects.

    ??? "**Request:** GET `/projects`"

        **Path parameters:** N/A

        **Query parameters:**

        | Parameter | usage | values | 
        |---|---|---|
        | company_id | filter projects by company id as found in the PMP |  |
        | action_required | filters by wether the token bearer needs to perform a action on the task |  |
        | pmp_project_id | filters by the project id as found in the PMP |  |
        | created_on | orders results based on the created on field |  |
        | updated_on | orders results based on the updated on field |  |

        **Request body:** N/A

        **Response:**

        ```json
        {
            "projects":[
                {
                    "pmp_project_id": "C6E647A4-00C5-4F9A-9502-08F6FFA21309",
                    "name": "ProjectManagementPortal",
                    "action_required": false
                },
                {
                    "pmp_project_id": "C6E647A4-00C5-4F9A-9502-08F6FFA12345",
                    "name": "Eurowheelz",
                    "action_required": true
                }
            ]
        }
        ```

        Alternatief om [de tellers](../Functioneel/Schermontwerpen.md#taken-tellers) binnen dit endpoint te verwerken

        ```json
        {
            "projects":[
                {
                    "pmp_project_id": "C6E647A4-00C5-4F9A-9502-08F6FFA21309",
                    "name": "ProjectManagementPortal",
                    "tasks_require_action": 0,
                    "tasks_total": 7
                },
                {
                    "pmp_project_id": "C6E647A4-00C5-4F9A-9502-08F6FFA21309",
                    "name": "Eurowheelz",
                    "tasks_require_action": 3,
                    "tasks_total": 5
                }
            ]
        }
        ```

        **Errors:**

        | Error response | Cause |
        |---|---|
        | too many requests | The API is overloaded and has reached its rate limit. |

        <!-- forbidden, not found, too many requests -->
        <!-- TODO: iets van een filter error? -->

        **Authentication, Authorization, Auditing:**

        Only returns projects you have at least read rights for, no logging.


    #### POST 

    TODO: request body, response, errors, AAA
    Not yet used

    #### PATCH/PUT 

    TODO: request body, response, errors, AAA
    Not yet used

    #### DELETE 

    TODO: request body, response, errors, AAA
    Not yet used

    #### GET {projectId}/details

    TODO: request body, response, errors, AAA
    Not yet used

    !!! note "Overige /projects endpoints"
        Er worden nog POST, PATCH/PUT, DELETE en een GET /projects/{projectId}/details endpoints gemaakt. Deze worden verder uitgewerkt zodra [FR5.1:Afhandelen project setup](../Functioneel/Requirements/FR5_Beheren_project.md#fr51-afhandelen-project-setup) opgepakt wordt.

### /projects/{projectId}/onboarding

Endpoints for managing a projects onboarding tasks.

??? "/projects/{projectId}/onboarding"

    #### GET 

    Provides a list of onboarding items for the given project.

    ??? "**Request:** GET `/projects/{projectId}/onboarding`"

        **Path parameters:**

        projectId

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        | company_id | filters based on company id as found in the PMP | 
        | action_required? | filters based on wether there are tickets in the project which the token bearer needs to perform actions for |
        <!-- | pmp_project_id | filters based on project id as found in the PMP | pmp project id filter is niet nodig als hij onder /projects/{id} hangt -->

        **Request body:**

        **Response body:**

        ```json
        {
            "onboarding_items":[
                {
                    "id": "94D60639-9FB9-4E1D-BA75-78F361D4558A",
                    "item_marked_done": true,
                    "description": "Server instellen",
                    "position": 1
                },
                {
                    "id": "12360639-9FB9-4E1D-BA75-78F361D4558A",
                    "item_marked_done": false,
                    "description": "Database schema laden",
                    "position": 2
                }
                {
                    "id": "98760639-9FB9-4E1D-BA75-78F361D4558A",
                    "item_marked_done": false,
                    "description": "Contact opnemen met Bluenotion",
                    "position": 3
                }
            ]
        }
        ```

        <!-- TODO: request body, response, errors, AAA -->

        **Errors:**

        | Error response | Cause |
        |---|---|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

        **Authentication, Authorization, Auditing:**

        Only returns projects you have at least read rights for, no logging.


    #### POST

    Creates new onboarding items in a project.

    ??? "**Request:** POST `/projects/{projectId}/onboarding`"

        **Request body:**

        ```json
        {
            "onboarding_items":[
                {
                    "item_marked_done": true,
                    "description": "Server instellen",
                    "position": 1
                }
            ]
        }
        ```

        <!-- TODO: request body, response, errors, AAA -->

        <!-- #### PATCH/PUT /projects/{projectId}/onboarding -->

        | Error response | Cause |
        |---|---|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

    #### PATCH/PUT

    Updates a onboarding item 

    ??? "**Request:** PATCH/PUT `/projects/{projectId}/onboarding`"

        **Request body:**

        ```json
        {
            "onboarding_items":[
                {
                    "id": "94D60639-9FB9-4E1D-BA75-78F361D4558A",
                    "item_marked_done": true,
                    "description": "Server instellen",
                    "position": 1
                },
                {
                    "id": "12360639-9FB9-4E1D-BA75-78F361D4558A",
                    "item_marked_done": false,
                    "description": "Database schema laden",
                    "position": 2
                }
                {
                    "id": "98760639-9FB9-4E1D-BA75-78F361D4558A",
                    "item_marked_done": false,
                    "description": "Contact opnemen met Bluenotion",
                    "position": 3
                }
            ]
        }
        ```

        | Error response | Cause |
        |---|---|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

        <!-- TODO: request body, response, errors, AAA -->
        <!-- TODO: Betere naam voor itemId -->

    #### DELETE 
    
    Deletes a onboarding item.

    **Request:** DELETE `/projects/{projectId}/onboarding/{itemId}`

    <!-- TODO: request body, response, errors, AAA -->

    **GET** 
    
    Provides details on a onboarding item.

    `/projects/{projectId}/onboarding/{itemId}/details`

    <!-- TODO: Navragen: zijn er onboarding details of niet? -->
    <!-- TODO: request body, response, errors, AAA -->

### /tickets

Endpoints for managing ticket related data.

??? "/tickets"

    #### GET

    Provides a filterable list of tickets.

    ??? "Request: GET `/tickets`"
    
        **Path parameters:** 

        **Query parameters:**

        | Parameter | usage |
        |--|--|
        | projectId | filter by projectId |
        | dependencies | include? |
        | attachments | include? |

        TODO: ga ik includes gebruiken om optioneel dependencies en attachments mee te geven?

        **Request body:**

        N/A

        **Response body:**

        <!-- ??? Response -->

            ```json
            {
                "ticketListItems":[
                    {
                        "ticketId": "3CE5AB8E-6C19-4ABA-B43B-6C10034657CE",
                        "name": "Trage laadtijden dashboard",
                        "description": "Het dashboard is traag, los dit op.",
                        "action_required": true,
                        "type": "doorontwikkeling",
                        "prioriteit": null,
                        "status": "Bezig", 
                        "Inschatting": 12,
                        "created_at": "10-10-2024:16:44:31",
                        "updated_at": "11-10-2024:16:44:31",
                    },
                    {
                        "ticketId": "12345678-6C19-4ABA-B43B-6C10034657CE",
                        "name": "Toevoegen knop werkt niet",
                        "description": "De toevoegen knop op de huppeldepup pagina werkt niet.",
                        "action_required": false,
                        "type": "issue",
                        "prioriteit": "1",
                        "status": "Bezig", 
                        "Inschatting": 12,
                        "created_at": "10-10-2024:16:44:31",
                        "updated_at": "11-10-2024:16:44:31",
                    }
                ]
            }
            ```

        **Errors:**

        | Error response | Cause |
        |--|--|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

        **Authentication, Authorization, Auditing:**

        Only returns tickets you have at least read rights for, no logging.

    #### POST

    Creates new tickets in the PMP

    ??? "Request: POST `/tickets`"

        **Path parameters:**

        N/A

        **Query parameters:**

        TODO

        **Request body:**

            ```json
            {
                "tickets":[
                    {
                        "name": "Trage laadtijden dashboard",
                        "description": "Het dashboard is traag, los dit op.",
                        "type": "issue",
                        "impact": "laag",
                        "urgentie": "hoog",
                        "Inschatting": 12
                    },
                    {
                        "name": "Trage laadtijden dashboard",
                        "description": "Het dashboard is traag, los dit op.",
                        "type": "issue",
                        "impact": "laag",
                        "urgentie": "hoog",
                        "Inschatting": 12
                    }
                ]
            }
            ```

        **Response body:**

        **Errors:**

        | Error response | Cause |
        |--|--|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

        **Authentication, Authorization, Auditing:**

    #### PATCH/PUT

    Updates the tickets with the given id with the provided data.

    ??? "Request: PATCH/PUT `/tickets`"

        **Path parameters:**

        N/A

        **Query parameters:**

        N/A

        **Request body:**

            <!-- ??? Request body -->

            ```json
            {
                "tickets":[
                    {
                        "ticketId": "3CE5AB8E-6C19-4ABA-B43B-6C10034657CE",
                        "name": "Trage laadtijden dashboard",
                        "description": "Het dashboard is traag, los dit op.",
                        "type": "issue",
                        "impact": "laag",
                        "urgentie": "hoog",
                        "Inschatting": 12
                    },
                    {
                        "ticketId": "12345678-6C19-4ABA-B43B-6C10034657CE",
                        "name": "Trage laadtijden dashboard",
                        "description": "Het dashboard is traag, los dit op.",
                        "type": "issue",
                        "impact": "laag",
                        "urgentie": "hoog",
                        "Inschatting": 12
                    }
                ]
            }
            ```
        **Response body:**

        N/A

        **Errors:**

        | Error response | Cause |
        |---|---|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

        **Authentication, Authorization, Auditing:**

        Heeft admin rechten nodig voor project of bedrijf
        Log de wijziging en de gebruiker die het heeft aangevraagd

    #### DELETE /{ticketId}

    Deletes the ticket with the given Id.

    ??? "Request: DELETE `/{ticketId}`"

        **Path parameters:**

        TicketId

        **Query parameters:**

        TODO

        **Request body:**
        
        N/A

        **Response body:**

        204 Deleted

        Errors:

        | Error response | Cause |
        |--|---|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

        **Authentication, Authorization, Auditing:**

        Log de wijziging en de gebruiker die het heeft aangevraagd

    #### GET /{ticketId}/details

    Provides extra data about a single ticket.

    ??? "Request: GET `tickets/{ticketId}/details`"

        **Path parameters:**

        ticketId

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        | |  |

        TODO

        **Request body:**

        N/A

        **Response body:**

        ```json
            {
                "ticket":{
                    "ticketId": "12345678-6C19-4ABA-B43B-6C10034657CE",
                    "name": "Toevoegen knop werkt niet",
                    "description": "De toevoegen knop op de huppeldepup pagina werkt niet.",
                    "action_required": false,
                    "type": "issue",
                    "prioriteit": "1",
                    "impact": "Hoog",
                    "urgentie": "Laag",
                    "attachments": [], // Aparte endpoint voor attachments?
                    "Aangemaakt door": "Sjeff Wouters",
                    "status": "Bezig", 
                    "estimate_in_minutes": 720,
                    "created_at": "10-10-2024:16:44:31",
                    "updated_at": "11-10-2024:16:44:31",
                }
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

### /tasks

Endpoint for managing task related data.

??? "/tasks"

    #### GET

    Provides a filterable list of tasks.

    ??? "**Request:** GET `/tasks`"

        **Path parameters:**

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        | ticketId | filter on ticket id |
        | taskId | filter on task id |
        | projectId | filter on project id |
        | status | filter on status |
        | dependencies | include? |

        TODO: ga ik includes gebruiken om optioneel dependencies en attachments mee te geven?
        
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
                    "created_on": "12-09-2024:11:11:11",
                    "updated_on": "12-09-2024:12:12:12",
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
                    "created_on": "12-09-2024:11:11:11",
                    "updated_on": "12-09-2024:12:12:12",
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
                    "created_on": "12-09-2024:11:11:11",
                    "updated_on": "12-09-2024:12:12:12",
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

    #### POST

    Adds a new task

    ??? "**Request:** POST `/tasks`"

        **Path parameters:**

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        |  |  |

        **Request body:**

        <!-- TODO: hoort dependencies hier bij? -->
        <!-- TODO: het feit dat je gelijk aan een ticketId koppelt geeft mij de indicatie dat dit mogelijk gewoon een endpoint op de ticket controller moet zijn. -->

        !!! note "Note to self"

            Post op ticketId, niet taakId zodat een taak gekoppeld is aan een ticket.

        ```json
        {
            "tasks":[
            {
                "ticketId": "12312312-6C19-4ABA-B43B-6C10034657CE",
                "name": "Toevoegen knop werkt niet",
                "description": "De toevoegen knop op de huppeldepup pagina werkt niet.",
                "estimate_in_minutes": 720,
                "task_team": "FE",
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
                "ticketId": "08498498-29C2-442B-96F8-2F611087E948",
                "name": "Dashboard",
                "description": "De toevoegen knop op de huppeldepup pagina werkt niet.",
                "task_team": "BE",
                "estimate_in_minutes": null,
                "dependencies":[]
            }]
        }
        ```

        **Response body:**

        **Errors:**

        | Error response | Cause |
        |---|---|
        |  |  |

        TODO: Ticket not found, task not found, forbidden


        **Authentication, Authorization, Auditing:**


    <!-- Moved to /tickets/{id}/tasks -->

    #### PATCH/PUT 

    ??? "**Request:** PATCH/PUT `/tasks`"

        **Path parameters:**

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        |  |  |

        **Request body:**

        <!-- TODO: dependencies include? -->

        ```json
            {
            "tasks":[{
                        "taskId":"12345678-6C19-4ABA-B43B-6C10034657CE",
                        "ticketId":"98765432-6C19-4ABA-B43B-6C10034657CE",
                        "task_name": "Schermontwerpen maken",
                        "task_team": "UX",
                        "estimate_in_minutes": 720,
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
                        "ticketId":"98765432-6C19-4ABA-B43B-6C10034657CE",
                        "task_name": "Views updaten",
                        "task_team": "FE",
                        "estimate_in_minutes": 720,
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
                        "ticketId":"98765432-6C19-4ABA-B43B-6C10034657CE",
                        "task_name": "Database server updaten",
                        "task_team": "BE",
                        "estimate_in_minutes": 720,
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

        **Response body:**

        **Errors:**
        | Error response | Cause |
        |---|---|


        **Authentication, Authorization, Auditing:**      


    <!-- Not needed, use PATCH/PUT /tickets -->
    <!-- TODO: request body, response, errors, AAA -->

    #### DELETE /tasks/{taskId}

    Deletes a task including on Productive, should remove task from any tickets but leave the ticket
    <!-- TODO: request body, response, errors, AAA -->

    <!-- #### GET /tasks/{taskId}/details -->

    <!-- TODO: response, errors, AAA -->

    #### GET /ticketless

    Provides a filterable list of all tasks

    ??? "**Request:** GET `/tasks/ticketless`"

        **Path parameters:**

        N/A

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        | taskId |  |
        | ticketId | Only returns tasks related to a certain PMP ticket |
        | projectId |  |
        | pmp_has_corresponding_ticket | Filter tasks for whether the task has any connection to a PMP ticket  |


        TODO

        **Request body:**

        N/A

        **Response body:**

        <!-- TODO: heeft een taak zonder ticket wel een taak id of voegen we ze niet toe in het PMP? -->

        ```json
            {
                "tasks":[
                    {
                        "taskId": "12345678-6C19-4ABA-B43B-6C10034657CE",
                        "productive_id": "12345",
                        "name": "Toevoegen knop werkt niet",
                        "description": "De toevoegen knop op de huppeldepup pagina werkt niet.",
                        "estimate_in_minutes": 720,
                        "dependencies":[],
                        "created_at": "10-10-2024:16:44:31",
                        "updated_at": "11-10-2024:16:44:31",
                    },
                    {
                        "taskId": "98765432-B393-4A55-8431-ED2EB0CDC1EC",
                        "productive_id": "12345",
                        "name": "Toevoegen knop werkt niet",
                        "description": "De toevoegen knop op de huppeldepup pagina werkt niet.",
                        "estimate_in_minutes": 720,
                        "dependencies":[],
                        "created_at": "10-10-2024:16:44:31",
                        "updated_at": "11-10-2024:16:44:31",
                    },
                ]
            }
        ```

        **Errors:**

        | Error response | Cause |
        |---|---|
        | Forbidden |  |

        **Authentication, Authorization, Auditing:**

        Only returns tickets you have at least read rights for, no logging.

### /dependencies

<!-- TODO potentially tickets and tickets. De functionaliteit om tickets afhankelijk te maken van andere tickets is mogelijk. Tot nu toe is er geen wens voor uitgesproken maar kan even gepitcht worden -->

Endpoints for managing the relations between tasks and other tasks, tickets and tasks and (potentially) tickets and tickets.

??? "/dependencies"

    #### GET

    ??? "**Request: ** GET `/dependencies`"

        **Path parameters:** 

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        | TicketId | Used to get all dependencies for a ticket |
        | TaskId | Used to get all dependencies for a task |
        | dependency_type |  |
        | resource_type |  |


        **Request body:**

        ```json

        ```
        **Response body:**

        ```json
        {
            "resource_type":"Ticket",
            "resource_id":"12345678-6C19-4ABA-B43B-6C10034657CE",
            "dependencies":[
            {
                "dependencyId": "D9425F6F-55A0-4312-8577-72C1DDC2876F",
                "dependency_type":2, //Waiting
                "resource_type": "Task",
                "dependent_taskId":"12345678-6C19-4ABA-B43B-6C10034657CE",
            },
            {
                "dependencyId": "E9425F6F-55A0-4312-8577-72C1DDC2876F",
                "dependency_type":2, //Waiting
                "resource_type":"Task",
                "dependent_taskId":"98765432-6C19-4ABA-B43B-6C10034657CE",
            },
            ]
        }
        ```

        **Errors:**
        | Error response | Cause |
        |---|---|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

        **Authentication, Authorization, Auditing:**

    #### POST

    ??? "**Request: ** POST `/dependencies`"

        **Path parameters:** 

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        |  |  |

        **Request body:**

        ```json

        ```

        **Response body:**

        ```json

        ```

        **Errors:**
        | Error response | Cause |
        |---|---|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

        **Authentication, Authorization, Auditing:**

    #### PATCH/PUT

    ??? "**Request: ** PATCH/PUT `/dependencies`"

        **Path parameters:** 

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        |  |  |


        **Request body:**

        ```json

        ```
        **Response body:**

        ```json

        ```

        **Errors:**
        | Error response | Cause |
        |---|---|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

        **Authentication, Authorization, Auditing:**

    #### DELETE

    ??? "**Request: ** DELETE `/dependencies/{DependencyId}`"

        **Path parameters:** 

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        |  |  |


        **Request body:**

        ```json

        ```
        **Response body:**

        ```json

        ```

        **Errors:**
        | Error response | Cause |
        |---|---|
        | Too many requests | The API is overloaded and has reached its rate limit. |
        | Forbidden | The requester doesn't have access to the requested project |
        | Not found | The requested project does not exist |

        **Authentication, Authorization, Auditing:**


### /feed

??? "/feed"

    #### GET 

    ??? "**Request:** GET /feed"

        **Path parameters:**

        N/A

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        |  |  |

        TODO

        **Request body:**

        TODO: actie gevraagd en voltooid en dergelijken kan beter geformuleerd worden

        **Response body**

            ```json
            {
                "feed"[
                    {
                        "action_on":"10-09-2024 12:03",
                        "action_description":"Actie voltooid door Jesse Bekke",
                        "ticketId": "12345678-6C19-4ABA-B43B-6C10034657CE",
                        "projectId": "98765432-6C19-4ABA-B43B-6C10034657CE",
                        "ticketnaam":"Maken ticket dashboard"
                    },
                    {
                        "action_on":"10-09-2024 12:02",
                        "action_description":"Actie van de Bluenotion gevraagd door Sjeff Wouters",
                        "ticketId": "12345678-6C19-4ABA-B43B-6C10034657CE",
                        "projectId": "98765432-6C19-4ABA-B43B-6C10034657CE",
                        "ticketnaam":"Maken ticket dashboard"
                    },
                    {
                        "action_on":"10-09-2024 10:02",
                        "action_description":"Comment toegevoegd: 'Ja hoor, helemaal top' door Sjeff Wouters",
                        "ticketId": "12345678-6C19-4ABA-B43B-6C10034657CE",
                        "projectId": "98765432-6C19-4ABA-B43B-6C10034657CE",
                        "ticketnaam":"Maken ticket dashboard"

                    },
                    {
                        "action_on":"05-09-2024 10:03",
                        "action_description":"Actie van de klant gevraagd op ticket {ticketnaam} door Jesse Bekke",
                        "ticketId": "12345678-6C19-4ABA-B43B-6C10034657CE",
                        "projectId": "98765432-6C19-4ABA-B43B-6C10034657CE",
                        "ticketnaam":"Maken ticket dashboard"
                    },
                    {
                        "action_on":"05-09-2024 10:03",
                        "action_description":"Comment toegevoegd aan {ticketnaam}: 'Zijn de scherm ontwerpen naar wens?' door Jesse Bekke",
                        "ticketId": "12345678-6C19-4ABA-B43B-6C10034657CE",
                        "projectId": "98765432-6C19-4ABA-B43B-6C10034657CE",
                        "ticketnaam":"Maken ticket dashboard"

                    },
                    {
                        "action_on":"05-09-2024 10:02",
                        "action_description":"Afbeeldingen Dashboard.png en Ticketlijst.png toegevoegd aan {ticketnaam} door Roel Dekkers",
                        "ticketId": "12345678-6C19-4ABA-B43B-6C10034657CE",  
                        "projectId": "98765432-6C19-4ABA-B43B-6C10034657CE",
                        "ticketnaam":"Maken ticket dashboard"
                    }
                ]
            }
            ```

        <!-- TODO: request body, response, errors, AAA -->

<!-- ### /onboarding

Moved /onboarding to /projects. -->

### /attachments

??? "/attachments"

    <!-- TODO: willen we een GET voor enkele attachment?  -->

    #### GET /attachments

    ??? "**Request: ** GET `/attachments`"

        **Path parameters:**

        **Query parameters:**

        | Parameter | usage |
        |---|---|
        |  |  |

        **Request body: **

        **Response body: **

        **Errors:**
        | Error response | Cause |
        |---|---|


        **Authentication, Authorization, Auditing:**

    <!-- TODO: request body, response, errors, AAA -->

    #### POST /attachments

    <!-- TODO: request body, response, errors, AAA -->

    #### PATCH/PUT /attachments

    <!-- TODO: request body, response, errors, AAA -->

    #### DELETE /attachments

    <!-- TODO: request body, response, errors, AAA -->

### /manuals

??? "manuals"

    #### GET /manuals

    <!-- TODO: request body, response, errors, AAA -->

    #### POST /manuals

    <!-- TODO: request body, response, errors, AAA -->

    #### PATCH/PUT /manuals

    <!-- TODO: request body, response, errors, AAA -->

    #### DELETE /manuals/{projectId}

    <!-- TODO: request body, response, errors, AAA -->

    #### GET /manuals/{projectId}/details

    <!-- TODO: request body, response, errors, AAA -->
