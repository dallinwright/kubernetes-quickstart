## Cluster Ingress Setup

**Add helm repo**

```bash
# Add the Repo:
helm repo add datawire https://app.getambassador.io && \
helm repo update
```

**Install the Emissary CRD**

```bash
kubectl create namespace ambassador && \
kubectl apply -f https://app.getambassador.io/yaml/edge-stack/3.10.2/aes-crds.yaml && \
kubectl wait --timeout=90s --for=condition=available deployment emissary-apiext -n emissary-system
```

**Enable Istio on the newly created resources**

```bash
kubectl label namespace ambassador istio-injection=enabled --overwrite
```

**Go to the Ambassador Labs UI and create a token**

https://app.getambassador.io/cloud/welcome

**Set the CLOUD_CONNECT_TOKEN environment variable**

```bash
export CLOUD_CONNECT_TOKEN=<MY_CLOUD_CONNECT_TOKEN>
```

**Install Emissary via helm**

```bash
helm upgrade --install edge-stack \
    --namespace ambassador \
    -f ambassador/values.yaml \
    --set emissary-ingress.agent.cloudConnectToken=$CLOUD_CONNECT_TOKEN \
    datawire/edge-stack && \
kubectl -n ambassador wait --for condition=available --timeout=90s deploy -l product=aes
```

**Set the current namespace in your config context**

```bash
kubectl config set-context --current --namespace=ambassador
```

**Create the listerner address, port and protocol**

```bash
kubectl apply -f ambassador/resources/listeners.yaml
```

**Create mTLS context for interservice communication**

Note, the order is important.
```bash
kubectl apply -f ambassador/resources/tls_context.yaml
```

Once the TLSContext is created, a Mapping can use it for TLS origination. An example might be:

```bash
kubectl apply -f ambassador/resources/examples/mapping.yaml
```

**If you want to validate the configuration, install a demo service**

```bash
kubectl apply -f https://app.getambassador.io/yaml/v2-docs/latest/quickstart/qotm.yaml
```
