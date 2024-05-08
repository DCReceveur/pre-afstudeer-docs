# Plan van aanpak Project Management Portal

## Inleiding

Binnen dit document wordt toelichting gegeven op het Project Management Portal dat als afstudeer opdracht ontwikkeld wordt voor Bluenotion. Er wordt toelichting gegeven op de oorsprong en doel van het project en een ontwikkelplan besproken om tot een product te komen waar alle stakeholders tevreden mee zijn.

### Achtergrond van het project

Bluenotion levert voor verschillende klanten op maat gemaakte softwareoplossingen. Te verrichte taken voor het bouwen van de softwareoplossingen worden bijgehouden in productive.io. Op het moment wordt de status van het project en de bijbehorende taken op twee manieren gecommuniceerd naar de klant:

- Directe communicatie via de PM:
Voor de meeste projecten dient de Project manager als koppeling tussen de projectplanning en de klant. Het is dan aan de Project manager om de huidige staat van het project tijdens vaste contact momenten te communiceren en waar nodig nieuwe taken aan te maken voor het verwerken van feedback van de klant of het creëren van nieuwe functionaliteiten.
- Guest account in Productive:
Voor een aantal projecten zijn aan de klant accounts beschikbaar gesteld waarin ze direct inzicht kunnen krijgen in productive.io. Hiermee kunnen ze real-time inzicht krijgen over de staat van het project en waar nodig zelf taken inschieten.

### Probleem

Beide manieren van het communiceren van de project status brengen voor- en nadelen met zich mee.

De management volledig overlaten aan de Project manager heeft als resultaat dat de klant geen direct eenduidig overzicht heeft van de status van zijn/haar project en wanneer hij/zij dit wel wil wordt de werkdruk van de PM verhoogd.

Productive.io accounts beschikbaar stellen voor de klant heeft als resultaat dat de klant voor Bluenotion op een niet-Bluenotion portaal terecht komt waar de data ongefilterd en voor klanten mogelijk onduidelijk beschikbaar is. Per klant verschilt of dit leidt tot vragen over bestaande taken en incorrect toegevoegde nieuwe taken.

### Doelstelling

Zorg voor een systeem waar de klanten van Bluenotion inzicht krijgen in de huidige staat van de voor hun relevante projecten met de optie hier nieuwe wensen aan toe te voegen die gereflecteerd worden in taken in Productive.

### Concrete resultaten

Een applicatie met een C# back-end (.NET), Typescript front-end (React Native) waar een externe klant of interne PM de huidige staat van projecten zijn/haar kan inzien en/of nieuwe taken kan inschieten.

Het gebruik van .NET en React Native staat niet vast, als er tijdens de loop van het project goede argumenten zijn voor het gebruik van andere frameworks en/of talen kan er van af gestapt worden. Aangezien er inhouse veel kennis is en doorgaans gewerkt wordt met .NET back-end en React front-end is voor de onderhoudbaarheid de keuze gemaakt dit ook als uitgangspunt te nemen.

## Project grenzen

- Het projectmanagement portal wordt niet ontwikkeld als vervanging van productive.io voor het dev team.
- Het project wordt in ieder geval door ontwikkeld tot (precieze datum eind stage nazoeken)
<!-- - Meer? -->

## Op te leveren producten en kwaliteitseisen en uit te voeren activiteiten

Binnen dit project worden de volgende producten opgeleverd.

