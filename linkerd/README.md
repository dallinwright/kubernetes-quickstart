```bash
helm repo add linkerd https://helm.linkerd.io/stable && \
helm repo update
```

```bash
kubectl create namespace linkerd; \
kubectl config set-context --current --namespace=linkerd
```

Now since we want interpod mTLS we need to generate certificates for the control plane.

Follow the instructions here: [Linkerd Certificates](https://linkerd.io/2/tasks/generate-certificates/)

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
kubectl apply -f issuer.yaml && \
kubectl apply -f certificate.yaml
```

Validate the newly created cert-manager intermediate CA
```bash
kubectl get secret linkerd-identity-issuer -o yaml -n linkerd
```

```bash
helm upgrade --install linkerd-control-plane \
    -n linkerd \
    --set-file identityTrustAnchorsPEM=ca.crt \
    -f values.yaml \
    linkerd/linkerd-control-plane
```
