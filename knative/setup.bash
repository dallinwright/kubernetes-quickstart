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

# Install the Istio network layer plugin
kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.13.1/net-istio.yaml

# Peering for Istio + Cert Manager for Knative, still TODO
kubectl apply -f knative/peering.yaml

# Our services namespace
kubectl config set-context --current --namespace=services
kubectl label namespace services istio-injection=enabled --overwrite
