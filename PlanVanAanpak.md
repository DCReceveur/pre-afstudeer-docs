# Plan van aanpak

## Inleiding

Achtergrond van het project:
Bluenotion levert voor verschillende klanten op maat gemaakte softwareoplossingen. Te verrichte taken voor het bouwen van de softwareoplossingen worden bijgehouden in productive.io. 

Voor de meeste projecten dient de Product owner als koppeling tussen de projectplanning en de klant. Het is dan aan de product owner om de huidige staat van het project tijdens vaste contact momenten te communiceren en waar nodig nieuwe taken aan te maken voor het verwerken van feedback van de klant of het creëren van nieuwe functionaliteiten.

Voor een aantal projecten zijn aan de klant accounts beschikbaar gesteld waarin ze direct inzicht kunnen krijgen in productive.io. Hiermee kunnen ze real-time inzicht krijgen over de staat van het project en waar nodig zelf taken inschieten.

## Probleem

Beide manieren van het communiceren van de project status brengen voor- en nadelen met zich mee.

De management volledig overlaten aan de product owner heeft als resultaat dat de klant geen direct eenduidig overzicht heeft van de status van zijn/haar project en wanneer hij/zij dit wel wil wordt de werkdruk van de PM verhoogd.

Productive.io accounts beschikbaar stellen voor de klant heeft als resultaat dat de klant voor Bluenotion op een niet-Bluenotion portaal terecht komt waar de data ongefilterd en voor klanten mogelijk onduidelijk beschikbaar is. Per klant verschilt of dit leidt tot vragen over bestaande taken en incorrect toegevoegde nieuwe taken.

## Doelstelling

Zorg voor een systeem waar de klanten van Bluenotion inzicht krijgen in de huidige staat van de voor hun relevante projecten met de optie hier nieuwe wensen aan toe te voegen die gereflecteerd worden in taken in Productive.

## Concrete resultaten

Een applicatie met een C# back-end (.NET), Typescript front-end (React Native) waar een externe klant of interne PM de huidige staat van projecten zijn/haar kan inzien en/of nieuwe taken kan inschieten.

Het gebruik van .NET en React Native staat niet vast, als er tijdens de loop van het project goede argumenten zijn voor het gebruik van andere frameworks en/of talen kan er van af gestapt worden. Aangezien er inhouse veel kennis is en doorgaans gewerkt wordt met .NET back-end en React front-end is voor de onderhoudbaarheid de keuze gemaakt dit ook als uitgangspunt te nemen.

## Project grenzen

- Het projectmanagement portal wordt niet ontwikkeld als vervanging van productive.io voor het dev team.
- Het project wordt in iedergeval door ontwikkeld (precieze datum eind stage nazoeken)

## Op te leveren producten en kwaliteitseisen en uit te voeren activiteiten

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
<li><p><mark>Wijzigingen in het TO/FO meenemen in de PR?</mark></p></li>
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
representeerd.</p></li>
<li><p><mark>Bevat verantwoording voor alle architecturaal relevante
gemaakte keuzes binnen het project.</mark></p></li>
<li><p>Bevat een API-definitie met alle binnen de applicatie beschikbare
end-points en de relevante producers/consumers.</p></li>
</ul></td>
<td><ul>
<li><p>Maak een klasse diagram aan op basis van het domeinmodel en de
initiële wensen.</p></li>
<li><p>Maak een package diagram aan op basis van gekozen software
architectuur.</p></li>
<li><p>Maak een deployment diagram aan op bsasis van de gekozen software
architectuur</p></li>
<li><p>Maak een database model aan op basis van het domeinmodel en de in
het FO aanwezige wensen.</p></li>
<li><p>Maak een API-definitie voor elk blootgestelde endpoint.
(Automatiseren AHV swagger?)</p></li>
<li><p>Werk het klasse diagram bij wanneer functionaliteiten hier
wijzigingen in aanbrengen (DoD).</p></li>
</ul></td>
<td><ul>
<li><p><mark>Wijzigingen in het TO/FO meenemen in de PR?</mark></p></li>
<li><p>Wanneer een taak resulteert in wijzigingen in een van de in het
TO aanwezige diagrammen dienen deze diagrammen en de bijbehorende
toelichting bijgewerkt te worden voor de taak af is (DoD)</p></li>
</ul></td>
</tr>
<tr class="even">
<td>UX <mark>Designonderzoek</mark> &amp; wireframes</td>
<td><ul>
<li><p><mark>Bevat een hoofd en deelvragen?</mark></p></li>
<li><p>Bevat wireframes of mockups van elke usecase voordat deze in code
wordt uitgewerkt.</p></li>
</ul></td>
<td><ul>
<li><p>Verzamel delen van andere projectmanagement software die kunnen
helpen het overzicht voor de klant te verbeteren.</p></li>
<li><p>Ga in gesprek met een van de inhouse UX-designers.</p></li>
<li><p>Maak de ontwerpen op basis van afgetekende usecases.</p></li>
</ul></td>
<td><ul>
<li><p>Designs zijn goedgekeurd door UX-designer en
opdrachtgever.</p></li>
</ul></td>
</tr>
<tr class="odd">
<td><mark>Software Architecture Document</mark></td>
<td><ul>
<li><p>Bevat een globaal overzicht van het systeem en de data flows die
hierin voorkomen volgens het <a href="https://c4model.com/">4C
model.</a></p></li>
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
<li><p>Het SAD dient over de levensduure van het project ADR geüpdatet
te worden volgens het <a
href="https://www.microtool.de/en/knowledge-base/what-is-the-twin-peaks-model/">Twin
Peaks Model</a>.</p></li>
</ul></td>
</tr>
<tr class="even">
<td>Onderzoek communicatie Productive</td>
<td><ul>
<li><p>Bevat een lijst die data wensen verbindt aan de relevante
Productive API endpoints.</p></li>
<li><p>Bevat een proof of concept applicatie <mark>die taak informatie
kan ophalen en verwerken boven de 100 requests per 10 sec rate
limit.</mark></p></li>
<li><p>Het POC dient de productive API te gebruiken als single source of
truth.</p></li>
<li><p>Er mogen geen race conditions voorkomen in het POC.</p></li>
</ul></td>
<td><ul>
<li><p>Na het verzamelen van de wensen en het opzetten van de mockups
wordt gekeken welke data nodig is voor het implementeren van de wensen.
Binnen de Productive API wordt vervolgens een endpoint gezocht die deze
data kan aanleveren.</p></li>
<li><p>Het POC wordt gebouwd met een manier van caching of een eigen
database.</p></li>
<li></li>
</ul></td>
<td><ul>
<li><p><mark>Er worden van tevoren unit tests gemaakt die race
conditions controlleren en de ratelimit voor de poc.</mark></p></li>
</ul></td>
</tr>
<tr class="odd">
<td>Code</td>
<td><ul>
<li><p>Code &amp; comments worden in het engels te schrijven</p></li>
<li><p>Code is herleidbaar naar oorsprong in het FO/TO</p></li>
<li><p>Er wordt <mark>zo veel mogelijk</mark> rekening gehouden met <a
href="https://refactoring.guru/refactoring/what-is-refactoring">CLEAN</a>
en <a
href="https://www.digitalocean.com/community/conceptual-articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design">SOLID</a>
coding principles.</p></li>
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

