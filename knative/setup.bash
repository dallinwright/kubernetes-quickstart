#!/usr/bin/env bash

# Install knative
kubectl config set-context --current --namespace=default
kubectl label namespace default istio-injection=enabled --overwrite

# Operator Setup
kubectl apply -f https://github.com/knative/operator/releases/download/knative-v1.13.3/operator.yaml

# Install knative-serving
kubectl wait --for=condition=Established --timeout=60s crd/knativeservings.operator.knative.dev
kubectl apply -f knative/serving.yaml
kubectl label namespace knative-serving istio-injection=enabled --overwrite
kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.13.1/net-istio.yaml

sleep 10

# Install the Istio network layer plugin
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.13.1/serving-default-domain.yaml
kubectl patch configmap/config-domain \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"127.0.0.1.sslip.io":""}}'

# Peering for Istio + Cert Manager for Knative, still TODO
kubectl apply -f knative/peering.yaml

# Our services namespace
kubectl create namespace services
kubectl config set-context --current --namespace=services
kubectl label namespace services istio-injection=enabled --overwrite
