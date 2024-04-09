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

