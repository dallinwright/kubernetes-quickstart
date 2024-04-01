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

**If you want to validate the configuration, install a demo service**
```bash
kubectl apply -f https://app.getambassador.io/yaml/v2-docs/latest/quickstart/qotm.yaml
```

**Set the current namespace in your config context**
```bash
kubectl config set-context --current --namespace=ambassador
```

```bash
kubectl apply -f ambassador/examples/mapping.yaml
kubectl apply -f ambassador/listeners.yaml
```