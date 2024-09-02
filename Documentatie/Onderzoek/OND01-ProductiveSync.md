# OND01-Communicatie met productive

Binnen dit document dient antwoord te geven op de vraag "Hoe gaat het PMP communiceren met de al bestaande Productive omgeving?". De resultaten van dit onderzoek zijn in het kort vastgelegd in [ADR001](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md), dit document dient als toelichting op de aanpak om tot de beslissing in [ADR001](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md) te komen.

Aangezien het PMP de klant inzicht dient te geven in de actuele staat van zijn/haar projecten is het van belang dat data uit Productive zichtbaar is in het PMP en wijzigingen gemaakt in het PMP doorgezet worden naar de Productive omgeving. Binnen het vooronderzoek tijdens het opzetten van het [PVA](../PVA/PlanVanAanpak.md#op-te-leveren-producten-en-kwaliteitseisen-en-uit-te-voeren-activiteiten) zijn er bij de communicatie van en naar het bestaande Productive systeem een aantal vragen naar boven gekomen.

- Q1: Biedt productive een API aan voor alle data die binnen het FO en schermontwerpen besproken worden?
- Q2: Hoe blijft het systeem up to date met wijzigingen gedaan in Productive?
- Q3: Hoe worden wijzigingen gedaan in het PMP doorgegeven aan Productive?
- Q4: Kan het systeem "oneindig" (los van Productive) schalen?
- Q5: Moeten er aparte endpoints gemaakt worden binnen het PMP voor de communicatie met Productive of kan er (netjes) gebruik gemaakt worden van de endpoints die de front-end ook gebruikt?

Tijdens het library onderzoek zijn nog een aantal vragen naar boven gekomen over de voorgestelde oplossingen.

- Q6: Hoe dicht in de buurt van de webhook limits komt het dagelijks gebruik van Bluenotion? 1000 per 5 min
- Q7: Kan een systeem op basis van webhooks foutieve informatie ontdekken en herstellen?
- Q8: Is er een initiële dataset nodig?
- Q9: Wordt alle informatie die het PMP nodig heeft doorgegeven aan de hand van webhooks? Wat gebeurt er bijvoorbeeld met comments?
  A: Staan als activity onder het object waar een comment op is achter gelaten.
- Q10: Wat zijn scenario's waarin foutieve informatie in het systeem zou kunnen komen?

## Methodiek

In dit hoofdstuk volgt een korte toelichting over de overwogen en gekozen onderzoek patronen en methodes.

### Methodiek: Overwegingen

Om tot antwoorden voor deze vragen te komen is gebruik gemaakt van verschillende onderzoeksmethodes. De gekozen onderzoek methodes zijn gebaseerd op de onderzoek patronen zoals beschreven op <https://ictresearchmethods.nl/>.

Voor dit onderzoek zijn voornamelijk de patronen "Realise as required", "Realise as expert" en "Choose fitting technology" overwogen. Beide patronen worden vanaf de analyse fase gebruikt om tot een nog onbekende oplossing te komen met als voornaamste verschil of er vanuit een functioneel (required) of technisch standpunt (expert) naar het probleem wordt gekeken.

In de omschrijving van het Realise as required pattern wordt onder risico's genoemd dat er mogelijk niet naar een optimale oplossing wordt gewerkt omdat er geen library of showroom onderzoek wordt gedaan die de wensen van de opdrachtgever zou vaststellen.

In de omschrijving van het Realise as expert pattern wordt onder risico's genoemd dat het zicht op de applicatie context verloren kan raken en dus software niet aan de eisen van de opdrachtgever voldoet.

In de omschrijving van het Choose fitting technology patroon wordt onder risico's genoemd dat er vaak suboptimale keuzes worden gemaakt door op basis van persoonlijke voorkeur en met incomplete criteria te kiezen.

Om de zwakheden van de onderzoek patronen af te dekken is gekozen het Realise as required patroon toe te passen met extra library onderzoek. Aan de hand van dit extra library onderzoek worden verschillende opties voor synchronisatie verkend zodat deze in de rest van het onderzoek meegenomen kunnen worden.*

*Side note: Eigenlijk is Realise as required met library onderzoek qua structuur het zelfde als choose fitting technology.

Realise as required: Field -> Workshop -> Lab

Realise as expert: Library -> Workshop -> Showroom

Choose fitting technology: Library -> Field -> Workshop -> Lab

De volgende methodes zijn overwogen toe te passen binnen het gekozen onderzoek patroon.

| Stap | Naam | Type | Doel binnen dit project |
|---|---|---|---|
| 1 | [Best, good & bad practices](https://ictresearchmethods.nl/library/best-good-and-bad-practices/) | Library | Vindt opties door met collega's en online te zoeken naar potentiële oplossingen voor vergelijkbare synchronisaties. |
| 2 | [Design Pattern Search](https://ictresearchmethods.nl/library/design-pattern-research/) | Library | Onderzoek of er standaard design patterns zijn die dergelijke synchronisaties afhandelen. |
| 3 | [Literature Study](https://ictresearchmethods.nl/library/literature-study/) | Library | Uitbreiding op de gevonden resultaten van de bovenstaande methodes. |
|  | [Stakeholder analysis](https://ictresearchmethods.nl/field/stakeholder-analysis/) | Field | [Onderdeel FO](../Functioneel/FunctioneelOntwerp.md#actors-en-user-stories) |
|  | [Problem analysis](https://ictresearchmethods.nl/field/problem-analysis/) | Field | Ter verificatie dat de voorgestelde oplossing niet vanaf een vroeg punt de verkeerde richting in is geslagen of onnodig complex is wordt met de PM&TL overlegd. |
|  | [Observation](https://ictresearchmethods.nl/field/observation/) | Field | Discover productive workflow |
|  | [Interview](https://ictresearchmethods.nl/field/interview/) | Field | Discover productive workflow |
|  | [Document analysis](https://ictresearchmethods.nl/field/document-analysis/) | Field | Discover productive workflow |
| 4 | [Peer review](https://ictresearchmethods.nl/showroom/peer-review/) | Showroom | Wordt gebruikt voorgestelde oplossingen te verifiëren met collega's die (ook als gebruiker van het systeem) uniek inzicht kunnen geven. Deze methode is gekozen om tijdens het proces toch de potentieel waardevolle kennis van mijn collega's te kunnen gebruiken. |
| 5 | [Requirements prioritization](https://ictresearchmethods.nl/workshop/requirements-prioritization/) | Workshop | Voor synchronisatie zijn vaak meerdere potentiele oplossingen beschikbaar die afhankelijk van de eisen aan de software complexer of simpeler gemaakt kunnen worden en daarbij meer of minder ontwikkeltijd kosten. |
| 6 | [Prototyping](https://ictresearchmethods.nl/workshop/prototyping/) | Workshop |  Na het vaststellen van de eisen en onderzoeken van de verschillende opties wordt de meest belovende optie uitgewerkt tot een PoC zodat er meer zekerheid is dat de oplossing naar verwachting functioneert. |
| 7 | [Usability testing](https://ictresearchmethods.nl/lab/usability-testing/) | Lab | Zodra een PoC is gemaakt kunnen er tests uitgevoerd worden die de grenzen van het systeem testen. |
| 8 | [A/B Testing](https://ictresearchmethods.nl/lab/a-b-testing/) | Lab | Zou gebruikt kunnen worden om twee oplossingen te vergelijken na het maken van één of meerdere PoC's. |

### Methodiek: Gekozen

<!-- TODO: bovenstaande hoofdstuk is eigenlijk dubbele informatie. -->

Op basis van de overwegingen uit het vorige hoofdstuk is het onderstaande onderzoek plan opgesteld.

| Stappen | Te beantwoorden deelvragen |
|--|--|
| 1 tm 3: Om er voor te zorgen dat er niet enkel tijd wordt gestoken in het onderzoek maar ook daadwerkelijk aan de rest van het PMP wordt gewerkt zullen stap 1 tm 3 gecombineerd worden tot één library onderzoek om tot een aantal potentiële oplossingen te komen. | Q1, Q2, Q3, Q6, Q7, Q8, Q9 |
| 4: Peer review zal gebruikt worden tussen de verschillende onderzoek stappen als verificatie of er nog rekening wordt gehouden met de wensen van de opdrachtgever en als extra collegiale inspiratiebron. | Q5, Q7, Q8, Q9 |
| 5: Op basis van de opgestelde eisen en tijdens de eerder uitgevoerde onderzoeksstappen gevonden potentiële oplossingen wordt een rangschikking gemaakt op welke aspecten de PM (en vooral TL) het belangrijkst vindt uit te werken en welke aspecten eventueel later geïmplementeerd zouden kunnen worden inclusief wat voor resultaat dit heeft voor de uiteindelijk aan te leveren software. Deze rangschikking is ook leidend voor het controleren van de uiteindelijk aangeleverde oplossing. | Q4, Q8 |
| 6: Op basis van deze rangschikking worden één of meerdere Proof of Concept prototypes uitgewerkt. | Q2, Q3, Q7 |
| 7 & 8: Om de gemaakte oplossing imperialistisch te kunnen controleren worden de eisen uit stap 5 gebruikt. Het doel van deze tests is met concrete nummers te kunnen zeggen hoe dicht de aangeleverde oplossing ligt bij de gewenste oplossing. | Q2, Q3 |

<!-- | [Co-reflection](https://cmdmethods.nl/cards/showroom/co-reflection) | Showroom |  | -->
<!-- | [Proof of Concept](https://cmdmethods.nl/cards/workshop/proof-of-concept) | Workshop | | -->
<!-- | [Requirements list](https://cmdmethods.nl/cards/stepping-stones/requirements-list) | Stepping stones |  | -->
<!-- |  |  |  | -->

## Library

In dit document wordt in meer detail in gegaan op de verschillende opties voor synchronisatie tussen [data uit het PMP](../Technisch/TechnischOntwerp.md#pmp-datamodel) en de [data uit Productive](../Technisch/TechnischOntwerp.md#productive-datamodel). Een korte omschrijving van het probleem en de gekozen oplossing is te vinden in [ADR001](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md), dit document dient voor meer diepgang op het onderwerp indien de lezer van ADR001 behoefte heeft aan meer diepgang op de verschillende overwogen opties.

Voor het project moet data uit en verstuurd worden naar productive. Deze data moet als single source of truth Productive gebruiken en dient met 50 gebruikers reactietijden te hebben van minder dan 3 sec zoals beschreven in [NFR3](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) en [NFR5](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements). Om de haalbaarheid deze NFR's te pijlen is gebruik gemaakt van de [scherm ontwerpen.](../Functioneel/Schermontwerpen.md)

Voor het uitlezen van data voor één pagina zouden bij sommige pagina's 5 verschillende Productive endpoints benaderd worden. Als volgens [NFR5.1](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) 50 gebruikers gelijktijdig bijvoorbeeld de details van een taak bekijken zou dit resulteren in 250 requests naar de Productive API. Er van uit gaande dat een pagina informatie nodig heeft van gemiddeld 3 a 4 endpoints zou de meest basale implementatie gebaseerd op directe communicatie met productive (met een rate limit van 100 requests per 10 sec) zich limiteren tot rond de 30 gelijktijdige gebruikers. (100/3.5=28.5)

Om er voor te zorgen dat de software aan alle eisen voldoet zal er dus één van twee (of beide) dingen moeten gebeuren:

A. Er dient tijdens de ontwikkeling van de front-end rekening gehouden te worden met welke data wanneer wordt getoond om de hoeveelheid requests naar productive te beperken.

B. De synchronisatie met productive dient losgekoppeld te worden van de front-end zodat Bluenotion zelf controle heeft over het aantal requests dat de front-end mag doen.

### Polling ADR001-O1

Er zou direct vanuit de front-end of back-end on demand data uit productive opgevraagd kunnen worden. Productive biedt endpoints met standaard [filter](https://developer.productive.io/#header-filtering) en [sorting](https://developer.productive.io/#header-sorting) opties die deze optie zouden kunnen faciliteren.

| Aanvraag | Resultaat* | Omgeving |
|-|-|-|
| Open taken (alle projecten vd klant)</br><https://api.productive.io/api/v2/tasks?page[size]=200&filter[company_id]=149808&filter[status]=1> | 77 resultaten over 1 pagina van 272KB in 499ms | klant |
| Projecten van klant</br><https://api.productive.io/api/v2/projects?page[size]=200&filter[company_id]=149808> | 2 resultaten over 1 pagina van 54KB in 292ms per pagina | klant |
| Alle taken van een project</br><https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877> | 845 resultaten op 5 pagina's van 438KB in 939ms per pagina | klant |
| Klanten lijst</br><https://api.productive.io/api/v2/companies?page[size]=200> | 307 resultaten over 2 pagina's van 158KB in 601ms per pagina | admin |
| Alle lopende projecten</br><https://api.productive.io/api/v2/projects?page[size]=200&filter[status]=1> | 233 resultaten over 2 pagina's van 358KB in 1434 ms per pagina | admin |
| Recente taken</br><https://api.productive.io/api/v2/tasks?page[size]=200&sort=-last_activity> | 27199 resultaten over 136 pagina's van 618KB in 2.29 s**  per pagina | admin |
| Alle open taken van een project</br><https://api.productive.io//api/v2/tasks?page[size]=200&filter[project_id]=102877&filter[status]=1> | 77 resultaten op 1 pagina van 272KB in 708ms per pagina | klant/admin |

*De getoonde resultaat grootte en tijd zijn voor het ophalen van één pagina. Er staan maximaal 200 items op één pagina dus resultaten met meer dan 200 items krijgen in het totaal een langere reactietijd.

**Zou mogelijk met de extra stap naar de back-end boven de 3 sec response time uitkomen zoals beschreven in de NFR

### Webhooks ADR001-O2

Productive biedt webhooks aan waarmee je automatisch op de hoogte wordt gebracht van wijzigingen in het Productive model. Aan de hand van deze webhooks zou het mogelijk zijn de PMP database automatisch te laten synchroniseren met alle wijzigingen direct wanneer Productive het PMP op de hoogte stelt van de wijzigingen. Productive biedt voor de volgende entiteiten Create, Update en Delete webhooks aan:

| Webhook entity | Create Id | Update Id | Delete Id | REST data source equivalent | Used in initial screen designs |
|--|--|--|--|--|--|
| Task  | 1 | 24 | 25 | [Tasks](https://developer.productive.io/tasks.html#tasks) | X |
| Invoice  | 2 | 14 | 15 | [Invoice](https://developer.productive.io/invoices.html#invoices) |  |
| Deal  | 3 | 12 | 13 | [Deals](https://developer.productive.io/deals.html#deals) |  |
| Budget  | 4 | 16 | 20 | Onbekend |  |
| Project  | 5 | 10 | 11 | [Projects](https://developer.productive.io/projects.html#projects) | X |
| Time entry  | 7 | 8 | 9 | [Time_entries](https://developer.productive.io/time_entries.html#time-entries) |  |
| Booking  | 17 | 18 | 19 | [Booking](https://developer.productive.io/bookings.html#bookings) |  |
| Expense  | 21 | 22 | 23 | [Expenses](https://developer.productive.io/expenses.html#expenses) |  |
| Person  | 26 | 27 | 28 | [People](https://developer.productive.io/people.html#people) | X |
| Company  | 29 | 30 | 31 | [Companies](https://developer.productive.io/companies.html#companies) | X |
| Payment  | 32 | 33 | 34 | [Payments](https://developer.productive.io/payments.html#payments) |  |
| None |  |  |  | [Attachments](https://developer.productive.io/attachments.html#attachments) | X |
| None |  |  |  | [Comments](https://developer.productive.io/comments.html#comments) | X |
| None |  |  |  | [Activities](https://developer.productive.io/activities.html#activities) | X |

Hierbij valt op dat attachments, comments en activities geen webhooks hebben die specifiek enkel de attachment, comment en activities data doorgeeft. Bijlages en comments zouden waarschijnlijk doorgegeven worden bij updates van hun gerelateerde objecten. Zo zou binnen productive een comment met bijlage op een taak plaatsen bijvoorbeeld resulteren met een trigger op de Task update hook en zal hier een referentie in zitten met de bijgevoegde bijlage.*

*Dit is nog niet uitgebreid getest en kan een fout begrip van het systeem zijn.

#### Webhook types

Binnen het vooronderzoek bleek dat Productive twee "types" webhooks biedt, om een geïnformeerde keuze te kunnen maken is gekeken naar de verschillen tussen deze twee types en wat dit betekend voor het PMP project.

##### Type 1: Webhook

Dit zijn reguliere webhooks, in te dienen bij Productive via de REST API met een event en een callback adres. Op het callback adres dient een endpoint beschikbaar te zijn die het HTTP bericht en zijn content verwerkt en een 2xx response code terug dient te sturen.

##### Type 2: Zapier

Om een begrip op te bouwen over wat een Zapier webhook is wordt uitgegaan van [dit artikel](https://caisy.io/blog/webhooks-vs-zapier). Uit dit artikel blijkt dat Zapier automatie tooling is die gebruikt kan worden om zonder code te schrijven simpele taken te automatiseren tussen verschillende applicaties. Hiermee heb je de optie snel simpele procedures op te zetten maar verlies je een stukje flexibiliteit door Zapiers proprietary protocol.

<!-- ##### Conclusie

De eerste indruk van Zapier is dat de vereenvoudigde automatisering voor kleinere/eenvoudigere projecten nuttig kan zijn, zoals het inlichten van een persoon bij een specifiek soort ticket. Hiervoor zou geen code geschreven hoeven worden en zou puur in de GUI van Zapier kunnen gebeuren.

Aangezien in het PMP de webhooks gebruikt zouden worden om de gehele dataset te synchroniseren en er binnen dit project toch endpoints geschreven moeten worden om data over projecten en taken te verwerken voor de front-end zie ik de voordelen van Zapier binnen het PMP vooralsnog niet opwegen tegen de extra kosten en verlaagde maten van flexibiliteit. -->

### Time based synchronisatie ADR001-O3

Binnen ADR001-O3 wordt gesproken over timer based synchronisatie. Technisch gezien zou er aan de hand van een proces dat elke x aantal seconde of minuten nieuwe data binnen haalt van de Productive API een synchronisatie opgezet kunnen worden die ongeacht de hoeveelheid gebruikers altijd een stabiel aantal requests doet naar de Productive API. Met een limiet van 100 requests in 10 seconde en filters als "last_activity_after" zouden waarschijnlijk genoeg requests mogelijk zijn om data te synchroniseren.

Het grote nadeel van deze aanpak is dat je als gebruiker niet weet of de data up to date is. Data kan wel automatisch bij binnenkomst aan de front-end doorgegeven worden maar er zal altijd een periode zijn waarin je data verouderd is aan het eind van de update cycle. Ook legt deze aanpak een relatief grote druk op het netwerk. Om deze redenen is geen prototype van een time based synchronisatie opgezet en verder gegaan met de overige keuzes.

### Change based polling ADR001-O4

Eén optie om up to date te blijven met productive is door bij elke data request voor een project of taak de lokale data van de entiteit te vergelijken met de data zoals beschikbaar op Productive. Als het "last_activity_at" date time veld in het PMP lager is dan die van Productive weet je dat de lokale data bijgewerkt moet worden. Dit kan vervolgens gedaan worden aan de hand van het /activities endpoint of de endpoint van de bijbehorende entiteit. Onder volgt een stroomschema van dit proces.

```puml

start
:get relevant project from local db;
if (Project found) then (no)
    :get project from productive;
    note right: Request to Productive API
    if(Productive contains project data) then (yes)
        :get all activities from productive*;
            note left: Request to Productive API as n1
    else (no)
    :Show project not found;
    endif
else (yes) 
    :get Activities from productive since last local update;
    note left: Request to Productive API
    if(Activities>0) then (yes)
    :Write changes to local db;
    else (no)
    endif
endif

:show data to user;
stop

```

Als aan de hand van de Activities endpoint alle relevante data binnengehaald kan worden zou het PMP met deze oplossing na maximaal* 2 requests naar productive altijd zekerheid kunnen bieden dat de aangeboden data compleet en correct is.

*Deze uitspraak is technisch gezien niet correct. Als de activity data meer dan 200 items bevat zouden er meer dan 2 requests naar Productive gestuurd moeten worden om alle data binnen te halen. TODO: corrigeren?

Het nadeel van deze optie zit hem echter ook in de twee requests naar Productive. Omdat de data van het eerste request als input dient voor de tweede request om de activities op te halen kunnen deze enkel sequentieel uitgevoerd worden.

### Gecombineerd webhooks en change based polling ADR001-O5

Door webhooks de standaard data synchronisatie te laten afhandelen zou het scenario dat het PMP twee sequentiële requests moet doen minder vaak voorkomen. Om er voor te zorgen dat data wanneer de gebruiker er om vraagt zeker up to date is kan gebruik gemaakt worden van het proces zoals beschreven bij [ADR001-O4](#change-based-polling-adr001-o4).*

Open vraag:
*De last activity geeft me geen garantie dat alle data tot dat punt is weggeschreven, alleen dat de activity van dat moment is weggeschreven. Kan ik iets zeggen over de activities die er voor kwamen en de garantie dat deze ook in de lokale database voorkomen?

## Workshop

Van de initieel voorgestelde opties [ADR001-O1 tm ADR001-O5](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md) leek [ADR001-O2](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md) de meest flexibele en schaalbare optie. Omdat deze optie wegens complexere implementatie toch lager scoorde dan ADR001-O1 is besloten te onderzoeken of deze optie ook in de praktijk naar verwachting functioneert en of het haalbaar is in de opgegeven afstudeer tijd is in twee fases een Proof of Concept prototype opgezet met de volgende eisen:

### Requirements prioritization

<!-- TODO: de onderstaande data wordt... -> de onderstaande data is....

Na in het library onderzoek een aantal mogelijke opties verzameld te hebben dienen de opties vergeleken te worden op basis van de opgestelde functionele en non-functionele requirements. De onderstaande data wordt voorgelegd aan de PM en TL van het project om feedback te krijgen op de voorgestelde oplossing voordat hier een prototype van gemaakt wordt. Ook hebben collega's op dit punt weer een feedback moment waar aan de hand van peer review commentaar of tips gegeven kan worden. -->

<!-- #### Kwaliteit eisen -->

Om tot een passende oplossing te komen voor de synchronisatie tussen het PMP en Productive worden binnen dit document voor de opties als beschreven in [ADR001](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md) een aantal test opstellingen opgezet. Aan de hand van deze testopstellingen zullen de opties op de volgende eisen getest worden:

| Eis | O1 | O2 | O3 | O4 | O5 |
|--|--|--|--|--|--|
| NFR5.1 & NFR5.2: Kan 50 gelijktijdige gebruikers ondersteunen | + | ++ | + | - | - |
| NFR2.1 & NFR8.3Delay tussen wijziging in Productive en sync in het PMP | ++ | + | -- | + | ++ |
| NFR3.2: Aantal requests naar Productive API | -- | ++ | + | -- | -- |
| NFR3.1: Aantal requests naar eigen API/db | ++ | + | + | -- | -- |
| NFR2.1: Compleetheid & Betrouwbaarheid gesynchroniseerde data | ++ | + | -- | ++ | ++ |
| NFR8.*: Opties voor catastrophisch herstel | ++ | +/- | +/- | +/- | +/- |
| Implementatie complexiteit | + | - | + | - | - |
| Totaal: | 8 | 6 | 0 | -1 | -2 |

Deze eisen zijn gebaseerd op de NFR's zoals beschreven en terug te vinden in het [functioneel ontwerp](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements).

### Proof of Concept

Na in het library onderzoek een aantal verschillende potentiële oplossingen uitgelicht te hebben en ze (voor zo ver mogelijk) op meetbare data gerangschikt te hebben wordt in elk geval de meest veelbelovende oplossing uitgewerkt naar een Proof of Concept prototype. Het doel van dit prototype is op kleine schaal project en taak data van en naar een lokale database te synchroniseren. Door eerst op (relatief) kleine schaal een prototype te maken vallen fouten in de synchronisatie eerder op en mocht de oplossing niet voldoen aan de verwachtingen kan er snel omgeslagen worden naar een andere potentiële oplossing. De eisen voor het PoC prototype zijn als volgt:

- POC: Worden binnen de webhooks alle identificerende data van objecten meegegeven of kan data uit de Productive API ambigu zijn?
- POC: Zet een procedure op die bij Productive kijkt of de webhooks actief zijn en indien dit niet het geval is webhooks kan activeren.
- POC: Zet een procedure op die aan de hand van webhooks één project passief op hoogte houdt met wijzigingen binnen Productive. (create, update delete webhooks on at least task & project)
- POC: Zet een aantal API endpoints op die (tijdelijke) Project/Taak data accepteren en doorsturen naar Productive via de Productive REST APi
- POC: (afhankelijk initiële dataset vraag) Zet een procedure op die voor één project alle voor het PMP relevante Project en taak informatie ophaalt.*
*Dit is een grote. Er zou voor een initiële dataset veel data (boven de api limits) aan Productive gevraagd moeten worden.

Na het opzetten van het proof of concept worden de resultaten van het onderzoek en opgeleverde POC besproken met een techlead van Bluenotion om de haalbaarheid en compleetheid van het opgeleverde product aan de hand van peer review te testen.

### Minimal Viable Product

Binnen fase 3 wordt het kleinschalige POC uitgebreid naar een "volwaardige" synchronisatie module die zonder verdere input de PMP database synchroniseert met wijzigingen binnen Productive en visa versa. Alle data die niet aan de hand van de webhooks gesynchroniseerd kan worden dient in het FO/TO genoteerd te worden met een potentiële oplossing voor waar de data eventueel vandaan kan komen. Ook worden er binnen fase 3 zo veel mogelijk edge cases getest die er voor moeten zorgen dat de data die in het PMP komt te staan correct en compleet is.

- FO/TO: Verifieer of naast project en taak data andere data nodig is van de webhooks
- FO/TO: Noteer voor alle data vragen binnen het PMP eventuele resterende REST endpoints.
- POC: Breidt het POC uit door in plaats van data uit één project te verzamelen data uit alle projecten te verzamelen.

Na het opzetten van het minimal viable product worden de resultaten van het onderzoek en opgeleverde MVP besproken met een techlead van Bluenotion om de haalbaarheid en compleetheid van het opgeleverde product aan de hand van peer review te testen.

- Verifieer dat alle data binnen komt.*
  - Wat als de PMP server bezig is met het verwerken van een ander bericht?
  - Wat als de Productive server boven de 12 (max) retries komt?
  - Wat als wijzigingen over de zelfde data gaan en ongeveer tegelijkertijd gedaan worden?
  - Wat als data in een onverwachte volgorde binnenkomt/verwerkt wordt?
  - Hoe gaan we met attachments om? Zelf hosten? Gebruik maken van Productive "hosting"?
- Meet het gebruik van de webhooks tegenover de schatting van phase 1.

<!-- TODO: *Is dit concreet testbaar? Mogelijk met integratietests? Zijn dit "HAN deelvragen"? Moet ik überhaupt "HAN deelvragen" hebben? -->

1. Set up webhook
2. Post data to productive
3. Verify webhook trigger
4. Verify database

## Lab

## Resultaten

### Q1: Biedt productive een API aan voor alle data die binnen het FO en schermontwerpen besproken worden?

Binnen de Productive API is vervolgens gezocht welke endpoints deze informatie zouden kunnen aanleveren als de front-end direct met productive zou communiceren als bij [ADR001-O1](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md#o1-directe-communicatie-met-productive). De resultaten hiervan zijn opgenomen in de onderstaande tabel:

| Scherm | [/projects](https://developer.productive.io/projects.html#projects) | [/tasks](https://developer.productive.io/tasks.html#tasks) | [/people](https://developer.productive.io/people.html#people) | [/companies](https://developer.productive.io/companies.html#companies) | [/attachments](https://developer.productive.io/attachments.html#attachments) | [/comments](https://developer.productive.io/comments.html#comments) | [/activities](https://developer.productive.io/activities.html#activities) |
|--|--|--|--|--|--|--|--|
| Klant: Projecten pagina | x | x | x |  |  |  |  |
| Admin: Projecten pagina | x |  | x | x |  |  |  |
| Klant: Taken lijst |  | x | x |  |  |  |  |
| Klant: Project overzicht | x | x |  |  |  |  |  |
| Klant: Taken detail |  | x | x |  | x | x | x |
| Admin: Taken lijst |  | x | x |  |  |  |  |
| Admin: Taken detail |  | x | x |  |  x | x | x |
| Klant: Documentatie pagina* |  |  |  |  |  |  |  |
| Admin: Toevoegen documentatie* |  |  |  |  |  |  |  |
| Admin: Controleren aanvraag |  | x | x |  | x | x | x |

<!-- TODO: links toevoegen na het reorganiseren scherm ontwerpen -->

Enkele opvallende aspecten van de Productive API zijn:

- Het /comments endpoint kan niet gefilterd worden op task_id of project_id dus kan niet makkelijk gebruikt worden alle comments van x op te vragen. Het /activities endpoint lijkt zich hier beter toe te lenen.
- Het wisselen van een tasklist wanneer een taak van bijvoorbeeld todo naar doing wordt gesleept wordt als change aangegeven binnen /activities maar enkel met de namen van de lijsten, niet de Id's die hier aan gekoppeld zijn. Het niet verifiëren van de achterliggende id's zou kunnen leiden tot corrupte/foutieve data binnen het PMP.
- Data over welke klant wat post zou binnen Productive minder duidelijk zijn als alles gepost wordt met de zelfde API key. Hier zijn eventueel ook veiligheids risico's bij. De procedure die op het moment het meest logisch lijkt is de naam van de klant toevoegen voor de comment. Hiermee is een comment in Productive niet meer netjes terug te leiden naar een klant in het PMP maar wel duidelijk wie een comment geschreven heeft.

```puml
"Customer" as klant
"Front-end" as fe
"Back-end" as be 
"Productive API" as prod

klant -> fe : leaves feedback comment
fe -> be : posts comment to pmp api
be -> prod : adds customer name and posts using bot api key
```

Een andere optie zou kunnen zijn zodra een klant zich registreert bij het PMP een account aanmaken binnen Productive. Er is echter vooralsnog geen endpoint gevonden waarin automatisch api tokens gegenereerd kunnen worden voor de klant.

### Q2: Hoe blijft het systeem up to date met wijzigingen gedaan in Productive?

Afhankelijk van [ADR001](../Technisch/ADRs/ADR001-Communicatie_met_de_Productive_API.md) maar waarschijnlijk aan de hand van webhooks met waar data niet binnengehaald kan worden met webhooks er directe communicatie met de Productive API gebruikt wordt.

### Q3: Hoe worden wijzigingen gedaan in het PMP doorgegeven aan Productive?

Aan de hand van directe API calls.

- Moet er een vorm van staging zijn die calls naar productive telt en alleen wijzigingen naar productive stuurt wanneer de capaciteit er is? Mogelijk met een queue oid?

### Q4: Kan het systeem "oneindig" (los van Productive) schalen?

Technisch gezien zou dit met webhooks mogelijk zijn?

### Q5: Moeten er aparte endpoints gemaakt worden binnen het PMP voor de communicatie met Productive of kan er (netjes) gebruik gemaakt worden van de endpoints die de front-end ook gebruikt?

Technisch gezien kunnen de zelfde endpoints gebruikt worden maar aparte endpoints voor dat wat de gebruiker doet en dat wat door het systeem wordt gebruikt om data te synchroniseren is netter.

<!-- TODO: Check if different actions from the Productive webhooks use different http methods or if they all use post. -->

```plantuml
class ProductiveSyncController 
ProductiveSyncController : Task ProcessPostTask(ProductiveTaskInputModel)
ProductiveSyncController : Task ProcessUpdateTask(ProductiveTaskInputModel)
ProductiveSyncController : Task ProcessDeleteTask(ProductiveTaskInputModel)
```

### Q6: Hoe dicht in de buurt van de webhook limits komt het dagelijks gebruik van Bluenotion? 1000 per 5 min

Om deze vraag te beantwoorden is gebruik gemaakt van de Productive activities endpoint. Deze endpoint geeft de mogelijkheid met filters activiteiten binnen taken, projecten, personen, bedrijven en meer te bekijken. Hiermee is het mogelijk alle productive wijzigingen op te vragen van bijvoorbeeld afgelopen week.

In 1 week, 3 pagina's van +/- 200 items

```https://api.productive.io/api/v2/activities?X-Feature-Flags=includes-overhaul&filter%5Bafter%5D=30-06-2024&filter%5Bbefore%5D=08-07-2024&page%5Bnumber%5D=3&page[size]=200```

Er is geen filter toegepast die enkel projecten, taken en comments dus er staan een aantal andere items in zoals boekingen maar het overgrote deel is data dat binnen het PMP nodig is. Dit houdt in dat binnen een reguliere week rond de 600 creates/updates/deletes zijn gedaan binnen productive op items waar het PMP in geïnteresseerd is. Aangezien webhooks gelimiteerd zijn aan 1000 requests per 5 min zit Bluenotion vooralsnog ver onder de limieten zoals opgelegd door Productive.

### Q7: Kan een systeem op basis van webhooks foutieve informatie ontdekken en herstellen?

Aangezien binnen het PMP (waarschijnlijk*) twee datasources zullen bestaan waar om de druk op de Productive API te verlagen primair gebruik wordt gemaakt van de lokale PMP database is het van belang dat data in deze database compleet en correct is. Om de compleetheid en correctheid te kunnen garanderen dient er gekeken te worden naar verschillende manieren om te detecteren wanneer data fout is en de juiste data te herstellen als het fout is.

Optie: webhook logs?

#### Optie1: Last edited

Omschrijving:

Productive houdt intern changes aan hun entiteiten bij aan de hand van drie datetime velden genaamd "created_at", "deleted_at" en "updated_at". Deze data wordt niet alleen meegestuurd* met de webhooks maar ook met elke aanvraag naar de reguliere REST API. Aan de hand van deze data zou binnen het PMP in ieder geval gekeken kunnen worden of de laatste edit aan een entiteit is doorgevoerd. Of de data vervolgens 100% overeen komt met de data op Productive is zonder extra requests naar Productive echter lastiger.

TODO: *meegestuurd zin opnieuw schrijven

Pro:

- 

Con:

#### Optie2: Item counts

Omschrijving:

Nog ruwer dan optie 1.

Pro:

Con:

#### Optie3: Edits gaan automatisch fout in productive

Omschrijving:

Bij deze oplossing zijn we niet zo zeer actief aan het zoeken naar fouten om ze op te lossen maar worden edits "on good faith" naar Productive gestuurd met het idee dat als data fout, out of date of incompleet is Productive niet toegestane edits niet toe laat.

Pro:

Con:

#### Optie4: ADR001-O1

Omschrijving:

Data hoeft niet gesynchroniseerd te worden als er direct met de Productive data gewerkt wordt.

Pro:

Con:

#### Optie5: Iets aan de hand van activities endpoint?

Omschrijving:

Er zou periodisch een call gemaakt kunnen worden naar de /activities endpoint om telkens de nieuwe staat van de database te verifiëren.

Pro:

Con:

### Q8: Is er een initiële dataset nodig?

Ja: De procedure zoals beschreven in ADR001-O4 resulteert in 2 of 3 database calls (lokaal en binnen de Productive API) voor één data vraag. Aangezien deze calls relatief dure/langzame operaties zijn zou een procedure waar enkel de "nodige" data uit Productive wordt gehaald resulteren in een tragere applicatie. Aangezien de datum gevonden in de eerste request als input dient voor de rest van de data requests moet de verzameling van deze data sequentieel gebeuren waardoor de snelheid van de applicatie nog verder zou afnemen en mogelijk boven het limiet zoals beschreven in [NFR3.1 en NFR3.2](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) zou komen.

Nee: Technisch gezien niet, er zou puur op aanvraag data verzameld kunnen worden.

### Q9: Wordt alle informatie die het PMP nodig heeft doorgegeven aan de hand van webhooks? Wat gebeurt er bijvoorbeeld met comments?

Voorlopig onbekend. Het zou kunnen dat voor informatie die weinig gebruikt wordt zoals bijlages in comments, wijzigingen in e-mail adressen of andere kleine wijzigingen op het moment over het hoofd worden gezien. Wel is in ieder geval het grootste deel van de gewenste data te verkrijgen aan de hand van webhooks. Dit geeft ook ruimte om aan de hand van reguliere API calls de missende data op te halen met een verlaagd risico boven de Productive rate limits te komen.



### Q10: Wat zijn scenario's waarin foutieve informatie in het systeem zou kunnen komen?

<!-- ### Fase 1

#### Hoe dicht in de buurt van de webhook limits komt het dagelijks gebruik van Bluenotion? -->

<!-- Om deze vraag te beantwoorden is gebruik gemaakt van de Productive activities endpoint. Deze endpoint geeft de mogelijkheid met filters activiteiten binnen taken, projecten, personen, bedrijven en meer te bekijken. Hiermee is het mogelijk alle productive wijzigingen op te vragen van bijvoorbeeld afgelopen week.

In 1 week, 3 pagina's van +/- 200 items

```https://api.productive.io/api/v2/activities?X-Feature-Flags=includes-overhaul&filter%5Bafter%5D=30-06-2024&filter%5Bbefore%5D=08-07-2024&page%5Bnumber%5D=3&page[size]=200```

Er is geen filter toegepast die enkel projecten, taken en comments dus er staan een aantal andere items in zoals boekingen maar het overgrote deel is data dat binnen het PMP nodig is. Dit houdt in dat binnen een reguliere week rond de 600 creates/updates/deletes zijn gedaan binnen productive op items waar het PMP in geïnteresseerd is. Aangezien webhooks gelimiteerd zijn aan 1000 requests per 5 min zit Bluenotion vooralsnog ver onder de limieten zoals opgelegd door Productive. -->

<!-- #### Kan een systeem op basis van webhooks foutieve informatie ontdekken en herstellen?


#### Is er een initiële dataset nodig? -->

<!-- Ja: De procedure zoals beschreven in ADR001-O4 resulteert in 2 of 3 database calls (lokaal en binnen de Productive API) voor één data vraag. Aangezien deze calls relatief dure/langzame operaties zijn zou een procedure waar enkel de "nodige" data uit Productive wordt gehaald resulteren in een tragere applicatie. Aangezien de datum gevonden in de eerste request als input dient voor de rest van de data requests moet de verzameling van deze data sequentieel gebeuren waardoor de snelheid van de applicatie nog verder zou afnemen en mogelijk boven het limiet zoals beschreven in [NFR3.1 en NFR3.2](/Documentatie/FunctioneelOntwerp.md#nonfunctional-requirements) zou komen.

Nee: Technisch gezien niet, er zou puur op aanvraag data verzameld kunnen worden. -->

#### Wordt alle informatie die het PMP nodig heeft doorgegeven aan de hand van webhooks


<!-- 
### Fase 2

### Fase 3 -->

<!-- Afhankelijk van ADR001-Communicatie met de Productive API heeft de synchronisatie service een aantal verschillende rollen:

- Een manier van verificatie bieden of data gevonden in het PMP overeen komt met data gevonden in het project management systeem.

TODO: Procedure uittekenen

- Handmatige synchronisatie starten waarmee de initiële dataset wordt binnengehaald.

TODO: Procedure uittekenen

- Het opzetten en in stand houden van webhooks die gebruikt kunnen worden om wijzigingen door te geven aan het PMP.

De voorlopige opzet maakt gebruik van een initiële dataset en webhooks om data van Productive over te nemen naar de lokale PMP database. Door de data uit Productive naar een eigen database te halen krijgen we controle over de rate limits en dus schaalbaarheid van de applicatie.*

*Geeft dit een onveiliger systeem ivm meer user input?

Is er een initiële dataset nodig?

Ja: De procedure zoals beschreven in ADR001-O4 resulteert in 2 of 3 database calls (lokaal en binnen de Productive API) voor één data vraag. Aangezien deze calls relatief dure/langzame operaties zijn zou een procedure waar enkel de "nodige" data uit Productive wordt gehaald resulteren in een tragere applicatie. Aangezien de datum gevonden in de eerste request als input dient voor de rest van de data requests moet de verzameling van deze data sequentieel gebeuren waardoor de snelheid van de applicatie nog verder zou afnemen en mogelijk boven het limiet zoals beschreven in [NFR3.1 en NFR3.2](/Documentatie/FunctioneelOntwerp.md#nonfunctional-requirements) zou komen.

Nee: Technisch gezien niet, er zou puur op aanvraag data verzameld kunnen worden. -->


<!-- In plaats van een directe afhankelijkheid op de Productive API is het ook mogelijk de data van Productive in een eigen database bij te houden. Hierdoor zou het mogelijk zijn de PMP applicatie los te koppelen van de Productive rate limits en reactie tijden.

Om zekerheid te kunnen bieden over dat de gewenste data met webhooks correct gesynchroniseerd wordt dient er in een vroeg stadium een prototype opgezet te worden die een aantal belangrijke vragen beantwoord:

- Is er een initiële dataset nodig en zo ja, hoe kan deze binnengehaald worden?

*Get all activities zou ook een all tasks van project kunnen zijn? Historische activities doen er in dit geval niet zo toe. -->

<!-- Activities op een project sinds inputdatum.

https://api.productive.io/api/v2/activities?page[size]=200&filter[project_id]=485803&filter[after]=16-06-2024 -->
<!-- 
- Hoe kan incorrecte data ontdekt worden?

iets met project last changed verandert maar data niet doorgekomen?

- Hoe kan incorrecte data gecorrigeerd worden?

- Hoe betrouwbaar zijn de webhooks met betrekking tot delays en retries? -->


<!-- 


- Wanneer wordt data binnen gehaald?

  - Data wordt een keer binnen gehaald als baseline.

Aangezien de volledige lijst van taken op het moment 27199 taken bevat zijn voor een baseline sync op zijn minst 136 requests nodig voor enkel de taak data. Mocht er voor elke taak ook de comments over de taak binnen gehaald willen worden is dit met 15486 comments zitten we al boven de 200 requests en is er dus (geen rekening houdend met de processing time van het PMP) al twee keer een wacht periode nodig om onder de 100 requests per 10 sec uit te komen. Dit is geen deal breaker voor een proces dat als het goed is maar een keer uitgevoerd moet worden maar hier dient wel over nagedacht te worden.

  - Data wordt gesynchroniseerd aan de hand van de webhooks.

Heeft de initiële database populatie nodig maar werkt hierna voor reads enkel met de PMP database.

Hoe weet je wat "relevante" data is en wat slaan we waarom op?

- Wanneer wordt data naar Productive gestuurd?

  - Direct

Zodra een gebruiker van het PMP een wijziging in een productive item doet sturen we dit naar de Productive API

  - Bulk

Er is een vast moment waarop alle synchronisatie naar productive wordt afgehandeld.

- Is er een mogelijkheid te detecteren wanneer data niet overeenkomt?

Als een gebruiker iets probeert in te voeren en een project/taak blijkt niet te bestaan

Als er van de webhook een wijziging binnen komt die niet overeen komt met de wijziging zoals eerder lokaal gedaan



  - Error bij inserts/updates?

  - Data opvragen bij inserts/updates?

  - Resultaten van de webhook?


- Is het mogelijk data te herstellen wanneer data niet overeenkomt?

  - Aan de hand van baseline import

  - Op object basis
 -->

## Conclusie


## Bronnen
