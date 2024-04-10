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

kubectl apply -f knative/serving.yaml

kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.13.1/net-istio.yaml

kubectl wait --for=condition=Established --timeout=60s crd/certificates.networking.internal.knative.dev
kubectl wait --for=condition=Established --timeout=60s crd/configurations.serving.knative.dev

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.13.1/serving-default-domain.yaml
kubectl patch configmap/config-domain \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"example.com":""}}'

kubectl patch configmap config-istio -n knative-serving \
  --type merge \
  -p '{"data":{"gateway.knative-serving.knative-ingress-gateway":"istio-ingressgateway.istio-ingress.svc.cluster.local"}}'

# Peering for Istio + Cert Manager for Knative, still TODO
kubectl apply -f knative/peering.yaml
