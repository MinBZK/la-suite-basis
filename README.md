# La suite basis

Met deze Infrastructure as Code (IaC) kan je makkelijk de basis voor mijn-bureau software deployen. De compontenten die worden deployed zijn:

* Ideniteit provider (keycloak)
* secrets manager (vault)

> [!WARNING]  
> Alertmanager en Grafana gaan we verplaatsen. Deze horen niet in deze repo thuis

## Introductie

Deze repository draait de core applicaties die nodig zijn voor mijn-bureau, namelijk een identity provider en een secrets manager. Zodra deze draaien moeten we ze configureren. Keycloak moet een realm krijgen, gebruikers moeten toegevoegd worden en clients moeten aangemaakt worden. De geheimen van deze clients moeten in vault komen zodat ze gebruikt kunnen worden door de applicaties.

Ook willen we keycloak instellen met een overheids theme voor keycloak zodat we de overheid look & feel krijgen. Zie de [keycloak-theme](https://github.com/MinBZK/keycloak-theme)

## Installatie Componenten

Voordat je de componenten kan deployen heb je eerst een kubernetes namespace(s) nodig.

Er zijn een aantal plekken binnen de overheid waar je een kubernetes cluster kan krijgen

- [Digilab](https://digilab.overheid.nl/)
- [ODC Noord](https://www.odc-noord.nl/)
- [Logius standard platform](https://www.logius.nl/domeinen/infrastructuur/standaard-platform)
- Public clouds. Zorg er voor dat je bewust bent van de [rijksbreed cloud beleid](https://www.rijksoverheid.nl/documenten/kamerstukken/2022/08/29/kamerbrief-rijksbreed-cloudbeleid-2022)
- [kind](https://kind.sigs.k8s.io/)

Zodra je een kubernetes namespace(s) hebt kan je de applicatie deployen met kubectl en kustomize. Kustomize wordt meegeleverd met kubectl. Als je kubectl nog niet geinstalleerd hebt doe dat via deze link: [kubectl](https://kubernetes.io/docs/tasks/tools/).

Nu kan je de applicatie deployen met het volgende commando:

```bash
kubectl apply -k overlays/voorbeeld/
```

Met de -k optie van kubectl activeer je de kustomize modus. Je kan ook `kubectl kustomize overlays/voorbeeld/` gebruiken om eerst alle data te zien voordat je deployed naar kubernetes, met de `apply` commando gaat gelijk de applicatie draaien. Het krachtige van kustomize is dat je alles kan overschrijven van een basis setup. De basis setup staat in /base/.

In overlays/ worden alle aanpassingen gedaan die nodig zijn voor jou omgeving. Momenteel hebben we een `digilab` en `voorbeeld` overlay. De `digilab` gebruiken we zelf en kan je gebruiken voor inspiratie. Het `voorbeeld` kan je kopiëren en veranderen.

## Configuratie Componenten

Als de compenenten draaien moeten ze nog geconfigureerd worden. Dit is best wel wat werk en vereist begrip van de applicatie. In de toekomst willen we hier terraform voor gebruiken zodat het makkelijker wordt, maar voor nu doen we het met de hand.

### Keycloak

todo

### Vault

todo

## Operators

Momenteel gebruiken we de cloudnative-pg operator. Door deze operator kan niet iedere kubernetes cluster onze software draaien. We gaan deze operator verwijderen en een eigen hosten.

## How to contribute

Alle contributies zijn welkom. Zie de [contributing docs](CONTRIBUTING.md)
