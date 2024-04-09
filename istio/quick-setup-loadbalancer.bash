#!/usr/bin/env bash

bash quick-setup-base.bash

kubectl create namespace istio-ingress
kubectl config set-context --current --namespace=istio-ingress
helm install istio-ingressgateway istio/gateway -n istio-ingress

kubectl apply -f https://app.getambassador.io/yaml/v2-docs/latest/quickstart/qotm.yaml

kubectl apply -f istio/gateway.yaml
kubectl apply -f istio/virtual_service.yaml

kubectl describe gateway -n istio-ingress && kubectl get virtualservice -n istio-ingress
