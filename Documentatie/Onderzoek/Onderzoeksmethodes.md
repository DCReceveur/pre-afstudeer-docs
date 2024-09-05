# Onderzoek methodes

Binnen dit document worden de verschillende onderzoek patronen en methodes gebruikt in dit project toegelicht.

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

| Methode | Type | Redenatie |
|--|--|--|
| [Realise as required pattern](https://ictresearchmethods.nl/patterns/realise-as-required/) | Pattern |  |
| [Realise as expert pattern](https://ictresearchmethods.nl/patterns/realise-as-an-expert/) | Pattern |  |
| [Choose fitting technology](https://ictresearchmethods.nl/patterns/choose-fitting-technology/) | Pattern |  |

De volgende methodes zijn overwogen toe te passen binnen het gekozen onderzoek patroon.

| Stap | Naam | Type | Doel binnen dit project | Gebruikt in |
|---|---|---|---|---|
| 1 | [Best, good & bad practices](https://ictresearchmethods.nl/library/best-good-and-bad-practices/) | Library | Vindt opties door met collega's en online te zoeken naar potentiële oplossingen voor vergelijkbare synchronisaties. | [OND01](OND01-ProductiveSync.md#library) |
| 2 | [Design Pattern Search](https://ictresearchmethods.nl/library/design-pattern-research/) | Library | Onderzoek of er standaard design patterns zijn die dergelijke synchronisaties afhandelen. | [OND01](OND01-ProductiveSync.md#library) |
| 3 | [Literature Study](https://ictresearchmethods.nl/library/literature-study/) | Library | Uitbreiding op de gevonden resultaten van de bovenstaande methodes. | [OND01](OND01-ProductiveSync.md#library) |
|  | [Stakeholder analysis](https://ictresearchmethods.nl/field/stakeholder-analysis/) | Field | [Onderdeel FO](../Functioneel/FunctioneelOntwerp.md#actors-en-user-stories) | [FO](../Functioneel/FunctioneelOntwerp.md#actors-en-user-stories) |
|  | [Problem analysis](https://ictresearchmethods.nl/field/problem-analysis/) | Field | Ter verificatie dat de voorgestelde oplossing niet vanaf een vroeg punt de verkeerde richting in is geslagen of onnodig complex is wordt met de PM&TL overlegd. | [FO](../Functioneel/FunctioneelOntwerp.md#user-stories) |
|  | [Observation](https://ictresearchmethods.nl/field/observation/) | Field | Mapping van het domein en de bijbehorende wensen voor de software. | [FO](../Functioneel/FunctioneelOntwerp.md#domein) |
|  | [Interview](https://ictresearchmethods.nl/field/interview/) | Field |  Mapping van het domein en de bijbehorende wensen voor de software. | [FO](../Functioneel/FunctioneelOntwerp.md#domein) |
|  | [Document analysis](https://ictresearchmethods.nl/field/document-analysis/) | Field |  Mapping van het domein en de bijbehorende wensen voor de software. | [FO](../Functioneel/FunctioneelOntwerp.md#domein) |
| 4 | [Peer review](https://ictresearchmethods.nl/showroom/peer-review/) | Showroom | Wordt gebruikt voorgestelde oplossingen te verifiëren met collega's die (ook als gebruiker van het systeem) uniek inzicht kunnen geven. Deze methode is gekozen om tijdens het proces toch de potentieel waardevolle kennis van mijn collega's te kunnen gebruiken. | [OND01](OND01-ProductiveSync.md) |
| 5 | [Requirements prioritization](https://ictresearchmethods.nl/workshop/requirements-prioritization/) | Workshop | Voor synchronisatie zijn vaak meerdere potentiële oplossingen beschikbaar die afhankelijk van de eisen aan de software complexer of simpeler gemaakt kunnen worden en daarbij meer of minder ontwikkeltijd kosten. | [OND01](OND01-ProductiveSync.md#workshop) |
| 6 | [Prototyping](https://ictresearchmethods.nl/workshop/prototyping/) | Workshop |  Na het vaststellen van de eisen en onderzoeken van de verschillende opties wordt de meest belovende optie uitgewerkt tot een PoC zodat er meer zekerheid is dat de oplossing naar verwachting functioneert. | [OND01](OND01-ProductiveSync.md#workshop) |
| 7 | [Usability testing](https://ictresearchmethods.nl/lab/usability-testing/) | Lab | Zodra een PoC is gemaakt kunnen er tests uitgevoerd worden die de grenzen van het systeem testen. | [OND01](OND01-ProductiveSync.md#lab) |
| 8 | [A/B Testing](https://ictresearchmethods.nl/lab/a-b-testing/) | Lab | Zou gebruikt kunnen worden om twee oplossingen te vergelijken na het maken van één of meerdere PoC's. | [OND01](OND01-ProductiveSync.md#lab) |
| 9 | [Stakeholder analysis](https://ictresearchmethods.nl/field/stakeholder-analysis/) | Field | [Onderdeel FO](../Functioneel/FunctioneelOntwerp.md#actors-en-user-stories) | |
| 10 | [Problem analysis](https://ictresearchmethods.nl/field/problem-analysis/) | Field | Ter verificatie dat de voorgestelde oplossing niet vanaf een vroeg punt de verkeerde richting in is geslagen of onnodig complex is wordt met de PM&TL overlegd. | |
| 11 | [Observation](https://ictresearchmethods.nl/field/observation/) | Field | Discover productive workflow | |
| 12 | [Interview](https://ictresearchmethods.nl/field/interview/) | Field | Discover productive workflow | |
| 13 | [Document analysis](https://ictresearchmethods.nl/field/document-analysis/) | Field | Discover productive workflow | |
