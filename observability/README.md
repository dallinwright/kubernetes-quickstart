helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

**Set the current namespace in your config context**
```bash
kubectl config set-context --current --namespace=observability
```

```bash
helm install grafana-k8s-monitoring --atomic --timeout 300s  grafana/k8s-monitoring --values values.yaml
```


helm install grafana-k8s-monitoring --atomic --timeout 300s  grafana/k8s-monitoring --values observability/values.yaml