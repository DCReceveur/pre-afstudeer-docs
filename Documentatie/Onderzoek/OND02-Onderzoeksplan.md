# Onderzoeksplan ai assisted requirements engineering

## Probleem omschrijving

Een belangrijke stap in het ontwikkelen van software is het opzetten van de requirements waar de software aan moet voldoen. Dit proces verloopt vaak minder soepel om een aantal verschillende redenen die vaak te maken hebben met hoe de verschillende partijen kijken naar de software en het ontwikkelproces en een gebrek aan verificatie en validatie van de requirements. [Common requirements problems](https://www.jot.fm/issues/issue_2007_01/column2/), [Human Error Management in Requirements Engineering](https://pdf.sciencedirectassets.com/271539/1-s2.0-S0950584923X00056/1-s2.0-S0950584923000770/am.pdf?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEMn%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIH3fAERVoI9tIG%2FyEpD4IfGarnPBoKBE7bztPOgPGZjwAiEAggAi8pfzhgLgHPUEEfEh5MkcXfsCskBRzEWLQkr3KqgqswUIQRAFGgwwNTkwMDM1NDY4NjUiDKYdlXVyK6YWn9BlsSqQBThOB1tIocuxPUoKtAjGkLWJMg%2BNx2Hlgjb%2Fn7xeotqPv7boZ3sDIDcpgY837uzJ3A%2FFn%2F2khNEMoFmPqujvDQtfJPzorJKdagl3zDn6q0B6bYrX02M4dqhna3CC7RBCocLx%2F3KQ%2FqssldyrCXxVFxsJ%2BMvnSWmPCFUqA%2BJd1QR7bU8hiBqEED5TwWpi7AY7LmZZT1R73eiDBR02J6tcJI7RJaBX9G%2FPf2d9xL7Ne%2FCvYDs0zzh%2FTXEx8lv%2BRF6kwZ8oITFt8FUl4BodO%2BdD4FjyQvvA12yZGwYEFGxNghFrBIBj%2F8RDM5NdYm8ItfTqBkbvR6OYvl6mn0OJ8qfezAyohAMCB0Gqx7Ms%2F8%2B3SpB5GnbIyGhZ9FOt2kwirEgD56Bzj3nvYw32rPz%2FH8nZkHVAvKJjMr%2BuwV4aS3m19Y3GD9UUzzJHisgOvKHDKWKGUfYEi5%2F980%2FZyea0jpG7jmGGlE1wx9%2BXbDVQjC9n9eECianM52dLqkl9xMlyiG0ltcMUZIC5bBpQwDX0J5HRS6St7Ic3hxj87aSYL2jfzoOkmn0oZNnW9xNpa3sr1mNnjwhAQfxAMd%2BLtzFRla9RVt2GxlirX5O0NwxuiOitlTZn52PH1HfL4hbPcF7yra6h2Pm9DRXlvHgmlRWWQBbwZEKsUDu1gMOb%2BrALWhlj2t0zb4ZEITz0qXtnkQGlro33NA2r4AqnIeAbcQpIViVZyFpK2slcGwV8DElpDiQqtERSyjYK%2Bkr6wTt%2B27Aat7wBLLn5pztRj3hR4mZQXwq7KSOt6uOFS%2Bj0QyKqqei86XlbKQzXQZVdqgc0QgyF4qDHERaHqfhvs7zJZmUnHUlcWsydVSZGsAI%2Bw5nBpqK1qO%2B2MMyP%2FbgGOrEBqLaqwxuzfyNiqqKCMzCdcKladhf53%2BO1eN%2BgEWJKOnSqezPN7PxuJJl1FXlJbtR2vfpuv8kaJPUmmK10MXD9EUBZToIt6T9Mk1USZHKppioo5%2BYyIuoE%2FBBzblXnjhZG1YDJjWhUikGkIaa5FANvr5HKTyHw4xjVMaucxNsMEil%2FfQl70JyRfkTGokL8csNz3s1Q55Vxwcs3iXm8OKpOdEu3jANG%2BRaIF0F82IIZCwZq&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20241028T082801Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIAQ3PHCVTY2YPMSJCS%2F20241028%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=50deddf408d39eafa7bfe12516b052b695a73efe27091348a998290be022d70d&hash=3f2dbacfe804d5b869e2a393c808cd76e663f0e90ffc4750ccd0a37f7d268bda&host=68042c943591013ac2b2430a89b270f6af2c76d8dfd086a07176afe7c76c2c61&pii=S0950584923000770&tid=pdf-5f837774-e270-4677-ae3c-46cd25d04ea2&sid=0004e1ef539f384cff5a81b4b638a65b45c0gxrqb&type=client)

## Aanleiding

Het probleem dat requirements niet altijd correct of volledig zijn omschreven doet zich ook voort bij Bluenotion. Omdat er op het moment als afstudeer opdracht een portaal ontwikkeld wordt waarin de klant inzicht kan krijgen in de status van zijn/haar projecten waar de HAN extra complexiteit in wenst te zien is er in een interne meeting besproken of er niet samen met een AI requirements opgezet kunnen worden. Dit voorstel komt uit de ontwikkelingen van AI op het domein van natural language processing met als voorbeeld de verschillende GPT modellen.

## Doelstelling

Het doel van dit onderzoek is er achter komen of een AI systeem gebruikt kan worden om het proces van het opzetten van de requirements. De hoofdvraag luidt dan ook "Kan AI gebruikt worden om het proces van het opzetten van requirements te verbeteren?".

Om deze vraag te beantwoorden dienen een aantal deelvragen beantwoord te worden:

DV1: Welk systeem/model/AI tooling kan gebruikt worden om met de gebruiker "in gesprek" te gaan?

Toelichting: Bij deze deelvraag worden verschillende systemen/models vergeleken op kosten, snelheid, en aangeboden functionaliteiten. Hierna worden de systemen gerangschikt en een systeem gekozen/aangeraden voor de rest van het onderzoek.

Methodiek: Deze deelvraag zal beantwoord worden met een "[literature study](https://ictresearchmethods.nl/library/literature-study/)" en waar mogelijk een vergelijking van reacties op een standaard set inputs/vragen ([benchmark test](https://ictresearchmethods.nl/showroom/benchmark-test/)).

DV2: Hoe kan vanuit de in DV1 besproken systeem(en) terug gehaakt worden naar het "traditionelere" project management portal met de requirements zoals opgesteld samen met de klant?

Toelichting: Deze deelvraag legt de focus op het isoleren van de uiteindelijk geformuleerde requirements uit het gesprek en deze verwerken in het PMP (en Productive) tot een te traceren taak. Het systeem dat deze analyse doet en een API call naar het PMP doet hoeft niet hetzelfde systeem te zijn als dat waar de klant mee "praat" dus er zal binnen deze deelvraag gekeken worden naar de [intent detection en entity identifacation](https://blog.pangeanic.com/intent-recognition-in-nlp) van het bij DV1 besproken systeem maar indien dit niet naar verwachting functioneerd mogelijk ook naar andere systemen.

Methodiek: Om tot de gewenste resultaten te komen zal een [prototype](https://ictresearchmethods.nl/workshop/prototyping/) opgezet worden waar aan de hand van een stuk text een API call wordt gedaan naar het PMP met daarin een "correct*" omschreven requirement.

*Correct omschreven requirements is een subjectieve term. Afhankelijk van hoe het systeem functioneert zouden requirements uitgewerkt kunnen worden naar verschillende formats. In volgorde van eenvoudig naar complex zou de uiteindelijke output naar het PMP een [userstory](https://agilescrumgroup.nl/wat-is-een-user-story/), [brief use case](https://modernanalyst.com/Careers/InterviewQuestions/tabid/128/ID/340/What-are-some-of-the-formats-used-for-writing-use-cases.aspx), [fully dressed use case](https://modernanalyst.com/Careers/InterviewQuestions/tabid/128/ID/340/What-are-some-of-the-formats-used-for-writing-use-cases.aspx) of verschillende use cases aan de hand van [functional decomposition](https://www.investopedia.com/terms/f/functional-decomposition.asp) kunnen zijn.

DV3: Is AI assisted requirements engineering een waardevolle toevoeging op het PMP?

Toelichting: Deze deelvraag legt de focus op gebruikersvriendelijkheid en de resulterende requirements. Omdat slecht geimplementeerde ai systemen frustrerend kunnen zijn voor de gebruiker en het doel van het PMP is om het klant contact te verbeteren heeft deze uitbreiding een risico om als frustrerend ervaren te kunnen worden.

Methodiek: Deze deelvraag zal beantwoord worden aan de hand van [usability testing](https://ictresearchmethods.nl/lab/usability-testing/). In iedergeval Bluenotion stakeholders en mogelijk een of meerdere klanten worden bij het gebruik van het systeem geobserveerd en een aantal vragen gesteld over het gebruik van het systeem. Jesse Bekke (Project Manager) en Yannic Smeets (Tech Lead) zullen de uiteindelijke beoordelaars zijn over de kwaliteit van de opgezette requirements.

## Planning

Dit onderzoek zal over de loop van twee sprints plaats vinden waar binnen de eerste sprint deelvraag 1 wordt beantwoord en binnen de tweede sprint antwoord wordt gegeven op deelvragen 2 en 3. Tijdens deze sprints zal de helft van de werk uren besteed worden aan het onderzoek en de andere helft aan de verdere ontwikkeling van het PMP. De tijd nodig voor het schrijven van het onderzoeks rapport is bij deze uren inbegrepen.

## Potentiele vervolg vragen

Bonus vragen waar mogelijk geen tijd voor is maar leuke uitbreidingen:

Is het mogelijk de correctheid van een requirement te bevestigen door de AI de main/alt flows te laten genereren en de klant hier op te laten reageren?
Is het mogelijk non functional requirements te specificeren uit een chat tussen AI en klant?
Is het mogelijk (en accuraat) de opgezette requirements op basis van het gesprek te clacificeren op type (incident, doorontwikkeling, onderhoud, ect) en prioriteit?
