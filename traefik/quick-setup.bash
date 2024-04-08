#!/usr/bin/env bash

helm repo add traefik https://traefik.github.io/charts --force-update
helm repo update

kubectl create namespace traefik
kubectl config set-context --current --namespace=traefik

# Install in the namespace "traefik-v2"
helm upgrade --install --namespace=traefik \
-f traefik/values.yaml \
traefik traefik/traefik

kubectl create namespace services
kubectl config set-context --current --namespace=services

kubectl label namespace services istio-injection=enabled --overwrite

kubectl apply -f https://app.getambassador.io/yaml/v2-docs/latest/quickstart/qotm.yaml

kubectl apply -f traefik/quote_route.yaml