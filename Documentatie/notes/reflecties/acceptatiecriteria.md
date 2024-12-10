# Planning

## Situatie

Voor onderzoek 1 over de communicatie met Productive stond na initieel library onderzoek een proof of concept (PoC) op de planning. Dit PoC zou over twee iteraties ontwikkeld worden, één iteratie voor het synchronisatie mechanisme voor enkel de projecten en taken en één iteratie voor het maken van de front-end voor FR1 en FR2.

## Taak

Voor het gehele afstudeerproject dien ik (zoals aangegeven in het PvA) volgens OpenUP elke iteratie een iteratieplan te maken. Binnen dit iteratieplan zou een work item lijst opgenomen zijn die als basis dient voor de individuele micro increments/taken. Ook zou dit iteratieplan acceptatie criteria bevatten voor work items die zijn opgenomen in de volgende iteratie. Hiermee kunnen stakeholders op de hoogte gebracht worden van de status van individuele micro increments en de vooraf afgesproken acceptatie criteria.

## Actie

Vanaf het begin van de stage heb ik de project planning niet correct bijgehouden. Er zijn voor de eerste paar iteraties taken op de backlog gezet in Productive die voor mij zelf werkte als een soort "TODO" lijstje. Deze taken kwamen echter vrijwel nooit voorbij "Testing" naar "Done" omdat er vaak een van de eisen van de DoR of DoR niet voltooid was. Dit kwam voornamelijk voor bij de volgende acceptatie criteria:

- DoR: "TR: In ieder geval de happy flow van de use case is opgenomen in het testrapport."
- DoR: "Planning: Aangemaakte taken kunnen (indien opgepakt) binnen één dag van Ready naar Done."
- DoD: "TR: Resultaten van de gemaakte functionaliteit zijn opgenomen in het test rapport."
- DoD: "TO: Het Technisch ontwerp is bijgewerkt met de implementatie van de gemaakte functionaliteit."
- DoD: "SAD: Het Software Architecture Document is bijgewerkt met eventueel aangepaste architecturale beslissingen."
- DoD: "Code: Werkt zoals beschreven in de eerder gemaakte fully dressed use case."

Door telkens een of meerdere van deze acceptatie criteria niet te voltooien kon ik niet met goed geweten de betreffende taken omzetten naar de volgende status.

## Resultaat

Door acceptatie criteria toe te passen op alle taken van het takenbord en deze taken vervolgens niet naar hun volgende status te slepen omdat er nog een acceptatie criteria mist en omdat het takenbord niet gebruikt werd in de reviews ben ik opgegeven moment opgehouden met het takenbord te updaten.

Dit heeft twee concrete resultaten geleverd:

1. De stakeholders (en ik) hadden minder inzicht in het gedane en geplande werk
2. De acceptatiecriteria werden minder nauw gevolgd.

## Reflectie

Stoppen met de takenlijst bijhouden op Productive heeft de transparantie van het project(management) geschaad waardoor voor mij en de verschillende stakeholders het te verrichten werk niet meer goed te overzien was. Bij communicatie met de opdrachtgever en bedrijfsbegeleider werd voornamelijk gebruik gemaakt van gemaakte documentatie, verschillende diagrammen of daadwerkelijke code om de status van bepaalde functionele requirements aan te geven. Dit draagt bij aan het gebrek aan artefacten zoals besproken in "Reflectie proces feedback cycle".

De voornaamste reden die mijn handelen verklaard is dat ik door strikte eisen te stellen aan de taken waarvan ik vervolgens niet met 100% zekerheid kan zeggen dat ze "Ready" of "Done" zijn deze eisen en het bijbehorende takenbord uit frustratie ben gaan negeren. Omdat hierdoor een stuk project planning voor mij en de stakeholders aanzienlijk minder inzichtelijk zijn geworden zouden in de toekomst een aantal strategieën toegepast kunnen worden dit soort gedrag tegen te gaan:

- Als ik iets als frustrerend ervaar bij een aspect van het project in plaats van hier niets mee te doen de frustratie voorleggen aan een van de begeleiders om te bespreken hoe zij er mee om zouden gaan.
- Elke iteratie review een checklist afgaan met de artefacten die in de review gepresenteerd gaan worden. Als de takenlijst hier deel van is valt het stakeholders eerder op wanneer dingen blijven hangen en wordt je zelf geforceerd de taken ook daadwerkelijk bij te werken.
- Als de DoD of DoR over één of meerdere taken als "te groot" wordt ervaren zou het een optie zijn de DoD en DoR opnieuw te definiëren. Hier onder staan een aantal voorbeelden van hoe verschillende kwaliteitseisen voor dit project in context van deze reflectie verbeterd zouden kunnen worden.

Van "TR: In ieder geval de happy flow van de use case is opgenomen in het testrapport."

Naar "TR: Er zijn taak specifieke testcases opgenomen in het testrapport"

Redenatie: Door het in de DoR al over de happy flow van use cases te hebben zijn taken in dit project vrij groot uitgevallen. (De hele happy flow van een FR kon in een taak zitten.) Wat tegenstrijdig is met "Aangemaakte taken kunnen binnen één dag van ready naar done".

Van "TO: Het Technisch ontwerp is bijgewerkt met de implementatie van de gemaakte functionaliteit."

Naar "TO: Er is een taak aangemaakt voor het bijwerken van het technisch ontwerp met uitleg over de implementatie van de gemaakte functionaliteit"

Redenatie: Door het bijwerken van de documentatie te koppelen aan de taak zelf kan het voorkomen dat een taak wordt uitgevoerd, documentatie wordt bijgewerkt en een dag later een collega een verbetering voorstelt en de documentatie dus weer bijgewerkt moet worden. Door het aanmaken van een documentatie taak op te nemen in het DoD verplicht je nog wel het updaten van de documentatie maar is er meer vrijheid wanneer dit gedaan wordt. In het geval dat er vanuit een van de stakeholders een wens is documentatie op een vast moment bij te werken zou het moment van documentatie taken afhandelen vastgesteld worden in het PvA.

Van "Code: Werkt zoals beschreven in de eerder gemaakte fully dressed use case."

Naar "Code: Werkt zoals beschreven in de flow gerelateerd aan de taak."

Redenatie: Het idee achter deze wijziging is het verkleinen van de taken. Hiermee zouden taken minder gebaseerd zijn op discipline+functionaliteit (Front-End:FR1, Back-End:FR2, ect...) maar meer op individuele flows binnen deze functionaliteiten (FE:FR1:Main flow, BE:FR2:Alt flow geen project error) waardoor de scope van de taken beperkt blijft.
