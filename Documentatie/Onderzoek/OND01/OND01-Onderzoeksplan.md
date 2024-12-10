# Onderzoeksplan OND1 Productive synchronisatie

## Probleem

Voor het product management portal dient data opgehaald te worden vanuit Productive om dit aan de klant te kunnen tonen. De "data" waar binnen dit document over gepraat wordt betreft voornamelijk de [taken](https://developer.productive.io/tasks.html#tasks), [projecten](https://developer.productive.io/projects.html#projects), [taak afhankelijkheden](https://developer.productive.io/taskdependency.html#taskdependency) en [activiteiten](https://developer.productive.io/activities.html#activities) endpoints van Productive. Het doel van dit onderzoek is echter om niet alleen voor deze endpoints schaalbaar data te kunnen synchroniseren met een lokale data source maar ook het eenvoudig uitbreiden naar andere endpoints faciliteren. De reden waarom binnen dit onderzoek specifiek naar de boven genoemde endpoints wordt gekeken is om de ontwikkeling van [FR1: Inzien project plannings informatie](../Functioneel/Requirements/FR1_Inzien_project_plannings_informatie.md) en [FR2: Inzien taken](../Functioneel/Requirements/FR2_Inzien_taken.md) toe te staan.

Een aantal factoren die een rol spelen in hoe deze data verzameld gaat worden zijn de volgende requirements:

| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) |  Document references |
|---|---|---|---|---|
|   | NFR2.1  | Informatie over projecten en taken komen altijd overeen met de informatie op Productive.  | Must have  |      |
|   | NFR2.2  | Het systeem geeft bij 95% van de requests in een maand antwoord zoals beschreven in dit document.  | Must have  |    [US17](#user-stories)   |
|   | NFR3.2  | Onder normale omstandigheden wordt data die afkomstig is van de Productive API binnen 3 seconden na aanvraag getoond aan de gebruiker. | Should have  |    [US17](#user-stories)  |
|   | NFR4.5  | Accounting: Loggen write events  | Must have?  |    [US15](#user-stories)  |
|   | NFR4.6  | Accounting: Loggen read events?  | Could have?  |    [US15](#user-stories)  |
|   | NFR5.1  | De software komt met 50? gelijktijdige gebruikers niet aan de Productive API rate limits  | Should have  |    [US17](#user-stories)  |
|   | NFR5.2  | De software komt ongeacht hoeveelheid gelijktijdige gebruikers niet aan de Productive API rate limits?  | Would have     | [US17](#user-stories)  |
|   | NFR8.1  | Het systeem kan bij verlies van de database binnen 3 uur hersteld worden naar een werkende state.  | Could have  |    [US18](#user-stories)  |
|   | NFR8.2  | Bij verlies van de database raken geen gegevens over projecten of taken verloren. | Must have |   [US18](#user-stories)  |
|   | NFR8.3  | Bij verlies van de database raken geen gegevens ouder dan 24 uur verloren.  | Must have  |    [US18](#user-stories)  |

Om tot een goede oplossing te komen die data voor de bovengenoemde FR's kan synchroniseren terwijl er aan alle NFR's wordt gehouden is de volgende hoofdvraag opgesteld:

Hoe kan het PMP op een schaalbare en betrouwbare manier data synchroniseren van en naar Productive?

Om deze hoofdvraag te kunnen beantwoorden dienen er eerst een aantal deelvragen beantwoord te worden:

- DV1: Wat zijn vaak gebruikte manieren van data synchronisatie die toe te passen zijn bij dit project?
- DV2: Hoe dicht zit de verwachte gebruik frequentie van de applicatie tegen de rate limits?
- DV3: Welke synchronisatie methoden schalen goed met het aantal requests?
- DV4: (Hoe) Is te garanderen dat data correct en consistent is?
- DV5: Hoe kunnen atomic transactions en data consistency worden gegarandeerd bij overschrijding van de rate limits of algehele onbereikbaarheid van de Productive API?

## Methodiek

Voor dit onderzoek zijn voornamelijk de patronen "Realize as required", "Realize as expert" en "Choose fitting technology" overwogen. Beide patronen worden vanaf de analyse fase gebruikt om tot een nog onbekende oplossing te komen met als voornaamste verschil of er vanuit een functioneel (required) of technisch standpunt (expert) naar het probleem wordt gekeken.

Realize as required: Field -> Workshop -> Lab

In de omschrijving van het Realize as required pattern wordt onder risico's genoemd dat er mogelijk niet naar een optimale oplossing wordt gewerkt omdat er geen library of showroom onderzoek wordt gedaan die de wensen van de opdrachtgever zou vaststellen.

Realize as expert: Library -> Workshop -> Showroom

In de omschrijving van het Realize as expert pattern wordt onder risico's genoemd dat het zicht op de applicatie context verloren kan raken en dus software niet aan de eisen van de opdrachtgever voldoet.

Choose fitting technology: Library -> Field -> Workshop -> Lab

In de omschrijving van het Choose fitting technology patroon wordt onder risico's genoemd dat er vaak suboptimale keuzes worden gemaakt door op basis van persoonlijke voorkeur en met incomplete criteria te kiezen.

Om de zwakheden van de onderzoek patronen af te dekken is gekozen het Realize as required patroon toe te passen met extra library onderzoek. Aan de hand van dit extra library onderzoek worden verschillende opties voor synchronisatie verkend zodat deze in de rest van het onderzoek meegenomen kunnen worden. Eigenlijk is Realize as required met library onderzoek qua structuur grotendeels het zelfde als choose fitting technology.

### Library

Om een beeld op te bouwen van de verschillende mogelijkheden wordt eerst aan de hand van een Library onderzoek gekeken naar bekende manieren waarop mensen synchronisatie regelen tussen twee data sources.

Dit gebeurt aan de hand van de volgende onderzoeks methodes:
[Best good and bad practices](https://ictresearchmethods.nl/library/best-good-and-bad-practices/), [Community research](https://ictresearchmethods.nl/library/community-research/), [Design pattern research](https://ictresearchmethods.nl/library/design-pattern-research/)

Tijdens het library onderzoek dient in ieder geval "DV1: Wat zijn vaak gebruikte manieren van data synchronisatie die toe te passen zijn bij dit project?" beantwoord te worden en het zou inzicht moeten geven in "DV5: Hoe kunnen atomic transactions en data consistency worden gegarandeerd bij overschrijding van de rate limits of algehele onbereikbaarheid van de Productive API?".

### Field

Aan de hand van een field onderzoek wordt gekeken precies welke data wanneer en vooral hoe vaak opgevraagd zou moeten worden om een beter begrip op te bouwen van de grenzen waarin het systeem zal werken.

Met een [Document analysis](https://ictresearchmethods.nl/field/document-analysis/) en [Task analysis](https://ictresearchmethods.nl/field/task-analysis/) worden de opties van DV1 en bijbehorende limieten vergeleken met de verwachte workload van het PMP.

De focus zal hier liggen op "DV2: Hoe dicht zit de verwachte gebruik frequentie van de applicatie tegen de rate limits?", "DV3: Welke synchronisatie methoden schalen goed met het aantal requests?" en "DV4: (Hoe) Is te garanderen dat data correct en consistent is?".

### Workshop

Aan de hand van de resultaten van het library en field onderzoek zal voor de meest belovende optie een prototype opgezet worden die binnen het Bluenotion template endpoints beschikbaar stelt voor het ophalen van de taken van een project.

Tijdens de workshop fase van het onderzoek wordt aan de hand van [Architecture sketching](https://ictresearchmethods.nl/workshop/it-architecture-sketching/), [Prototyping](https://ictresearchmethods.nl/workshop/prototyping/) en [Multi-criteria decision making](https://ictresearchmethods.nl/workshop/multi-criteria-decision-making/) een Proof of Concept (PoC) prototype opgezet van de meest belovende optie die in ieder geval taak data van één project synchroniseert naar een lokale data source. Hierna dient op de vragen "DV4: (Hoe) Is te garanderen dat data correct en consistent is?" en "DV5: Hoe kunnen atomic transactions en data consistency worden gegarandeerd bij overschrijding van de rate limits of algehele onbereikbaarheid van de Productive API?" antwoord gegeven te kunnen worden.

### Lab

Aan de hand van een lab onderzoek zal gekeken worden of het gemaakte prototype functioneert binnen de parameters zoals aangegeven bij de niet functionele requirements om te kijken of de gekozen oplossing voldoet aan de eisen van het project. Deze fase is voornamelijk bedoelt als bevestiging of ontkrachting van de gekozen oplossing.

[Component test](https://ictresearchmethods.nl/lab/component-test/)

### Doelstelling

Aan het eind van dit onderzoek dient niet alleen antwoord gegeven te zijn op de deelvragen maar wordt er ook een Proof of Concept prototype opgeleverd waar in de [Bluenotion template](https://gitlab.bluenotion.nl/bluenotion/template.bluenotion.nl) endpoints neergezet zijn die een lijst aan taken per project kunnen leveren waarbij de geleverde data overeen komt met de data in Productive.