Binnen dit project wordt
[agile](https://www.agilealliance.org/agile101/#:~:text=Agile%20is%20the%20ability%20to,an%20uncertain%20and%20turbulent%20environment.)
gewerkt in sprints van twee weken. Deze standaard wordt gehanteerd om in
dezelfde cyclus te draaien als de rest van het bedrijf en omdat dit
project na afloop van de stage nog doorontwikkeld wordt.

Voor het globale overzicht wordt ook vooruitgekeken naar het project
zoals het er nu aan het eind van de stage uit zou moeten zien. Dit zou
beschouwd kunnen worden als pre-game of <span class="mark">een beetje
waterval</span>. Door dit te doen zijn in ieder geval op hoog niveau
alle use cases al besproken met de opdrachtgever zodat misverstanden of
belangrijke eisen niet blijven liggen tot een van de latere sprints.

## Projectorganisatie en communicatie

| Rol(len): | **Student** |
|---|---|
| Naam: | Daan Receveur |
| Contactgegevens: | <daan@bluenotion.nl> |
| Contactmomenten: | Maandag tm vrijdag 9 tm 17:30 |
| Verantwoordelijkheden | - Plannen en uitvoeren van het afstudeerproject. </br> - Plannen van de begeleidingsafspraken en communicatie met de docentbegeleider en bedrijfsbegeleider. |

| Rol(len): | **Bedrijfsbegeleider & Techlead** |
|---|---|
| Naam: | Yannic Smeets |
| Contactgegevens: | <yannic@bluenotion.nl> |
| Contactmomenten | Sprint review |
| verantwoordelijkheden | Feedback/mogelijkheid tot sparren over technische aspecten van het project. |

| Rol(len): | **Projectmanager & Opdrachtgever** |
|---|---|
| Naam: | Jesse Bekke |
| Contactgegevens: | <jesse@bluenotion.nl> |
| Contactmomenten: | Sprint review |
| verantwoordelijkheden: | Feedback/mogelijkheid tot sparren over functionele aspecten van het project. |

| Rol(len): | **Docentbegeleider** |
|---|---|
| Naam: | Onbekend |
| Contactgegevens: | Onbekend |
| Contactmomenten | Onbekend |
| verantwoordelijkheden | Onbekend |

## Planning

Zoals besproken in het hoofdstuk Ontwikkelmethoden hebben sprints een
duur van 2 weken, met een stageperiode van 18 weken komt dit uit op 9
sprints. Aangezien er tijdens het project agile gewerkt wordt kan er
enkel een generiek overzicht gegeven worden van de richtlijnen van de al
geplande op te leveren producten. Uiteraard kan het zijn dat er (vooral
in de latere sprints) wordt afgeweken van de planning om meer tijd te
steken in problemen die nu nog niet aan het licht zijn gekomen.


## Risico’s

| **Risico**   | **Kans** | **Impact** | **Tegenmaatregel**  |**Uitwijkstrategie**  |
|---|---|---|---|---|
| Langdurige ziekte | Klein    | Middel     | ?     | Thuis werken   |
| Verlies data development machine | Klein | Klein  | Zorg ervoor dat wijzigingen elke dag online worden gezet  | Herstel vanuit git & cloud storage.                                                            |
| Productive.io API is niet toereikend aan het project | Klein    | Middel     | <span class="mark">Overleg met productive.io of er wijzigingen mogelijk zijn?</span> | Overleg met opdrachtgever over wat te doen met de functionaliteit die de API niet ondersteund. |
