helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

```bash
kubectl create namespace grafana
```

```bash
```

**Set the current namespace in your config context**
```bash
kubectl config set-context --current --namespace=grafana
```

```bash
helm install grafana-k8s-monitoring --atomic --timeout 300s  grafana/k8s-monitoring --values values.yaml
```


helm install grafana-k8s-monitoring --atomic --timeout 300s  grafana/k8s-monitoring --values observability/values.yaml


---
apiVersion: getambassador.io/v3alpha1
kind: Mapping
metadata:
  name: metrics
spec:
  hostname: "*"
  prefix: /metrics
  rewrite: ""
  service: localhost:8877

