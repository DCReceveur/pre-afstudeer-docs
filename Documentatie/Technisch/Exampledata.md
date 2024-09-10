# Example data

In dit document wordt per endpoint aangegeven wat voor data ze verwachten, terug kunnen geven en wat voor foutmeldingen er te verwachten zijn.

## PMP

### /projects

#### GET /projects

request body:

N/A

Response:

```json
"projects":[
    {
        "pmp_project_id": "C6E647A4-00C5-4F9A-9502-08F6FFA21309",
        "name": "ProjectManagementPortal",
        "actie_vereist": false
    },
    {
        "pmp_project_id": "C6E647A4-00C5-4F9A-9502-08F6FFA12345",
        "name": "Eurowheelz",
        "actie_vereist": true
    }
  ]
```

Alternatief om [de tellers](../Functioneel/Schermontwerpen.md#taken-tellers) binnen dit endpoint te verwerken

```json
"projects":[
    {
        "pmp_project_id": "C6E647A4-00C5-4F9A-9502-08F6FFA21309",
        "name": "ProjectManagementPortal",
        "actie_vereist_taken": 0,
        "totaal_taken": 7
    },
    {
        "pmp_project_id": "C6E647A4-00C5-4F9A-9502-08F6FFA21309",
        "name": "Eurowheelz",
        "actie_vereist_taken": 3,
        "totaal taken": 5
    }
  ]
```

Errors:

forbidden, not found, too many requests
<!-- TODO: iets van een filter error? -->

Authentication, Authorization, Auditing:

Only returns projects you have at least read rights for, no logging.

#### POST /projects

<!-- TODO: request body, response, errors, AAA -->
Not yet used

#### PATCH/PUT /projects

<!-- TODO: request body, response, errors, AAA -->
Not yet used

#### DELETE /projects/{projectId}

<!-- TODO: request body, response, errors, AAA -->
Not yet used

#### GET /projects/{projectId}/details

<!-- TODO: request body, response, errors, AAA -->
Not yet used

### /tickets

#### GET /tickets

Request body:

N/A

Response:

```json

"ticketListItems":[
    {
        "ticketId": "3CE5AB8E-6C19-4ABA-B43B-6C10034657CE",
        "name": "Trage laadtijden dashboard",
        "description": "Het dashboard is traag, los dit op.",
        "actie_vereist": true,
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
        "actie_vereist": false,
        "type": "issue",
        "prioriteit": "1",
        "status": "Bezig", 
        "Inschatting": 12,
        "created_at": "10-10-2024:16:44:31",
        "updated_at": "11-10-2024:16:44:31",
    }
]

```

Errors:

forbidden, not found

Authentication, Authorization, Auditing:

Only returns tickets you have at least read rights for, no logging.

<!-- TODO: request body, response, errors, AAA -->

#### POST /tickets

Request body:

```json
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
```

<!-- TODO: request body, response, errors, AAA -->

#### PATCH/PUT /tickets

Request body:

<!-- TODO: misschien een expliciete change mee sturen? -->

```json
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
```

Response: 201

Errors:

Forbidden, not found

AAA:

Heeft admin rechten nodig voor project of bedrijf

Log de wijziging en de gebruiker die het heeft aangevraagd

<!-- TODO: request body, response, errors, AAA -->

#### DELETE /tickets/{ticketId}

<!-- TODO: request body, response, errors, AAA -->

#### GET /tickets/{ticketId}/details

<!-- TODO: request body, response, errors, AAA -->

Request body:

Response:

Errors:

Authentication, Authorization, Auditing:

### /tasks

#### GET /tasks

<!-- TODO: request body, response, errors, AAA -->

#### POST /tasks

<!-- TODO: request body, response, errors, AAA -->

#### PATCH/PUT /tasks

<!-- TODO: request body, response, errors, AAA -->

#### DELETE /tasks/{taskId}

<!-- TODO: request body, response, errors, AAA -->

#### GET /tasks/{taskId}/details

<!-- TODO: request body, response, errors, AAA -->

### /feed

#### GET /feed

<!-- TODO: request body, response, errors, AAA -->

### /onboarding

#### GET /onboarding

<!-- TODO: request body, response, errors, AAA -->

#### POST /onboarding

<!-- TODO: request body, response, errors, AAA -->

#### PATCH/PUT /onboarding

<!-- TODO: request body, response, errors, AAA -->
<!-- TODO: Betere naam voor itemId -->

#### DELETE /onboarding/{itemId}

<!-- TODO: request body, response, errors, AAA -->

#### GET /onboarding/{itemId}/details

<!-- TODO: request body, response, errors, AAA -->

### /attachments

<!-- TODO: willen we een GET voor enkele attachment?  -->

#### GET /attachments

<!-- TODO: request body, response, errors, AAA -->

#### POST /attachments

<!-- TODO: request body, response, errors, AAA -->

#### PATCH/PUT /attachments

<!-- TODO: request body, response, errors, AAA -->

#### DELETE /attachments/{projectId}

<!-- TODO: request body, response, errors, AAA -->

### /manuals

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

