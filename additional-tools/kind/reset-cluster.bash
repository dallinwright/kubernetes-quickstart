#!/usr/bin/env bash

podman machine stop
podman machine rm -f podman-machine-default
podman machine init \
    --cpus 8 \
    --disk-size 60 \
    --memory 16384 \
    --user-mode-networking \
    podman-machine-default

# Unfortunately on windows, this flag is needed
podman machine set --rootful
podman machine start

kind delete cluster
kind create cluster
