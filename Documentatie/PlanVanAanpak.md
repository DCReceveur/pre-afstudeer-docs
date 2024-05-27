# Plan van aanpak Project Management Portal

## Inleiding

Binnen dit document wordt toelichting gegeven op het Project Management Portal dat als afstudeer opdracht ontwikkeld wordt voor Bluenotion. In de volgende hoofdstukken zal duidelijk gemaakt worden vanuit welke vraag de opdracht is ontstaan, het doel van de opdracht en worden verwachtingen geschept van de concreet te leveren producten, de kwaliteitseisen hiervan en hoe deze eisen bereikt dienen te worden.

## Achtergrond van het project

Bluenotion is een bedrijf dat naar opdracht op maat gemaakte software oplossingen aanbiedt. Dit houdt in dat er op elk moment bij Bluenotion voor verschillende opdrachtgevers aan verschillende (vaak kort durende) projecten wordt gewerkt.

Met deze projectmatige wijze van maatwerk software oplossingen leveren heeft Bluenotion ondervonden dat de opdrachtgever bij het bouwproces betrekken een positieve invloed heeft op het algemene ontwikkelproces. Om deze reden is de opdracht "Een centraal portaal bouwen waar beide actoren in kunnen werken. Zodat alle informatie aangaande het proces geborgen wordt in een single point of truth" bedacht. Het idee voor dit project bestaat al een tijdje maar is wegens de lagere prioriteit van interne projecten nooit gebouwd.

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
    Kennis als handleidingen of deployment informatie kunnen aangeleverd worden op de zelfde plek als waar de klant inzicht heeft in de ontwikkeling van het project. (TODO: navragen aanleveren documenten op het moment)

### Concrete resultaten

Een applicatie met een C# back-end (.NET), Typescript front-end (React Native) waar een externe klant of interne PM de huidige staat van projecten zijn/haar kan inzien en/of nieuwe taken kan inschieten.

Het gebruik van .NET en React Native staat niet vast, als er tijdens de loop van het project goede argumenten zijn voor het gebruik van andere frameworks en/of talen kan er van af gestapt worden. Aangezien er inhouse veel kennis is en doorgaans gewerkt wordt met .NET back-end en React front-end is voor de onderhoudbaarheid de keuze gemaakt dit ook als uitgangspunt te nemen.

## Project grenzen

- Het projectmanagement portal wordt niet ontwikkeld als vervanging van productive.io voor het dev team of de PM/TL. Enkel voor de communicatie met de externe klant. Hiermee hebben alle usecases waar de externe klant geen primaire actor is automatisch een MoSCoW prioriteit van "Should have" of lager.
- Het project wordt in ieder geval door ontwikkeld tot (TODO: precieze datum eind stage nazoeken)

TODO: Grenzen overleggen

## Randvoorwaarden

- Bluenotion levert na akkoord op de software architectuur de infrastructuur waar het PMP kan draaien.
- Bluenotion levert een werkplek met laptop waar aan het PMP gewerkt kan worden.
- Bluenotion stelt op zijn minst 1x in de 2 weken een medewerker beschikbaar voor het geven van feedback op het project.
- Bluenotion stelt een Productive account beschikbaar met de juiste rechten om de beschreven functionaliteit te behalen.

<div style="page-break-after: always;"></div>

## Op te leveren producten en kwaliteitseisen en uit te voeren activiteiten

Binnen dit project worden de volgende producten opgeleverd.

