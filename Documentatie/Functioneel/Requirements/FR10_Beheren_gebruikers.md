# FR10: Beheren gebruikers

## FR10.1: Uitnodigen gebruiker

| FR10.1 | Uitnodigen gebruiker |
|---|---|
| Prioriteit | Must have |
| Primaire Actor | ACT1: Interne beheerder, ACT2: Externe beheerder  |
| Stakeholders | ACT3: Interne medewerker, ACT5: Externe medewerker |
| Pre condities | Primaire actor is beheerder van een project, bedrijf of corporatie |
| Post condities | Er is een gebruikers account toegevoegd aan het gewenste project, bedrijf of corporatie |
| Triggers | Op aanvraag van primaire actor |
| Exceptions | ? |
| Open issues | ? |

### FR10.1: Main flow

|Stap | Actor | System |
|---|---|---|
| 1 | De beheerder navigeert naar de resource waar een gebruiker aan toegevoegd dient te worden (project, bedrijf of corporatie). |  |
| 2 |  | Geeft de optie om een gebruiker toe te voegen aan de resource |
| 3 | Geeft aan dat er een nieuwe gebruiker toegevoegd dient te worden |  |
| 4 |  | Geeft Een selectie van gebruikers en de vraag of het om een medewerker of beheerders account gaat. |
| 5 | Kiest een gebruiker uit de lijst met bestaande gebruikers. |  |
| 6 |  | Geeft de gebruiker rechten op de gevraagde resource en stuurt een e-mail naar de gebruiker om hem/haar in te lichten. |

### FR10.1: Alternative flow - Gebruiker bestaat niet in het PMP

|Stap | Actor | System |
|---|---|---|
| 5A | Geeft aan dat de gebruiker niet in de lijst staat |  |
| 6A |  | Geeft de optie een nieuw account toe te voegen (aan de hand van een e-mail adres, voor en achternaam?) |
| 7A | Vult de gevraagde gegevens in |  |
| 8A |  | Maakt een nieuw account aan met rechten op de gevraagde resource en stuurt een e-mail naar de gebruiker met de vraag een wachtwoord in te stellen |

## FR10.2: Wijzigen rechten

| FR10.2 | Wijzigen rechten |
|---|---|
| Prioriteit | ?  |
| Primaire Actor | ACT1: Interne beheerder, ACT2: Externe beheerder  |
| Stakeholders | ACT3: Interne medewerker, ACT5: Externe medewerker |
| Pre condities | Primaire actor is beheerder van een project, bedrijf of corporatie |
| Post condities |  |
| Triggers | Op aanvraag van primaire actor |
| Exceptions | ? |
| Open issues | ? |

| Naam gebruiker | Rol | Wijzig |
|---|---|---|
| Jesse | Beheerder (inherited) | ... |
| Klaas | Beheerder extern | ... |
| Daan | Medewerker extern | ... |

<!-- 
https://www.studocu.com/row/document/riphah-international-university/computer-sciences/fully-dressed-use-case-example-pdf/19676384

https://www.tmaworld.com/2017/10/04/use-case-approach/#:~:text=Fully%20dressed%20use%20case%3A%20A,goals%2C%20tasks%2C%20and%20requirements.

 -->