# Istio Service Mesh

```bash
helm repo add istio https://istio-release.storage.googleapis.com/charts && \
helm repo update
```

```bash
kubectl create namespace istio-system
```

```bash
helm install istio-base istio/base -n istio-system --set defaultRevision=default
```

```bash
helm install istiod istio/istiod -n istio-system --wait
```