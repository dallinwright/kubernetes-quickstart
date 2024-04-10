#!/usr/bin/env bash

# Install knative
kubectl config set-context --current --namespace=default
kubectl label namespace default istio-injection=enabled --overwrite

kubectl apply -f https://github.com/knative/operator/releases/download/knative-v1.13.3/operator.yaml
kubectl wait --for=condition=Established --timeout=60s crd/knativeservings.operator.knative.dev

# Install knative-serving
kubectl apply -f knative/serving.yaml
kubectl label namespace knative-serving istio-injection=enabled --overwrite

kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.13.1/net-istio.yaml
kubectl apply -f knative/peering.yaml

kubectl config set-context --current --namespace=services
kubectl label namespace services istio-injection=enabled --overwrite

kubectl get svc istio-ingressgateway -n istio-ingress

docker buildx build --platform linux/arm64,linux/amd64 -t "dallinpm/hello-world" --push .

kubectl apply -f knative/hello-world.yaml
kubectl get ksvc hello-world

curl $(kn service describe hello-world -o url)
