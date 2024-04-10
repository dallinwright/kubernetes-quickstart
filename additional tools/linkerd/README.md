```bash
helm repo add linkerd https://helm.linkerd.io/stable && \
helm repo update
```

```bash
kubectl create namespace linkerd; \
kubectl config set-context --current --namespace=linkerd
```

Generate the Root CA
```bash
step certificate create root.linkerd.cluster.local ca.crt ca.key \
--profile root-ca --no-password --insecure --not-after=87600h
```

Store the Root CA in a Kubernetes secret
```bash
kubectl create secret tls \
    linkerd-trust-anchor \
    --cert=ca.crt \
    --key=ca.key \
    --namespace=linkerd
```

Install the Linkerd CRDs
```bash
helm upgrade --install linkerd-crds linkerd/linkerd-crds \
    -n linkerd \
    --create-namespace
```

Create the cert-manager resources required to automatically rotate the Linkerd intermediate CA
```bash
kubectl apply -f linkerd/issuer.yaml && \
kubectl apply -f linkerd/certificate.yaml
```

Validate the newly created cert-manager intermediate CA
```bash
kubectl get secret linkerd-identity-issuer -o yaml -n linkerd
```

```bash
helm upgrade --install linkerd-control-plane \
    -n linkerd \
    --set-file identityTrustAnchorsPEM=ca.crt \
    -f linkerd/values.yaml \
    linkerd/linkerd-control-plane
```


kubectl -n emissary get deploy emissary-ingress -o yaml | \
linkerd inject \
--skip-inbound-ports 80,443 - | \
kubectl apply -f -