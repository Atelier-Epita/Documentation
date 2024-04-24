# K8S Cluster

## Hardware setup

We now have a working k8s cluster running currently:
- 1 master
- 1 worker node

The whole cluster should be using the ip range
`10.69.17.0/24`
with
- 10.69.17.1-10.69.17.19: for the masters
- 10.69.17.20-10.69.17.199: for the workers
- 10.69.17.200-10.69.17.255: for the load balancer ips

The nameserver for the cluster is `k8s.dc-01.le-maker.fr`.
For each node, the dns is the nameserver prepended with the type
of the node and its number.
- `master-1.k8s.dc-01.le-maker.fr` for the first master
- `node-1.k8s.dc-01.le-maker.fr` for the first node

and so on.

The apiserver can be reached at the provided dns above.

## Installed software

### CNI software 

The cluster is currently running calico network controller
manually deployed using the config file at `/root/calico.yaml` on
`master-1`.
You can read more about it [here](https://www.golinuxcloud.com/calico-kubernetes/)
and on the [calico documentation](https://docs.tigera.io/calico/latest/about/)

### Load Balancing

The cluster is running [metalLB](https://metallb.universe.tf/) to get load
balancer services.

MetalLB has been deployed using helm in the `metallb-system` namespace.
