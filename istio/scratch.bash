#!/usr/bin/env bash

#kubectl delete namespace services
kubectl config set-context --current --namespace=istio-ingress
kubectl label namespace services istio-injection=enabled --overwrite

kubectl apply -f https://app.getambassador.io/yaml/v2-docs/latest/quickstart/qotm.yaml

kubectl apply -f istio/gateway.yaml
kubectl apply -f istio/virtual_service.yaml

kubectl describe gateway -n istio-ingress && kubectl get virtualservice -n istio-ingress