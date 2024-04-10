#!/usr/bin/env bash

# Setup the istio ingress gateway
kubectl create namespace istio-ingress
kubectl config set-context --current --namespace=istio-ingress
helm upgrade --install istio-ingressgateway istio/gateway -n istio-ingress --set service.type=LoadBalancer

kubectl apply -f istio/gateway.yaml
kubectl apply -f istio/virtual-service.yaml

kubectl describe gateway -n istio-ingress && kubectl get virtualservice -n istio-ingress
