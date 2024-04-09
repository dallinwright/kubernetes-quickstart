#!/usr/bin/env bash

# Install cert-manager
bash cert-manager/quick-setup.bash
bash istio/quick-setup-base.bash
bash istio/quick-setup-loadbalancer.bash