<table>
<colgroup>
<col style="width: 17%" />
<col style="width: 27%" />
<col style="width: 33%" />
<col style="width: 21%" />
</colgroup>
<thead>
<tr class="header">
<th>Product</th>
<th>Productkwaliteitseisen</th>
<th>Benodigde activiteiten om te komen tot het product</th>
<th>Proceskwaliteit (5 x W, 1 x H)</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Plan van Aanpak</td>
<td><ul>
<li><p>De opdrachtgever heeft afgetekend op het plan van
aanpak.</p></li>
<li><p>Geeft inzicht over de achtergrond, doelstelling en op te leveren
resultaten van het project.</p></li>
<li><p>Backend het project af met duidelijke project grenzen en
randvoorwaarden.</p></li>
<li><p>Op te leveren producten, kwaliteitseisen en uit te voeren
activiteiten zijn aan de hand van <a
href="https://en.wikipedia.org/wiki/SMART_criteria">SMAR(T)</a> en <a
href="https://www.lean.nl/wat-is-de-5-x-w-1h-doorvraag-methode-green-belt/">5xW
1xH</a> beschreven.</p></li>
<li><p>De ontwikkelmethodiek is vastgelegd</p></li>
<li><p>Voor elke tijdens de stage relevante partij zijn contactgegevens
vastgelegd.</p></li>
<li><p>Er is een globale planning aanwezig met alle aan te leveren
producten.</p></li>
<li><p>Risico’s zijn vastgelegd met tegenmaatregels en uitwijk
strategieën</p></li>
</ul></td>
<td><ul>
<li><p>Bespreking project met PM en TL om de informatie voor het
document te verzamelen</p></li>
<li><p>Aan de hand van de PvA handleiding van de HAN (HAN, 2024) het
document schrijven.</p></li>
</ul></td>
<td><ul>
<li><p>De developer zet in de eerste sprint het PvA op en loopt deze met
de opdrachtgever door in de sprint review.</p></li>
<li><p>Bespreking met PM die het systeem zou gebruiken de functionele
aspecten van het project te controleren.</p></li>
<li><p>Bespreking met TL om de technische aspecten van het project te
controleren.</p></li>
</ul></td>
</tr>
<tr class="even">
<td>Functioneel Ontwerp</td>
<td><ul>
<li><p>Bevat een genummerde lijst van alle voor het project relevante
stakeholders.</p></li>
<li><p>Bevat een genummerde lijst van alle Functionele en
non-functionele wensen.</p></li>
<li><p>Bevat de happy flow van de software in
wireframes/mockups</p></li>
<li><p>Bevat een Usecase diagram</p></li>
<li><p>Bevat een domein model</p></li>
<li><p>Functionele requirements zijn uitgewerkt naar fully dressed
usecases</p></li>
<li><p>Bevat alternative flows die als relevant worden beoordeeld door
de opdrachtgever, productmanager of techlead.</p></li>
</ul></td>
<td><ul>
<li><p>Gesprek met opdrachtgever om de wensen en stakeholders vast te
leggen.</p></li>
<li><p>(Optioneel) Gesprek met verdere stakeholders voor verduidelijking
wensen.</p></li>
<li><p>Gesprek met collega’s van UX om tot goed te gebruiken mockups te
komen.</p></li>
<li><p>Domein model maken op basis UX en gesprek
opdrachtgever/stakeholders.</p></li>
<li><p>Wensen opdelen in functioneel en non-functioneel</p></li>
<li><p>Functionele wensen vastleggen in fully dressed usecases met <a
href="https://www.productplan.com/glossary/moscow-prioritization/">MoSCoW
prioritisering</a></p></li>
</ul></td>
<td><ul>
<li><p>Aanpassingen binnen het document dienen gecontroleerd te worden
aan de hand van de DoR</p></li>
<li><p>Tijdens de sprint reviews dient het document als basis voor de
presentatie tegenover de opdrachtgever.</p></li>
<li><p>Wijzigingen en het FO en TO worden direct meegenomen in PR's die de wijzigingen doen.</p></li>
</ul></td>
</tr>
<tr class="odd">
<td>Technisch Ontwerp</td>
<td><ul>
<li><p>Bevat een klasse diagram die overeenkomt met de software in zijn
huidige staat.</p></li>
<li><p>Bevat een package diagram die overeenkomt met de software in zijn
huidige staat.</p></li>
<li><p>Bevat een deployment diagram die overeenkomt met de software in
zijn huidige staat.</p></li>
<li><p>Bevat een Database model die de huidige staat van de database
representeert.</p></li>
<li><p>Bevat een API-definitie met alle binnen de applicatie beschikbare
end-points en de relevante producers/consumers.</p></li>
</ul></td>
<td><ul>
<li><p>Maak een klasse diagram aan op basis van het domeinmodel en de
initiële wensen.</p></li>
<li><p>Maak een package diagram aan op basis van gekozen software
architectuur.</p></li>
<li><p>Maak een deployment diagram aan op basis van de gekozen software
architectuur</p></li>
<li><p>Maak een database model aan op basis van het domeinmodel en de in
het FO aanwezige wensen.</p></li>
<li><p>Maak een API-definitie voor elk blootgestelde endpoint.
(Automatiseren AHV swagger?)</p></li>
<li><p>Werk het klasse diagram bij wanneer functionaliteiten hier
wijzigingen in aanbrengen (DoD).</p></li>
</ul></td>
<td><ul>
<li><p>Wijzigingen en het FO en TO worden direct meegenomen in PR's die de wijzigingen doen.</p></li>
<li><p>Wanneer een taak resulteert in wijzigingen in een van de in het
TO aanwezige diagrammen dienen deze diagrammen en de bijbehorende
toelichting bijgewerkt te worden voor de taak af is (DoD)</p></li>
</ul></td>
</tr>
<tr class="odd">
<td>Software Architecture Document</td>
<td><ul>
<li><p>Bevat een globaal overzicht van het systeem en de data flows die
hierin voorkomen volgens het <a href="https://c4model.com/">4C
model.</a></p></li>
<li><p>Bevat verantwoording voor alle architecturaal relevante
gemaakte keuzes binnen het project.</p></li>
<li><p>Bevat een overzicht van alle <a
href="https://medium.com/oolooroo/a-step-wise-guide-to-architectural-decisions-ee7304871a71">Architectural
Relevant Decisions</a></p></li>
</ul></td>
<td><ul>
<li><p>De globale dataflow dient vastgelegd te worden na het vaststellen
van de eerste requirements van de software.</p></li>
<li><p>Wanneer een ADR wordt genomen dient deze de dag zelf nog in het
SAD gezet te worden.</p></li>
</ul></td>
<td><ul>
<li><p>Het SAD dient over de levensduur van het project ADR geüpdatet
te worden volgens het <a href="https://www.microtool.de/en/knowledge-base/what-is-the-twin-peaks-model/">
TwinPeaks Model</a>.</p></li>
</ul></td>
</tr>
<tr class="odd">
<td>Code</td>
<td><ul>
<li><p>Code &amp; comments worden in het engels te schrijven</p></li>
<li><p>Code is herleidbaar naar oorsprong in het FO/TO</p></li>
<li><p>Er wordt waar praktisch mogelijk rekening gehouden met <a href="https://refactoring.guru/refactoring/what-is-refactoring">CLEAN</a> en <a href="https://www.digitalocean.com/community/conceptual-articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design">SOLID</a> coding principles.</p></li>
<li><p>Frontend code wordt geanalyseerd door <a
href="https://eslint.org/">ESLint</a>.</p></li>
<li><p>Backend code wordt geanalyseerd door StyleCop.</p></li>
<li><p>Code formatting wordt gedaan aan de hand van Editorconfig en
prettier.</p></li>
</ul></td>
<td><ul>
<li><p>Voordat logica geschreven wordt worden alle relevante
constructors en functie signatures klaargezet met de oorsprong in
comments boven de signature.</p></li>
<li><p>ESLint, StyleCop, Editorconfig en Prettier dienen geïnstalleerd
en gebruikt te worden.</p></li>
</ul></td>
<td><ul>
<li><p>Voor het maken van een PR worden de wijzigingen vergeleken met de
DoD.</p></li>
</ul></td>
</tr>
<tr class="even">
<td>Testplan &amp; Testrapport</td>
<td><ul>
<li><p>Het test plan is aan het eind van elke sprint een accurate
representatie van de staat van het project.</p></li>
<li><p>Het testplan bevat voor elke usecase de happy flow.</p></li>
<li><p>Het testplan bevat alternative flows voor scenario’s waar de
opdrachtgever dit belangrijk acht.</p></li>
</ul></td>
<td><ul>
<li><p>In het testplan worden happy flows opgenomen zodra de
bijbehorende usecases “Done” zijn.</p></li>
<li><p>Alternative flows worden overlegd met de opdrachtgever, techlead
of productmanager en indien ze complex zijn of om andere reden er een
wens is alt flows toe te lichten worden ze meegenomen in het FO en
Testrapport.</p></li>
</ul></td>
<td><ul>
<li><p>Het testrapport wordt op de laatste dag van elke sprint opnieuw
ingevuld.</p></li>
</ul></td>
</tr>
<tr class="odd">
<td><mark>Opleverdocument</mark></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr class="even">
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>

