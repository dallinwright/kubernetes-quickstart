#!/usr/bin/env bash

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace telemetry
kubectl config set-context --current --namespace=telemetry
#kubectl label namespace telemetry istio-injection=enabled --overwrite

helm upgrade --install prometheus-stack prometheus-community/kube-prometheus-stack -f prometheus/values.yaml
kubectl apply -f prometheus/virtual-service.yaml

# Add the Prometheus operator to enable scraping of metrics
kubectl apply -f prometheus/prometheus-operator.yaml