#!/usr/bin/env bash

cd knative/demos/serving/hello-world || exit

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Docker does not seem to be running, start Docker before running this script."
    exit 1
fi

# Check if the builder "container" exists
if ! docker buildx ls | grep -q 'container'; then
    # Create the builder
    docker buildx create --name container --driver docker-container --use
else
    # Use the existing builder
    docker buildx use container
fi

docker buildx build --platform linux/amd64,linux/arm64 --builder=container -t "dallinpm/hello-world:latest" --push .

cd ../../../.. || exit
# Our services namespace
kubectl create namespace services
kubectl config set-context --current --namespace=services
kubectl label namespace services istio-injection=enabled --overwrite

kubectl apply -f knative/demos/serving/knative-service.yaml

kubectl get ksvc hello-world
kubectl get svc istio-ingressgateway -n istio-ingress

# shellcheck disable=SC2046
#curl $(kn service describe hello-world -o url)
