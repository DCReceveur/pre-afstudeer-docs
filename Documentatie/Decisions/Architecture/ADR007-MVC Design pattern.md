### ADR007-MVC Design pattern

<!-- En deze is wel een ASR maar heeft een slechte reden om te bestaan. -->

**Status:** Proposed

**Context:**

Het PMP dient zo opgezet te worden dat de software onderhoudbaar is en zodat collega's er in de toekomst op verder kunnen bouwen. Hiervoor dient een standaard design pattern gebruikt te worden.

**Decision:**

Om de code onderhoudbaar te houden wordt gebruik gemaakt van het [MVC pattern](https://www.geeksforgeeks.org/mvc-design-pattern/).

**Consequences:**

- Code wordt gescheiden naar data, UI en logica (Separation of Concerns)
