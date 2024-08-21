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
 
usecase "FR1.1: Inzien projecten \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR1_1 #FF9999 
usecase "FR1: Inzien project plannings informatie" as FR1 
usecase "FR1.2: Inzien totaal geplande uren+kosten \n <color:#FF0000> <size:20>●</size></color>" as FR1_2 #999999 
usecase "FR2.1: Inzien taken van project \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR2_1 #FF9999 
usecase "FR2.2: Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR2_2 #FF9999 
usecase "FR2.3: Inzien taak details \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR2_3 #FF9999 
usecase "FR2: Inzien taken" as FR2 
usecase "FR2.4: Tonen taken in Gantt chart \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR2_4 #BB9999 
usecase "FR3.1: Toevoegen nieuwe taak \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_1 #FF9999 
usecase "FR3.2: Toelichting geven op aanvraag (extern) \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_2 #FF9999 
usecase "FR3.3: Toevoegen taken past zich aan aan de klant zijn SLA \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_3 #BB9999 
usecase "FR3.4: Toevoegen bijlagen bij taak \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>●</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_4 #FF9999 
usecase "FR3.5: Aanpassen taak prioriteit \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_5 #BB9999 
usecase "FR3: Toevoegen aanvraag" as FR3 
usecase "FR3.6: Annuleren aanvraag \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR3_6 #DD9999 
usecase "FR4.1: Inlichten klant wanneer een taak wacht op input van de klant \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR4_1 #DD9999 
usecase "FR4: Versturen notificaties" as FR4 
usecase "FR4.2: Inlichten Bluenotion bij blockers/criticals \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR4_2 #BB9999 
usecase "FR5.1: Afhandelen project setup binnen PMP \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR5_1 #BB9999 
usecase "FR5.2: Instellen productive boards & taak status \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR5_2 #BB9999 
usecase "FR5.3: Beheren project documentatie \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR5_3 #BB9999 
usecase "FR5: Beheren project" as FR5 
usecase "FR5.3: Beheren project services \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR5_3 #BB9999 
usecase "FR6.1: Inzien lijst van project dependencies \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR6_1 #BB9999 
usecase "FR6: Inzien project service statuses" as FR6 
usecase "FR6.2: Inzien huidige status (online/offline) project dependencies \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR6_2 #BB9999 
usecase "FR7.1: Openen/downloaden document \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR7_1 #BB9999 
usecase "FR7: Inzien project documentatie" as FR7 
usecase "FR7.2: Filteren documentnaam/categorie \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR7_2 #BB9999 
usecase "FR8.1: Controleren aanvraag (intern) \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR8_1 #FF9999 
usecase "FR8: Controleren aanvraag" as FR8 
usecase "FR8.2: Op splitten taak naar team taken \n <color:#999999> <size:20>●</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR8_2 #BB9999 
usecase "FR9.1: Starten nieuwe chat \n <color:#FF0000> <size:20>●</size></color>" as FR9_1 #999999 
usecase "FR9.2: Bericht sturen niet afgesloten chat \n <color:#FF0000> <size:20>●</size></color>" as FR9_2 #999999 
usecase "FR9.3: Hervatten afgesloten chat \n <color:#FF0000> <size:20>●</size></color>" as FR9_3 #999999 
usecase "FR9: Chat met tenants" as FR9 
usecase "FR9.4: Sluiten chat \n <color:#FF0000> <size:20>●</size></color>" as FR9_4 #999999 
usecase "FR10.1: Uitnodigen gebruiker \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR10_1 #FF9999 
usecase "FR10.2: Wijzigen rechten \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR10_2 #FF9999 
usecase "FR10: Beheren gebruikers" as FR10 
usecase "FR10.3: Verwijderen gebruiker \n <color:#999999> <size:20>○</size></color> <color:#AA55AA> <size:20>○</size></color> <color:#349034> <size:20>○</size></color> <color:#02CB02> <size:20>○</size></color> <color:#00FF00> <size:20>○</size></color>" as FR10_3 #FF9999
 
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
      
      FR5 -DOWN->  FR5_3
       
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
   | **Done** | **Planned** | **Milestone** |
   | <color:#999999><size:20>●</size></color> | <color:#999999><size:20>○</size></color>| Define |
   | <color:#AA55AA><size:20>●</size></color> | <color:#AA55AA><size:20>○</size></color>| UX |
   | <color:#349034><size:20>●</size></color> | <color:#349034><size:20>○</size></color>| FE |
   | <color:#02CB02><size:20>●</size></color> | <color:#02CB02><size:20>○</size></color>| BE |
   | <color:#00FF00><size:20>●</size></color> | <color:#00FF00><size:20>○</size></color>| Testing |
   | <color:#FF0000><size:20>●</size></color> | <color:#FF0000><size:20>○</size></color>| Rejected |

  | **Task color** | **Priority** |
  | <#FF9999> | Must have |
  | <#DD9999> | Should have |
  | <#BB9999> | Could have |
  | <#999999> | Won't have |
  end legend
