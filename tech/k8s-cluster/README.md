# K8S Cluster

## Hardware setup

### Nodes

We now have a working k8s cluster running currently:
- 1 master
- 2 worker node

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

### Storage

A storage machine has been added to the cluster running an NFS
server. This machine is currently used to provide `PersistentVolume`s
on the cluster.

## Installed software

### CNI software 

The cluster is currently running calico network controller
manually deployed using the config file at `/root/calico.yaml` on
`master-1`.
You can read more about it [here](https://www.golinuxcloud.com/calico-kubernetes/)
and on the [calico documentation](https://docs.tigera.io/calico/latest/about/)

*Beware: calico ip pool had to be configured using vxlan since
the cluster is multi node and the ip of the pods are only registered
on each node. You can read more about it [here](https://docs.tigera.io/calico/latest/networking/configuring/vxlan-ipip)*

### Load Balancing

The cluster is running [metalLB](https://metallb.universe.tf/) to get load
balancer services.

MetalLB has been deployed using helm in the `metallb-system` namespace.

An ip address pool has been deployed in the `metallb-system` namespace with
the name `default`, and the ip range `10.69.17.200-10.69.17.254`.

*Warning: In order to have the ip range working, all the traffic from
the range is redirected to the `master-1` node using `policy-based-forwarding`
on the palo alto router.*

*Warning: Right now, a static ip route has been added on the router network.
A solution allowing route rewriting within same interface should be
investigated on the firewall.*

### Ingress controller

Two ingress controllers are installed.
It is twice [traefik](https://platform9.com/learn/v1.0/tutorials/traefik-ingress)
in the namespace `traefik`.

The helm registry used is (https://helm.traefik.io/traefik) and the chart
is `traefik`.

#### Public traefik

The first instance is deployed using the following command
```
helm upgrade -n traefik \
    --create-namespace \
    --install traefik \
    --set dashboard.enabled=true \
    --set rbac.enabled=true \
    --set="additionalArguments={--api=true,--log.level=DEBUG,--serversTransport.insecureSkipVerify=true,--providers.kubernetescrd.allowexternalnameservices=true,,--providers.kubernetesingress.ingressclass=traefik}" \
    traefik/traefik
```

The name of the release is `traefik` and the `ingressClassName` is
`traefik`.

#### Private traefik

The first instance is deployed using the following command
```
helm upgrade -n traefik \
    --create-namespace \
    --install traefik-internal \
    --set dashboard.enabled=true \
    --set rbac.enabled=true \
    --set="additionalArguments={--api=true,--log.level=INFO,--serversTransport.insecureSkipVerify=true,--providers.kubernetescrd.allowexternalnameservices=true,,--providers.kubernetesingress.ingressclass=traefik-internal}" \
    traefik/traefik
```

The name of the release is `traefik-internal` and the `ingressClassName` is
`traefik-internal`.

### Cert manager

Cert manager is install to manage tls certificates using helm.
`ClusterIssuer` configurations can be found at `/root/cert-manager`
on `master-1`.

### Database

A postgresql database has been manually deployed
one the cluster in the namespace `database`.

It should be used for every project to avoid duplicating databases.

## Other software

*This section is referencing the non-required software
installed on the cluster. It may not be up to date as this
software may come and go*

### Vaultwarden

A vault is deploy on the cluster under the namespace
`vaultwarden` using values from `/root/vaultwarden`
folder on `master-1` and [this](https://github.com/guerzon/vaultwarden) chart.

### Github Runners

Github runners have been deployed in the `github-runners` namespace
following [this](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/quickstart-for-actions-runner-controller) tutorial.
