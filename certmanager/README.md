# Cluster Certificate Management

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
helm upgrade --install \
    --namespace cert-manager \
    --create-namespace \
    --version v1.14.4 \
    --set installCRDs=true \
    -f certmanager/values.yaml \
    cert-manager jetstack/cert-manager
```