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

echo "Setting up knative-serving"
kubectl apply -f knative/serving.yaml

echo "Setting up istio network plugin CRDs"
kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.13.1/net-istio.yaml

# Peering for Istio + Cert Manager for Knative, still TODO
echo "Setting up peering for Istio + Cert Manager for Knative"
kubectl apply -f knative/peering.yaml
