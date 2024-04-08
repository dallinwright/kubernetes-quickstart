#!/usr/bin/env bash

# Install cert-manager
helm repo add jetstack https://charts.jetstack.io --force-update
helm repo update

kubectl create namespace cert-manager
kubectl config set-context --current --namespace=cert-manager

helm upgrade --install \
    --namespace cert-manager \
    --create-namespace \
    --version v1.14.4 \
    --set installCRDs=true \
    -f cert-manager/values.yaml \
    cert-manager jetstack/cert-manager

