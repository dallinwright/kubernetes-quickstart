#!/usr/bin/env bash

# Install knative
kubectl config set-context --current --namespace=default
kubectl label namespace default istio-injection=enabled --overwrite

kubectl apply -f https://github.com/knative/operator/releases/download/knative-v1.13.3/operator.yaml
kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.13.1/net-istio.yaml

# Install knative-serving
kubectl apply -f knative/serving.yaml
kubectl label namespace knative-serving istio-injection=enabled --overwrite

kubectl apply -f knative/eventing.yaml
kubectl label namespace knative-eventing istio-injection=enabled --overwrite

kubectl apply -f knative/peering.yaml
kubectl apply -f knative/hello-world.yaml

kubectl apply -f knative/hello-world.yaml