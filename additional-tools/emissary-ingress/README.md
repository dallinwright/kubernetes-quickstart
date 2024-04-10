## Cluster Ingress Setup

**Add helm repo**

```bash
# Add the Repo:
helm repo add datawire https://app.getambassador.io && \
helm repo update
```

**Install the Emissary CRD**

```bash
kubectl create namespace emissary && \
kubectl config set-context --current --namespace=emissary && \
kubectl apply -f https://app.getambassador.io/yaml/emissary/3.9.1/emissary-crds.yaml && \
kubectl wait --timeout=90s --for=condition=available deployment emissary-apiext -n emissary-system
```

**Install Emissary via helm**

```bash
helm install emissary-ingress --namespace emissary datawire/emissary-ingress -f emissary-ingress/values.yaml && \
kubectl -n emissary wait --for condition=available --timeout=90s deploy -lapp.kubernetes.io/instance=emissary-ingress
```

**Create the listener address, port and protocol**
```bash
kubectl apply -f emissary-ingress/listeners.yaml
```

Once the TLSContext is created, a Mapping can use it for TLS origination. An example might be:

**If you want to validate the configuration, install a demo service**

```bash
kubectl create namespace services && \
kubectl annotate namespace services linkerd.io/inject=enabled && \
kubectl config set-context --current --namespace=services && \
kubectl apply -f https://app.getambassador.io/yaml/v2-docs/latest/quickstart/qotm.yaml && \
kubectl apply -f emissary-ingress/mapping.yaml
```