# Serveurs

## Routing

Le routing passe par le firewall palo alto, dont l'IP est
`10.69.1.1` et dont les credentials sont disponibles
sur le vault.
Toute la configuration reseaux doit idealement passer
par ce router.

## Worker Nodes

Pour l'instant, 4 noeuds sont configurées:
- cpt-03
- cpt-05
- cpt-06
- cpt-07

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

## Storage Nodes

Un noeud de storage est egalement configure appele
`cpt-storage`. Ce noeud est utilise pour fournir du stockage reseau
au machines physiques et aux VMS.

## Proxmox

Pour accéder à l'interface de proxmox, celle-ci
est disponible derrière un `nginx`, sur le noeud `cpt-03` et
bind a l'addresse IP `10.69.1.13`.
Le proxy proxmox du cluster est disponible a l'addresse
(https://pve.dc-01.le-maker.fr/)
et chaque noeud expose son proxy proxmox sur le subdomain
`https://<nom-du-noeud>.pve.dc-01.le-maker.fr/`
e.g.: [cpt-05](https://cpt-05.pve.dc-01.le-maker.fr)

### Configuration virtualisation

Du a un bug de proxmox sur les serveurs HP (machines
utilisees dans la baie pour l'instant), il faut activer
un kernel module en plus pour activer la fonctionnalite
`iommu` sur la machine.
(https://github.com/brunokc/pve-kernel-builder#configuration)

## Machines virtuelles

Pour l'instant, un router est configuré sur une VM avec wireguard dessus
qui permet de forward et de recevoir le trafic depuis la [vm AWS](gateway.infra.atelier-maker.fr).
