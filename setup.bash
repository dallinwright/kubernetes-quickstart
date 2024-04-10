#!/usr/bin/env bash

# Install cert-manager
#bash cert-manager/setup.bash

# Install istio
bash istio/setup-base.bash

# Install istio ingress gateway of type loadbalancer, only works for docker desktop and cloud providers
# Otherwise node port and port forwarding is needed
bash istio/setup-loadbalancer.bash

## Install development prometheus basic stack
# bash prometheus/setup.bash
#
## Install kiali, the istio service mesh visualization
# bash kiali/setup.bash

# Setup knative
bash knative/setup.bash

# Demo setup to validate knative config
# bash knative/demos/serving/setup.bash
bash istio/demo/setup.bash