## Ontwikkelmethoden

Het project wordt voornamelijk door één software developer uitgevoerd. Daar waar gewenst zijn binnen Bluenotion collega's beschikbaar voor feedback en tips op het gebied van Project management, UX, UI en het programmeren zelf maar deze collega's zijn in hun dagelijks werk aan het werk aan andere projecten.

Aangezien binnen Bluenotion vaker met kleine teams tegelijkertijd aan verschillende projecten wordt gewerkt hanteren ze hier een lichtere vorm van SCRUM dan die aangegeven in het SCRUM manifesto. Om de voortgang van het project voor alle stakeholders duidelijk te houden wordt er wel gewerkt in sprints van 2 weken per stuk waar aan het eind van elke sprint concrete deliverables worden aangeleverd.

Deze deliverables worden besproken tijdens een sprint review waar stakeholders de optie hebben feedback te geven en het project bij te sturen. De review is de enige Scrum ceremonie die met regelmaat wordt uitgevoerd en dient tevens als retrospective en planning voor de volgende sprint.

Met een klein team waar elke sprint afhankelijk van wat er in het project nodig is collega's aan/af kunnen haken is de keuze gemaakt deze structuur ook voor het project management portal aan te houden. Bij dit project zal ik de rol van Tech lead op me nemen en collega's per sprint inschakelen waar ik het nodig acht.

