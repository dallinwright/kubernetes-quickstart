#!/usr/bin/env bash

# Install istio
helm repo add istio https://istio-release.storage.googleapis.com/charts --force-update
helm repo update

kubectl create namespace istio-system
kubectl config set-context --current --namespace=istio-system

helm upgrade --install istio-base istio/base -n istio-system -f istio/values.yaml
helm upgrade --install istiod istio/istiod -n istio-system --wait

kubectl label namespace default istio-injection=enabled --overwrite
