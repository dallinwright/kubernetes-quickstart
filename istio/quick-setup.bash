#!/usr/bin/env bash

# Install istio
helm repo add istio https://istio-release.storage.googleapis.com/charts --force-update
helm repo update

kubectl create namespace istio-system
kubectl config set-context --current --namespace=istio-system

helm upgrade --install istio-base istio/base -n istio-system --set defaultRevision=default
helm upgrade --install istiod istio/istiod -n istio-system --wait

helm status istiod -n istio-system
kubectl get deployments -n istio-system --output wide

# Install the gateway for knative
kubectl create namespace istio-ingress
kubectl config set-context --current --namespace=istio-ingress
helm install istio-ingressgateway istio/gateway -n istio-ingress

kubectl create namespace services
kubectl config set-context --current --namespace=services
kubectl label namespace services istio-injection=enabled --overwrite

kubectl apply -f https://app.getambassador.io/yaml/v2-docs/latest/quickstart/qotm.yaml -n services

kubectl apply -f istio/gateway.yaml
kubectl apply -f istio/virtual_service.yaml

kubectl describe gateway -n istio-ingress && kubectl get virtualservice -n istio-ingress