## Projectorganisatie en communicatie

| Rol(len): | **Student & Tech lead** |
|---|---|
| Naam: | Daan Receveur |
| Contactgegevens: | <daan@bluenotion.nl> |
| Contactmomenten: | Maandag tm vrijdag 9 tm 17:30 |
| Verantwoordelijkheden | - Plannen en uitvoeren van het afstudeerproject. </br> - Plannen van de begeleidingsafspraken en communicatie met de docentbegeleider en bedrijfsbegeleider. |

| Rol(len): | **Bedrijfsbegeleider & ACT4: Tech lead** |
|---|---|
| Naam: | Yannic Smeets |
| Contactgegevens: | <yannic@bluenotion.nl> |
| Contactmomenten | Sprint review |
| verantwoordelijkheden | Feedback/mogelijkheid tot sparren over technische aspecten van het project. |

| Rol(len): | **ACT2: Projectmanager & Opdrachtgever** |
|---|---|
| Naam: | Jesse Bekke |
| Contactgegevens: | <jesse@bluenotion.nl> |
| Contactmomenten: | Sprint review |
| verantwoordelijkheden: | Feedback/mogelijkheid tot sparren over functionele aspecten van het project. |

| Rol(len): | **UX Designer** |
|---|---|
| Naam: | Roel Dekkers |
| Contactgegevens: | Roel@bluenotion.nl |
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
