# OND01-Onderzoeksplan

<!-- Oud uit het PVA

Aangezien er op het gebied van communicatie met productive een aantal open vragen zijn die invloed kunnen hebben op de rest van de software is er besloten vroegtijdig een onderzoekje op te zetten waar verschillende manieren van synchronisatie worden vergeleken en een prototype wordt gebouwd met de (afhankelijk van de functionele en non-functionele eisen) meest belovende oplossing. Dit prototype dient initieel als Proof of Concept en wordt als de oplossing bevalt uitgebouwd tot synchronisatie module. Met deze aanpak is de hoop eventuele problemen en/of limitaties van het gebruik van de Productive API te ontdekken en indien mogelijk een synchronisatie systeem te maken dat volledig losgekoppeld staat van de rest van de software.

Open Productive communicatie vragen:

- Biedt productive een API aan voor alle data die binnen het FO en schermontwerpen besproken worden?
- Hoe blijft het systeem up to date met wijzigingen gedaan in Productive?
- Hoe worden wijzigingen gedaan in het PMP doorgegeven aan Productive?
- Kan het systeem los van Productive rate limits schalen?
- Is het nodig de huidige data uit productive in een lokale database weg te schrijven of kan het systeem op requests werken?
- Moeten er aparte endpoints gemaakt worden binnen het PMP voor de communicatie met Productive of kan er (netjes) gebruik gemaakt worden van de endpoints die de front-end ook gebruikt?

Aan de hand van de antwoorden op deze vragen en de specifieke functionele en non-functionele eisen dient antwoord gegeven te worden op de hoofdvraag/Architectural Decision: Hoe dient het PMP te communiceren met Productive? -->

De te bouwen software dient als verbinding tussen een extern software (Productive) pakket en externe klanten. Omdat de Project manager en externe klant beslissingen gaan maken op basis van informatie binnen het PMP dient deze data "altijd" up-to-date en compleet te zijn. Aangezien de klant voornamelijk geïnteresseerd is in de status van de taken voor zijn/haar projecten dient er een procedure opgezet opgezet te worden om deze data uit Productive te halen. Deze procedure dient rekening te houden met de niet functionele eisen zoals [vastgelegd in het functioneel ontwerp](../Functioneel/FunctioneelOntwerp.md). Kort samengevat hebben deze NFRs betrekking op de maximale response time van berichten afkomstig van de verschillende data sources en de schaalbaarheid met gelijktijdige gebruikers. Om deze reden wordt tijdens dit onderzoek extra focus gelegd op deze data op een schaalbare wijze verwerken in het PMP.

<!-- TODO: "altijd" weghalen? -->

De hoofdvraag luidt dan ook als volgt:
Hoe gaat het PMP op een schaalbare wijze communiceren met de al bestaande Productive omgeving?

Naar aanleiding van deze hoofdvraag zijn een aantal deelvragen opgezet. Deze deelvragen zullen aan de hand van verschillende onderzoeksmethodes beantwoord worden om uiteindelijk de hoofdvraag te beantwoorden. Deze deelvragen zijn in de volgende categorieën in te delen:

Vragen over webhooks:

- Q6: Hoe dicht in de buurt van de webhook limits komt het dagelijks gebruik van Bluenotion? 1000 per 5 min
- Q7: Kan een systeem op basis van webhooks foutieve informatie ontdekken en herstellen?
- Q9: Wordt alle informatie die het PMP nodig heeft doorgegeven aan de hand van webhooks? Wat gebeurt er bijvoorbeeld met comments?
- Zijn de limieten op reactietijd en schaalbaarheid zoals opgenomen in het [FO](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) realistisch?

Vragen over beschikbaarheid data:

