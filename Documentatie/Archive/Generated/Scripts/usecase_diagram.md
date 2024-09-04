```plantuml
left to right direction
skinparam packageStyle rect
:ACT1 Externe beheerder: as ACT1
:ACT2 Interne beheerder: as ACT2
:ACT3 Interne medewerker: as ACT3
:ACT4 notification manager: as ACT4
:ACT5 Externe medewerker: as ACT5
ACT2-LEFT-|>ACT3
ACT2-LEFT-|>ACT1
ACT1-LEFT-|>ACT5
ACT3-LEFT-|>ACT5
 
usecase "FR1.1: Inzien projecten \n" as FR1_1 #66ff33 
usecase "FR1: Inzien project plannings informatie" as FR1 
usecase "FR1.2: Inzien totaal geplande uren+kosten \n" as FR1_2 #FF0000 
usecase "FR2.1: Inzien taken van project \n" as FR2_1 #66ff33 
usecase "FR2.2: Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed \n" as FR2_2 #66ff33 
usecase "FR2.3: Inzien taak details \n" as FR2_3 #66ff33 
usecase "FR2: Inzien taken" as FR2 
usecase "FR2.4: Tonen taken in Gantt chart \n" as FR2_4 #ff9933 
usecase "FR3.1: Toevoegen nieuwe taak \n" as FR3_1 #66ff33 
usecase "FR3.2: Toelichting geven op ticket (extern) \n" as FR3_2 #66ff33 
usecase "FR3.3: Toevoegen taken past zich aan aan de klant zijn SLA \n" as FR3_3 #ff9933 
usecase "FR3.4: Toevoegen bijlagen bij taak \n" as FR3_4 #66ff33 
usecase "FR3.5: Aanpassen taak prioriteit \n" as FR3_5 #ff9933 
usecase "FR3: Toevoegen ticket" as FR3 
usecase "FR3.6: Annuleren ticket \n" as FR3_6 #ffff00 
usecase "FR4.1: Inlichten klant wanneer een taak wacht op input van de klant \n" as FR4_1 #ffff00 
usecase "FR4: Versturen notificaties" as FR4 
usecase "FR4.2: Inlichten Bluenotion bij blockers/criticals \n" as FR4_2 #ff9933 
usecase "FR5.1: Afhandelen project setup binnen PMP \n" as FR5_1 #ff9933 
usecase "FR5.2: Instellen productive boards & taak status \n" as FR5_2 #ff9933 
usecase "FR5.3: Beheren project documentatie \n" as FR5_3 #ff9933 
usecase "FR5: Beheren project" as FR5 
usecase "FR5.4: Beheren project services \n" as FR5_4 #ff9933 
usecase "FR6.1: Inzien lijst van project dependencies \n" as FR6_1 #ff9933 
usecase "FR6: Inzien project service statuses" as FR6 
usecase "FR6.2: Inzien huidige status (online/offline) project dependencies \n" as FR6_2 #ff9933 
usecase "FR7.1: Openen/downloaden document \n" as FR7_1 #ff9933 
usecase "FR7: Inzien project documentatie" as FR7 
usecase "FR7.2: Filteren documentnaam/categorie \n" as FR7_2 #ff9933 
usecase "FR8.1: Controleren ticket (intern) \n" as FR8_1 #66ff33 
usecase "FR8: Controleren ticket" as FR8 
usecase "FR8.2: Op splitten taak naar team taken \n" as FR8_2 #ff9933 
usecase "FR9.1: Starten nieuwe chat \n" as FR9_1 #FF0000 
usecase "FR9.2: Bericht sturen niet afgesloten chat \n" as FR9_2 #FF0000 
usecase "FR9.3: Hervatten afgesloten chat \n" as FR9_3 #FF0000 
usecase "FR9: Chat met tenants" as FR9 
usecase "FR9.4: Sluiten chat \n" as FR9_4 #FF0000 
usecase "FR10.1: Uitnodigen gebruiker \n" as FR10_1 #66ff33 
usecase "FR10.2: Wijzigen rechten \n" as FR10_2 #66ff33 
usecase "FR10: Beheren gebruikers" as FR10 
usecase "FR10.3: Verwijderen gebruiker \n" as FR10_3 #66ff33
 
      ACT5 -DOWN-> FR1
      FR1 -DOWN->  FR1_1
      
      FR1 -DOWN->  FR1_2
       
      ACT5 -DOWN-> FR2
      FR2 -DOWN->  FR2_1
      
      FR2 -DOWN->  FR2_2
      
      FR2 -DOWN->  FR2_3
      
      FR2 -DOWN->  FR2_4
       
      ACT1 -DOWN-> FR3
      FR3 -DOWN->  FR3_1
      
      FR3 -DOWN->  FR3_2
      
      FR3 -DOWN->  FR3_3
      
      FR3 -DOWN->  FR3_4
      
      FR3 -DOWN->  FR3_5
      
      FR3 -DOWN->  FR3_6
       
      ACT4 -DOWN-> FR4
      FR4 -DOWN->  FR4_1
      
      FR4 -DOWN->  FR4_2
       
      ACT2 -DOWN-> FR5
      FR5 -DOWN->  FR5_1
      
      FR5 -DOWN->  FR5_2
      
      FR5 -DOWN->  FR5_3
      
      FR5 -DOWN->  FR5_4
       
      ACT5 -DOWN-> FR6
      FR6 -DOWN->  FR6_1
      
      FR6 -DOWN->  FR6_2
       
      ACT5 -DOWN-> FR7
      FR7 -DOWN->  FR7_1
      
      FR7 -DOWN->  FR7_2
       
      ACT2 -DOWN-> FR8
      FR8 -DOWN->  FR8_1
      
      FR8 -DOWN->  FR8_2
       
      ACT5 -DOWN-> FR9
      FR9 -DOWN->  FR9_1
      
      FR9 -DOWN->  FR9_2
      
      FR9 -DOWN->  FR9_3
      
      FR9 -DOWN->  FR9_4
       
      ACT2 -DOWN-> FR10
      FR10 -DOWN->  FR10_1
      
      FR10 -DOWN->  FR10_2
      
      FR10 -DOWN->  FR10_3
      
legend left
  | **Task color** | **Priority** |
  | <#66ff33> | Must have |
  | <#ffff00> | Should have |
  | <#ff9933> | Could have |
  | <#FF0000> | Won't have |
  end legend
```
 
| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Document references |
|---|---|---|---|---|
| FR1 | Inzien project plannings informatie |  |  | [Requirement overzicht](/Documentatie/Requirements/FR1_Inzien_project_plannings_informatie.md) |
| FR1.1 |  | Inzien projecten | Must have | [US1](/Documentatie/FunctioneelOntwerp.md#user-stories), [US2](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR1_Inzien_project_plannings_informatie.md#fr11-alternative-flow---no-projects-for-customer) |
| FR1.2 |  | Inzien totaal geplande uren+kosten | Won't have FDR001 | [US3](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR1_Inzien_project_plannings_informatie.md#fr12-inzien-totaal-geplande-urenkosten), [FDR001](../Decisions/Functional/FDR001-Tijd-en-kosten-niet-tonen.md) |
| FR2 | Inzien taken |  |  | [Requirement overzicht](/Documentatie/Requirements/FR2_Inzien_taken.md) |
| FR2.1 |  | Inzien taken van project | Must have | [US3](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR2_Inzien_taken.md#fr21-inzien-taken-van-project) |
| FR2.2 |  | Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed | Must have | [US3](/Documentatie/FunctioneelOntwerp.md#user-stories), [US8](/Documentatie/FunctioneelOntwerp.md#user-stories), [US9](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) |
| FR2.3 |  | Inzien taak details | Must have | [US3](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR2_Inzien_taken.md#fr23-inzien-taak-details)  |
| FR2.4 |  | Tonen taken in Gantt chart | Could have | [US3](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR2_Inzien_taken.md#fr24-main-flow) |
| FR3 | Toevoegen ticket |  |  | [Requirement overzicht](/Documentatie/Requirements/FR3_Toevoegen_ticket.md) |
| FR3.1 |  | Toevoegen nieuwe taak | Must have | [US6](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR3_Toevoegen_ticket.md#fr31-toevoegen-nieuwe-ticket-in-een-project) |
| FR3.2 |  | Toelichting geven op ticket (extern) | Must have | [US7](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR3_Toevoegen_ticket.md#fr32-toelichting-geven-op-ticket) |
| FR3.3 |  | Toevoegen taken past zich aan aan de klant zijn SLA | Could have | [Fully dressed usecase description](/Documentatie/Requirements/FR3_Toevoegen_ticket.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla) |
| FR3.4 |  | Toevoegen bijlagen bij taak | Must have | [US12](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR3_Toevoegen_ticket.md#fr34-toevoegen-bijlagen-bij-taak) |
| FR3.5 |  | Aanpassen taak prioriteit | Could have | [Fully dressed usecase description](/Documentatie/Requirements/FR3_Toevoegen_ticket.md#fr35-aanpassen-taak-prioriteit) |
| FR3.6 |  | Annuleren ticket | Should have | [Fully dressed usecase description](./Requirements/FR3_Toevoegen_ticket.md#fr36-annuleren-ticket) |
| FR4 | Versturen notificaties |  |  | [Requirement overzicht](/Documentatie/Requirements/FR4_Versturen_notificaties.md) |
| FR4.1 |  | Inlichten klant wanneer een taak wacht op input van de klant | Should have | [US9](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR4_Versturen_notificaties.md#fr41-inlichten-klant-wanneer-een-taak-wacht-op-input-van-de-klant) |
| FR4.2 |  | Inlichten Bluenotion bij blockers/criticals | Could have | [Fully dressed usecase description](/Documentatie/Requirements/FR4_Versturen_notificaties.md#fr42-inlichten-bluenotion-bij-blockerscriticals) |
| FR5 | Beheren project |  |  |  |
| FR5.1 |  | Afhandelen project setup binnen PMP | Could have | [US19](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR5_Beheren_project.md#fr51-afhandelen-project-setup)  |
| FR5.2 |  | Instellen productive boards & taak status | Could have | [US20](#user-stories) [FR5.2](./Requirements/FR5_Beheren_project.md#fr52-instellen-productive-boards-en-taak-status) |
| FR5.3 |  | Beheren project documentatie | Could have |  [Fully dressed usecase description](/Documentatie/Requirements/FR7_Inzien_project_documentatie.md#fr73-beheren-project-documentatie) |
| FR5.4 |  | Beheren project services | Could have | [Fully dressed usecase description](/Documentatie/Requirements/FR6_Inzien_project_service_statuses.md#fr63-beheren-project-services) |
| FR6 | Inzien project service statuses |  |  | [Requirement overzicht](/Documentatie/Requirements/FR6_Inzien_project_service_statuses.md)  |
| FR6.1 |  | Inzien lijst van project dependencies | Could have | [US13](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR6_Inzien_project_service_statuses.md#fr61-inzien-lijst-van-project-dependencies) |
| FR6.2 |  | Inzien huidige status (online/offline) project dependencies | Could have | [US13](/Documentatie/FunctioneelOntwerp.md#user-stories),[Fully dressed usecase description](/Documentatie/Requirements/FR6_Inzien_project_service_statuses.md#fr62-inzien-huidige-status-onlineoffline-project-dependencies) |
| FR7 | Inzien project documentatie |  |  | [Requirement overzicht](/Documentatie/Requirements/FR7_Inzien_project_documentatie.md) |
| FR7.1 |  | Openen/downloaden document | Could have | [US13](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR7_Inzien_project_documentatie.md#fr71-openendownloaden-document) |
| FR7.2 |  | Filteren documentnaam/categorie | Could have | [US13](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR7_Inzien_project_documentatie.md#fr72-filteren-documentnaamcategorie) |
| FR8 | Controleren ticket |  |  | [Requirement overzicht](/Documentatie/Requirements/FR8_Controleren_ticket.md) |
| FR8.1 |  | Controleren ticket (intern) | Must have | [US7](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR8_Controleren_ticket.md#fr81-controleren-ticket), [US10](/Documentatie/FunctioneelOntwerp.md#user-stories) |
| FR8.2 |  | Op splitten taak naar team taken | Could have | [US7](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR8_Controleren_ticket.md#fr82-op-splitten-taak-naar-team-taken), [US10](/Documentatie/FunctioneelOntwerp.md#user-stories) |
| FR9 | Chat met tenants |  | Won't have | [Requirement overzicht](/Documentatie/Requirements/FR9_Tenant_level_chat.md), [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) |
| FR9.1 |  | Starten nieuwe chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR9_Tenant_level_chat.md#fr91-starten-nieuwe-chat), [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) |
| FR9.2 |  | Bericht sturen niet afgesloten chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR9_Tenant_level_chat.md#fr92-bericht-sturen-niet-afgesloten-chat), [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) |
| FR9.3 |  | Hervatten afgesloten chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR9_Tenant_level_chat.md#fr93-hervatten-afgesloten-chat), [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) |
| FR9.4 |  | Sluiten chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR9_Tenant_level_chat.md#fr94-sluiten-chat), [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) |
| FR10 | Beheren gebruikers |  |  | [Requirement overzicht](/Documentatie/Requirements/FR8_Controleren_ticket.md) |
| FR10.1 |  | Uitnodigen gebruiker | Must have |  |
| FR10.2 |  | Wijzigen rechten | Must have |  |
| FR10.3 |  | Verwijderen gebruiker | Must have |  |

