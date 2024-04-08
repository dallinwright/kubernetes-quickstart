#!/usr/bin/env bash

# Install cert-manager
bash cert-manager/quick-setup.bash
bash istio/quick-setup.bash
bash traefik/quick-setup.bash