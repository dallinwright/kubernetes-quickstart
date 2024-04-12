#!/usr/bin/env bash

# Install Kiali service mesh visualization
helm upgrade --install \
  --namespace istio-system \
  --repo https://kiali.org/helm-charts \
  -f kiali/values.yaml \
  kiali-server \
  kiali-server

kubectl apply -f kiali/virtual-service.yaml