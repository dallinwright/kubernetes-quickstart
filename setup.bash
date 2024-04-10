#!/usr/bin/env bash

# Install cert-manager
bash cert-manager/quick-setup.bash

# Install istio
bash istio/quick-setup-base.bash

# Install istio ingress gateway of type loadbalancer, only works for docker desktop and cloud providers
# Otherwise node port and port forwarding is needed
bash istio/quick-setup-loadbalancer.bash

# Demo setup to validate istio config
bash istio/demo/setup.bash

# Install development prometheus basic stack
bash prometheus/quick-setup.bash

# Install kiali, the istio service mesh visualization
bash kiali/quick-setup.bash

# Setup knative
bash knative/quick-setup.bash

# Demo setup to validate knative config
bash knative/demos/serving/setup.bash
