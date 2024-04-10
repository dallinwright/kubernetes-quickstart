#!/usr/bin/env bash

docker build build -t "dallinpm/hello-world" --push .

kubectl apply -f knative/hello-world.yaml

kubectl get ksvc hello-world
kubectl get svc istio-ingressgateway -n istio-ingress

# shellcheck disable=SC2046
curl $(kn service describe hello-world -o url)
