# ADR0008 Taak mijlpalen & scheiding tussen aanvraag en taak

## **Status: Needs decision**

## **Context:**

Binnen Bluenotion heeft een taak een aantal mijlpalen die de meeste taken doorlopen voordat ze als af beschouwd kunnen worden. Deze mijlpalen zijn gebaseerd op bij welke partij het werk voor een taak ligt. Hiervoor worden binnen Productive aparte taken aangemaakt met de naam van de uitvoerende partij in de naam van de taak. Zo zou een vraag voor de functionaliteit "Inzien mijlpalen" drie verschillende taken opleveren:

| Mijlpaal naam | Taak naam | Mijlpaal doel | Verantwoordelijke partij |
|---|---|---|---|
| User experience | [UX] Inzien mijlpalen | De taak voor de wire frames/UX design voor de functionaliteit. | UX designer |
| Front-end | [FE] Inzien mijlpalen | De taak voor het bouwen van de front-end voor de functionaliteit. | Front-end developer |
| Back-end | [BE] Inzien mijlpalen | De taak voor het bouwen van de back-end voor de functionaliteit. | Back-end developer |
| Testing | NVT | Onduidelijk of dit in_review, development of staging is* | Bluenotion medewerker |
| Livegang | NVT | De laatste checks voor de klant voordat een functionaliteit op de live omgeving komt. | Externe beheerder |

Deze taken worden volgens conventie aangemaakt maar de namen worden niet over alle projecten consistent hetzelfde opgebouwd. Om binnen het PMP een overzicht aan te kunnen bieden van welke mijlpalen voor een specifieke functionaliteit wel/niet behaald zijn dient deze data op een gestandaardiseerde manier geregistreerd te worden in Productive of het PMP.

```puml
rectangle "Aanvragen komen in Productive" as Q1
rectangle "De link tussen een aanvraag en de resulterende taken komen in Productive" as Q2
rectangle "ADR0008-O1: Taken worden gekoppeld aan de hand van task dependencies" as Q3
rectangle "ADR0008-O3: Taken worden gekoppeld aan de hand van tags met het id van de parent taak." as Q4
rectangle "ADR0008-O2: Taken worden gekoppeld in de PMP database" as Q5
rectangle "ADR0008-O4: Taken worden gekoppeld in de taak omschrijving" as Q6 

Q1-DOWN-Q2 : Ja
Q2-DOWN-Q3 
Q2-DOWN-Q4 

Q1-DOWN-Q5 : Nee
Q2-DOWN-Q6
```

## **Decision: None**

Het liefst zou ik werken aan de hand van TaskDependencies zodat alle informatie over een taak terug te vinden is in Productive. Hiermee voorkom je het splitten van de twee systemen en verklein je dus de kans op moeten werken in twee systemen.

## **Consequences:**

| Optie | Consequentie |
|--|--|
| O1 | Pro: Alle data over mijlpalen is niet alleen in het PMP te vinden maar ook in Productive. |
| O1 | Pro: Het is mogelijk de status van mijlpalen te automatiseren door naar de status van de verschillende subtaken te kijken. |
| O1 | Con: Zit niet in het huidige Productive pakket. |
| O2 | Pro: Past binnen het huidige Productive pakket. |
| O2 | Pro: Biedt flexibiliteit over het ontwerp en gebruik van de mijlpalen zonder limitaties van Productive. |
| O2 | Con: Omdat er met twee verschillende datasources gewerkt wordt kan het zijn dat door onvoorziene omstandigheden data tussen deze sources niet het zelfde is. |
| O3 | Pro: Past binnen het huidige Productive pakket. |
| O3 | Pro: Het is mogelijk binnen Productive alle taken op te vragen die aan een bepaalde tag zijn gekoppeld. (Beiden in productive dashboard en API) |
| O3 | Con: Het is niet waar het tag systeem voor is gemaakt. |
| O3 | Con: Er worden tags aangemaakt die na afloop van een taak nooit meer gebruikt worden. |
| O3 | Con: De oplossing is navigeerbaar naar 1 kant maar niet beiden kanten |
| O4 | Pro: Past binnen het huidige Productive pakket |
| O4 | Pro: Er is binnen Productive te zien welke taken gerelateerd zijn |
| O4 | Con: Foutgevoelig, mensen kunnen binnen Productive de omschrijving aanpassen met taken die niet bestaan en oude/verwijderde taken worden niet automatisch bijgewerkt |
| O4 | Con: Het is niet waar het tag systeem voor is gemaakt. |
| O4 |  |
| O4 |  |
| O4 |  |


## **Alternatives:**

Mijlpalen is een keuze in te maken. De data over "mijlpalen" staat op het moment voor een taak en de workflow wordt bijgehouden door de PM.

### Optie 1: TaskDependency

Er is binnen productive een task_dependencies endpoint die gebruikt kan worden om voor één taak op verschillende borden verschillende taken te linken. Hiermee zou voor een van de klant binnengekomen taak een aantal dependent taken gemaakt kunnen worden voor de benodigde teams/mijlpalen. 

Voordeel: Binnen productive is te zien welke mijlpalen voor een taak behaald zijn. Bij verlies van de database kan de data aan de hand van productive data hersteld worden.

Nadeel: De grootste reden om hier niet mee te werken echter is dat de task dependencies niet zijn opgenomen in het huidig gebruikte Productive pakket.

### Optie 2: Lokale database

Het is een optie om de data over mijlpalen per taak enkel op te slaan in de PMP database. Hiermee zou binnen het PMP gezien kunnen worden welke gerelateerde taken gedaan zijn en dus mijlpalen behaald.

Voordeel: Er is geen uitbreiding op het Productive pakket nodig. Data over mijlpalen wordt volledig beheerd door het PMP in plaats van een extern systeem. Dit geeft controle over de betrouwbaarheid van deze data.

Nadeel: Binnen productive kan niet snel gevonden worden welke taken nog waar op wachten. Bij verlies van de database kan data niet uit productive hersteld worden.

### Optie 3: Tags

De mogelijkheid bestaat de mijlpaal data op te slaan in Productive binnen het huidige pakket. Hiervoor zou gebruik gemaakt kunnen worden van verschillende systemen. Zo zou (zoals het huidige proces) voor taken binnen de naam aangegeven kunnen worden voor welk team een taak is en als taken verder de zelfde naam hebben ze binnen het PMP groeperen als mijlpalen. Een vergelijkbare werkwijze zou gehanteerd kunnen worden aan de hand van [tags](https://developer.productive.io/tags.html#tags).

Voordeel: Er is geen uitbreiding op het Productive pakket nodig. Data over mijlpalen is beschikbaar op productive.

Nadeel: Binnen productive onschuldig lijkende aanpassingen zoals het aanpassen van een naam wijzigen zou invloed kunnen hebben op de PMP task dependencies. De oplossing is vrij fout gevoelig.

### Optie 4: Omschrijvingen

Als een taak over verschillende teams verdeeld moet worden zou er voor de hoofdtaak een taak aangemaakt kunnen worden waar binnen de beschrijving wordt aangegeven welke taken hier aan gekoppeld zijn. Deze omschrijving kan uitgelezen worden binnen het PMP om hiermee informatie te kunnen verstrekken over de gekoppelde taken.

Voordeel: Er is geen uitbreiding op het Productive pakket nodig. Data over mijlpalen is beschikbaar op productive.

Nadeel: Binnen productive onschuldig lijkende aanpassingen zoals een omschrijving wijzigen zou invloed kunnen hebben op de PMP task dependencies. De oplossing is vrij foutgevoelig.