- Q1: Biedt productive een API aan voor alle data die binnen het FO en schermontwerpen besproken worden?
- Q2: Hoe blijft het systeem up to date met wijzigingen gedaan in Productive?
- Is alle data zoals beschreven in de [functionele requirements](../Functioneel/FunctioneelOntwerp.md#requirements) en [schermontwerpen](../Functioneel/Schermontwerpen.md) beschikbaar in de [Productive API](https://developer.productive.io/index.html#top)?
- Wat doen we als de Productive API tijdelijk niet beschikbaar is?

Vragen over writes

- Q3: Hoe worden wijzigingen gedaan in het PMP doorgegeven aan Productive?

Vragen over software architectuur:

- Slaan we data uit Productive lokaal op of halen we het altijd opnieuw uit Productive?
- Wat zijn bestaande wijzes om data tussen twee verschillende data sources te synchroniseren?
- Q4: Kan het systeem "oneindig" (los van Productive) schalen?
- Q5: Moeten er aparte endpoints gemaakt worden binnen het PMP voor de communicatie met Productive of kan er (netjes) gebruik gemaakt worden van de endpoints die de front-end ook gebruikt?

Algemeen:

- Q8: Is er een initiële dataset nodig?
- Q10: Wat zijn scenario's waarin foutieve informatie in het systeem zou kunnen komen?
- Zijn de limieten op reactietijd en schaalbaarheid zoals opgenomen in het [FO](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) realistisch?

## Methodiek

Voor dit onderzoek zijn voornamelijk de patronen "Realize as required", "Realise as expert" en "Choose fitting technology" overwogen. Beide patronen worden vanaf de analyse fase gebruikt om tot een nog onbekende oplossing te komen met als voornaamste verschil of er vanuit een functioneel (required) of technisch standpunt (expert) naar het probleem wordt gekeken.

Realise as required: Field -> Workshop -> Lab

In de omschrijving van het Realise as required pattern wordt onder risico's genoemd dat er mogelijk niet naar een optimale oplossing wordt gewerkt omdat er geen library of showroom onderzoek wordt gedaan die de wensen van de opdrachtgever zou vaststellen.

Realise as expert: Library -> Workshop -> Showroom

In de omschrijving van het Realise as expert pattern wordt onder risico's genoemd dat het zicht op de applicatie context verloren kan raken en dus software niet aan de eisen van de opdrachtgever voldoet.

Choose fitting technology: Library -> Field -> Workshop -> Lab

In de omschrijving van het Choose fitting technology patroon wordt onder risico's genoemd dat er vaak suboptimale keuzes worden gemaakt door op basis van persoonlijke voorkeur en met incomplete criteria te kiezen.

Om de zwakheden van de onderzoek patronen af te dekken is gekozen het Realise as required patroon toe te passen met extra library onderzoek. Aan de hand van dit extra library onderzoek worden verschillende opties voor synchronisatie verkend zodat deze in de rest van het onderzoek meegenomen kunnen worden. Eigenlijk is Realise as required met library onderzoek qua structuur grotendeels het zelfde als choose fitting technology.

**Library**: Om een beeld op te bouwen van de verschillende mogelijkheden wordt eerst aan de hand van een Library onderzoek gekeken naar bekende manieren waarop mensen synchronisatie regelen tussen twee data sources.

[Best good and bad practices](https://ictresearchmethods.nl/library/best-good-and-bad-practices/), [Community research](https://ictresearchmethods.nl/library/community-research/), [Design pattern research](https://ictresearchmethods.nl/library/design-pattern-research/)

- Is alle data zoals beschreven in de [functionele requirements](../Functioneel/FunctioneelOntwerp.md#requirements) en [schermontwerpen](../Functioneel/Schermontwerpen.md) beschikbaar in de [Productive API](https://developer.productive.io/index.html#top)?
- Slaan we data uit Productive lokaal op of halen we het altijd opnieuw uit Productive?
  - Q8: Is er een initiële dataset nodig?

- Wat zijn bestaande wijzes om data tussen twee verschillende data sources te synchroniseren?
- Q1: Biedt productive een API aan voor alle data die binnen het FO en schermontwerpen besproken worden?

**Field:** Aan de hand van een field onderzoek wordt gekeken precies welke data wanneer en vooral hoe vaak opgevraagd zou moeten worden om een beter begrip op te bouwen van de grenzen waarin het systeem zal werken.

[Document analysis](https://ictresearchmethods.nl/field/document-analysis/), [Task analysis](https://ictresearchmethods.nl/field/task-analysis/)

- Is alle data zoals beschreven in de [functionele requirements](../Functioneel/FunctioneelOntwerp.md#requirements) en [schermontwerpen](../Functioneel/Schermontwerpen.md) beschikbaar in de [Productive API](https://developer.productive.io/index.html#top)?
- Slaan we data uit Productive lokaal op of halen we het altijd opnieuw uit Productive?

**Workshop**: Aan de hand van de resultaten van het library en field onderzoek zal voor de meest belovende optie een prototype opgezet worden die binnen het Bluenotion template endpoints beschikbaar stelt voor het ophalen van de taken van een project.

[Architecture sketching](https://ictresearchmethods.nl/workshop/it-architecture-sketching/), [Prototyping](https://ictresearchmethods.nl/workshop/prototyping/), [Multi-criteria decision making](https://ictresearchmethods.nl/workshop/multi-criteria-decision-making/)

- Kan de aantal requests naar de Productive API beperkt worden door webhooks te gebruiken?
- Zijn de limieten op reactietijd en schaalbaarheid zoals opgenomen in het [FO](../Functioneel/FunctioneelOntwerp.md#nonfunctional-requirements) realistisch?

**Lab**: Aan de hand van een lab onderzoek zal gekeken worden of het gemaakte prototype functioneert binnen de parameters zoals aangegeven bij de niet functionele requirements om te kijken of de gekozen oplossing voldoet aan de eisen van het project.

[Component test](https://ictresearchmethods.nl/lab/component-test/)

## Doelstelling

Aan het eind van dit onderzoek dient niet alleen antwoord gegeven te zijn op de deelvragen maar wordt er ook een Proof of Concept prototype opgeleverd waar in de [Bluenotion template](https://gitlab.bluenotion.nl/bluenotion/template.bluenotion.nl) endpoints neergezet zijn die een lijst aan taken per project kunnen leveren waarbij de geleverde data overeen komt met de data in Productive.

## Resultaten

## Discussie

## Conclusie

## Bronnen

