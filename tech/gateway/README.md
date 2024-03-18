# Gateway

Une instance AWS sert actuellement de gateway et d'interface publique
unique pour toutes les IPs publiques redirigeant vers la baie
de serveurs.

Cet instance est sur le compte AWS *root* de l'atelier dont les
creds sont sur le vault.

FQDN: gateway.infra.atelier-maker.fr

## Architecture

### Wireguard

Cette instance est equipée d'un serveur wireguard permettant de
faire le routing de l'instance vers n'importe quelle VM dans la baie.

Le service de gestion des paquets est *nftables*, et tout le routing
doit se faire via des rules *nftables* d'une NIC avec une IP publique
vers une IP interne a wireguard.

**Warning: Il ne faut idéalement router aucun trafic de l'IP publique par défaut d'AWS vers une autre machine pour eviter de se bloquer
des services sur l'instance (comme le SSH par exemple :eyes:).**


### IP Publiques

Pour ajouter une IP publique dans sur une machine il faut:

1. suivre la [documentation AWS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/MultipleIP.html) pour ajouter une IP sur la machine
2. Ajouter une regle de routing via *nftables* de cette ip publique/NIC vers l'IP wireguard interne targeted.
3. Verifier que le connection est bien active et fonctionelle.
