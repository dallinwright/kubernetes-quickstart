#!/usr/bin/env bash

# Our services namespace
kubectl create namespace services
kubectl config set-context --current --namespace=services
kubectl label namespace services istio-injection=enabled --overwrite

kubectl apply -f knative/demos/serving/knative-service.yaml

kubectl get ksvc hello-world
kubectl get svc istio-ingressgateway -n istio-ingress
