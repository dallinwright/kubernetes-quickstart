#!/usr/bin/env bash

# Install knative
kubectl label namespace default istio-injection=enabled --overwrite

# Operator Setup
kubectl apply -f https://github.com/knative/operator/releases/download/knative-v1.13.3/operator.yaml

# Install knative-serving
kubectl create namespace knative-serving
kubectl config set-context --current --namespace=knative-serving
kubectl label namespace knative-serving istio-injection=enabled --overwrite

kubectl wait --for=condition=Established --timeout=60s crd/knativeservings.operator.knative.dev
kubectl wait --for=condition=Established --timeout=60s crd/peerauthentications.security.istio.io

echo "Setting up knative-serving"
kubectl apply -f knative/serving.yaml

echo "Setting up istio network plugin CRDs"
kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.13.1/net-istio.yaml

sleep 30

kubectl wait --for=condition=Established --timeout=60s crd/certificates.networking.internal.knative.dev
kubectl wait --for=condition=Established --timeout=60s crd/configurations.serving.knative.dev

echo "Setting up configmap for domain mapping"
kubectl patch configmap/config-domain \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"example.com":""}}'

echo "Setting up knative configmap for istio gateway"
# Fetch the current configmap and save it to a file
kubectl get configmap config-istio -n knative-serving -o json > config-istio.json

# Use jq to replace the specific key-value pair in the data field
jq '.data["gateway.knative-serving.knative-ingress-gateway"]="istio-ingressgateway.istio-ingress.svc.cluster.local"' config-istio.json > config-istio-updated.json

# Apply the updated configmap
kubectl apply -f config-istio-updated.json

# Peering for Istio + Cert Manager for Knative, still TODO
echo "Setting up peering for Istio + Cert Manager for Knative"
kubectl apply -f knative/peering.yaml
