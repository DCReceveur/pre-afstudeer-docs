# Plan van aanpak Project Management Portal

## Inleiding

Binnen dit document wordt toelichting gegeven op het Project Management Portal dat als afstudeer opdracht ontwikkeld wordt voor Bluenotion. In de volgende hoofdstukken zal duidelijk gemaakt worden vanuit welke vraag de opdracht is ontstaan, het doel van de opdracht en worden verwachtingen geschept van de concreet te leveren producten, de kwaliteitseisen hiervan en hoe deze eisen bereikt dienen te worden.

## Achtergrond van het project

Bluenotion is een bedrijf met +/- 20 medewerkers dat naar opdracht op maat gemaakte software oplossingen aanbiedt. Dit houdt in dat er op elk moment bij Bluenotion voor verschillende opdrachtgevers aan verschillende (vaak kort durende) projecten wordt gewerkt.

```puml
rectangle CEO
rectangle Finance 
rectangle "Operationeel management" as OM
rectangle HR

rectangle "Project technisch/management" as PTM

rectangle Development

rectangle "User experience" as UX
rectangle "Front end" as FE
rectangle "Back end" as BE

CEO -- Finance
CEO -- OM
CEO -- HR

OM--PTM
PTM--Development

Development--UX
Development--FE
Development--BE
note bottom
    Daan Receveur
end note
```

<!-- TODO: organigram toelichten? -->

Met deze projectmatige wijze van maatwerk software oplossingen leveren heeft Bluenotion ondervonden dat de opdrachtgever bij het bouwproces betrekken een positieve invloed heeft op het algemene ontwikkelproces. Om deze reden is de opdracht "Een centraal portaal bouwen waar beide de klant en PM in kunnen samenwerken om inzicht te bieden in en controle te geven over project management" bedacht. Het idee voor dit project bestaat al een tijdje maar is wegens de lagere prioriteit van interne projecten nooit gebouwd.

Met het aanbod het project verder te laten uitwerken als afstudeer project zijn er intern resources beschikbaar gesteld voor verdere ontwikkeling.

## Doelstelling, opdracht & op te leveren resultaten

Binnen dit hoofdstuk wordt toegelicht welke delen in het huidig proces ervaren kunnen worden als probleem of uitdaging, wat het doel van Bluenotion is met deze opdracht, de opdracht omschrijving en een korte omschrijving van het uiteindelijk te leveren software pakket.

### Probleem/uitdaging

Op het moment worden te verrichte taken voor het bouwen van de software oplossingen bijgehouden in productive.io. De status van het project en de bijbehorende taken worden voornamelijk op de volgende twee manieren gecommuniceerd:

- Directe communicatie via de PM:
Voor de meeste projecten dient de Project manager als koppeling tussen klant en development team. Het is dan aan de Project manager om de huidige staat van het project tijdens vaste contactmomenten te communiceren en waar nodig nieuwe taken aan te maken voor het verwerken van feedback van de klant of het creëren van nieuwe functionaliteiten.
- Guest account in Productive:
Voor een aantal projecten zijn aan de klant accounts beschikbaar gesteld waarin ze direct inzicht kunnen krijgen in de status van het bouwproces. Hiermee kunnen ze real-time inzicht krijgen over de staat van het project en waar nodig zelf taken inschieten.

Beide manieren van het communiceren van de project status brengen voor- en nadelen met zich mee.

Het management volledig overlaten aan de Project manager heeft als resultaat dat de klant geen direct eenduidig overzicht heeft van de status van zijn/haar project en wanneer hij/zij dit wel wil wordt de werkdruk van de PM verhoogd.

Productive.io accounts beschikbaar stellen voor de klant heeft als resultaat dat de klant voor Bluenotion op een niet-Bluenotion portaal terecht komt waar de data ongefilterd en voor klanten mogelijk onduidelijk beschikbaar is. Per klant verschilt of dit leidt tot vragen over bestaande taken en incorrect toegevoegde nieuwe taken.

### Doelstelling

Aangezien Bluenotion voornamelijk maatwerk software bouwt wil Bluenotion dat de klant en ontwikkelaar in co-creatie samenwerken om tot de vereiste digitale oplossing te komen.

### Opdracht