| Product  | ProductKwaliteitseisen  | Benodigde activiteiten om te komen tot het product  | Proceskwaliteit (5 x W 1 x H)  |
|---|---|---|---|
| Code  | - Code & comments worden in het engels te schrijven</br> - Code is herleidbaar naar oorsprong in het FO/TO</br> - Er wordt waar praktisch mogelijk rekening gehouden met [CLEAN](https://refactoring.guru/refactoring/what-is-refactoring) en [SOLID](https://www.digitalocean.com/community/conceptual-articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design") coding principles.</br> - Frontend code wordt geanalyseerd door [ESLint](https://eslint.org/).</br> - Backend code wordt geanalyseerd door [StyleCop](https://github.com/StyleCop/StyleCop).</br> - Code formatting wordt gedaan aan de hand van Editorconfig en prettier.  | - Voordat logica geschreven wordt worden alle relevante constructors en functie signatures klaargezet met de oorsprong in comments boven de signature.</br> - ESLint, StyleCop, Editorconfig en Prettier dienen geïnstalleerd en gebruikt te worden.  | - Voor het maken van een PR worden de wijzigingen vergeleken met de [DoD](kwaliteitseisen.md#definition-of-done).  |
| Plan van aanpak  | - De opdrachtgever heeft afgetekend op het plan van aanpak. </br>- Geeft inzicht over de achtergrond, doelstelling en op te leveren resultaten van het project.</br>- Backend het project af met duidelijke project grenzen en randvoorwaarden.</br>- Op te leveren producten, kwaliteitseisen en uit te voeren activiteiten zijn aan de hand van [SMAR(T)](https://en.wikipedia.org/wiki/SMART_criteria) en [5xW 1xH beschreven](https://www.lean.nl/wat-is-de-5-x-w-1h-doorvraag-methode-green-belt/).</br>- De ontwikkelmethodiek is vastgelegd</br>- Voor elke tijdens de stage relevante partij zijn contactgegevens vastgelegd.</br>- Er is een globale planning aanwezig met alle aan te leveren producten.</br>- Risico’s zijn vastgelegd met tegen maatregels en uitwijk strategieën  | - Bespreking project met PM en TL om de informatie voor het document te verzamelen </br>- Aan de hand van de PvA handleiding van de HAN (HAN, 2024) het document schrijven.  | - De developer zet in de eerste sprint het PvA op en loopt deze met de opdrachtgever door in de sprint review. </br>- Bespreking met PM die het systeem zou gebruiken de functionele aspecten van het project te controleren.</br>- Bespreking met TL om de technische aspecten van het project te controleren.  |
| Functioneel Ontwerp  | - Bevat een genummerde lijst van alle voor het project relevante stakeholders.</br>- Bevat een genummerde lijst van alle Functionele en non-functionele wensen.</br> - Bevat de happy flow van de software in wireframes/mockups</br> -Bevat een Usecase diagram</br> -Bevat een domein model</br> -Functionele requirements zijn uitgewerkt naar fully dressed usecases</br> -Bevat alternative flows die als relevant worden beoordeeld door de opdrachtgever, productmanager of techlead.  | - Gesprek met opdrachtgever om de wensen en stakeholders vast te leggen.</br> - (Optioneel) Gesprek met verdere stakeholders voor verduidelijking wensen.</br> - Gesprek met collega’s van UX om tot goed te gebruiken mockups te komen.</br> - Domein model maken op basis UX en gesprek opdrachtgever/stakeholders.</br> - Wensen opdelen in functioneel en non-functioneel</br> - Functionele wensen vastleggen in fully dressed usecases met [MoSCoW](https://www.productplan.com/glossary/moscow-prioritization/) prioritering  | - Aanpassingen binnen het document dienen gecontroleerd te worden aan de hand van de [DoR](kwaliteitseisen.md#definition-of-ready)</br> - Tijdens de sprint reviews dient het document als basis voor de presentatie tegenover de opdrachtgever.</br> - Wijzigingen en het FO en TO worden direct meegenomen in PR's die de wijzigingen doen.  |
| Technisch ontwerp  | - Bevat een klasse diagram die overeenkomt met de software in zijn huidige staat.</br> - Bevat een package diagram die overeenkomt met de software in zijn huidige staat.</br> - Bevat een deployment diagram die overeenkomt met de software in zijn huidige staat.</br> - Bevat een Database model die de huidige staat van de database representeert.</br> - Bevat een API-definitie met alle binnen de applicatie beschikbare end-points en de relevante producers/consumers.  | - Maak een klasse diagram aan op basis van het domeinmodel en de initiële wensen.</br> - Maak een package diagram aan op basis van gekozen software architectuur.</br> - Maak een deployment diagram aan op basis van de gekozen software architectuur</br> - Maak een database model aan op basis van het domeinmodel en de in het FO aanwezige wensen.</br> - Maak een API-definitie voor elk blootgestelde endpoint. (Automatiseren AHV swagger?)</br> - Werk het klasse diagram bij wanneer functionaliteiten hier wijzigingen in aanbrengen ([DoD](kwaliteitseisen.md#definition-of-done)).  | Wijzigingen en het FO en TO worden direct meegenomen in PR's die de wijzigingen doen.</br> - Wanneer een taak resulteert in wijzigingen in een van de in het TO aanwezige diagrammen dienen deze diagrammen en de bijbehorende toelichting bijgewerkt te worden voor de taak af is ([DoD](kwaliteitseisen.md#definition-of-done))  |
| Software architecture document  | - Bevat een globaal overzicht van het systeem en de data flows die hierin voorkomen volgens het [4C model](https://c4model.com/).</br> - Bevat verantwoording voor alle [architecturaal relevante gemaakte keuzes](https://medium.com/oolooroo/a-step-wise-guide-to-architectural-decisions-ee7304871a71) binnen het project.</br> - Bevat een overzicht van alle Architectural Relevant Decisions  | - De globale dataflow dient vastgelegd te worden na het vaststellen van de eerste requirements van de software.</br> - Wanneer een ADR wordt genomen dient deze de dag zelf nog in het SAD gezet te worden.  | Het SAD dient over de levensduur van het project ADR geüpdatet te worden volgens het [TwinPeaks Model](https://www.microtool.de/en/knowledge-base/what-is-the-twin-peaks-model/).  |
| Testplan & Testrapport  | - Het test plan is aan het eind van elke sprint een accurate representatie van de staat van het project.</br> - Het testplan bevat voor elke usecase de happy flow.</br> - Het testplan bevat alternative flows voor scenario’s waar de opdrachtgever dit belangrijk acht.  | - In het testplan worden happy flows opgenomen zodra de bijbehorende usecases “Done” zijn.</br> - Alternative flows worden overlegd met de opdrachtgever, techlead of productmanager en indien ze complex zijn of om andere reden er een wens is alt flows toe te lichten worden ze meegenomen in het FO en Testrapport.  | - Het testrapport wordt op de laatste dag van elke sprint opnieuw ingevuld.  |
| Afstudeerverslag | - Het afstudeerverslag is niet langer dan 6.000 woorden of 15 pagina's (exclusief samenvatting, inhoudsopgave, bronvermeldingen en bijlagen)</br> - Alle beoordelingscriteria (BC1 tm BC5) uit het beoordelingsformulier afstuderen ICT 2020-2021 van de Afstudeerhandleiding HBO-ICT en CMD 2024-2026 zijn met op zijn minst twee prestatiecriterium afgevinkt. </br> | - Woorden & pagina teller </br> - Feedback docent begeleider  | De beoordeling criteria en bijbehorende prestatie criteria in een verslag template zetten aan het begin van de stage en wanneer ze aan bod komen de bijbehorende hoofdstukken aanvullen. </br> indien halverwege de stage BC's of PC's blijven nog niet ingevuld zijn dit aangeven bij de bedrijf of docent begeleider met vraag om advies dit te rectificeren. |
| Eindpresentatie  | - Er wordt een presentatie gegeven van 20 tot 30 minuten over het afstudeerproject | - Het stage verslag maken. | - Aan het eind van de stage het proces als vastgelegd in het afstudeerverslag in een powerpoint zetten. |

## Ontwikkelmethoden

Het project wordt voornamelijk door één software developer uitgevoerd. Daar waar gewenst zijn binnen Bluenotion collega's beschikbaar voor feedback en tips op het gebied van Project management, UX, UI en het programmeren zelf maar deze collega's zijn in hun dagelijks werk aan het werk aan andere projecten.

Aangezien binnen Bluenotion vaker met kleine teams tegelijkertijd aan verschillende projecten wordt gewerkt hanteren ze hier een lichtere vorm van SCRUM dan die aangegeven in het SCRUM manifesto. Om de voortgang van het project voor alle stakeholders duidelijk te houden wordt er wel gewerkt in sprints van 2 weken per stuk waar aan het eind van elke sprint concrete deliverables worden aangeleverd.

Deze deliverables worden besproken tijdens een sprint review waar stakeholders de optie hebben feedback te geven en het project bij te sturen. De review is de enige Scrum ceremonie die met regelmaat wordt uitgevoerd en dient tevens als retrospective en planning voor de volgende sprint.

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

| Rol(len): | **UI Developer** |
|---|---|
| Naam: | ? |
| Contactgegevens: | ? |
| Contactmomenten | Op aanvraag |
| verantwoordelijkheden | Brainstormen en feedback leveren op de development van de UI |

<!-- Deze wordt toegekend aan het begin van de stage. -->

| Rol(len): | **Docentbegeleider** |
|---|---|
| Naam: | Onbekend |
| Contactgegevens: | Onbekend |
| Contactmomenten | Onbekend |
| verantwoordelijkheden | Onbekend |

## Planning

Zoals besproken in het hoofdstuk Ontwikkelmethoden hebben sprints een duur van 2 weken, met een stageperiode van 18 weken komt dit uit op 9 sprints. Aangezien de wensen voor het Minimal Viable Product al redelijk vast staan worden deze wensen gebruikt als basis van de UX ontwerpen. Door in een vroeg stadium de belevings ervaring van de klant in kaart te brengen wordt eerder gewerkt naar iets dat de klant ook daadwerkelijk wilt gebruiken.

De planning van de stage is in [het volgende document](./Planning.md) opgenomen, opgedeeld in de bovengenoemde 9 sprints.

Aangezien de stage uitgesteld is en er tijd en ruimte is al voorbereidend werk te doen voor de opdracht is er een kleine planning gemaakt tot het begin van de stage.

Ook deze zijn ingedeeld in sprints van 2 weken, aangezien er per week twee werkdagen tijd is om aan de voorbereiding van de afstudeer opdracht te werken is er tijdens de sprints rekening gehouden met 32 werkuur per sprint. Het doel van het voorbereidend werk is voor de afstudeer periode de wensen voor het project vast te stellen en de praktische en technische haalbaarheid van het project te beoordelen.

| Sprint | Werkzaamheden | Op te leveren producten |
|---|---|---|
| Sprint 1 | Verfijnen projectplan. | PVA |
| Sprint 2 | Opzet FO & SAD | User stories, NFR's & domein model |
| Sprint 3 | Verfijnen FO & SAD | Fully dressed usecases en wireframes/mock-ups |
| Sprint 4 | In kaart brengen welke domein data uit welke Productive endpoints kunnen komen | Communicatie poc? |
| Sprint 5 | Technische uitdagingen uitsluiten. | SAD uitgebreid met de tot nu toe besproken ADR's |
| Sprint 6 | Opzet TO | Database/entity model en bijbehorende endpoints voor de back-end |
| Sprint 7 | Verfijnen TO | back-end endpoint definities en signatures |
| Sprint 8 | ? |  |
| Sprint 9 | ? |  |
| Sprint 10 | ? |  |

## Risico’s

| **Risico**   | **Kans** | **Impact** | **Tegenmaatregel**  |**Uitwijkstrategie**  |
|---|---|---|---|---|
| Langdurige ziekte | Klein    | Middel     | ?     | Thuis werken   |
| Verlies data development machine | Klein | Klein  | Zorg ervoor dat wijzigingen elke dag online worden gezet  | Herstel vanuit git & cloud storage.                                                            |
| Productive.io API is niet toereikend aan het project | Klein    | Middel     | Overleg met productive.io of er wijzigingen mogelijk zijn?  | Overleg met opdrachtgever over wat te doen met de functionaliteit die de API niet ondersteund. |
<!-- 3 is een beetje onzinnige tegenmaatregel -->
