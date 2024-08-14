# FR9: Tenant chat

## FR9.1: Starten nieuwe chat

User story: Als Bluenotion admin wil ik servicevragen gescheiden houden van taken zodat developers hier minder tijd aan kwijt zijn.

Deze functional requirement heeft betrekking op communiceren met de klant op een algemenere basis.

| FR9.1 | Starten nieuwe chat |
|---|---|
| Prioriteit | Won't have  |
| Primaire Actor | ACT1: Externe beheerder  |
| Stakeholders | ACT2: Bluenotion admin |
| Pre condities | Beide actoren kunnen inloggen in het systeem |
| Post condities | Er is een chat opgezet waar de externe beheerder met "Bluenotion" kan communiceren |
| Triggers | De klant heeft een vraag aan Bluenotion zonder dat dit een incident of doorontwikkeling is. |
| Exceptions |  |
| Open issues |  |

### FR9.1: Main flow

| Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan een medewerker van Bluenotion een vraag te willen stellen |  |
| 2 |  | (Toont een lijst van de meest recente chats)* en de optie een nieuwe chat aan te maken |
| 3 | Geeft aan een nieuwe chat te willen starten. |  |
| 4 |  | Toont een invoerveld voor het onderwerp en de vraag. |
| 5 | Geeft aan wat het onderwerp en de vraag is. |  |
| 6 |  | Licht de betreffende Bluenotion admin in over de gestelde vraag. |
| 7 |  | Geeft de gebruiker de mogelijkheid meer berichten te sturen in de chat of de chat te sluiten. |

*Meest recente chats ja of nee?
Hoe kom ik achter het onderwerp? Is dat iets dat de gebruiker aangeeft?

## FR9.2 Bericht sturen niet afgesloten chat

User story: Als Bluenotion admin wil ik servicevragen gescheiden houden van taken zodat developers hier minder tijd aan kwijt zijn.

| FR9.2 | Bericht sturen niet afgesloten chat |
|---|---|
| Prioriteit | Won't have  |
| Primaire Actor | ACT1: Externe beheerder, ACT2: Bluenotion admin  |
| Stakeholders |  |
| Pre condities | Er is een chat opgezet tussen de klant en Bluenotion |
| Post condities | De gebruiker kan berichten sturen in de active chat |
| Triggers | De actor wil een bericht sturen in een al actieve chat |
| Exceptions |  |
| Open issues |  |

### FR9.2: Main flow

| Stap | Actor | System |
|---|---|---|
| 1  | De actor geeft aan de historie aan chats te willen bekijken  |   |
| 2  |   | Toont de historie aan chats met indicator voor nieuwe berichten  |
| 3  | Kiest een niet afgesloten gesprek  |   |
| 4  |   | Geeft de mogelijkheid nieuwe berichten te sturen in de chat  |
| 5  | Voert een nieuw bericht in en geeft aan deze te willen versturen.  |   |
| 6  |   | Verstuurd het nieuwe bericht en licht de betreffende actor in.  |

## FR9.3 Hervatten afgesloten chat

User story: Als Bluenotion admin wil ik servicevragen gescheiden houden van taken zodat developers hier minder tijd aan kwijt zijn.

| FR9.3 | Hervatten afgesloten chat |
|---|---|
| Prioriteit | Won't have  |
| Primaire Actor | ACT1: Externe beheerder, ACT2: Bluenotion admin  |
| Stakeholders |  |
| Pre condities | Er is een afgesloten chat tussen de klant en Bluenotion. |
| Post condities | De gebruiker kan berichten sturen in de voorheen afgesloten chat. |
| Triggers | De actor wil een bericht sturen in een al actieve chat |
| Exceptions |  |
| Open issues |  |

### FR9.3: Main flow

| Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan een medewerker van Bluenotion een vraag te willen stellen |  |
| 2 |   | (Toont een lijst van de meest recente chats)* en de optie een nieuwe chat aan te maken |
| 3 | Selecteert een chat die in het verleden al afgerond is. |  |
| 4 |   | Geeft aan dat het gesprek is gesloten en de optie het gesprek opnieuw te openen. |
| 5 | Geeft aan het gesprek opnieuw te willen openen. |  |
| 6 |   | Geeft de optie nieuwe berichten te sturen in de chat.  |

## FR9.4 Sluiten chat

User story: Als Bluenotion admin wil ik servicevragen gescheiden houden van taken zodat developers hier minder tijd aan kwijt zijn.

| FR9.4 | Hervatten afgesloten chat |
|---|---|
| Prioriteit | Won't have  |
| Primaire Actor | ACT1: Externe beheerder, ACT2: Bluenotion admin  |
| Stakeholders |  |
| Pre condities | Er is een open chat tussen de klant en Bluenotion |
| Post condities | De chat is afgesloten en kan niet meer gebruikt worden berichten te sturen. |
| Triggers | De actor geeft aan dat het onderwerp van de chat is afgehandeld. |
| Exceptions |  |
| Open issues |  |

### FR9.4: Main flow

| Stap | Actor | System |
|---|---|---|
| 1 | Geeft aan een chat te willen sluiten |  |
| 2 |  | Toont een lijst van de meest recente chats |
| 3 | Kiest de chat die hij wilt sluiten | |
| 4 |  | Toont de chatlog en een optie de chat te sluiten |
| 5 | Geeft aan de chat te willen sluiten.  |   |
| 6 |   | Vraagt de reden waarom de chat gesloten mag worden. (Vraag beantwoord, Omgezet naar taak, Anders...)*  |
| 7 | Geeft een reden op waarom de chat gesloten mag worden. |  |
| 8 |   | Haalt de optie nieuwe berichten te sturen in de chat weg.  |

TODO: redenen nodig? navragen.
