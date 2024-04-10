#!/usr/bin/env bash

# Service setup for demo purposes and testing
kubectl create namespace services
kubectl config set-context --current --namespace=services
kubectl label namespace services istio-injection=enabled --overwrite

kubectl apply -f https://app.getambassador.io/yaml/v2-docs/latest/quickstart/qotm.yaml
kubectl apply -f istio/demo/virtual-service.yaml
