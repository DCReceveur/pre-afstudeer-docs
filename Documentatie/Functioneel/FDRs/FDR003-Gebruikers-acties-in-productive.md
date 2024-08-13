# FDR003 Gebruikers acties in productive

## **Status:** Unknown

## **Context:**

Binnen het huidige functionele ontwerp zou in ieder geval de externe beheerder comments kunnen toevoegen aan een lopende taak. Dit zou kunnen voorkomen als een developer vraagt om extra toelichting van de klant en de klant via het PMP deze vraag beantwoord. Aangezien de interne developers geen gebruik zullen maken van het PMP dient deze data weer in Productive terecht te komen. Afhankelijk van eventuele technische limitaties zouden hier een aantal opties voor zijn:

- Elke klant krijgt een "account" binnen Productive*
- Het PMP heeft één account die gebruikt wordt wijzigingen in het PMP aan te brengen (klinkt gevaarlijk?)

*Dit account hoeft niet gebruikt te worden door de klant maar zou enkel kunnen dienen als representatie van de klant met zijn/haar naam. Het PMP zou zo comments (en eventueel andere acties) kunnen doen in de naam van de klant.

## **Decision:** Elke klant krijgt een "account" binnen Productive

## **Consequences:**

Er zouden accounts aangemaakt moeten worden voor klanten binnen Productive wanneer ze uitgenodigd worden in het PMP. Of dit mogelijk is moet uitgezocht worden. In een ideale situatie zou ook de authorizatie in dit geval gesynchroniseerd worden met of volledig lopen aan de hand van de Productive API.

## **Alternatives:**
