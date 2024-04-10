#!/usr/bin/env bash

helm repo add traefik https://traefik.github.io/charts --force-update
helm repo update

kubectl create namespace traefik
kubectl config set-context --current --namespace=traefik

# Install in the namespace "traefik-v2"
helm upgrade --install --namespace=traefik \
-f traefik/values.yaml \
traefik traefik/traefik

kubectl apply -f traefik/quote_route.yaml