Hiervoor dient een centraal portaal gebouwd te worden waar beide de klant en medewerkers van Bluenotion kunnen werken aan de zelfde projecten. Het PMP zal aan de hand van de onderstaande punten meehelpen aan deze doelstelling:

- De klantvriendelijkheid te vergroten
    Door de transparantie naar de klant te vergroten en de klant zelf te laten meewerken aan de planning van het project wordt de klantvriendelijkheid vergroot.
- Als centraal overzicht voor de PM/Klant
    Door de klant en de PM beiden via de zelfde portal te laten werken is het voor beiden partijen sneller duidelijk wat er gedaan moet worden en waar de ander vragen of opmerkingen over heeft.
- Communicatie kanaal voor de PM/Klant
    Door de communicatie over het aanmaken of prioriteren van taken via het PMP te laten lopen is het voor beide partijen gelijk inzichtelijk waar de ander het over heeft.
- Stroomlijnen development proces
    Door de klant meer input te geven over het plannings proces is de hoop dat onduidelijke taken verduidelijkt worden voordat ze bij developers terecht komen.
- Borgen van kennis over projecten
    Kennis als handleidingen of deployment informatie kunnen aangeleverd worden op de zelfde plek als waar de klant inzicht heeft in de ontwikkeling van het project.

### Concrete resultaten

Een applicatie met een C# back-end (.NET), Typescript front-end (React Native) waar een externe beheerder of interne PM de huidige staat van projecten zijn/haar kan inzien en/of nieuwe taken kan inschieten. De te maken applicatie dient informatie over projecten en de bijbehorende tickets inzichtelijk te maken voor de klant van Bluenotion en communicatie kanalen te bieden die de klant betrekken in het proces vanaf het indienen van een aanvraag tot de deployment op de live omgeving van de klant.

Het gebruik van .NET en React Native staat niet vast, als er tijdens de loop van het project goede argumenten zijn voor het gebruik van andere frameworks en/of talen kan er van af gestapt worden. Aangezien er inhouse veel kennis is en doorgaans gewerkt wordt met .NET back-end en React front-end is voor de onderhoudbaarheid de keuze gemaakt dit ook als uitgangspunt te nemen.

## Project grenzen

- Het projectmanagement portal wordt niet ontwikkeld als vervanging van Productive.io voor het dev team of de PM/TL. Enkel voor de communicatie met de externe beheerder.
- Het project wordt in ieder geval door ontwikkeld tot 25-01-2025

<!-- TODO: Grenzen overleggen -->

## Randvoorwaarden

- Bluenotion levert na akkoord op de software architectuur de infrastructuur waar het PMP kan draaien.
- Bluenotion levert een werkplek met laptop waar aan het PMP gewerkt kan worden.
- Bluenotion stelt op zijn minst 1x in de 2 weken een medewerker beschikbaar voor het geven van feedback op het project.
- Bluenotion stelt een Productive account beschikbaar met de juiste rechten om de gevraagde functionaliteit te behalen.

## Op te leveren producten en kwaliteitseisen en uit te voeren activiteiten

Binnen dit project worden de volgende producten opgeleverd.

