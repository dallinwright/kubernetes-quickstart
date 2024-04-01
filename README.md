# Kubernetes Cluster Setup Quick Start Guide


## Prerequisites

**Tools installed and callable via your terminal**
- [Docker](https://docs.docker.com/get-docker/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [helm](https://helm.sh/docs/intro/install/)

And obviously a Kubernetes cluster, either local or remote. You can use the default Docker Desktop Kubernetes cluster, 
or a cloud provider like AWS, GCP, Azure, Scaleway, etc.

## Bare metal additional setup, if using a cloud provider skip this step
```bash
kubectl edit configmap --namespace kube-system kube-proxy
```
Edit the `strictARP` line item to the value `true` in the `kube-proxy` configmap
```yaml
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: "ipvs"
ipvs:
  strictARP: true
```

Afterwords we add the metallb repository and install it as usual.
```bash
helm repo add metallb https://metallb.github.io/metallb && \
helm install --namespace metallb --create-namespace metallb metallb/metallb
```

Now, we will perform the post install configuration of ip address space, if you want to route
traffic to the cluster from inside your cluster, without exposing the scheme external to your network.

An example of a corporate network with example address space feel free to view and deploy this file.
```bash
kubectl apply --namespace metallb -f metallb/ip_address_pools.yaml
```

An example for a home network with example address space feel free to view and deploy this file. Note you will 
usually need to change the address space to match your home network.
```bash
kubectl apply --namespace metallb -f metallb/home-network.yaml
```

## Cluster Certificate Management
**Add helm repo for cert-manager**
```bash
helm repo add jetstack https://charts.jetstack.io --force-update
```

**Update helm repo**
```bash
helm repo update
```

**Install cert-manager via helm**
```bash
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.14.4 \
  --set installCRDs=true
```

### Cluster Ingress Controller
```bash
# Add the Repo:
helm repo add datawire https://app.getambassador.io && \
helm repo update
```
 
```bash
kubectl apply -f https://app.getambassador.io/yaml/edge-stack/3.10.2/aes-crds.yaml && \
kubectl wait --timeout=90s --for=condition=available deployment emissary-apiext -n emissary-system
```

```bash
helm install edge-stack --namespace ambassador datawire/edge-stack \
  --set emissary-ingress.agent.cloudConnectToken=$CLOUD_CONNECT_TOKEN && \
kubectl -n ambassador wait --for condition=available --timeout=90s deploy -l product=aes
```