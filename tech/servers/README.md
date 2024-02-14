# Serveurs

## Routing

Le routing passe par le firewall palo alto, dont l'IP est
`10.69.1.1` et dont les credentials sont disponibles
sur le vault.
Toute la configuration reseaux doit idealement passer
par ce router.

## Machines

Pour l'instant, 2 noeuds sont configurées:
- cpt-03
- cpt-05

Le noeud `cpt-04` (qui est vraiment pete) semble
avoir des problemes de reseau consequents, et n'est
donc pas pour le moment dans le cluster.

les IPs pour ces machines sont
10.69.1.1x
Où x est le numero de la machine

*e.g.: cpt-03 -> 10.69.1.13*

Les serveurs ne fonctionnant pas en UEFI,
une version de debian 12 avec un grub BIOS est installé
sur les machines, avec proxmox par dessus.
(voir [documentation](https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_12_Bookworm))

## Proxmox

Pour accéder à l'interface de proxmox, celle-ci
est disponible derrière un `nginx`, sur le noeud `cpt-03` et
bind a l'addresse IP `10.69.1.13`.
Le proxy proxmox du cluster est disponible a l'addresse
(https://pve.dc-01.le-maker.fr/)
et chaque noeud expose son proxy proxmox sur le subdomain
`https://<nom-du-noeud>.pve.dc-01.le-maker.fr/`
e.g.: [cpt-05](https://cpt-05.pve.dc-01.le-maker.fr)