| Product  | ProductKwaliteitseisen  | Benodigde activiteiten om te komen tot het product  | Proceskwaliteit (5 x W 1 x H)  |
|---|---|---|---|
| Plan van aanpak  | - De opdrachtgever heeft afgetekend op het plan van aanpak. </br>- Geeft inzicht over de achtergrond, doelstelling en op te leveren resultaten van het project.</br>- Backend het project af met duidelijke project grenzen en randvoorwaarden.</br>- Op te leveren producten, kwaliteitseisen en uit te voeren activiteiten zijn aan de hand van [SMAR(T)](https://en.wikipedia.org/wiki/SMART_criteria)(Robertlbogue, 2007) en [5xW 1xH beschreven](https://www.lean.nl/wat-is-de-5-x-w-1h-doorvraag-methode-green-belt/)(Admin, 2024).</br>- De ontwikkelmethodiek is vastgelegd</br>- Voor elke tijdens de stage relevante partij zijn contactgegevens vastgelegd.</br>- Er is een globale planning aanwezig met alle aan te leveren producten.</br>- Risico’s zijn vastgelegd met tegen maatregels en uitwijk strategieën  | - Bespreking project met PM en TL om de informatie voor het document te verzamelen </br>- Aan de hand van de PvA handleiding van de HAN (HAN, 2024) het document schrijven.  | - De developer zet in de eerste sprint het PvA op en loopt deze met de opdrachtgever door in de sprint review. </br>- Bespreking met PM die het systeem zou gebruiken de functionele aspecten van het project te controleren.</br>- Bespreking met TL om de technische aspecten van het project te controleren.  |
| Functioneel Ontwerp  | - Bevat een genummerde lijst van alle voor het project relevante stakeholders.</br>- Bevat een genummerde lijst van alle Functionele en non-functionele wensen volgens FURPS+(FURPS+, z.d.)</br> - Bevat de happy flow van de software in wireframes/mockups</br> -Bevat een Usecase diagram</br> -Bevat een domein model</br> -Functionele requirements zijn uitgewerkt naar fully dressed usecases (Studocu, z.d.)</br> -Bevat alternative flows die als relevant worden beoordeeld door de opdrachtgever, productmanager of techlead. </br>- Bevat een deployment diagram (GeeksforGeeks, 2024) met de voorgestelde omgeving waar het PMP in draait.   | - Gesprek met opdrachtgever om de wensen en stakeholders vast te leggen.</br> - (Optioneel) Gesprek met verdere stakeholders voor verduidelijking wensen.</br> - Gesprek met collega’s van UX om tot goed te gebruiken mockups te komen.</br> - Domein model maken op basis UX en gesprek opdrachtgever/stakeholders.</br> - Wensen opdelen in functioneel en non-functioneel</br> - Functionele wensen vastleggen in fully dressed usecases met [MoSCoW](https://www.productplan.com/glossary/moscow-prioritization/) prioritering.(MOSCOW Prioritization, 2022)  | - Aanpassingen binnen het document dienen gecontroleerd te worden aan de hand van de [DoR](kwaliteitseisen.md#definition-of-ready)</br> - Tijdens de sprint reviews dient het document als basis voor de presentatie tegenover de opdrachtgever.</br> - Wijzigingen en het FO en TO worden direct meegenomen in PR's die de wijzigingen doen.  |
| Onderzoek: Productive communicatie  | Beantwoord in ieder geval de volgende vragen: </br> - Biedt productive een API aan voor alle data die binnen het FO en schermontwerpen besproken worden? </br> - Hoe blijft het systeem up to date met wijzigingen gedaan in Productive? </br> - Hoe worden wijzigingen gedaan in het PMP doorgegeven aan Productive? </br> - Kan het systeem "oneindig" (los van Productive) schalen?</br>- Is het nodig de huidige data uit productive in een lokale database weg te schrijven of kan het systeem op requests werken?</br>- Moeten er aparte endpoints gemaakt worden binnen het PMP voor de communicatie met Productive of kan er (netjes) gebruik gemaakt worden van de endpoints die de front-end ook gebruikt?  | - Vergelijking tussen gewenste data stakeholders en aangeboden data Productive API. </br>- Verschillende voorstellen voor data synchronisatie tussen de systemen op basis van FR's en NFR's. | - Voor het starten van het onderzoek dienen de FR's en NFR's goedgekeurd te worden door de PM en TL. </br>- Voor het PoC wordt gebouwd voor de potentiële oplossing dient een testplan opgezet te worden met meetbare eisen. |
| PoC: Productive communicatie | - Houdt zich aan de alle NFR's. | - Antwoord op de vragen zoals besproken in het Onderzoek over Productive communicatie</br>- Een testplan met meetbare acceptatie criteria. | Na het beantwoorden van de vragen van het Productive communicatie onderzoek dient er een proof of concept opgezet te worden die de data aan de hand van de in het onderzoek gekozen methodiek synchroniseert met een lokale database. |
| Technisch ontwerp  | - Bevat een klasse diagram die overeenkomt met de software in zijn huidige staat.</br> - Bevat een package diagram die overeenkomt met de software in zijn huidige staat.</br> - Bevat een deployment diagram die overeenkomt met de software in zijn huidige staat.</br> - Bevat een Database model die de huidige staat van de database representeert.</br> - Bevat een API-definitie met alle binnen de applicatie beschikbare end-points en de relevante producers/consumers.  | - Maak een klasse diagram aan op basis van het domeinmodel en de initiële wensen.</br> - Maak een package diagram aan op basis van gekozen software architectuur.</br> - Maak een deployment diagram aan op basis van de gekozen software architectuur</br> - Maak een database model aan op basis van het domeinmodel en de in het FO aanwezige wensen.</br> - Maak een API-definitie voor elk blootgestelde endpoint. (Automatiseren AHV swagger?)</br> - Werk het klasse diagram bij wanneer functionaliteiten hier wijzigingen in aanbrengen ([DoD](kwaliteitseisen.md#definition-of-done)).  | Wijzigingen en het FO en TO worden direct meegenomen in PR's die de wijzigingen doen.</br> - Wanneer een taak resulteert in wijzigingen in een van de in het TO aanwezige diagrammen dienen deze diagrammen en de bijbehorende toelichting bijgewerkt te worden voor de taak af is ([DoD](kwaliteitseisen.md#definition-of-done))  |
| Code  | - Code & comments worden in het engels te schrijven</br> - Code is herleidbaar naar oorsprong in het FO/TO</br> - Er wordt waar praktisch mogelijk rekening gehouden met [CLEAN](https://refactoring.guru/refactoring/what-is-refactoring)(Refactoring.Guru, z.d.) en [SOLID](https://www.digitalocean.com/community/conceptual-articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design) coding principles.(SOLID: The First 5 Principles Of Object Oriented Design \| DigitalOcean, z.d.)</br> - Frontend code wordt geanalyseerd door [ESLint](https://eslint.org/).</br> - Backend code wordt geanalyseerd door [StyleCop](https://github.com/StyleCop/StyleCop).</br> - Code formatting wordt gedaan aan de hand van Editorconfig en prettier.  | - Voordat logica geschreven wordt worden alle relevante constructors en functie signatures klaargezet met de oorsprong in comments boven de signature.</br> - ESLint, StyleCop, Editorconfig en Prettier dienen geïnstalleerd en gebruikt te worden.  | - Voor het maken van een PR worden de wijzigingen vergeleken met de [DoD](kwaliteitseisen.md#definition-of-done).  |
| Software architecture document  | - Bevat een globaal overzicht van het systeem en de data flows die hierin voorkomen volgens het [4C model](https://c4model.com/).(The C4 Model For Visualising Software Architecture, z.d.)</br> - Bevat verantwoording voor alle [architecturaal relevante gemaakte keuzes](https://medium.com/oolooroo/a-step-wise-guide-to-architectural-decisions-ee7304871a71)(Paradkar, 2023) binnen het project.</br> - Bevat een overzicht van alle Architectural Relevant Decisions  | - De globale dataflow dient vastgelegd te worden na het vaststellen van de eerste requirements van de software.</br> - Wanneer een ADR wordt genomen dient deze de dag zelf nog in het SAD gezet te worden.  | Het SAD dient over de levensduur van het project ADR geüpdatet te worden volgens het [TwinPeaks Model](https://www.microtool.de/en/knowledge-base/what-is-the-twin-peaks-model/). (Haefke, 2024)  |
| Testplan & Testrapport  | - Het test plan is aan het eind van elke sprint een accurate representatie van de staat van het project.</br> - Het testplan bevat voor elke usecase de happy flow.</br> - Het testplan bevat alternative flows voor scenario’s waar de opdrachtgever dit belangrijk acht.  | - In het testplan worden happy flows opgenomen zodra de bijbehorende usecases “Done” zijn.</br> - Alternative flows worden overlegd met de opdrachtgever, techlead of productmanager en indien ze complex zijn of om andere reden er een wens is alt flows toe te lichten worden ze meegenomen in het FO en Testrapport.  | - Het testrapport wordt op de laatste dag van elke sprint opnieuw ingevuld.  |
| Afstudeerverslag | - Het afstudeerverslag is niet langer dan 6.000 woorden of 15 pagina's (exclusief samenvatting, inhoudsopgave, bronvermeldingen en bijlagen)</br> - Alle beoordelingscriteria (BC1 tm BC5) uit het beoordelingsformulier afstuderen ICT 2020-2021 van de Afstudeerhandleiding HBO-ICT en CMD 2024-2026 zijn met een voldoende afgevinkt. </br> | - Woorden & pagina teller in de gaten houden tijdens het schrijven van het verslag </br> - Feedback vragen aan de docent begeleider </br>- Ingevuld beoordelingsformulier afstuderen ICT 2020-2021 | - De beoordeling criteria en bijbehorende prestatie criteria in een verslag template zetten aan het begin van de stage en wanneer ze aan bod komen de bijbehorende hoofdstukken aanvullen. </br>- Indien halverwege de stage BC's of PC's blijven nog niet ingevuld zijn dit aangeven bij de bedrijf of docent begeleider met vraag om advies dit te rectificeren. </br>- Elke vrijdag de tijd nemen belangrijke informatie weg te schrijven in het afstudeerverslag |
| Eindpresentatie  | - Er wordt een presentatie gegeven van 20 tot 30 minuten over het afstudeerproject | - Het stage verslag maken.</br> - Presentatie voorbereiden | - Aan het eind van de stage het proces als vastgelegd in het afstudeerverslag in een powerpoint zetten. |
| Opleverdocument | - Bevat een kort overzicht van de aangeleverde software en de bijbehorende functionaliteiten op basis van het testrapport. </br>- Bevat een deployment diagram met stappenplan om de software vanaf niets op te zetten. </br>- Bevat een kort overzicht van eventuele toekomstige uitbreidingen. | - Testrapport maken en invullen</br>- Functionaliteiten lijst nalopen met implementatie status</br>- Deployment instructies schrijven</br>- Samenvatten van belangrijke beslissingen uit het SAD, FO en TO</br>- Noteren potentiële aandachtspunten en uitbreidingsmogelijkheden | - In sprint 9 de gemaakte software vergelijken met de gemaakte documentatie en de hiervoor genoemde punten nalopen. |

## Ontwikkelmethoden

Het project wordt voornamelijk door één software developer uitgevoerd. Daar waar gewenst zijn binnen Bluenotion collega's beschikbaar voor feedback en tips op het gebied van Project management, UX, FE en het programmeren zelf maar deze collega's zijn in hun dagelijks werk aan het werk aan andere projecten.

Aangezien binnen Bluenotion vaker met kleine teams tegelijkertijd aan verschillende projecten wordt gewerkt hanteren ze hier een lichtere vorm van SCRUM dan die aangegeven in het [SCRUM manifesto](https://agilescrumgroup.nl/scrum-manifesto/)(Sania, 2023). Om de voortgang van het project voor alle stakeholders duidelijk te houden wordt er wel gewerkt in sprints van 2 weken per stuk waar aan het eind van elke sprint concrete deliverables worden aangeleverd.

Deze [deliverables](#planning) worden besproken tijdens een sprint review waar stakeholders de optie hebben feedback te geven en het project bij te sturen. De review is de enige Scrum ceremonie die met regelmaat wordt uitgevoerd en dient tevens als retrospective en planning voor de volgende sprint.

### Ceremonies

Zoals eerder vermeld wordt er een lichtere vorm van SCRUM gehandhaafd dan de vorm zoals aangegeven in het SCRUM manifesto. Dit is voornamelijk terug te zien in de vorm die de SCRUM ceremonies aanhouden.

Daily standup:

Zolang er zoals vermeld in de [ontwikkelmethoden](#ontwikkelmethoden) niet dagelijks samengewerkt wordt met collega's brengt een daily stand up weinig toegevoegde waarde dus wordt deze niet meegenomen in de actieve ontwikkelmethode. Als er dagelijks vaker in teams gewerkt wordt kan dit veranderen.

Sprint retrospective:

Zolang er niet regelmatig binnen een team wordt gewerkt wordt ook de retrospective niet meegenomen als aparte ceremonie. Dit omdat er tijdens de retrospective wordt gereflecteerd op het handelen en samenwerken van het team. Om de waarde van de retrospective toch niet volledig te niet te doen krijgen de bedrijfsbegeleider en opdrachtgever (beiden stakeholders van het PMP) aan het eind van sprint review het verzoek het liefst aan de hand van de zeester methode feedback te geven op de kwaliteit van de doorlopen processen.

Sprint review:

De sprint review wordt grotendeels gehouden zoals beschreven in het [SCRUM manifesto](https://agilescrumgroup.nl/scrum-manifesto/). De in de afgelopen sprint gemaakte functionaliteit wordt aan de stakeholders voorgelegd met de vraag hier feedback op te geven. Hierna wordt samen met de stakeholders een planning opgezet voor de volgende sprint en de functionaliteiten die de stakeholders graag zouden willen zien in de volgende sprint. Door deze twee acties wordt er over de loop van het project oog gehouden op of het geleverde werk overeen komt met de wensen van de opdrachtgever en de andere stakeholders.

## Projectorganisatie en communicatie

| Rol(len): | **Student** |
|---|---|
| Naam: | Daan Receveur |
| Contactgegevens: | <daan@bluenotion.nl> |
| Contactmomenten: | Maandag tm vrijdag 9 tm 17:30 |
| Verantwoordelijkheden | - Plannen en uitvoeren van het afstudeerproject. </br> - Plannen van de begeleidingsafspraken en communicatie met de docentbegeleider en bedrijfsbegeleider. |

| Rol(len): | **Bedrijfsbegeleider** |
|---|---|
| Naam: | Yannic Smeets |
| Contactgegevens: | <yannic@bluenotion.nl> |
| Contactmomenten | Sprint review |
| verantwoordelijkheden | Feedback/mogelijkheid tot sparren over technische aspecten van het project. |

| Rol(len): | **Opdrachtgever** |
|---|---|
| Naam: | Jesse Bekke |
| Contactgegevens: | <jesse@bluenotion.nl> |
| Contactmomenten: | Sprint review |
| verantwoordelijkheden: | Feedback/mogelijkheid tot sparren over functionele aspecten van het project. |

| Rol(len): | **UX Designer** |
|---|---|
| Naam: | Roel Dekkers |
| Contactgegevens: | <Roel@bluenotion.nl> |
| Contactmomenten | Op aanvraag |
| verantwoordelijkheden | Brainstormen en feedback leveren op de user experience |

| Rol(len): | **FE Developer** |
|---|---|
| Naam: | Jelle Streefkerk |
| Contactgegevens: | Jelle@bluenotion.nl |
| Contactmomenten | Op aanvraag |
| verantwoordelijkheden | Brainstormen en feedback leveren op de development van de FE |

| Rol(len): | **Docentbegeleider** |
|---|---|
| Naam: | Niek van Diepen |
| Contactgegevens: | <Niek.vanDiepen@han.nl> |
| Contactmomenten | Op aanvraag |
| verantwoordelijkheden | Voor beoordeling van de beroepsproducten en afstudeerverslagen. |

## Planning

Zoals besproken in het hoofdstuk Ontwikkelmethoden hebben sprints een duur van 2 werkweken, met een stageperiode van 18 weken komt dit uit op 9 sprints. Aangezien de wensen voor het Minimal Viable Product al redelijk vast staan worden deze wensen gebruikt als basis van de UX ontwerpen. Door in een vroeg stadium de belevingservaring van de klant in kaart te brengen wordt eerder gewerkt naar iets dat de klant ook daadwerkelijk wilt gebruiken. Naast de belevingservaring wordt er ook in een vroeg stadium gekeken naar waar de benodigde data vandaan gaat komen aan de hand van een Productive communicatie onderzoek om potentiële uitdagingen met de synchronisatie van data tussen het PMP en Productive vroegtijdig tegen te komen.

Opmerking over de planning: Binnen de planning wordt gesproken over het "afronden" van project documentatie. In realiteit is de documentatie op dit punt geen laatste versie die niet meer aangepast wordt maar is het nog een levend document wegens de iteratieve ontwikkeling van de gekozen [ontwikkelmethode](#ontwikkelmethoden). In de context van de globale planning is een "afgerond" document een document dat voldoet aan de [DoD en eventueel de DoR](./kwaliteitseisen.md).

| Sprint | Werkzaamheden | Op te leveren producten |
|---|---|---|
| Sprint 1 | Probleem vastleggen, plan van aanpak schrijven, functionaliteiten vastleggen. | PVA, actors, user stories, Functionele requirements |
| Sprint 2 | Functioneel ontwerp schrijven, start software architecture document, identificeren potentiële technische uitdagingen, start Productive communicatie onderzoek | NFR's, domein model, onderzoeksplan, SAD context & containers  |
| Sprint 3 | UX/UI ontwerpen, FO "afronden", start maken TO, SAD aanvullen, Productive communicatie onderzoek | Fully dressed usecases, wireframes/mock-ups, SAD Components, Productive communicatie POC |
| Sprint 4 | Communicatie onderzoek afronden, start maken uiteindelijke software oplossing | Communicatie onderzoek, SAD Code, API endpoint definities, start back-end incl database & model |
| Sprint 5 | Start maken front-end systeem | TO alle views & components front-end voor must en should haves |
| Sprint 6 | TO "afronden", SAD "afronden", implementatie FE & BE | Technisch ontwerp, SAD, implementatie must haves |
| Sprint 7 | Implementatie PMP koppeling met Productive, implementatie FE & BE | implementatie must haves |
| Sprint 8 | Implementatie uitloop | Uitloop implementatie |
| Sprint 9 | Implementatie uitloop | Uitloop implementatie |

## Risico’s

| **Risico**   | **Kans** | **Impact** | **Tegenmaatregel**  | **Uitwijkstrategie**  |
|---|---|---|---|---|
| Langdurige ziekte | Klein    | Middel     | ?     | Thuis werken   |
| Verlies data development machine | Klein | Klein  | Zorg ervoor dat wijzigingen elke dag online worden gezet  | Herstel vanuit git & cloud storage.                                                            |
| Productive.io API is niet toereikend aan het project | Klein    | Middel     | Overleg met productive.io of er wijzigingen mogelijk zijn  | Overleg met opdrachtgever over wat te doen met de functionaliteit die de API niet ondersteund. |
| Wijzigingen in de Productive API zorgen er voor dat gemaakte functionaliteit refactored moet worden  | middel  | middel  | In de gaten houden Productive API changes feed en handelen wanneer een gebruikte endpoint wordt aangepast.  | Bij te korte support oude API endpoint contact opnemen met Productive support om opties te bespreken. |

## Bronnen

- Admin. (2024, 20 augustus). Wat Is De 5 x W + 1H Doorvraag Methode in Lean? | Lean.nl. Lean.nl. <https://www.lean.nl/wat-is-de-5-x-w-1h-doorvraag-methode-green-belt/>
- FURPS+. (z.d.). <http://agileinaflash.blogspot.com/2009/04/furps.html>
- GeeksforGeeks. (2024, 6 maart). Deployment diagram in Unified Modeling Language(UML). GeeksforGeeks. <https://www.geeksforgeeks.org/deployment-diagram-unified-modeling-languageuml/>
- Haefke, E. (2024, 14 februari). What Is the Twin Peaks Model? | microTOOL. microTOOL. <https://www.microtool.de/en/knowledge-base/what-is-the-twin-peaks-model/>
- MOSCOW Prioritization. (2022, 21 december). ProductPlan. <https://www.productplan.com/glossary/moscow-prioritization/>
- Paradkar, S. (2023, 24 november). A Step-Wise Guide to Architectural Decisions - Oolooroo - Medium. Medium. <https://medium.com/oolooroo/a-step-wise-guide-to-architectural-decisions-ee7304871a71>
- Refactoring.Guru. (z.d.). Clean code. <https://refactoring.guru/refactoring/what-is-refactoring>
- Robertlbogue. (2007, 8 juni). Use S.M.A.R.T. goals to launch management by objectives plan. TechRepublic. <https://www.techrepublic.com/article/use-smart-goals-to-launch-management-by-objectives-plan/>
- Sania, L. (2023, 4 oktober). Het Scrum Manifesto: de 6 principes en hun waarden. Agile Scrum Group. <https://agilescrumgroup.nl/scrum-manifesto/>
- SOLID: The First 5 Principles of Object Oriented Design | DigitalOcean. (z.d.). <https://www.digitalocean.com/community/conceptual-articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design>
- Studocu. (z.d.). Fully Dressed Use Case Example pdf - computer sciences - Riphah - Studocu. <https://www.studocu.com/row/document/riphah-international-university/computer-sciences/fully-dressed-use-case-example-pdf/19676384>
- The C4 model for visualising software architecture. (z.d.). <https://c4model.com/>
