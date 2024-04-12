#!/usr/bin/env bash

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

kubectl apply -f grafana/namespace.yaml
kubectl apply -f grafana/secret.yaml

kubectl config set-context --current --namespace=grafana

helm install grafana-k8s-monitoring --atomic --timeout 300s  grafana/k8s-monitoring --values grafana/values.yaml