```
 
| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Document references | Status |
|---|---|---|---|---|---|
| FR1 | Inzien project plannings informatie |  |  | [Requirement overzicht](/Documentatie/Requirements/FR1_Inzien_project_plannings_informatie.md) |  |
| FR1.1 |  | Inzien projecten | Must have | [US1](/Documentatie/FunctioneelOntwerp.md#user-stories), [US2](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR1_Inzien_project_plannings_informatie.md#fr11-alternative-flow---no-projects-for-customer) | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR1.2 |  | Inzien totaal geplande uren+kosten | Won't have FDR001 | [US3](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR1_Inzien_project_plannings_informatie.md#fr12-inzien-totaal-geplande-urenkosten), [FDR001](../Decisions/Functional/FDR001-Tijd-en-kosten-niet-tonen.md) | [x] Rejected |
| FR2 | Inzien taken |  |  | [Requirement overzicht](/Documentatie/Requirements/FR2_Inzien_taken.md) |  |
| FR2.1 |  | Inzien taken van project | Must have | [US3](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR2_Inzien_taken.md#fr21-inzien-taken-van-project) | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR2.2 |  | Filteren taken op: waiting for feedback intern+extern, open, staging/testing, closed | Must have | [US3](/Documentatie/FunctioneelOntwerp.md#user-stories), [US8](/Documentatie/FunctioneelOntwerp.md#user-stories), [US9](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR2_Inzien_taken.md#fr22-filteren-taken-op-waiting-for-feedback-internextern-open-stagingtesting-closed) | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR2.3 |  | Inzien taak details | Must have | [US3](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR2_Inzien_taken.md#fr23-inzien-taak-details)  | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR2.4 |  | Tonen taken in Gantt chart | Could have | [US3](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR2_Inzien_taken.md#fr24-main-flow) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3 | Toevoegen aanvraag |  |  | [Requirement overzicht](/Documentatie/Requirements/FR3_Toevoegen_aanvraag.md) |  |
| FR3.1 |  | Toevoegen nieuwe taak | Must have | [US6](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR3_Toevoegen_aanvraag.md#fr31-toevoegen-nieuwe-aanvraag-in-een-project) | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3.2 |  | Toelichting geven op aanvraag (extern) | Must have | [US7](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR3_Toevoegen_aanvraag.md#fr32-toelichting-geven-op-aanvraag) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3.3 |  | Toevoegen taken past zich aan aan de klant zijn SLA | Could have | [Fully dressed usecase description](/Documentatie/Requirements/FR3_Toevoegen_aanvraag.md#fr33-toevoegen-taken-past-zich-aan-aan-de-klant-zijn-sla) | [ ] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3.4 |  | Toevoegen bijlagen bij taak | Must have | [US12](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR3_Toevoegen_aanvraag.md#fr34-toevoegen-bijlagen-bij-taak) | [x] Define  </br> [x] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3.5 |  | Aanpassen taak prioriteit | Could have | [Fully dressed usecase description](/Documentatie/Requirements/FR3_Toevoegen_aanvraag.md#fr35-aanpassen-taak-prioriteit) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR3.6 |  | Annuleren aanvraag | Should have | [Fully dressed usecase description](./Requirements/FR3_Toevoegen_aanvraag.md#fr36-annuleren-aanvraag) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR4 | Versturen notificaties |  |  | [Requirement overzicht](/Documentatie/Requirements/FR4_Versturen_notificaties.md) |  |
| FR4.1 |  | Inlichten klant wanneer een taak wacht op input van de klant | Should have | [US9](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR4_Versturen_notificaties.md#fr41-inlichten-klant-wanneer-een-taak-wacht-op-input-van-de-klant) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR4.2 |  | Inlichten Bluenotion bij blockers/criticals | Could have | [Fully dressed usecase description](/Documentatie/Requirements/FR4_Versturen_notificaties.md#fr42-inlichten-bluenotion-bij-blockerscriticals) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR5 | Beheren project |  |  |  |  |
| FR5.1 |  | Afhandelen project setup binnen PMP | Could have | [US19](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR5_Beheren_project.md#fr51-afhandelen-project-setup)  | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR5.2 |  | Instellen productive boards & taak status | Could have | [US20](#user-stories) [FR5.2](./Requirements/FR5_Beheren_project.md#fr52-instellen-productive-boards-en-taak-status) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR5.3 |  | Beheren project documentatie | Could have |  [Fully dressed usecase description](/Documentatie/Requirements/FR7_Inzien_project_documentatie.md#fr73-beheren-project-documentatie) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR5.3 |  | Beheren project services | Could have | [Fully dressed usecase description](/Documentatie/Requirements/FR6_Inzien_project_service_statuses.md#fr63-beheren-project-services) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR6 | Inzien project service statuses |  |  | [Requirement overzicht](/Documentatie/Requirements/FR6_Inzien_project_service_statuses.md)  |  |
| FR6.1 |  | Inzien lijst van project dependencies | Could have | [US13](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR6_Inzien_project_service_statuses.md#fr61-inzien-lijst-van-project-dependencies) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR6.2 |  | Inzien huidige status (online/offline) project dependencies | Could have | [US13](/Documentatie/FunctioneelOntwerp.md#user-stories),[Fully dressed usecase description](/Documentatie/Requirements/FR6_Inzien_project_service_statuses.md#fr62-inzien-huidige-status-onlineoffline-project-dependencies) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR7 | Inzien project documentatie |  |  | [Requirement overzicht](/Documentatie/Requirements/FR7_Inzien_project_documentatie.md) |  |
| FR7.1 |  | Openen/downloaden document | Could have | [US13](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR7_Inzien_project_documentatie.md#fr71-openendownloaden-document) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR7.2 |  | Filteren documentnaam/categorie | Could have | [US13](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR7_Inzien_project_documentatie.md#fr72-filteren-documentnaamcategorie) | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR8 | Controleren aanvraag |  |  | [Requirement overzicht](/Documentatie/Requirements/FR8_Controleren_aanvraag.md) |  |
| FR8.1 |  | Controleren aanvraag (intern) | Must have | [US7](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR8_Controleren_aanvraag.md#fr81-controleren-aanvraag), [US10](/Documentatie/FunctioneelOntwerp.md#user-stories) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR8.2 |  | Op splitten taak naar team taken | Could have | [US7](/Documentatie/FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR8_Controleren_aanvraag.md#fr82-op-splitten-taak-naar-team-taken), [US10](/Documentatie/FunctioneelOntwerp.md#user-stories) | [x] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR9 | Chat met tenants |  | Won't have | [Requirement overzicht](/Documentatie/Requirements/FR9_Tenant_level_chat.md), [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) |  |
| FR9.1 |  | Starten nieuwe chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR9_Tenant_level_chat.md#fr91-starten-nieuwe-chat), [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) | [x] Rejected |
| FR9.2 |  | Bericht sturen niet afgesloten chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR9_Tenant_level_chat.md#fr92-bericht-sturen-niet-afgesloten-chat), [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) | [x] Rejected |
| FR9.3 |  | Hervatten afgesloten chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR9_Tenant_level_chat.md#fr93-hervatten-afgesloten-chat), [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) | [x] Rejected |
| FR9.4 |  | Sluiten chat | Won't have | [US20](./FunctioneelOntwerp.md#user-stories), [Fully dressed usecase description](/Documentatie/Requirements/FR9_Tenant_level_chat.md#fr94-sluiten-chat), [FDR002](./Decisions/Functional/FDR002-Tenant-level-chat.md) | [x] Rejected |
| FR10 | Beheren gebruikers |  |  | [Requirement overzicht](/Documentatie/Requirements/FR8_Controleren_aanvraag.md) |  |
| FR10.1 |  | Uitnodigen gebruiker | Must have |  | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR10.2 |  | Wijzigen rechten | Must have |  | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |
| FR10.3 |  | Verwijderen gebruiker | Must have |  | [ ] Define  </br> [ ] UX  </br> [ ] FE  </br> [ ] BE  </br> [ ] Testing |

